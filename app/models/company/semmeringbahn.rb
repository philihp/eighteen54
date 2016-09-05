module Company
  class Semmeringbahn < ::Company::Company

    def set_defaults
      super
      self.cost = 190
    end

    def income
      25
    end

  end
end
