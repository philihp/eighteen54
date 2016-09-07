class BidsController < ApplicationController

  before_action :set_company
  before_action :set_instance
  before_action :set_bid

  def destroy
    unless @bid.company == @company
      flash[:error] = "Bid #{@bid.id} was not made on company #{@company.id}"
      return redirect_to @instance
    end
    player = @bid.player
    player.wallet += @bid.amount
    if player.save && @bid.destroy
      flash[:success] = "Bid successfully retracted."
    else
      flash[:error] = "Unable to destroy bid."
    end
    redirect_to @instance
  end

private

  def set_bid
    @bid = Bid.find(params[:id])
  end

  def set_company
    @company = Company::Company.find(params[:company_id])
  end

  def set_instance
    @instance = Instance.find(params[:instance_id])
  end

end
