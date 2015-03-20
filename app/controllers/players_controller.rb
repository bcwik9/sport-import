class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

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

    # Map ID to player_id
    id = query_params.delete 'id'
    unless query_params.has_key? 'player_id'
      query_params[:player_id] = id
    end
    
    # if we're not searching for a player, return all players
    if query_params.empty?
      @players = Player.all
    else
      # search for specific players
      @players = Player.where query_params
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
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
