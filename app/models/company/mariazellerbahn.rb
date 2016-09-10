module Company
  class Mariazellerbahn < LocalCompany

    def set_defaults
      super
      self.cost = 150
    end

  end
end
