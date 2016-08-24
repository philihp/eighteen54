class InstanceInSetup < Instance

  class TooFewPlayersError < StandardError
  end

  class TooManyPlayersError < StandardError
  end

  def bump_round!
    raise TooFewPlayersError if players.size < 3
    raise TooManyPlayersError if players.size > 6
    self.auction!
  end

end
