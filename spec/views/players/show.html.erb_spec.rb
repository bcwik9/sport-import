require 'rails_helper'

RSpec.describe "players/show", type: :view do
  before(:each) do
    @player = assign(:player, Player.create!(
      :player_id => 1,
      :sport => "Sport",
      :first_name => "First Name",
      :last_name => "Last Name",
      :position => "Position",
      :age => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Sport/)
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Position/)
    expect(rendered).to match(/2/)
  end
end
