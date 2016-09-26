module Map
  class Tile

    #             _
    #       3     |
    #   4       2 |
    #   |---W---| H
    #   5       1 |
    #       6     _
    #

    H = 75
    W = H * Math::sqrt(3)/2

    P1 = [W/2, -H/4]
    P2 = [W/2,  H/4]
    P3 = [0,    H/2]
    P4 = [-W/2, H/4]
    P5 = [-W/2,-H/4]
    P6 = [0,   -H/2]

    # Manifest
    #     6
    # 5 /---\ 1
    # 4 \---/ 2
    #     3
    #
    # 0 - point zero is the center
    #
    M = {
      # Yellow tiles
      t7: { color: :yellow,  connections: [[2,3]] },
      t8: { color: :yellow,  connections: [[1,3]] },
      t9: { color: :yellow,  connections: [[6,3]] },

      t5: { color: :yellow,  connections: [[2,0],[3,0]], cities: 1 },
      t6: { color: :yellow,  connections: [[1,0],[3,0]], cities: 1 },
      t57: { color: :yellow, connections: [[3,0],[6,0]], cities: 1 },

      t3: { color: :yellow,  connections: [[2,3]], towns: 1 },
      t4: { color: :yellow,  connections: [[3,6]], towns: 1 },
      t58: { color: :yellow, connections: [[1,3]], towns: 1 },

      t1: { color: :yellow,  connections: [[1,3],[4,6]], towns: 2 },
      t2: { color: :yellow,  connections: [[1,2],[3,6]], towns: 2 },
      t55: { color: :yellow, connections: [[1,4],[3,6]], towns: 2 },
      t56: { color: :yellow, connections: [[1,3],[2,6]], towns: 2 },
      t69: { color: :yellow, connections: [[1,5],[3,6]], towns: 2 },
      # Green tiles
      t16: { color: :green,  connections: [[1,3],[2,4]] },
      t17: { color: :green,  connections: [[1,3],[4,6]] },
      t18: { color: :green,  connections: [[3,6],[4,5]] },
      t19: { color: :green,  connections: [[1,5],[4,6]] },
      t20: { color: :green,  connections: [[1,4],[3,6]] },
      t21: { color: :green,  connections: [[1,6],[3,5]] },
      t22: { color: :green,  connections: [[1,3],[5,6]] },
      t23: { color: :green,  connections: [[1,3],[3,6]] },
      t24: { color: :green,  connections: [[3,5],[3,6]] },
      t25: { color: :green,  connections: [[1,3],[3,5]] },
      t26: { color: :green,  connections: [[2,3],[3,6]] },
      t27: { color: :green,  connections: [[3,4],[3,6]] },
      t28: { color: :green,  connections: [[1,3],[2,3]] },
      t29: { color: :green,  connections: [[3,4],[3,5]] },
      t30: { color: :green,  connections: [[1,3],[3,4]] },
      t31: { color: :green,  connections: [[2,3],[3,5]] },
      t433: { color: :green, cities: 5 },
      t441: { color: :green, connections: [[1,0],[3,0],[6,0]], cities: 2 },  # TODO these are probably wrong
      t442: { color: :green, connections: [[3,0],[5,0],[6,0]], cities: 2 },
      t443: { color: :green, connections: [[1,0],[3,0],[5,0]], cities: 2 },
      t444: { color: :green, connections: [[1,0],[5,0],[6,0]], cities: 2 },
      t457: { color: :green, connections: [[1,3],[2,3],[2,6],[1,6]], cities: 2 },
      t458: { color: :green, connections: [[1,4],[3,4],[3,6],[1,6]], cities: 2 },
      t459: { color: :green, connections: [[1,4],[3,4],[3,6],[1,6]], cities: 2 },
      t460: { color: :green, connections: [[1,3],[1,4],[3,6],[4,6]], cities: 2 },
      t461: { color: :green, connections: [[1,3],[1,2],[2,0],[3,0],[6,0]], cities: 2 },
      t462: { color: :green, connections: [[1,2],[1,0],[2,6],[3,0],[6,0]], cities: 2 },
      t463: { color: :green, connections: [[1,3],[1,5],[3,6],[5,6]], cities: 2 },
      t464: { color: :green, connections: [[1,5],[1,6],[3,5],[3,6]], cities: 2 },
      # Brown tiles
      t39: { color: :brown, connections: [[3,4],[4,5],[3,5]] },
      t40: { color: :brown, connections: [[1,3],[3,5],[1,5]] },
      t41: { color: :brown, connections: [[3,4],[4,6],[3,6]] },
      t42: { color: :brown, connections: [[2,3],[3,6],[2,6]] },
      t43: { color: :brown, connections: [[1,2],[1,3],[3,6],[2,6]] },
      t44: { color: :brown, connections: [[1,4],[3,4],[3,6],[1,6]] },
      t45: { color: :brown, connections: [[1,3],[3,6],[5,6],[1,5]] },
      t46: { color: :brown, connections: [[1,5],[3,5],[3,6],[1,6]] },
      t47: { color: :brown, connections: [[1,3],[3,6],[4,6],[1,4]] },
      t70: { color: :brown, connections: [[1,3],[2,3],[2,6],[1,6]] },
      t448: { color: :brown,connections: [[1,0],[2,0],[3,0],[6,0]], cities: 2 },
      t449: { color: :brown,connections: [[1,0],[3,0],[4,0],[6,0]], cities: 2 },
      t450: { color: :brown,connections: [[1,0],[3,0],[5,0],[6,0]], cities: 2 },
      t451: { color: :brown,connections: [[1,-1],[2,-2],[3,-2],[4,-1],[5,-3],[6,-3]], cities: 5 },
      # Grey tiles
      t452: { color: :grey, connections: [[1,3],[1,5],[1,6],[3,6],[3,5],[5,6]] },
      t453: { color: :grey, connections: [[1,3],[1,4],[1,6],[3,6],[3,4],[4,6]] },
      t454: { color: :grey, connections: [[1,2],[1,3],[1,6],[2,3],[2,6],[3,6]] },
      t455: { color: :grey, connections: [[1,0],[2,0],[3,0],[4,0],[5,0],[6,0]], cities: 3 },
      t456: { color: :grey, connections: [[1,0],[2,0],[3,0],[4,0],[5,0],[6,0]], cities: 5 },
    }

    attr_accessor :options
    attr_accessor :color
    attr_accessor :connections
    attr_accessor :cities
    attr_accessor :towns

    def initialize(type={})
      if type.is_a? Hash
        @options = type
      else
        id = type.to_i
        key = "t#{id}".to_sym
        @options = M[key] || {}
      end
      @color = @options[:color]
      @connections= @options[:connections] || []
      @cities = @options[:cities] || 0
      @towns = @options[:towns] || 0
    end

    def points
      [P1,P2,P3,P4,P5,P6].map { |p| p.join(',') }.join(' ')
    end

    def self.points
      Tile.new.points
    end

    def has_connection?(src,dst)
      @connections.include?([src,dst]) || @connections.include?([dst,src])
    end

  end
end
