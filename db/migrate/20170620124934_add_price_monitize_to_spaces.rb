class AddPriceMonitizeToSpaces < ActiveRecord::Migration[5.0]
  def change
    add_monetize :spaces, :price, currency: { present: false }
  end
end
