module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user_locale

    rescue_from ActiveRecord::RecordNotFound do
      redirect_to '/404', alert: "Oops! The page you're looking for does not exist."
    end
    rescue_from CanCan::AccessDenied do
      redirect_to '/404', alert: "Oops! The page you're looking for does not exist."
    end

    private

    def set_user_locale
      I18n.locale = current_user&.locale ||
                    extract_locale_from_accept_language_header ||
                    I18n.default_locale
    end

    def extract_locale_from_accept_language_header
      request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
    end
  end
end
