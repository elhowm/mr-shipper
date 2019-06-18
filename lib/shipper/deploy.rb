# frozen_string_literal: true

module Shipper
  class Deploy
    attr_reader :config

    def initialize
      @config = Shipper::Config.instance
    end

    def perform
      ship_services!
      update_host!
    end

    private

    def ship_services!
      logger.headline('Shipping services..')
      services = load_services
      services.each(&:ship!)
      logger.headline('Services shipped!')
    end

    def update_host!
      logger.headline('Updating host..')
      host = ::Shipper::Host.new(config.host)
      host.update!
      logger.headline('Host updated!')
    end

    def load_services
      config.services.map do |name, config|
        ::Shipper::Service.new(name, config)
      end
    end

    def logger
      ::Shipper::Logger.instance
    end
  end
end
