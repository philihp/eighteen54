class InstanceInSetup < Instance

  class WrongNumberOfPlayersError < StandardError
  end

  def bump_round!
    start_capital = case players.size
                    when 3
                      860
                    when 4
                      650
                    when 5
                      525
                    when 6
                      450
                    else
                      raise WrongNumberOfPlayersError
                    end

    self.players.each do |player|
      player.wallet += start_capital
      self.bank -= start_capital
    end
    self.auction!
  end

end
