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

  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.preowned = false
  end

  def optioned?
    self.player.try(:optioned_share) == self
  end

  def sellable?
    self.company.charter_type == :major &&
      [nil, self].include?(self.player.optioned_share) &&
      self.instance.stock_rounds > 1
  end

  def counts_toward_limit?
    x = self.company.value_x
    y = self.company.value_y
    !(y == 0 ||
      y == 1 && [0,1,4,5].include?(x) ||
      y == 2 && [0,5,6].include?(x))
  end

  def sell_value
    self.company.value
  end

  def sell!
    amount = sell_value

    self.player.wallet += amount
    self.player.save

    self.instance.bank -= amount
    self.instance.save

    self.sold_by = self.player
    self.player = nil
    self.preowned = true
    self.save
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
    # TODO: If the company has split, the money goes to the company treasury
    money = cost
    player.wallet -= money
    self.instance.bank += money
    self.player = player
    self.preowned = true
    self.instance.save
  end

  def option!(player)
    # TODO: If the company has split, the money goes to the company treasury
    money = cost / 2
    player.optioned_share = self
    player.wallet -= money
    self.instance.bank += money
    self.player = player
    self.preowned = true
    self.instance.save
    player.save
  end

  def execute_option!
    # TODO: If the company has split, the money goes to the company treasury
    money = cost / 2
    self.player.optioned_share = nil
    self.player.wallet -= money
    self.player.save
    self.instance.bank += money
    self.instance.save
  end

end
