class CreateOrderedChoices < ActiveRecord::Migration[7.0]
  def change
    create_table :ordered_choices do |t|
      t.integer :point
      t.references :movie, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
