class CreateQRCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :qr_codes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :path_alias, unique: true
      t.string :destination
      t.string :domain
      t.string :png
      t.string :svg
      t.integer :visits_amount, default: 0

      t.timestamps
    end
  end
end
