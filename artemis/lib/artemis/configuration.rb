require 'thor'
require 'artemis'
require 'tty-config'
require 'ostruct'

module Artemis
  class Configuration

    attr_reader :data, :prompt

    def initialize
      @data = TTY::Config.new
      @data.filename = 'config'
      @data.extname = '.yml'
      @data.append_path Dir.pwd
      # @data.append_path Dir.home
      @data.read
      # @data.append_path Dir.home
    end

    def prompt
      @prompt ||= TTY::Prompt.new
    end

    def target
      data.fetch(:target_ip)
    end

    def c2
      ip = data.fetch(:c2_ip)
      user = data.fetch(:c2_username)
      OpenStruct.new(ip: ip, user: user)
    end

    def setup
      prompt.say "Generating configuration file"
      configure_c2
      configure_target
      configure_nmap
      # configure_tor_container
    end

    def configure_nmap
      prompt.say "Configuring Nmap"
      nmap_location = prompt.ask "Nmap location"
      data.set(:nmap_location, value: nmap_location)

      default_output = prompt.ask "Nmap output location"
      data.set(:nmap_output_location, value: default_output)

      save_nmap_scans = prompt.yes? "Save Nmap Scan data?"
      data.set(:save_nmap_scans, value: save_nmap_scans)
    end

    def configure_target
      prompt.say "Configuring Target"
      target = prompt.ask "Target Server IP Address"
      data.set(:target_ip, value: target)
    end

    def configure_c2
      prompt.say "Configuring c2 server"
      c2_ip = prompt.ask "C2 Server IP Address"
      data.set(:c2_ip, value: c2_ip)

      c2_username = prompt.ask "C2 Login"
      data.set(:c2_username, value: c2_username)
      data.write
    end

    def configure_tor_container
      tor_container = prompt.ask "Tor Container Name"
      data.set(:tor_container, value: tor_container)

      tor_container_ip = prompt.ask "Tor Container URL"
      data.set(:tor_container_ip, value: tor_container_ip)

      privoxy_container = prompt.ask "Privoxy Container"
      data.set(:privoxy_container, value: privoxy_container)

      privoxy_container_ip = prompt.ask "Privoxy Container URL"
      data.set(:privoxy_container_ip, value: privoxy_container_ip)
      data.write
    end

    def self.config
      @data ||= self.class.new.config
    end
  end
end