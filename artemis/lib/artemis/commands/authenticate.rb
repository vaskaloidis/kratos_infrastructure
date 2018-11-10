# frozen_string_literal: true

require_relative '../command'

module Artemis
  module Commands
    class Authenticate < Artemis::Command
      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        ip = config.c2.ip
        user = config.c2.user
        command "ssh-copy-id #{user}@#{ip}"
      end
    end
  end
end
