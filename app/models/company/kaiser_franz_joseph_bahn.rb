module Company
  class KaiserFranzJosephBahn < ::Company::Company

    def set_defaults
      super
    end

    def name
      'Kaiser Franz Joseph-Bahn'
    end

    def stations
      3
    end

    def home
      'Wien'
    end

    def charter_type
      :major
    end

  end
end
