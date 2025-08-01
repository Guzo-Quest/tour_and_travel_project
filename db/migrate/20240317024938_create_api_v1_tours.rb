class CreateApiV1Tours < ActiveRecord::Migration[7.1]
  def change
    create_table :api_v1_tours do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :duration, null: false
      t.string :image
      t.references :category, null: false, foreign_key: { to_table: :api_v1_categories }
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
    add_index :api_v1_tours, :name, unique: true
  end
end
