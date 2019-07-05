# frozen_string_literal: true

module Shipper
  class Service
    attr_reader :name, :path, :before_build, :repo

    def initialize(name, options)
      @name = name
      @path = "#{Dir.pwd}/#{options['path']}"
      @before_build = options['before_build']
      @repo = options['repo']
    end

    def ship!
      executor.cd(path)
      before_build&.each { |cmd| exec(cmd) }
      exec "docker build . -t #{repo}"
      exec "docker push #{repo}"
    end

    private

    def exec(cmd)
      executor.exec(cmd)
    end

    def executor
      @executor ||= ::Shipper::Executor.new
    end
  end
end
