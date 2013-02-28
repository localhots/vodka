module Vodka
  class Configuration
    attr_accessor :request_secret,          # Secret token to use in signing requests, stronger is better
                  :response_secret,         # Secret token to use in signing responses, stronger is better
                  :digest,                  # Digest algorithm to use in signing process
                  :perform_request_signing, # If the value is set to false no signing middlewares will be injected
                  :her_auto_configure,      # Configure Her automatically
                  :api_url,                 # REST API endpoint passed to Her
                  :prefix                   # Almost the same thing, path prefix for server

    def initialize
      @digest = Digest::SHA512
      @perform_request_signing = true
      @her_auto_configure = true
    end

    def configure_her!
      raise Exception.new('api_url must be set') if api_url.nil?

      ::Her::API.setup(url: api_url) do |c|
        c.use(Vodka::Client::Middleware::ErrorAware)
        c.use(Vodka::Client::Middleware::SignedRequest) if perform_request_signing
        c.use(Faraday::Request::UrlEncoded)
        c.use(Vodka::Client::Middleware::SignedResponse) if perform_request_signing
        c.use(::Her::Middleware::SecondLevelParseJSON)
        c.use(Faraday::Adapter::NetHttp)
      end
    end
  end

  module Configurable
    def config
      @config ||= Configuration.new
    end

    def configure
      yield config if block_given?
      config.configure_her! if config.her_auto_configure
    end
  end
end
