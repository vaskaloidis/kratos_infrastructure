# frozen_string_literal: true
require 'thor'

require 'artemis'
require_relative 'configuration'
require_relative 'command'

module Artemis
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor

    # Error raised by this runner
    Error = Class.new(StandardError)

    no_commands do
      prompt = TTY::Prompt.new

      if !File.exist? 'config.yml'
        require 'fileutils'
        FileUtils.touch 'config.yml'
        `echo 'init_config: 'init' >> config.yml`
        data.setup
      else
        prompt.say 'Loading configuration data'
      end
      data = Artemis::Configuration.new
      prompt.ok "C2 IP: "+ data.c2.ip
      prompt.ok "C2 User: "+ data.c2.user

      running = true
      while running

        options = {}
        operation = prompt.select("Operation", %w(Deploy Connect Config Authenticate Tor Exit))

        case operation.downcase
        when 'deploy'
          require_relative 'commands/deploy'
          Artemis::Commands::Deploy.new(options).execute
        when 'connect'
          require_relative 'commands/connect'
          Artemis::Commands::Connect.new(options).execute
        when 'config'
          require_relative 'commands/config'
          Artemis::Commands::Config.new(options).execute
        when 'authenticate'
          require_relative 'commands/authenticate'
          Artemis::Commands::Authenticate.new(options).execute
        when 'tor'
          require_relative 'commands/tor'
          Artemis::Commands::Tor.new(options).execute
        when 'exit'
          running = false
        else
          prompt.error "Command not found #{operation}"
          # self.send operation.downcase.to_sym
        end
      end
    end

  end

  desc 'version', 'artemis version'

  def version
    require_relative 'version'
    puts "v#{Artemis::VERSION}"
  end

  map %w(--version -v) => :version

    desc 'recon', 'Command description...'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def recon(*)
      if options[:help]
        invoke :help, ['recon']
      else
        require_relative 'commands/recon'
        Artemis::Commands::Recon.new(options).execute
      end
    end

  desc 'tor', 'Command description...'
  method_option :help, aliases: '-h', type: :boolean,
                desc: 'Display usage information'

  def tor(*)
    if options[:help]
      invoke :help, ['tor']
    else
      require_relative 'commands/tor'
      Artemis::Commands::Tor.new(options).execute
    end
  end

  desc 'connect', 'Command description...'
  method_option :help, aliases: '-h', type: :boolean,
                desc: 'Display usage information'

  def connect(*)
    if options[:help]
      invoke :help, ['connect']
    else
      require_relative 'commands/connect'
      Artemis::Commands::Connect.new(options).execute
    end
  end

  desc 'authenticate', 'Command description...'
  method_option :help, aliases: '-h', type: :boolean,
                desc: 'Display usage information'

  def authenticate(*)
    if options[:help]
      invoke :help, ['authenticate']
    else
      require_relative 'commands/authenticate'
      Artemis::Commands::Authenticate.new(options).execute
    end
  end

  desc 'deploy', 'Command description...'
  method_option :help, aliases: '-h', type: :boolean,
                desc: 'Display usage information'

  def deploy(*)
    if options[:help]
      invoke :help, ['deploy']
    else
      require_relative 'commands/deploy'
      Artemis::Commands::Deploy.new(options).execute
    end
  end

  desc 'config', 'Command description...'
  method_option :help, aliases: '-h', type: :boolean,
                desc: 'Display usage information'

  def config(*)
    if options[:help]
      invoke :help, ['config']
    else
      require_relative 'commands/config'
      Artemis::Commands::Config.new(options).execute
    end
  end

end
