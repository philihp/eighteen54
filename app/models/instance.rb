class Instance < ApplicationRecord

  has_many :players,
           -> { order(:turn_order) },
           validate: true,
           dependent: :destroy

  has_many :companies,
           class_name: 'Company::Company',
           validate: true,
           dependent: :destroy

  belongs_to :active_player,
             class_name: 'Player',
             optional: true

  after_initialize :set_defaults, unless: :persisted?

  enum round: {
    setup: 0,
    auction: 1,
    share_round: 2,
    operating_round_1: 3,
    operating_round_2: 4,
    operating_round_3: 5,
  }

  def set_defaults
    self.round ||= 0
    self.phase ||= 1
    self.bank ||= 10000
  end

  def from_round
    case self.round.to_sym
    when :setup
      self.becomes(InstanceInSetup)
    when :auction
      self.becomes(InstanceInAuction)
    when :share_round
      self.becomes(InstanceInShareRound)
    when :operating_round_1, :operating_round_2, :operating_round_3
      self.becomes(InstanceInOperatingRound)
    end
  end

  def bump_phase!
    self.phase += 1 if self.phase < 7
  end

  def next_player!
    next_turn_order = (self.active_player.turn_order + 1) % self.players.count
    next_player = self.players.where(turn_order: next_turn_order).first
    self.active_player = next_player
    self.save
  end

end
