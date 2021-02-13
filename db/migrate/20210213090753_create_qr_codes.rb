class CreateQrCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :qr_codes do |t|
      t.string :data
      t.integer :scans

      t.timestamps
    end
  end
end
