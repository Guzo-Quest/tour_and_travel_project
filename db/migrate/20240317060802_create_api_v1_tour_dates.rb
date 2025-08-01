class CreateApiV1TourDates < ActiveRecord::Migration[7.1]
  def change
    create_table :api_v1_tour_dates do |t|
      t.date :start_date
      t.date :end_date
      t.references :tour, null: false, foreign_key: { to_table: :api_v1_tours }
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
