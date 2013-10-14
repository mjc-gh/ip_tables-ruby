# TODO add validation for in/out-interfaces and different chains
# TODO add protocol method for implicit protocol matcher

module IPTables
  class Chain
    include Enumerable

    attr_reader :name, :table, :policy, :options

    def initialize(name, options = {})
      @name = name.to_s.upcase

      if default = options.delete(:default)
        @policy = default.to_s.upcase
      end

      if table = options.delete(:table)
        @table = table.to_s.downcase
      end

      @options = options
      @rules   = []
    end

    def accept(options, &block)
      jump :accept, options, &block
    end

    def drop(options, &block)
      jump :drop, options, &block
    end

    def jump(target, options = {}, &block)
      @rules << Rule.new(target, options)

      @rules.last.instance_eval(&block) if block_given?
    end

    def each
      @rules.each do |rule|
        yield rule
      end
    end
  end
end
