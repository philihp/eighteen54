module Company
  class Murtalbahn < ::Company::Company

    def set_defaults
      super
      self.cost = 50
    end

    def income
      10
    end

    def perk
      'Building one tunnel is 40 G. cheaper'
    end

    def charter_type
      :mountain
    end

  end
end
