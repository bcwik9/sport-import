class PlayersController < ApplicationController
  before_action :set_player, only: [:show]
  before_action :set_default_response_format

  # GET /players
  # GET /players.json
  def index
    # determine if we have any player parameters to search for
    # first figure out what attributes are valid
    player_attributes = Player.columns.collect { |c| c.name }
    # iterate through params and add the ones which match up with player attributes
    query_params = {}
    params.each do |k,v| 
      query_params[k] = v if player_attributes.include? k
    end

    # Map id to player_id since we don't really care about the actual
    # id assigned to the record by rails
    id = query_params.delete 'id'
    query_params['player_id'] = id unless query_params.has_key? 'player_id' or id.nil?

    # Map average_position_age_diff to age_diff
    age_diff = params.delete 'average_position_age_diff'
    query_params['age_diff'] = age_diff unless query_params.has_key? 'age_diff' or age_diff.nil?
    
    # if we're not searching for a player, return all players
    if query_params.empty?
      @players = Player.all
    else
      # search for specific players, but be case insensitive
      # might be a more efficient way to do this
      query_params.each do |k,v|
        where_params = ["lower(#{k}) = ? ", v.downcase]
        if @players.nil?
          @players = Player.where(*where_params)
        else
          @players = @players.where(*where_params)
        end
      end
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  protected

  # Always return json
  def set_default_response_format
    request.format = :json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:player_id, :sport, :first_name, :last_name, :position, :age, :name_brief, :age_diff)
    end

end
