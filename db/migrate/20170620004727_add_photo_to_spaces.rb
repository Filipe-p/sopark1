class AddPhotoToSpaces < ActiveRecord::Migration[5.0]
  def change
    add_column :spaces, :photo, :string
  end
end
