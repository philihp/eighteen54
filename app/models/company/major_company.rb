module Company
  class MajorCompany < ::Company::Company

    PAR_VALUES = [67,72,77,82,87,93].sort

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

      self.save
      self.instance.save
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

  end
end
