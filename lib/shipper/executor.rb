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
        status = Open3.popen2e(cmd) do |_stdin, stdout, wait_thread|
          stdout.each_line { |line| logger.puts(line) }

          wait_thread.value
        end
        fall_down!(cmd) unless status.exitstatus.zero?
      end
    end

    def logger
      ::Shipper::Logger.instance
    end

    def fall_down!(failed_cmd)
      logger.error 'Command finished with non-zero code:'
      logger.puts "'#{failed_cmd}'"
      logger.puts 'halt.'
      exit
    end
  end
end
