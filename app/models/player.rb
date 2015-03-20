class Player < ActiveRecord::Base
  validates_presence_of :player_id, :sport, :last_name

  # query the AverageAge table to calcullate the age difference between
  # the player and the average age for the player's position
  #def age_diff
  #  if age
  #    average_age = AverageAge.where(:sport => sport, :position => position#)
 #     age - average_age.first.age
 #   else
 #     nil
 #   end
 # end
end
