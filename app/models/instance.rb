class Instance < ApplicationRecord

  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.round ||= 0
    self.phase ||= 1
  end

  def round_name
    case round
    when 0
      'auction round'
    when 1
      'share round'
    when 2
      'operating round 1'
    when 3
      'operating round 2'
    when 4
      'operating round 3'
    else
      '?'
    end
  end

  ###############
  # MUTATORS
  ###############

  def bump_round
    round += 1
    round = 1 if round > 4 or
                 round > 3 && phase <= 4 or
                 round > 2 && phase <= 2
  end

  def bump_phase
    phase += 1
  end

end
