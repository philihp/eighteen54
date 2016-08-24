class InstanceInAuction < Instance

  def bump_round!
    self.share_round!
  end

end
