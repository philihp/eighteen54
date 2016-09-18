class InstanceInOperatingRound < Instance

  def bump_round!
    if self.round.to_sym == :operating_round_1 && phase > 2
      self.operating_round_2!
    elsif self.round.to_sym == :operating_round_2 && phase > 4
      self.operating_round_3!
    else
      self.share_round!
    end
  end

  def majors
    self.companies.select { |c| c.charter_type == :major }
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
      market[company.value_y][company.value_x][:companies] << company
    end
    market
  end

end
