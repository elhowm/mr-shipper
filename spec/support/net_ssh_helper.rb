# frozen_string_literal: true

module Shipper
  module TestHelpers
    class HostSSH
      def exec!(cmd)
        Shipper::TestHelpers::Watcher.instance.log_host!(cmd)
        yield
      end
    end
  end
end

Net::SSH.class_eval do
  def self.start(host, user)
    yield(Shipper::TestHelpers::HostSSH.new)
  end
end
