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

  it "renders attributes as json" do
    render
    json = JSON.parse rendered

    expected_response = {
      :id => 1,
      :first_name => "First Name",
      :last_name => "Last Name",
      :position => "Position",
      :age => 2
    }
    
    expected_response.each do |k,v|
      expect(json[k.to_s]).to eq v
    end
  end
end
