class CreateAPIKeys < ActiveRecord::Migration[7.1]
  def change
    create_table :api_keys do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :secret

      t.timestamps
    end
  end
end
