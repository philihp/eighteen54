class Instance < ApplicationRecord

  has_many :players
  validates_associated :players

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

end
