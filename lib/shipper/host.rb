# frozen_string_literal: true

module Shipper
  class Host
    attr_accessor :user, :host, :port, :location, :executor

    def initialize(options)
      @user, full_host = options['ssh_entry'].split('@')
      @host, @port = full_host.split(':')

      @location = options['location']
      @executor = nil
    end

    def update!
      restart!(pull_changes: true)
    end

    def restart!(pull_changes: false)
      ::Net::SSH.start(host, user, port: port || 22) do |ssh|
        load_executor(ssh)
        executor.cd location
        exec 'docker-compose pull' if pull_changes
        exec 'docker-compose down'
        exec 'docker-compose up -d'
      end
    end

    private

    def exec(cmd)
      executor.exec(cmd)
    end

    def load_executor(ssh)
      @executor = ::Shipper::Executor.new(ssh, location)
    end
  end
end
