class ArtistsController < ApplicationController

  def index
    @artists = Artist.all
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  private

  def artist_params
    params.require(:artist).permit(:name)
  end

end
