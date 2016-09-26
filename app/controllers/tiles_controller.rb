class TilesController < ApplicationController

  def show
    @tile = Map::Tile.new(params[:id])
  end

end
