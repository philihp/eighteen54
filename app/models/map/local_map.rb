module Map
  class LocalMap

    attr_reader :map

    def initialize
      @map = {
        j: {
          30 => Tile.new(towns: 2),
          32 => Tile.new(label: 'Steyr'),
          34 => Tile.new(label: 'Amstetten', city: true),
          36 => Tile.new(towns: 2, mountain: 50),
          38 => Tile.new(label: 'Sankt Pölten', color: :yellow),
        },
        k: {
          29 => Tile.new(mountain: 50),
          31 => Tile.new(mountain: 60),
          33 => Tile.new(river: 50, towns: 1),
          35 => Tile.new,
          37 => Tile.new(towns: 2, mountain: 50),
          39 => Tile.new(towns: 1, mountain: 60),
        },
        l: {
          30 => Tile.new(towns: 1, mountain: 60),
          32 => Tile.new(towns: 2, mountain: 80),
          34 => Tile.new,
          36 => Tile.new(towns: 1, mountain: 60),
          38 => Tile.new(mountain: 70)
        },
      }
    end

    def rows
      map.key
    end

    def cols(row=nil)
      map[row].keys
    end

  end
end
