module Company
  class YbbstalerBahn < ::Company::Company

    def set_defaults
      super
      self.cost = 150
    end

    def name
      'Ybbstaler Bahn'
    end

  end
end
