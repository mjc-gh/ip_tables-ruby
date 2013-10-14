require 'minitest_helper'

class IPTablesCLIBuilderTest < MiniTest::Unit::TestCase
  def setup
    @ctx = IPTables.define do
      chain :in, default: :drop, table: :filter do
        accept src: '192.168.1.1' do
          match :udp, dport: 53
          match :tcp, dport: [80, 443]
        end
      end
    end

    @builder = IPTables::Builder.new(@ctx, :append)
  end

  test "self.cli_string" do
    str = @builder.class.cli_string(a: 1, b: 'x y z')

    assert_equal '--a 1 --b x y z', str
  end

  test "self.cli_string converts underscores to dashes" do
    str = @builder.class.cli_string(to_port: 123)

    assert_equal '--to-port 123', str
  end

  test "self.cli_string uses aliases" do
    IPTables::Builder::ALIASES.expects(:[]).with('a')

    @builder.class.cli_string(a: 1)
  end

  test "command_args" do
    assert_equal ['--policy IN DROP'], @builder.commands
  end

  test "rule_args" do
    assert_equal([
      '--table filter --append INPUT --jump ACCEPT --source 192.168.1.1 --match udp --dport 53',
      '--table filter --append INPUT --jump ACCEPT --source 192.168.1.1 --match tcp --dport 80,443'
    ], @builder.rules)
  end
end
