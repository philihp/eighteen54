module Company
  class Ausserfernbahn < MountainCompany

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

  end
end
