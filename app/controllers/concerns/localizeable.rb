module Localizeable
  extend ActiveSupport::Concern

  included do
    before_action :set_user_locale
  end

  def set_user_locale
    I18n.locale = current_user&.locale ||
                  params[:locale] ||
                  extract_locale_from_accept_language_header ||
                  I18n.default_locale
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
  end
end
