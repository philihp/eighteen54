module Company
  class Salzkammergutbahn < ::Company::Company

    def set_defaults
      super
      self.cost = 150
    end

  end
end
