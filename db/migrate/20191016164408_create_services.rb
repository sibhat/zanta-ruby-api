class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name
      t.date :from_date
      t.date :to_date
      t.time :from_time
      t.time :to_time
      t.boolean :is_completed
      t.string :description
      t.string :headline

      t.timestamps
    end
  end
end
