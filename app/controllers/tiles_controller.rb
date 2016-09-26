class TilesController < ApplicationController

  def show
    @tile = Map::Tile.new(params[:id])
    render layout: false
  end

end
