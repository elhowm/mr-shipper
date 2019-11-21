# frozen_string_literal: true

module Shipper
  class Run
    attr_reader :config, :options, :env

    COMMANDS = %w[restart].freeze

    def initialize(options)
      pop_env!(options)
      @config = ::Shipper::Config.new(env: env)
      @options = options.empty? ? nil : options
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

    def pop_env!(options)
      if options.empty? || COMMANDS.include?(options[0])
        @env = 'production'
      else
        @env = options.delete_at(0)
      end
    end
  end
end
