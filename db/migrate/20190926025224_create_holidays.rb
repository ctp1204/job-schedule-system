class CreateHolidays < ActiveRecord::Migration[5.2]
  def change
    create_table :holidays do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.datetime :start
      t.datetime :end
      t.string :color

      t.timestamps
    end
  end
end
