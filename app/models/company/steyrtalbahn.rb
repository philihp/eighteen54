module Company
  class Steyrtalbahn < ::Company::Company

    def set_defaults
      super
      self.cost = 150
    end

    def charter_type
      :local
    end

  end
end
