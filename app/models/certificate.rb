class Certificate < ApplicationRecord

  belongs_to :instance

  belongs_to :player,
             optional: true

  belongs_to :company,
             class_name: 'Company::Company'

  # Remembers that a player sold stock of this company this SR, so they cannot
  # buy stock from the same company in the same round. These should all be cleared
  # at the end of the SR.
  belongs_to :sold_by,
             class_name: 'Player',
             optional: true

  # This indicates that a stock is optioned by this player.
  has_one :optioning_player,
          class_name: 'Player',
          foreign_key: 'optioned_share_id',
          inverse_of: :optioned_share

  scope :unowned, -> { where(player: nil) }
  scope :owned, -> { where.not(player: nil) }

  def optioned?
    self.player.try(:optioned_share) == self
  end

  def effective_percent
    if optioned?
      self.percent / 2
    else
      self.percent
    end
  end

  def cost
    return false if self.company.cost.nil?
    self.company.cost * self.percent / 10
  end

  def buy!(player)
    money = cost
    player.wallet -= money
    instance.bank += money
    self.player = player
  end

end
