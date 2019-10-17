# frozen_string_literal: true

require 'ostruct'
require 'singleton'
require 'yaml'

module Shipper
  class Config < ::OpenStruct
    def initialize(config_path: nil, env: nil)
      config_path ||= "#{Dir.pwd}/shipper.yml"
      env ||= 'production'

      config = load_env_config(config_path, env)
      super(config)
    end

    private

    def load_env_config(config_path, env)
      full_config = ::YAML.load_file(config_path)
      check_env_available!(full_config, env)

      hosts = full_config.delete('hosts')
      services = full_config.delete('services')

      full_config['host'] = hosts[env]
      full_config['services'] = services[env]
      full_config
    end

    def check_env_available!(config, env)
      services = !config.dig('services', env).nil?
      hosts = !config.dig('hosts', env).nil?

      puts "Error: No host available for env '#{env}'" unless hosts
      puts "Error: No services available for env '#{env}'" unless services
      exit(0) if !hosts || !services
    end
  end
end
