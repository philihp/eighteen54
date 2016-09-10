module Company
  class Sudbahn < MajorCompany

    def set_defaults
      super
    end

    def name
      'Südbahn'
    end

    def abbr
      'SD'
    end

    def color
      'darkorange'
    end

    def stations
      4
    end

    def home
      'Wien'
    end

  end
end
