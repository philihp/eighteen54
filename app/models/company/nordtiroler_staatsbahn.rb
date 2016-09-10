module Company
  class NordtirolerStaatsbahn < MajorCompany

    def set_defaults
      super
    end

    def name
      'Nordtiroler Staatsbahn'
    end

    def abbr
      'NT'
    end

    def color
      'paleturquoise'
    end

    def stations
      4
    end

    def home
      'Innsbruck'
    end

    def charter_type
      :major
    end

  end
end
