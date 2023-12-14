class APIKey < ApplicationRecord
  belongs_to :user

  attribute :name, :string, default: -> { I18n.t('activerecord.models.api_keys.default_name') }

  before_create :generate_secret

  private

  def generate_secret
    SecureRandom.hex(32).tap do |secret|
      self.secret = secret
    end
  end
end
