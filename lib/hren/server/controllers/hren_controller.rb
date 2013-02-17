module Hren
  module Server
    class HrenController < ApplicationController
      include Handlers::Scaffold
      include Handlers::Resource
      include Handlers::Response

      before_filter :fix_params_names, :set_locale
      before_filter :handle_not_found, only: [:show, :update, :destroy]

    private

      def set_locale
        return unless defined?(I18n)
        locale = request.headers['X-Response-Locale']
        I18n.locale = locale if locale.present? && locale.in?(I18n.available_locales)
      end

      def fix_params_names
        params[:password] = params.delete(:buzzword) unless params[:buzzword].nil?
      end

      def handle_not_found
        return not_found if resource.nil?
      end
    end
  end
end
