require 'minitest_helper'

class IPTablesRuleTest < MiniTest::Unit::TestCase
  def setup
    @rule = IPTables::Rule.new(:accept, src: :any)
  end

  test "rule sets target" do
    assert_equal 'ACCEPT', @rule.target
  end

  test "match adds name as match" do
    @rule.match :tcp

    assert_equal({ match: 'tcp' }, @rule.first)
  end

  test "match adds options" do
    @rule.match :udp, { dport: 80 }

    assert_equal({ match: 'udp', dport: 80 }, @rule.first)
  end
end
