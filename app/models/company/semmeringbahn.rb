module Company
  class Semmeringbahn < ::Company::Company

    def set_defaults
      super
      self.cost = 190
    end

    def income
      25
    end

    def perk
      'Receives a 20% share in SD, Closes when SD first runs'
    end

    def charter_type
      :mountain
    end

  end
end
