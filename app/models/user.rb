class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :qr_codes, dependent: :destroy
  has_many :domains, class_name: 'UserDomain'

  validates :locale, presence: true, inclusion: { in: %w(en ru) }
end
