require 'cocaine'
require 'thor'

require 'ip_tables/builder'
require 'ip_tables/cli/command'

module IPTables
  class CLI < Thor
    include Thor::Actions

    source_root Dir.pwd

    map '-C' => :check
    rule_options = [:rules, { required: true, desc: 'Rule file to load' }]

    desc :dump, 'Output the rules (as the append command)'
    method_option(*rule_options)

    def dump
      builder(:append).all.each do |cmd|
        puts cmd
      end
    end

    desc :check, 'Check if a rules from a Ruby file are installed'
    method_option(*rule_options)

    def check
      # TODO create a "reporter" for executing each command
      # TODO make each command\argument its own class that links
      # to a line number within the rules file
      builder(:check).all_arguments.each do |args|
      end
    end

    protected

    def builder(command)
      IPTables.load_builder(options.rules, command)
    end

    def command_for(arguments)
      Cocaine::CommandLine.new('iptables', arguments)
    end
  end
end
