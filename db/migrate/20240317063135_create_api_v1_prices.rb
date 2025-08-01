class CreateApiV1Prices < ActiveRecord::Migration[7.1]
  def change
    create_table :api_v1_prices do |t|
      t.float :amount
      t.string :currency
      t.references :tour, null: false, foreign_key: { to_table: :api_v1_tours }

      t.timestamps
    end
  end
end
