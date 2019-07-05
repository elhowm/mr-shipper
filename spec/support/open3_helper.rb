# frozen_string_literal: true

Open3.class_eval do
  def self.popen3(cmd)
    stdin = OpenStruct.new
    stdout = OpenStruct.new(gets: true)
    stderr = OpenStruct.new(gets: true)
    wait_thr = OpenStruct.new(value: 0)

    yield(stdin, stdout, stderr, wait_thr)
    Shipper::TestHelpers::Watcher.instance.log_local!(cmd)
  end
end
