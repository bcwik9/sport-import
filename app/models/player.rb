class Player < ActiveRecord::Base
  validates_presence_of :player_id, :sport, :last_name

  def to_json
    brief = case @sport
            when /basketball/i
              "#{@first_name} #{@last_name.first}."
            when /baseball/i
              "#{@first_name.first}. #{@last_name.first}."
            when /football/i
              "#{@first_name.first}. #{@last_name}"
            end
    # return
    return {
      :id => @player_id,
      :name_brief => brief,
      :first_name => @first_name,
      :last_name => @last_name,
      :position => @position,
      :age => @age,
      :average_position_age_diff => 'TODO: implement me!'
    }.to_json
  end
end
