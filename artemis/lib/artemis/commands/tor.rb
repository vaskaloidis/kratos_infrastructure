# frozen_string_literal: true

require_relative '../command'

module Artemis
  module Commands
    class Tor < Artemis::Command
      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        command "tor"
        output.puts "Tor Started"
      end
    end
  end
end
