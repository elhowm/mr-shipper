# frozen_string_literal: true

require 'colorize'

module Shipper
  class Logger
    include Singleton

    attr_reader :io_splitter

    def initialize
      @io_splitter = '#' * 5
    end

    def headline(phrase)
      puts "##### #{phrase}".bold.green
    end

    def bold(phrase)
      puts "# #{phrase}".bold.yellow
    end

    def error(phrase)
      puts "# #{phrase}".bold.red
    end

    def puts(phrase)
      super(phrase)
    end

    def success!
      puts '# Success!'.green
    end
  end
end
