# frozen_string_literal: true

module Shipper
  module TestHelpers
    class Watcher
      include Singleton

      attr_reader :local_log, :host_log

      def initialize
        reset_logs!
      end

      def reset_logs!
        @local_log = []
        @host_log = []
      end

      def log_local!(cmd)
        local_log << cmd
      end

      def log_host!(cmd)
        host_log << cmd
      end
    end
  end
end

RSpec.configure do |config|
  config.before(:each) do
    Shipper::TestHelpers::Watcher.instance.reset_logs!
  end
end
