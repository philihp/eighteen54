class InstancesController < ApplicationController
  before_action :set_instance, except: [:index, :new, :create ]

  # GET /instances
  # GET /instances.json
  def index
    @instances = Instance.all
  end

  # GET /instances/1
  # GET /instances/1.json
  def show
  end

  # GET /instances/new
  def new
    @instance = Instance.new
  end

  # GET /instances/1/edit
  def edit
  end

  # POST /instances
  # POST /instances.json
  def create
    @instance = Instance.new(instance_params)

    respond_to do |format|
      if @instance.save
        format.html { redirect_to @instance, flash: {success: 'Instance was successfully created.' }}
        format.json { render :show, status: :created, location: @instance }
      else
        format.html { render :new }
        format.json { render json: @instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instances/1
  # PATCH/PUT /instances/1.json
  def update
    respond_to do |format|
      if @instance.update(instance_params)
        format.html { redirect_to @instance, flash: {success: 'Instance was successfully updated.' }}
        format.json { render :show, status: :ok, location: @instance }
      else
        format.html { render :edit }
        format.json { render json: @instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instances/1
  # DELETE /instances/1.json
  def destroy
    @instance.destroy
    respond_to do |format|
      format.html { redirect_to instances_url, flash: {success: 'Instance was successfully destroyed.' }}
      format.json { head :no_content }
    end
  end

  def bump_round
    begin
      @instance.from_round.bump_round!
      @instance.save
      flash[:success] = "A new round has begun. It is now #{@instance.round.titleize}"
    rescue InstanceInSetup::WrongNumberOfPlayersError
      flash[:error] = "Game require 3-6 players."
    end
    redirect_to @instance
  end

  def bump_phase
    @instance.bump_phase!
    @instance.save
    flash[:success] = "The current instance's phase has moved forward. It is now phase #{@instance.phase}."
    redirect_to @instance
  end

  def auction_pass
    unless @instance.from_round.instance_of? InstanceInAuction
      flash[:error] = "Can't pass in an auction unless the instance is currently in the auction phase"
      return redirect_to @instance
    end
    result_message = @instance.from_round.pass!
    @instance.save
    flash[:success] = result_message
    redirect_to @instance
  end

  def auction_buy
    flash[:success] = @instance.from_round.buy!
    @instance.save
    redirect_to @instance
  end

  def next_player
    @instance.next_player!
    @instance.save
    flash[:success] = "Active player passed to the next player."
    redirect_to @instance
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_instance
    @instance = Instance.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def instance_params
    params.require(:instance).permit(:round, :name)
  end
end
