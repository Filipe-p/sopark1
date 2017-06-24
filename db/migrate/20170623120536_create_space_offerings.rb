class CreateSpaceOfferings < ActiveRecord::Migration[5.0]
  def change
    create_table :space_offerings do |t|
      t.references :user, foreign_key: true
      t.references :space, foreign_key: true
      t.date :start_datetime
      t.date :end_datetime
      t.monetize :price, currency: { present: false }

      t.timestamps
    end
  end
end
