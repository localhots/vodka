module Hren
  class Configuration
    attr_accessor :secret
  end

  module Configurable
    def config
      @config ||= Configuration.new
    end

    def configure
      yield config if block_given?
    end
  end
end
