module Company
  class MajorCompany < ::Company::Company

    PAR_VALUES = [67,72,77,82,87,93].sort

    MAIL_CONTRACT_SMALL_COST = 100
    MAIL_CONTRACT_LARGE_COST = 200

    MAIL_CONTRACT_SMALL_REVENUE = {
      yellow: 10,
      green: 20,
      brown: 30,
      gray: 40,
    }

    MAIL_CONTRACT_LARGE_REVENUE = {
      yellow: 30,
      green: 40,
      brown: 50,
      gray: 60,
    }

    MARKET = [
      [nil, 54, 57, 60, 63 ],
      [ 56, 59, 62, 65, 68, 71 ],
      [ 61, 64, 67, 70, 73, 76, 79 ],
      [ 66, 69, 72, 75, 78, 81, 85, 89 ],
      [ 71, 74, 77, 80, 83, 87, 91, 95,100 ],
      [ 76, 79, 82, 85, 89, 93, 97,102,108,115,123 ],
      [ 81, 84, 87, 91, 95, 99,104,110,117,125,134,143,153,165,180,200 ],
      [ 86, 89, 93, 97,101,106,112,119,127,136,146,158,170,185,210,230,250,275,300 ],
    ]

    # scope :major, -> do
    #   where(type: [
    #     Company::KaiserinElisabethWestbahn.name,
    #     Company::KaiserFranzJosephBahn.name,
    #     Company::Sudbahn.name,
    #     Company::KronprinzRudolfBahn.name,
    #     Company::KarntnerBahn.name,
    #     Company::SalzburgerBahn.name,
    #     Company::NordtirolerStaatsbahn.name,
    #     Company::VorarlbergerBahn.name,
    #   ])
    # end

    def charter_type
      :major
    end

    def create_certificates!
      self.certificates << Certificate.create(instance: instance, company: self, percent: 40)
      self.certificates << Certificate.create(instance: instance, company: self, percent: 20)
      self.certificates << Certificate.create(instance: instance, company: self, percent: 20)
      self.certificates << Certificate.create(instance: instance, company: self, percent: 20)
    end

    def value(x=self.value_x, y=self.value_y)
      return nil if y.nil? || y < 0 ||
                    x.nil? || x < 0 ||
                    MARKET[y].nil?
      return MARKET[y][x]
    end

    def update_value_from_buying_train_from_another_company!
      if value(self.value_x-1, self.value_y+1).present?
        self.value_x -= 1
        self.value_y += 1
      end
      set_sequence!
      self.save
    end

    def update_value_from_selling_train_to_another_company!
      if value(self.value_x+1, self.value_y-1).present?
        self.value_x += 1
        self.value_y -= 1
      end
      set_sequence!
      self.save
    end

    def update_value_from_not_paying_dividend!
      return if [self.value_x,self.value_y] == [1,0] # bottom left 54
      return if [self.value_x,self.value_y] == [0,1] # bottom right 56
      if self.value_x > 0
        self.value_x -= 1
      elsif self.value_y > 0
        self.value_x = 0
        self.value_y -= 1
      end
      set_sequence!
      self.save
    end

    def update_value_from_paying_dividend!
      if value(self.value_x+1, self.value_y).present?
        self.value_x += 1
      elsif value(self.value_x+1, self.value_y+1).present?
        self.value_x += 1
        self.value_y += 1
      end
      # TODO split! if should_split?
      set_sequence!
      self.save
    end

    def update_value_from_all_shares_sold!
      self.value_y += 1 if value(self.value_x, self.value_y+1).present?
      # TODO split! if should_split?
      set_sequence!
      self.save
    end

    def update_value_from_selling_share!
      self.value_y -= 1 if value(self.value_x, self.value_y-1).present?
      set_sequence!
      self.save
    end

    def set_sequence!
      # Ensures that when a marker is placed on the same spot as other pieces,
      # it will be placed the existing markers. Important because turn order
      # says the marker on top goes first.
      self.instance.bump_sequence!
      self.value_set_at_sequence = self.instance.sequence
      self.save
    end

    def should_split?
      self.value_y + self.value_x > 9
    end

    def par_value
      # In the context of a Major, `cost` is the par value.
      self.cost
    end

    def should_float?
      percent_owned >= 50
    end

    def percent_owned
      certificates.owned.reduce(0) { |sum, c| sum + c.effective_percent }
    end

    def first_unowned_share
      certificates.unowned.first
    end

    def float!
      self.director = determine_director
      swap_director_certificate_with!(self.director)
      self.treasury = self.cost * 10
      self.instance.bank -= self.treasury
      self.set_sequence!

      self.save
      self.instance.save
    end

    def operates?
      self.director.present?
    end

    def directors_certificate
      # self.certificates.order(percent: :desc).first
      @directors_certificate ||= self.certificates.where(percent: 40).first
    end

    def determine_director
      owner = self.certificates.owned.reduce({}) do |o, certificate|
        id = certificate.player.id
        o[id] = (o[id]||0) + certificate.percent
        o
      end
      max_ownership = owner.max{ |a,b| a[1] <=> b[1] }[1]
      candidate_director_ids = owner.find_all{ |a| a[1] == max_ownership }.map{ |a| a[0] }
      return self.director if candidate_director_ids.include?(self.director.try(:id))
      return Player.find(candidate_director_ids.first)
    end

    def swap_director_certificate_with!(dst_player)
      src_player = directors_certificate.player
      return if src_player == dst_player
      exchanged_certs = dst_player.certificates.where(company: self)
      {
        directors_certificate => dst_player,
        exchanged_certs.first => src_player,
        exchanged_certs.second => src_player,
      }.each do |cert, to_player|
        cert.player = to_player
        cert.save
      end
    end

    def turn_order
      # Used as a sorting key... basically a shortcut for...
      # * Highest price goes first
      # * If price is equal, the marker to the right goes first
      # * If markers are on the same spot, the marker on top goes first
      [-value, value_y, value_set_at_sequence]
    end

    def can_buy_small_mail_contract?
      self.no_mail_contract? && self.treasury >= 100 && self.instance.small_mail_contracts > 0
    end

    def can_buy_large_mail_contract?
      self.no_mail_contract? && self.treasury >= 200 && self.instance.large_mail_contracts > 0
    end

    def buy_small_mail_contract!
      return unless can_buy_small_mail_contract?
      self.instance.small_mail_contracts -= 1
      self.small_mail_contract!
      self.treasury -= MAIL_CONTRACT_SMALL_COST
      self.instance.bank += MAIL_CONTRACT_SMALL_COST
      self.save
      self.instance.save
    end

    def buy_large_mail_contract!
      return unless can_buy_large_mail_contract?
      self.instance.large_mail_contracts -= 1
      self.large_mail_contract!
      self.treasury -= MAIL_CONTRACT_LARGE_COST
      self.instance.bank += MAIL_CONTRACT_LARGE_COST
      self.save
      self.instance.save
    end

    def mail_contract_revenue
      if self.small_mail_contract?
        MAIL_CONTRACT_SMALL_REVENUE[self.instance.phase_color]
      elsif self.large_mail_contract?
        MAIL_CONTRACT_LARGE_REVENUE[self.instance.phase_color]
      end || 0
    end

    def pay_mail_contract_income!
      revenue = mail_contract_revenue
      self.treasury += revenue
      self.instance.bank -= revenue
      self.instance.save && self.save
    end

  end
end
