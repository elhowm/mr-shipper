# frozen_string_literal: true

# Monkey path logger to not output anything
module Shipper
  class Logger
    def puts(msg)
      true
    end
  end
end
