# frozen_string_literal: true

Dir.class_eval do
  def self.chdir(path)
    path = path.gsub(Dir.pwd + '/', '')
    Shipper::TestHelpers::Watcher.instance.log_local!("cd #{path}")

    yield
  end
end
