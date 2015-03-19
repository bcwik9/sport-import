class Player < ActiveRecord::Base
  validates_presence_of :player_id, :sport, :last_name
end
