# frozen_string_literal: true

module Shipper
  class Run
    attr_reader :config, :options

    def initialize(options)
      @options = options.empty? ? nil : options
      @config = ::Shipper::Config.instance
    end

    def perform
      if restart?
        ::Shipper::Host.new(config.host).restart!
      else
        ::Shipper::Deploy.new(config, options).perform
      end
    end

    private

    def restart?
      options&.size == 1 && options[0] == 'restart'
    end
  end
end
