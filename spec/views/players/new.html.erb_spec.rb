require 'rails_helper'

RSpec.describe "players/new", type: :view do
  before(:each) do
    assign(:player, Player.new(
      :player_id => 1,
      :sport => "MyString",
      :first_name => "MyString",
      :last_name => "MyString",
      :position => "MyString",
      :age => 1
    ))
  end

  it "renders new player form" do
    render

    assert_select "form[action=?][method=?]", players_path, "post" do

      assert_select "input#player_player_id[name=?]", "player[player_id]"

      assert_select "input#player_sport[name=?]", "player[sport]"

      assert_select "input#player_first_name[name=?]", "player[first_name]"

      assert_select "input#player_last_name[name=?]", "player[last_name]"

      assert_select "input#player_position[name=?]", "player[position]"

      assert_select "input#player_age[name=?]", "player[age]"
    end
  end
end
