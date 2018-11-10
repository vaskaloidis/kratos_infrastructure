# frozen_string_literal: true

require_relative '../command'

module Artemis
  module Commands
    class Deploy < Artemis::Command
      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        ip = prompt.ask 'C2 Deploy Target', default: config.get(:c2_ip)
        port = prompt.ask 'C2 Deploy Target Port', default: "22"
        user = prompt.ask 'C2 Username', default: config.get(:c2_username)

        verify = prompt.yes?('Deploy?')

        if verify
          command "cp -R ~/kratos ~/deploy"
          command "sudo chown -r root ~/deploy"
          command "tar -zcvf ~/deploy.tar.gz ~/deploy"

          command "scp -o ProxyCommand=\"nc -x localhost:9050 #{ip} #{port}\" /Users/$(whoami)/deploy.tar.gz #{user}@#{ip}:/tmp"

          command "ssh #{user}@#{ip} 'cd /tmp && tar -xvf deploy.tar.gz && mv /tmp/deploy /root/'" # TODO: This is not ready yet. Implement SSH Package here
        end

      end

    private

      # Specify which applications to deploy (version 2)
      def configure_deploy
        applications = %w(docker metasploit empire)
        apps_selected = prompt.multi_select("Deploy Applications", applications)

        deploy_dir_question = prompt.yes?('Deploy a directory?')
        if deploy_dir_question
          deploy_dir = prompt.ask("Provide range of numbers?", convert: :range)
        else
          deploy_dir = false
        end
      end

    end

  end
end
