class AddDefaultValueToArchive < ActiveRecord::Migration[7.0]
  def change
    change_column :groups, :archive, :boolean, default: false
  end
end
