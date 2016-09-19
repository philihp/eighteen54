class InstanceInOperatingRound < Instance

  def start_round!
    establish_companies_to_operate!
    mountain_railway_payout!
    set_active_player!
  end

  def bump_round!
    if self.round.to_sym == :operating_round_1 && phase > 2
      self.operating_round_2!
    elsif self.round.to_sym == :operating_round_2 && phase > 4
      self.operating_round_3!
    else
      self.share_round!
    end
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

  def set_active_player!
    self.active_player = company_turn_order.first.director
    self.save
  end

  def company_turn_order
    companies = self.companies.select do |company|
      company.needs_to_operate
    end.sort_by(&:turn_ordering)
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
    market = Company::MajorCompany::MARKET.map do |row|
      row.map do |cell|
        {
          companies: [],
          value: cell,
        }
      end
    end
    majors.each do |company|
      next if company.value_y.nil? or company.value_x.nil?
      companies = market[company.value_y][company.value_x][:companies] << company
      companies.sort_by! { |c| -c.value_set_at_sequence }
    end
    market
  end

end
