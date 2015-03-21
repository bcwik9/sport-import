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

  it "renders a list of players as json" do
    render
    json_response = JSON.parse(response)

    expected_response = {
      :id => 1,
      :first_name => "First Name",
      :last_name => "Last Name",
      :position => "Position",
      :age => 2
    }
    
    expect(json_response.size).to eq 2
    expect(json_response.first).to eq json_response.last
    expected_response.each do |k,v|
      expect(json_response.first[k.to_s]).to eq v
    end
  end
end
