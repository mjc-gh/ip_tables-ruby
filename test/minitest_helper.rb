$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'ip_tables'
require 'ip_tables/cli'

require 'minitest/autorun'

class MiniTest::Unit::TestCase
  def self.test(name, &block)
    define_method "test_#{name.gsub(/\s+/, '_')}", block
  end

  def teardown
    mocha_teardown
  end
end

require 'mocha/setup'
