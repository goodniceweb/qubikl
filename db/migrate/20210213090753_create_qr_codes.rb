class CreateQrCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :qr_codes do |t|
      t.string :external_id, unique: true
      t.string :data
      t.integer :scans

      t.timestamps
    end
  end
end
