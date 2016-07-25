class SongsController < ApplicationController

  def index
    if params[:artist_id]
      if !Artist.exists?(params[:artist_id])
        redirect_to artists_path, alert: "Artist not found."
      else
        @songs = Artist.find(params[:artist_id]).songs
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      artist = Artist.find_by(id: params[:artist_id])
        if artist.nil?
          redirect_to artists_path, alert: "No artist found."
        else
          @song = artist.songs.find_by(id: params[:id])
          redirect_to artist_songs_path(artist), alert: "Song not found." if @song.nil?
        end
   else
      @song = Song.find(params[:id])
  end
end

  def new
    if params[:artist_id] && !Artist.exists?(params[:artist_id])
      redirect_to artists_path, alert: "Artist not found."
    else
      @song = Song.new(artist_id: params[:artist_id])
    end
  end

  def create
    @song = Song.new(song_params)
    @song.save
    redirect_to song_path(@song)
  end

  def edit
    if params[:artist_id]
      @nested = true
      
      artist = Artist.find_by(id: params[:artist_id])
      if artist.nil?
        redirect_to artists_path, alert: "Artist not found."
      else
        @song = artist.songs.find_by(id: params[:id])
        redirect_to artist_songs_path(artist), alert: "Song not found." if @song.nil?
      end
    else
      @song = Song.find(params[:id])
    end
  end

  def update
    @song = Song.find(params[:id])
    @song.update(song_params)
    redirect_to song_path(@song)
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_id)
  end

end
