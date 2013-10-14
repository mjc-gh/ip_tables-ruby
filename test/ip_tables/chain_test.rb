require 'minitest_helper'

class IPTablesChainTest < MiniTest::Unit::TestCase
  def setup
    @chain = IPTables::Chain.new :in, default: :drop, table: :filter
  end

  test "defines name" do
    assert_equal 'IN', @chain.name
  end

  test "defines default policy" do
    assert_equal 'DROP', @chain.policy
  end

  test "defines table name" do
    assert_equal 'filter', @chain.table
  end

  test "jump evaluates block within new Rule context" do
    assert_instance_of IPTables::Rule, @chain.jump(:return) { self }
  end

  test "jump optionally evaluates block" do
    assert_nil @chain.jump(:accept, src: :any)
  end

  test "jump adds rule with correct target" do
    @chain.jump(:return)

    @chain.each do |rule|
      assert_equal 'RETURN', rule.target
    end
  end

  test "accept adds rule with ACCEPT target" do
    @chain.accept(dst: '10.0.0.1')
    @chain.each do |rule|
      assert_equal 'ACCEPT', rule.target
    end
  end

  test "accept adds rule with DROP target" do
    @chain.drop(dst: '10.0.0.1')
    @chain.each do |rule|
      assert_equal 'DROP', rule.target
    end
  end
end
