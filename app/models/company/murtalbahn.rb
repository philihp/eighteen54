module Company
  class Murtalbahn < ::Company::Company

    def set_defaults
      super
      self.cost = 50
    end

    def income
      10
    end

  end
end
