require 'ip_tables/version'
require 'ip_tables/context'
require 'ip_tables/chain'
require 'ip_tables/rule'

module IPTables
  def self.define(&block)
    Context.new.tap do |ctx|
      ctx.instance_eval(&block)
    end
  end

  def self.load(file)
    Context.new.tap do |ctx|
      ctx.instance_eval File.read(file), file
    end
  end

  def self.load_builder(file, cmd)
    Builder.new(self.load(file), cmd)
  end

  def self.parse(io)
  end
end
