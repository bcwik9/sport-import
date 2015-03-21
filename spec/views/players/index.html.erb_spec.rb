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
    raise 'implement'
  end
end
