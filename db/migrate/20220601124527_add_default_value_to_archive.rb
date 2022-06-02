class AddDefaultValueToArchive < ActiveRecord::Migration[7.0]
  def up
    change_column :groups, :archive, :boolean, default: false
  end
  def down
    change_column :groups, :archive, :boolean
  end
end
