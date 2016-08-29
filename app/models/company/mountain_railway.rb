module Company

  class UndefinedIncomeError < StandardError
  end

  class UndefinedCostError < StandardError
  end

  class MountainRailway < Company

    def set_defaults
      super
      self.tapped = false
    end

    def cost
      raise UndefinedCostError
    end

    def income
      raise UndefinedIncomeError
    end

  end
end
