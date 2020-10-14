# frozen_string_literal: true

module Shipper
  class Service
    attr_reader :name, :options, :path

    def initialize(name, options)
      @name = name
      @options = options
      @path = "#{Dir.pwd}/#{options['path']}"
    end

    def ship!
      executor.cd(path)
      options['before_build']&.each { |cmd| exec(cmd) }
      exec "docker build . -t #{options.fetch('repo')} #{build_args}".strip
      exec "docker push #{options.fetch('repo')}"
    end

    private

    def build_args
      return nil if options['args'].nil?

      options['args'].map { |key, value| "--build-arg #{key}=#{value}" }
                     .join(' ')
    end

    def exec(cmd)
      executor.exec(cmd)
    end

    def executor
      @executor ||= ::Shipper::Executor.new
    end
  end
end
