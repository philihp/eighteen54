module Company
  class KaiserinElisabethWestbahn < MajorCompany

    def set_defaults
      super
    end

    def name
      'Kaiserin Elisabeth-Westbahn'
    end

    def abbr
      'KE'
    end

    def color
      'pink'
    end

    def stations
      4
    end

    def home
      'Wien'
    end

  end
end
