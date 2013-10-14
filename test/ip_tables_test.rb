require 'minitest_helper'

class IPTablesTest < MiniTest::Unit::TestCase
  test 'has version constant' do
    refute_nil IPTables::VERSION
  end

  test "define returns new Context" do
    assert_instance_of IPTables::Context, IPTables.define {}
  end

  test "load returns new Context" do
    rule_file = File.expand_path('../fixtures/rules.rb', __FILE__)

    assert_instance_of IPTables::Context, IPTables.load(rule_file)
  end

  test "load_builder returns new Builder" do
    rule_file = File.expand_path('../fixtures/rules.rb', __FILE__)

    assert_instance_of IPTables::Builder, IPTables.load_builder(rule_file, :check)
  end
end
