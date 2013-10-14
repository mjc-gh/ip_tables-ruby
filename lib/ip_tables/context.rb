module IPTables
  class Context
    include Enumerable

    def initialize
      @chains = []
    end

    def chain(name, options = {}, &block)
      @chains << Chain.new(name, options)

      @chains.last.instance_eval(&block) if block_given?
    end

    def each
      @chains.each do |chain|
        yield chain
      end
    end
  end
end
