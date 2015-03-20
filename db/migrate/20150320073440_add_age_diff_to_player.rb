class AddAgeDiffToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :age_diff, :integer
  end
end
