class InstanceInAuction < Instance

  # Pass to the next player.
  def pass!
    next_player!
    self.passes += 1
    self.save
    if self.passes < self.players.count
      "#{self.passes} of #{self.players.count} players have passed."
    elsif self.companies.unowned.first.instance_of? Company::Ausserfernbahn
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
    company = companies.unowned.first
    certificate = company.certificates.first
    cost = company.cost
    player = self.active_player

    if player.wallet < cost
      return "Player doesn't have enough"
    end

    player.wallet -= cost
    player.save

    company.director = player
    company.save

    certificate.player = player
    certificate.save

    next_player!

    # Save who normally would have the active player, because we might go into bidding
    self.priority = self.active_player
    self.passes = 0
    self.save

    next_auction!

    "#{company.name} was purchased for #{cost} G. by #{player.name}"
  end

  def bump_round!
    self.stock_round!
    self.save
    self.from_round.start_round!
  end

  def reduce_first_cost!
    ausserfernbahn = self.companies.first
    ausserfernbahn.cost -= 5
    ausserfernbahn.save
    buy! if ausserfernbahn.cost == 0
  end

  def next_player!
    if self.active_company.nil?
      super
    else
      self.active_player = self.active_company.bids.last.player
      self.save
    end
  end

  def next_auction!
    # Buy companies while they have 1 bid. Go into auction if 2+ bids.
    self.companies.unowned.each do |c|
      if c.bids.count == 1
        # The player with the lone bid buys the property uncontested
        c.bids.first.execute!
      elsif c.bids.count == 0
        # Go back to general bidding with the option to buy the top
        self.active_player = self.priority
        self.priority = nil
        self.active_company = nil
        self.save
        return
      else
        # Begin an auction for the company
        self.active_player = c.bids.last.player
        self.active_company = c
        self.save
        return
      end
    end

    self.companies.reload
    unless self.companies.unowned.present?
      create_majors!
      bump_round!
    end
  end

  def create_majors!
    self.companies << Company::KaiserinElisabethWestbahn.create(instance: self)
    self.companies << Company::KaiserFranzJosephBahn.create(instance: self)
    self.companies << sb = Company::Sudbahn.create(instance: self)
    self.companies << Company::KronprinzRudolfBahn.create(instance: self)
    self.companies << Company::KarntnerBahn.create(instance: self)
    self.companies << Company::SalzburgerBahn.create(instance: self)
    self.companies << Company::NordtirolerStaatsbahn.create(instance: self)
    self.companies << vb = Company::VorarlbergerBahn.create(instance: self)

    semmeringbahn = Company::Company.where(instance: self, type: Company::Semmeringbahn.name).first
    semmeringbahn.tapped = true
    semmeringbahn.save
    sbcertificate = sb.certificates.second
    sbcertificate.player = semmeringbahn.director
    sbcertificate.save

    arlbergbahn = Company::Company.where(instance: self, type: Company::Arlbergbahn.name).first
    arlbergbahn.tapped = true
    arlbergbahn.save
    vbcertificate = vb.certificates.second
    vbcertificate.player = arlbergbahn.director
    vbcertificate.save
  end

end
