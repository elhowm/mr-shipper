# frozen_string_literal: true

require 'ostruct'
require 'singleton'
require 'yaml'

module Shipper
  class Config < ::OpenStruct
    def initialize(config_path = nil)
      config_path ||= "#{Dir.pwd}/shipper.yml"

      config = ::YAML.load_file(config_path)
      super(config)
    end
  end
end
