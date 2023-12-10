class CreateVisits < ActiveRecord::Migration[7.1]
  def change
    create_table :visits do |t|
      t.references :qr_code, null: false, foreign_key: true
      t.string :country
      t.string :referrer
      t.string :device
      t.string :os

      t.timestamps
    end
  end
end
