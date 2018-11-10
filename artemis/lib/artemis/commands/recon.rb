# frozen_string_literal: true

require_relative '../command'

module Artemis
  module Commands
    class Recon < Artemis::Command
      def initialize(options)
        @options = options
        @config = Configuration.new
      end

      def execute(input: $stdin, output: $stdout)

        target = prompt.ask('Target IP:', default: config.target)

        actively_scanning = true

        if target.include? '/'
          choices = Nmap.MULTI_SCANS << "exit" << "switch"
        else
          choices = Nmap.SINGLE_SCANS << "exit" << "switch"
        end

        while actively_scanning
          scan_selected = prompt.select("Scan Operation:", choices)

          if scan_selected == 'exit'
            running = false
          elsif scan_selected == 'switch'
            actively_scanning = false
          else
            nmap = Nmap.new
            nmap.send scan_selected.to_sym, target

            prompt.warn "CMD: #{nmap.preview?}"

            if prompt.yes? "Execute?"
              result = nmap.execute!

              if result.success?
                prompt.ok "Scan Successful!"
                prompt.say result.output
              else
                prompt.error "Scan error"
                prompt.say result.error
              end
            else
              prompt.warn "Scan aborted"
            end
          end
        end

      end
    end
  end
end
