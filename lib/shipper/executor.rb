# frozen_string_literal: true

require 'net/ssh'
require 'open3'

module Shipper
  class Executor
    attr_accessor :host_bash, :path

    def initialize(host_bash = nil, path = nil)
      @host_bash = host_bash
      @path = path || Dir.pwd
    end

    def exec(cmd)
      host_bash ? exec_host(cmd) : exec_local(cmd)
    end

    def cd(new_location)
      @path = new_location
    end

    private

    def exec_host(cmd)
      logger.bold("Exec host '#{cmd}'")

      host_bash.exec!("cd #{path}; #{cmd}") do |_channel, _stream, data|
        logger.puts(data)
      end
    end

    def exec_local(cmd)
      logger.bold("Exec local '#{cmd}'")

      Dir.chdir(path) do
        Open3.popen3(cmd) do |_stdin, stdout, stderr, wait_thread|
          logger.puts(stdout.gets)
          logger.puts(stderr.gets)

          wait_thread.value
        end
      end
    end

    def logger
      ::Shipper::Logger.instance
    end
  end
end
