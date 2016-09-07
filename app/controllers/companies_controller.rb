class CompaniesController < ApplicationController

  before_action :set_company
  before_action :set_instance

  def index
  end

  def show
  end

  def bid
    amount = params[:amount].to_i
    bid = Bid.new(amount: amount)
    @player = @instance.active_player

    unless @company.minimum_bid <= bid.amount
      flash[:error] = "Must bid a minimum of #{@company.minimum_bid}"
      return redirect_to @instance
    end
    unless can_afford_bid(amount)
      flash[:error] = "#{@player.name} doesn't have enough money to bid that"
      return redirect_to @instance
    end

    retract_any_old_bid!

    bid.company = @company
    bid.player = @player
    @player.wallet -= bid.amount

    if @player.save && bid.save
      @instance.next_player!
      flash[:success] = "Bid #{bid.amount} G. on #{bid.company.name} by #{bid.player.name}"
      redirect_to @instance
    else
      flash[:error] = "Unable to create bid"
    end
  end

private

  def set_company
    @company = Company::Company.find(params[:id])
  end

  def set_instance
    @instance = Instance.find(params[:instance_id])
  end

  def retract_any_old_bid!
    return unless bid = Bid.where(company: @company, player: @player).first
    @player.wallet += bid.amount
    @player.save
    bid.destroy
  end

  def can_afford_bid(amount)
    old_bid = Bid.where(company: @company, player: @player).first
    bankroll = @player.wallet + (old_bid.try(:amount) || 0)
    bankroll >= amount
  end

end
