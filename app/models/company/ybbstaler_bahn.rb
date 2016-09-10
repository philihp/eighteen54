module Company
  class YbbstalerBahn < LocalCompany

    def set_defaults
      super
      self.cost = 150
    end

    def name
      'Ybbstaler Bahn'
    end

  end
end
