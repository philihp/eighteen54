class CompaniesController < ApplicationController

  before_action :set_company
  before_action :set_instance
  before_action :set_player

  def index
  end

  def show
  end

  def bid
    amount = params[:amount].to_i
    bid = Bid.new(amount: amount)

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

    if bid.save && @player.save
      @instance.from_round.next_player!
      flash[:success] = "Bid #{bid.amount} G. on #{bid.company.name} by #{bid.player.name}"
    else
      flash[:error] = 'Unable to create bid.'
    end
    redirect_to @instance
  end

  def set_par_and_buy
    par_value = params[:par_value].to_i
    director_certificate = @company.certificates.where(percent: 40).first
    if @company.cost.present?
      flash[:error] = "Can't set par value. #{@company.name} already one of #{@company.cost}."
    elsif director_certificate.player.present?
      flash[:error] = "Can't buy company share, #{director_certificate.player.name} already holds the director certificate."
    else
      @company.cost = par_value
      @player.wallet -= par_value * director_certificate.percent / 10
      @player.save
      director_certificate.player = @player
      if  director_certificate.save && @company.save && @player.save
        @instance.from_round.next_player!
        flash[:success] = "Par value set to #{par_value} and director certificate awarded to #{@player.name}."
      else
        flash[:error] = 'Unable to set par value and buy director certificate.'
      end
    end
    redirect_to @instance
  end

private

  def set_company
    @company = Company::Company.find(params[:id])
  end

  def set_instance
    @instance = Instance.find(params[:instance_id])
  end

  def set_player
    @player = @instance.active_player
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
