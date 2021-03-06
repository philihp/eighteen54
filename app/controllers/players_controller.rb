class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :set_instance

  # GET /players
  # GET /players.json
  def index
    @players = @instance.players
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
    @player.instance = @instance
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)
    @player.instance = @instance

    respond_to do |format|
      if @player.save
        format.html { redirect_to [@instance, 'players'], flash: {success: 'Player was successfully created.' }}
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
        format.html { redirect_to [@instance, @player], flash: {success: 'Player was successfully updated.' }}
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
      format.html { redirect_to instance_players_url, flash: {success: 'Player was successfully destroyed.' }}
      format.json { head :no_content }
    end
  end

  private

    def set_player
      @player = Player.find(params[:id])
    end

    def set_instance
      @instance = Instance.find(params[:instance_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:name)
    end
end
