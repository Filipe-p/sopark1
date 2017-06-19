class CreateCars < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.integer :owner_id
      t.string :registration

      t.timestamps
    end
  end
end
