module Vodka
  class Configuration
    attr_accessor :request_secret, :response_secret, :api_url, :digest

    def initialize
      @digest = Digest::SHA512
    end
  end

  module Configurable
    def config
      @config ||= Configuration.new
    end

    def configure
      yield config if block_given?
    end

    def configure_her!
      ::Her::API.setup(url: Vodka::Client.config.api_url) do |c|
        c.use Vodka::Client::Middleware::ErrorAware
        c.use Vodka::Client::Middleware::SignedRequest
        c.use Faraday::Request::UrlEncoded
        c.use Vodka::Client::Middleware::SignedResponse
        c.use ::Her::Middleware::SecondLevelParseJSON
        c.use Faraday::Adapter::NetHttp
      end
    end
  end
end
