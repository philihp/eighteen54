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

end
