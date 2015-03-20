namespace :data do
  require 'open-uri'

  # URLs to CBS Sport API
  BASE_CBS_URL = 'http://api.cbssports.com/fantasy/players/list'
  
  # supported sports
  SPORTS = ['baseball', 'basketball', 'football']
  
  desc 'Import data from CBS Sports API to database'
  task :import => :environment do
    # Create URI from base CBS URL
    uri = URI.parse BASE_CBS_URL
    
    # Import data for each sport
    SPORTS.each do |sport|
      # Store players so we can commit them all at once quickly
      players_store = []

      # Store players ages per position
      average_ages = {}
      
      # Add necessary params to URI, including specific sport
      uri.query = URI.encode_www_form({
                                        :SPORT => sport,
                                        :version => '3.0',
                                        :response_format => 'JSON'
                                      })
      # Grab the data from CBS
      players = JSON.parse(uri.open.read)['body']['players']
      # Iterate through all players and add them to the database
      players.each do |player|
        player_params = {
          :player_id => player['id'],
          :sport => sport,
          :first_name => player['firstname'],
          :last_name => player['lastname'],
          :position => player['position'],
          :age => player['age']
        }
        # Disregard age if it isn't realistic
        player_params[:age] = nil if player_params[:age] > 100 if player_params[:age]

        # Set the name brief
        player_params[:name_brief] =
          case sport
          when /basketball/i
            "#{player_params[:first_name]} #{player_params[:last_name].first}."
          when /baseball/i
            "#{player_params[:first_name].first}. #{player_params[:last_name].first}."
          when /football/i
            "#{player_params[:first_name].first}. #{player_params[:last_name]}"
          end

        # Check that the new player is valid
        new_player = Player.new player_params
        unless new_player.valid?
          Rails.logger.info new_player.errors.to_yaml
          Rails.logger.info player_params.to_s
          Rails.logger.info player.to_s
          raise 'Encountered invalid player. Check log for more info'
        end

        # Add age to our average ages
        if new_player.age and new_player.position
          average_ages[new_player.position] ||= []
          average_ages[new_player.position].push new_player.age
        end

        # Add player to our temporary store
        players_store.push new_player
      end

      # Calculate average ages
      average_ages.each do |position, ages|
        average_age = ages.sum / ages.size
        average_ages[position] = average_age
      end
      
      # Store average ages in in player model so we dont have to do an additional fetch
      players_store.each do |player|
        unless player[:age].nil?
          player[:age_diff] = player[:age] - average_ages[player[:position]]
        end
      end

      # Now commit all players to the database
      Player.import players_store
      puts "Imported #{players_store.size} #{sport} players!"
    end
  end
end
