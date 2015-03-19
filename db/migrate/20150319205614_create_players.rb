class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :player_id
      t.string :sport
      t.string :first_name
      t.string :last_name
      t.string :position
      t.integer :age

      t.timestamps null: false
    end
  end
end
