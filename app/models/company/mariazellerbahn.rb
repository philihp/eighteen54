module Company
  class Mariazellerbahn < ::Company::Company

    def set_defaults
      super
      self.cost = 150
    end

  end
end
