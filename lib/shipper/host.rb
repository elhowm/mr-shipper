# frozen_string_literal: true

module Shipper
  class Host
    attr_accessor :ssh_entry, :location, :executor

    def initialize(options)
      @ssh_entry = options['ssh_entry']
      @location = options['location']
      @executor = nil
    end

    def update!
      user, host = ssh_entry.split('@')

      ::Net::SSH.start(host, user) do |ssh|
        load_executor(ssh)

        executor.cd location
        exec 'docker-compose pull'
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
