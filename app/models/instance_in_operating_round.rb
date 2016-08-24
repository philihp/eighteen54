class InstanceInOperatingRound < Instance

  def bump_round!
    if self.round.to_sym == :operating_round_1 && phase > 2
      self.operating_round_2!
    elsif self.round.to_sym == :operating_round_2 && phase > 4
      self.operating_round_3!
    else
      self.share_round!
    end
  end

end
