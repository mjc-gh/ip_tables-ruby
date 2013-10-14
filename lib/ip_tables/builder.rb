require 'ip_tables/builder/aliases'

module IPTables
  class Builder
    attr_reader :prefix, :commands, :rules

    def self.cli_string(cmd)
      cmd.map { |switch, args|
        # TODO maybe joins args when array here?
        "--#{(ALIASES[switch.to_s] || switch).to_s.gsub(/_/, '-')} #{args}"
      } * ' '
    end

    def initialize(ctx, command)
      @context = ctx
      @command = command.to_s

      @commands = []
      @rules = []

      compile_command_strings!
    end

    def all
      @commands + @rules
    end

    private

    def compile_command_strings!
      @context.each do |chain|
        if chain.policy
          @commands << self.class.cli_string(policy: "#{chain.name} #{chain.policy}")
        end

        chain.each do |rule|
          name = ALIASES[chain.name] || chain.name

          opts = {}
          opts['table'] = chain.table unless chain.table.nil?

          opts.update(@command => name, 'jump' => rule.target)
          opts.update(rule.options)

          rule.each do |match|
            match.each do |key, val|
              opts[key] = Array === val ? val * ',' : val
            end

            @rules << self.class.cli_string(opts)
          end
        end
      end
    end
  end
end
