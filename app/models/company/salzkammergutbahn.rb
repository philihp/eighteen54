module Company
  class Salzkammergutbahn < LocalCompany

    def set_defaults
      super
      self.cost = 150
    end

  end
end
