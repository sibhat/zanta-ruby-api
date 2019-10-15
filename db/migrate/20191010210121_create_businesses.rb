class CreateBusinesses < ActiveRecord::Migration[5.2]
  def change
    create_table :businesses do |t|
      t.string :business_name
      t.references :user, foreign_key: true
      t.string :location
      t.float :rating
      t.float :on_time_delivery
      t.float :order_completion
      t.decimal :last_month_earning

      t.timestamps
    end
  end
end
