class Company < ApplicationRecord
  belongs_to :instance

  after_initialize :set_defaults, unless: :persisted?

  # enum name: {
  #   'Außerfernbahn': 1,
  #   'Murtalbahn': 2,
  #   'Graz-Köflacher Bahn': 3,
  #   'Arlbergbahn': 4,
  #   'Semmeringbahn': 5,
  #   'Local 1': 6,
  #   'Local 2': 7,
  #   'Local 3': 8,
  #   'Local 4': 9,
  #   'Local 5': 10,
  #   'Local 6': 11,
  #   'Kaiserin Elisabeth-Westbahn': 12,
  #   'Kaiser Franz Joseph-Bahn': 13,
  #   'Südbahn Kronprinz Rudolf-Bahn': 14,
  #   'Kärntner Bahn': 15,
  #   'Salzburger Bahn': 16,
  #   'Nord roler Staatsbahn': 17,
  #   'Vorarlberger Bahn': 18,
  #   'Lokalbahn AG A': 19,
  #   'Lokalbahn AG B': 20,
  #   'Lokalbahn AG C': 21,
  # }

  def set_defaults
    self.tapped = false
  end

  def cost
    raise NotImplementedError, 'No cost defined for this company'
  end

  def income
    raise NotImplementedError, 'No income defined for this company'
  end

  end
