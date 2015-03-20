class AddNameBriefToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :name_brief, :string
  end
end
