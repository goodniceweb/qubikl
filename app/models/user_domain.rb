class UserDomain < ApplicationRecord
  belongs_to :user

  has_many :qr_codes, dependent: :destroy

  validates :name, presence: true
end
