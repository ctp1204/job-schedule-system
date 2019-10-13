class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.datetime :start
      t.datetime :end
      t.integer :progress
      t.string :color

      t.timestamps
    end
  end
end
