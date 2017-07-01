class AddMoreAdressFieldToSpaces < ActiveRecord::Migration[5.0]
  def change
    add_column :spaces, :zip_code, :string
    add_column :spaces, :house_number, :float
    add_column :spaces, :street, :string
    add_column :spaces, :city_town, :float
    add_column :spaces, :country, :string
  end
end
