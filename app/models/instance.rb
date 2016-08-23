class Instance < ApplicationRecord

  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.round ||= 0
    self.phase ||= 1
    self.bank ||= 10000
  end

  def round_name
    case round
    when 0
      'setup'
    when 1
      'auction round'
    when 2
      'share round'
    when 3
      'operating round 1'
    when 4
      'operating round 2'
    when 5
      'operating round 3'
    else
      '?'
    end
  end

  def bump_round!
    self.round += 1
    self.round = 2 if round > 5 or
                 round > 4 && phase <= 4 or
                 round > 3 && phase <= 2
  end

  def bump_phase!
    self.phase += 1 if phase < 7
  end

end
