module Hren
  class Configuration
    attr_accessor :secret, :api_url
  end

  module Configurable
    def config
      @config ||= Configuration.new
    end

    def configure
      yield config if block_given?
    end

    def configure_her!
      ::Her::API.setup(url: Hren::Client.config.api_url) do |c|
        c.use Hren::Client::Middleware::ErrorAware
        c.use Hren::Client::Middleware::SignedRequest
        c.use Faraday::Request::UrlEncoded
        c.use ::Her::Middleware::SecondLevelParseJSON
        c.use Faraday::Adapter::NetHttp
      end
    end
  end
end
