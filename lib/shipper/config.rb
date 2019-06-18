# frozen_string_literal: true

require 'ostruct'
require 'singleton'
require 'yaml'

module Shipper
  class Config < ::OpenStruct
    include Singleton

    def initialize
      config = ::YAML::load_file("#{Dir.pwd}/shipper.yml")
      super(config)
    end
  end
end
