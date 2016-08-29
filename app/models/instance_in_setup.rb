class InstanceInSetup < Instance

  class WrongNumberOfPlayersError < StandardError
  end

  class UnderfundedBankError < StandardError
  end

  def bump_round!
    socialize_the_bank!
    randomize_player_order!
    create_privates!
    self.round = :auction
  end

private

  def socialize_the_bank!
    raise WrongNumberOfPlayersError if players.size < 3 || players.size > 6
    start_capital = case players.size
                    when 3
                      860
                    when 4
                      650
                    when 5
                      525
                    when 6
                      450
                    end
    raise UnderfundedBankError if self.bank <= start_capital * players.size
    self.players.each do |player|
      player.wallet += start_capital
      player.save
      self.bank -= start_capital
    end
  end

  def randomize_player_order!
    shuffled = self.players.shuffle
    shuffled.each_with_index do |player, index|
      player.turn_order = index
      player.save
    end
    self.active_player = shuffled.first
  end

  def create_privates!
    self.companies << Company::Ausserfernbahn.new
    self.companies << Company::Murtalbahn.new
    self.companies << Company::GrazKoflacherBahn.new
    self.companies << Company::Arlbergbahn.new
    self.companies << Company::Semmeringbahn.new
  end

end
