module Company
  class Phyrnbahn < LocalCompany

    def set_defaults
      super
      self.cost = 150
    end

  end
end
