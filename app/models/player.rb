class Player < ApplicationRecord
  belongs_to :instance

  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.wallet ||= 0
  end
end
