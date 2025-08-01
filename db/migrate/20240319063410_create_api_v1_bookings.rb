class CreateApiV1Bookings < ActiveRecord::Migration[7.1]
  def change
    create_table :api_v1_bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tour, null: false, foreign_key: { to_table: :api_v1_tours}
      t.string :booking_status, default: "pending", null: false

      t.timestamps
    end
  end
end
