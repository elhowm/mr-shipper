# frozen_string_literal: true

module Shipper
  class Host
    attr_accessor :user, :host, :location, :executor

    def initialize(options)
      @user, @host = options['ssh_entry'].split('@')
      @location = options['location']
      @executor = nil
    end

    def update!
      restart!(pull_changes: true)
    end

    def restart!(pull_changes: false)
      ::Net::SSH.start(host, user) do |ssh|
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
