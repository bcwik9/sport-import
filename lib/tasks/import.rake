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
      # store players so we can commit them all at once quickly
      players_store = []
      
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
        # Check that the new player is valid
        new_player = Player.new player_params
        unless new_player.valid?
          Rails.logger.info new_player.errors.to_yaml
          Rails.logger.info player_params.to_s
          Rails.logger.info player.to_s
          raise 'Encountered invalid player. Check log for more info'
        end

        # Add player to our temporary store
        players_store.push new_player
      end
      
      # Now commit all players to the database
      Player.import players_store
      puts "Imported #{players_store.size} #{sport} players!"
    end
  end
end
