# frozen_string_literal: true

require_relative '../command'

module Artemis
  module Commands
    class Config < Artemis::Command
      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        config.setup
      end
    end
  end
end
