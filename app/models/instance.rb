class Instance < ApplicationRecord

  has_many :players,
           -> { order(:turn_order) },
           validate: true,
           dependent: :destroy

  has_many :companies,
           class_name: 'Company::Company',
           validate: true,
           dependent: :destroy,
           autosave: true

  belongs_to :active_player,
             class_name: 'Player',
             optional: true

  belongs_to :priority,
             class_name: 'Player',
             optional: true

  belongs_to :active_company,
             class_name: 'Company::Company',
             autosave: true,
             optional: true

  after_initialize :set_defaults, unless: :persisted?

  enum round: {
    setup: 0,
    auction: 1,
    auction_operating_round: 2,
    share_round: 3,
    operating_round_1: 4,
    operating_round_2: 5,
    operating_round_3: 6,
  }

  def set_defaults
    self.round ||= 0
    self.phase ||= 1
    self.bank ||= 10000
    self.passes ||= 0
  end

  def from_round
    case self.round.to_sym
    when :setup
      self.becomes(InstanceInSetup)
    when :auction
      self.becomes(InstanceInAuction)
    when :share_round
      self.becomes(InstanceInShareRound)
    when :operating_round_1, :operating_round_2, :operating_round_3, :auction_operating_round
      self.becomes(InstanceInOperatingRound)
    end
  end

  def auction?
    self.round.to_sym == :auction
  end

  def bump_phase!
    self.phase += 1 if self.phase < 7
  end

  def next_player!
    next_turn_order = (self.active_player.turn_order + 1) % self.players.count
    self.active_player = self.players.where(turn_order: next_turn_order).first
    self.save
  end

  def next_player
    next_turn_order = (self.active_player.turn_order + 1) % self.players.count
    self.players.where(turn_order: next_turn_order).first
  end

  def unowned_companies
    self.companies.find_all do |company|
      company.director == nil
    end
  end

end
