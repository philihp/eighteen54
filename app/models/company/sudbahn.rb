module Company
  class Sudbahn < ::Company::Company

    def set_defaults
      super
    end

    def name
      'Südbahn'
    end

    def stations
      4
    end

    def home
      'Wien'
    end

  end
end
