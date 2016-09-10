module Company
  class Murtalbahn < MountainCompany

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

  end
end
