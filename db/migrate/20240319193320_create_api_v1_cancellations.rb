class CreateApiV1Cancellations < ActiveRecord::Migration[7.1]
  def change
    create_table :api_v1_cancellations do |t|
      t.references :booking, null: false, foreign_key: { to_table: :api_v1_bookings}
      t.text :reason

      t.timestamps
    end
  end
end
