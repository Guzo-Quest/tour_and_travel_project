class CreateApiV1Reviews < ActiveRecord::Migration[7.1]
  def change
    create_table :api_v1_reviews do |t|
      t.references :tour, null: false, foreign_key: { to_table: :api_v1_tours }
      t.references :user, null: false, foreign_key: true
      t.integer :rating, null: false
      t.text :review_text, null: false

      t.timestamps
    end
  end
end
