require 'rails_helper'

RSpec.describe "players/index", type: :view do
  before(:each) do
    assign(:players, [
      Player.create!(
        :player_id => 1,
        :sport => "Sport",
        :first_name => "First Name",
        :last_name => "Last Name",
        :position => "Position",
        :age => 2
      ),
      Player.create!(
        :player_id => 1,
        :sport => "Sport",
        :first_name => "First Name",
        :last_name => "Last Name",
        :position => "Position",
        :age => 2
      )
    ])
  end

  it "renders a list of players" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Sport".to_s, :count => 2
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Position".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
