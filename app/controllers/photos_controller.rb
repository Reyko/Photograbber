class PhotosController < ApplicationController

  def index
    @photos = Photo.import_popular_photos_from_instagram
  end

  def search
    @location = params[:photo][:location]
    @photos = Photo.find_by_location(@location)
  end

end
