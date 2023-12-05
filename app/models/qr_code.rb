class QrCode < ApplicationRecord
  attribute :scans, :integer, default: 0

  before_save :ensure_external_id

  private

  def ensure_external_id
    return if external_id.present?

    potential_external_id = SecureRandom.hex(5)
    potential_external_id = SecureRandom.hex(5) while self.class.exists?(external_id: potential_external_id)

    self.external_id = potential_external_id
  end
end
