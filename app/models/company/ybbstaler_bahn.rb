module Company
  class YbbstalerBahn < ::Company::Company

    def set_defaults
      super
      self.cost = 150
    end

    def name
      'Ybbstaler Bahn'
    end

    def charter_type
      :local
    end

  end
end
