class CreateSpaces < ActiveRecord::Migration[5.0]
  def change
    create_table :spaces do |t|
      t.string :name
      t.string :location
      t.integer :owner_id
      t.boolean :covered
      t.boolean :staff
      t.boolean :charging
      t.boolean :gate
      t.boolean :cctv
      t.boolean :valet
      t.boolean :water

      t.timestamps
    end
  end
end
