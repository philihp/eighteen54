module Company
  class GrazKoflacherBahn < ::Company::Company

    def set_defaults
      super
      self.cost = 70
    end

    def name
      'Graz-Koflacher Bahn'
    end

    def perk
      'Routes through Graz earn 10 G. more'
    end

    def income
      15
    end

    def charter_type
      :mountain
    end

  end
end
