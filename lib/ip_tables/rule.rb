module IPTables
  class Rule
    include Enumerable

    attr_reader :target, :options

    def initialize(target, options)
      @target = target.to_s.upcase
      @options = options

      @matches = []
    end

    # TODO add protocol DSL method

    def match(name, opts = {})
      @matches << { match: name.to_s }.merge!(opts)
    end

    def each
      @matches.each do |match|
        yield match
      end
    end
  end
end
