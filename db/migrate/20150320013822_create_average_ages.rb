class CreateAverageAges < ActiveRecord::Migration
  def change
    create_table :average_ages do |t|
      t.string :sport
      t.string :position
      t.integer :age

      t.timestamps null: false
    end
  end
end
