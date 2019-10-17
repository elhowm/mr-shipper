# frozen_string_literal: true

module Shipper
  class Run
    attr_reader :config, :options

    def initialize(options)
      @config = ::Shipper::Config.new(env: options[0] || 'production')
      @options = options.empty? ? nil : options
      @options&.delete(0) # remove env
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
