class InstanceInStockRound < Instance

  def bump_round!
    self.operating_round_1!
    self.save
    self.from_round.start_round!
  end

  def start_round!
    self.active_player = self.priority
    self.save
  end

end
