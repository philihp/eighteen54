class InstanceInStockRound < Instance

  def pass!
    next_player!
    self.passes += 1
    if self.passes < self.players.count
      self.save
      "#{self.passes} of #{self.players.count} players have passed."
    else
      self.passes = 0
      self.priority = self.active_player
      bump_round!
      "Everyone has passed. Going to Operating Round 1."
    end
  end

  def bump_round!
    self.operating_round_1!
    self.save
    # self.from_round.start_round!
  end

  def start_round!
    self.active_player = self.priority
    self.save
  end

end
