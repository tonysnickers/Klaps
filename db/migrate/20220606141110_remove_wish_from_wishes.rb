class RemoveWishFromWishes < ActiveRecord::Migration[7.0]
  def change
    remove_column :wishes, :wish
  end
end
