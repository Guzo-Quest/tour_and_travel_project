class CreateApiV1Categories < ActiveRecord::Migration[7.1]
  def change
    create_table :api_v1_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
