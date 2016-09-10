module Company
  class Ausserfernbahn < ::Company::Company

    def set_defaults
      super
      self.cost = 20
    end

    def name
      'Außerfernbahn'
    end

    def perk
      'Building one mountain is 20 G. cheaper'
    end

    def income
      5
    end

    def charter_type
      :mountain
    end

  end
end
