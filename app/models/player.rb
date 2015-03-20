class Player < ActiveRecord::Base
  validates_presence_of :player_id, :sport, :first_name, :last_name

  def name_brief
    case sport
    when /basketball/i
      "#{first_name} #{last_name.first}."
    when /baseball/i
      "#{first_name.first}. #{last_name.first}."
    when /football/i
      "#{first_name.first}. #{last_name}"
    end
  end

  def age_diff
    'TODO: implement me'
  end
end
