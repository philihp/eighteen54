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
    company = @bid.company
    player.wallet += @bid.amount
    if player.save && @bid.destroy
      if company.being_auctioned?
        if company.has_only_one_bid?
          @instance.active_company = nil
          @bid = company.bids.first
          flash[:success] = "#{@bid.company.name} was purchased for #{@bid.amount} G. by #{@bid.player.name}"
          @bid.execute!
          @instance.from_round.next_auction!
        else
          flash[:success] = "Bid successfully retracted."
          @instance.from_round.next_auction!
        end
      else
        flash[:success] = "Bid successfully retracted."
      end
    else
      flash[:error] = "Unable to retract bid."
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
