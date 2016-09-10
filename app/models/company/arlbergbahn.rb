module Company
  class Arlbergbahn < MountainCompany

    def set_defaults
      super
      self.cost = 170
    end

    def income
      2
    end

    def perk
      'Receives a 20% share in VB, Closes when VB first runs'
    end

  end
end
