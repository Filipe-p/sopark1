class CreateCars < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.references :user, foreign_key: true
      t.string :registration

      t.timestamps
    end
  end
end
