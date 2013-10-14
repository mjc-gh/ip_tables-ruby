require 'minitest_helper'

class IPTablesTest < MiniTest::Unit::TestCase
  def setup
    @ctx = IPTables::Context.new
  end

  test "evaluates block within new Chain context" do
    assert_instance_of IPTables::Chain, @ctx.chain(:in) { self }
  end
end
