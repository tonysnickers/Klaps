class AddPointsToAchieveToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :points_to_achieve, :integer, default: 0
  end
end
