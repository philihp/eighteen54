module Company
  class Ausserfernbahn < ::Company::Company

    def set_defaults
      super
      self.cost = 20
    end

    def name
      'Außerfernbahn'
    end

    def income
      5
    end

  end
end
