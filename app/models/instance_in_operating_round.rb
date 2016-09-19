class InstanceInOperatingRound < Instance

  def mail_contract_pays_income!
    self.activity_mail_contract_pays_income!
    self.save
    self.active_company.pay_mail_contract_income!
    self.build_track!
  end

  def build_track!
    self.activity_build_track!
    self.save
    # User now gets to build track...
  end

  def start_round!
    establish_companies_to_operate!
    mountain_railway_payout!
    set_next_active_company!
    operate_company!
  end

  def bump_round!
    if self.round.to_sym == :operating_round_1 && phase > 2
      self.operating_round_2!
    elsif self.round.to_sym == :operating_round_2 && phase > 4
      self.operating_round_3!
    else
      self.share_round!
    end
    self.save
    self.from_round.start_round!
  end

  def establish_companies_to_operate!
    self.companies.each do |company|
      if company.charter_type == :major
        company.needs_to_operate = company.operates?
      elsif company.charter_type == :mountain
        company.needs_to_operate = true
      else
        company.needs_to_operate = false
      end
      company.save
    end
  end

  def mountain_railway_payout!
    self.mountain_railways.each do |company|
      next if company.director.nil?
      director = company.director
      director.wallet += company.income
      director.save
      self.bank -= company.income
      self.save
      company.needs_to_operate = false
      company.save
    end
  end

  def set_next_active_company!
    self.active_company = company_turn_order.first
    set_active_player!
    self.save
  end

  def set_active_player!
    self.active_player = self.active_company.director
    self.save
  end

  def operate_company!
    if self.active_company.present?
      self.mail_contract_pays_income!
    else
      self.bump_round!
    end
  end

  def company_turn_order
    companies = self.companies.select do |company|
      company.needs_to_operate
    end.sort_by(&:turn_order)
    # .map do |company|
    #   "[#{company.id} #{company.name} #{company.turn_ordering}]"
    # end
    companies
  end

  def majors
    self.companies.select { |c| c.charter_type == :major }
  end

  def mountain_railways
    self.companies.select { |c| c.charter_type == :mountain }
  end

  def market
    market = MARKET.map do |row|
      row.map do |cell|
        {
          companies: [],
          value: cell,
          class: []
        }
      end
    end
    MARKET_BASEMENT.each do |coords|
      (y,x) = coords
      market[y][x][:class] << 'market-basement'
    end
    majors.each do |company|
      next if company.value_y.nil? or company.value_x.nil? or company.value_set_at_sequence.nil?
      companies = market[company.value_y][company.value_x][:companies] << company
      companies.sort_by! { |c| [-c.value, c.value_y, -c.value_set_at_sequence] }
    end
    market
  end

  def local_map
    Map::LocalMap.new
  end

  def major_map
    Map::MajorMap.new
  end

end
