require 'action_controller' unless defined?(::ActionController)

module Vodka
  module Server
    class VodkaController < ::ActionController::Base
      include Handlers::Scaffold
      include Handlers::Resource
      include Handlers::Response

      before_filter :set_response_id, :set_locale
      before_filter :handle_not_found, only: [:show, :update, :destroy]

    private

      def set_locale
        return unless defined?(I18n)
        locale = request.headers['X-Response-Locale']
        I18n.locale = locale if locale.present? && locale.to_sym.in?(I18n.available_locales)
      end

      def handle_not_found
        not_found if resource.nil? && vodka_response.success == false
      end

      def set_response_id
        vodka_response.id = request.headers['X-Request-Id']
      end
    end
  end
end

VodkaController = Vodka::Server::VodkaController
