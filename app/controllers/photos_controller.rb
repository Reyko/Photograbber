class PhotosController < ApplicationController

  def index
    @photos = Photo.import_popular_photos_from_instagram
  end

  def search
    @photos = Photo.find_by_location("London")
  end

end
