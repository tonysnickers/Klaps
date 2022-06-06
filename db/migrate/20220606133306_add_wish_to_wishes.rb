class AddWishToWishes < ActiveRecord::Migration[7.0]
  def change
    add_column :wishes, :wish, :boolean, default: false
  end
end
