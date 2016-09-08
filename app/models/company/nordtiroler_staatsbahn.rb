module Company
  class NordtirolerStaatsbahn < ::Company::Company

    def set_defaults
      super
    end

    def name
      'Nordtiroler Staatsbahn'
    end

    def stations
      4
    end

    def home
      'Innsbruck'
    end

  end
end
