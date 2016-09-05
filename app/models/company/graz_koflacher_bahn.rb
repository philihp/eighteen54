module Company
  class GrazKoflacherBahn < ::Company::Company

    def set_defaults
      super
      self.cost = 70
    end

    def name
      'Graz-Koflacher Bahn'
    end

    def income
      15
    end

  end
end
