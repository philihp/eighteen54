module Company
  class KaiserinElisabethWestbahn < ::Company::Company

    def set_defaults
      super
    end

    def name
      'Kaiserin Elisabeth-Westbahn'
    end

    def stations
      4
    end

    def home
      'Wien'
    end

  end
end
