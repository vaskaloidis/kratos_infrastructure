# frozen_string_literal: true

require_relative '../command'

module Artemis
  module Commands
    class Connect < Artemis::Command
      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        ip = config.c2.ip
        user = config.c2.user
        ssh(ip, user)
        # `ssh -o ProxyCommand=\"nc -x localhost:9050 #{ip} #{port}\" #{user}@#{ip}`
      end

      private

      def ssh(ip, user, port = 22)
        command "ssh -o ProxyCommand=\"nc -x localhost:9050 #{ip} #{port}\" #{user}@#{ip}", pty: true
      end
    end
  end
end
