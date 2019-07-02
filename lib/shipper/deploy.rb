# frozen_string_literal: true

module Shipper
  class Deploy
    attr_reader :config, :specified_services

    def initialize(config, specified_services = nil)
      @config = config
      @specified_services = specified_services
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
      config.services
            .select { |name, _| !service_ignored?(name) }
            .map { |name, config| ::Shipper::Service.new(name, config) }
    end

    def service_ignored?(name)
      specified_services && !specified_services.include?(name.to_s)
    end

    def logger
      ::Shipper::Logger.instance
    end
  end
end
