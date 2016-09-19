module Map
  class Tile

    H = 75
    W = H * Math::sqrt(3)/2

    #             _
    #       3     |
    #   4       2 |
    #   |---W---| H
    #   5       1 |
    #       6     _
    #

    P1 = [W/2, -H/4]
    P2 = [W/2,  H/4]
    P3 = [0,    H/2]
    P4 = [-W/2, H/4]
    P5 = [-W/2,-H/4]
    P6 = [0,   -H/2]

    def initialize(options={})

    end

    def points
      [P1,P2,P3,P4,P5,P6].map { |p| p.join(',') }.join(' ')
    end

  end
end
