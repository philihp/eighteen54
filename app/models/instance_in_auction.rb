class InstanceInAuction < Instance

  # Pass to the next player.
  def pass!
    next_player!
    self.passes += 1
    if self.passes < self.players.count
      "#{self.passes} of #{self.players.count} players have passed."
    elsif first_unowned_company.instance_of? Company::Ausserfernbahn
      reduce_first_cost!
      self.passes = 0
      "Everyone passed, but no one bought Ausserfernbahn, so its price has been reduced."
    else
      self.passes = 0
      self.auction_operating_round!
      "Everyone has passed. Going into auction operating round."
    end
  end

  # Buy the first private (assumes it has no bids)
  def buy!
    company = first_unowned_company
    cost = company.cost
    player = self.active_player

    if player.wallet < cost
      return "Player doesn't have enough"
    end

    player.wallet -= cost
    player.save

    company.director = player
    company.save

    next_player!
    "#{company.name} was purchased for #{cost} G. by #{player.name}"
  end

  def bump_round!
    self.share_round!
  end

  def reduce_first_cost!
    ausserfernbahn = self.companies.first
    ausserfernbahn.cost -= 5
    ausserfernbahn.save
    buy! if ausserfernbahn.cost == 0
  end

end
