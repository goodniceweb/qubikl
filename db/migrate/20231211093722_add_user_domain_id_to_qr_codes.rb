class AddUserDomainIdToQRCodes < ActiveRecord::Migration[7.1]
  def change
    add_reference :qr_codes, :user_domain, null: true, foreign_key: true
  end
end
