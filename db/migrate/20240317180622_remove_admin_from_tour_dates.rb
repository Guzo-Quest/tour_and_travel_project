class RemoveAdminFromTourDates < ActiveRecord::Migration[7.1]
  def change
    remove_reference :api_v1_tour_dates , :admin, null: false, foreign_key: true
  end
end
