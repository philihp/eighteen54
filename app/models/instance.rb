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

  has_many :certificates,
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
    stock_round: 3,
    operating_round_1: 4,
    operating_round_2: 5,
    operating_round_3: 6,
  }

  # Only used in InstanceInOperatingRound, but needs to be here because it's not a true STI
  enum activity: {
    activity_mail_contract_pays_income: 1,
    activity_build_track: 2,
    activity_place_station_marker: 3,
    activity_run_trains: 4,
    activity_distribute_revenue: 5,
    activity_purchase_trains: 6,
    activity_purchase_mail_contract: 7,
  }

  def set_defaults
    self.round ||= 0
    self.phase ||= 1
    self.bank ||= 10000
    self.passes ||= 0
    self.stock_rounds ||= 0
    self.sequence ||= 1
    self.small_mail_contract ||= 6
    self.large_mail_contract ||= 6
  end

  def from_round
    case self.round.to_sym
    when :setup
      self.becomes(InstanceInSetup)
    when :auction
      self.becomes(InstanceInAuction)
    when :stock_round
      self.becomes(InstanceInStockRound)
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

  def bump_sequence!
    self.sequence += 1
    self.save
  end

  def next_player!(block=nil)
    next_turn_order = (self.active_player.turn_order + 1) % self.players.count
    self.active_player = self.players.where(turn_order: next_turn_order).first
    yield if block_given?
    self.save
  end

  def next_player
    next_turn_order = (self.active_player.turn_order + 1) % self.players.count
    self.players.where(turn_order: next_turn_order).first
  end

  def phase_color
    case self.phase
      when 1..2 then :yellow
      when 3..4 then :green
      when 5..6 then :brown
      when 7..8 then :gray
      else :unknown
    end
  end

end
