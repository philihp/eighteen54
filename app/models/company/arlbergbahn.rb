module Company
  class Arlbergbahn < ::Company::Company

    def set_defaults
      super
      self.cost = 170
    end

    def income
      20
    end

    def charter_type
      :mountain
    end

  end
end
