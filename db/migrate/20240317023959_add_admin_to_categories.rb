class AddAdminToCategories < ActiveRecord::Migration[7.1]
  def change
    add_reference :api_v1_categories, :admin, null: false, foreign_key: true
  end
end
