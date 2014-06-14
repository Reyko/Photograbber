class Photo < ActiveRecord::Base
  geocoded_by :location   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  def self.import_popular_photos_from_instagram
    Instagram.media_popular.map do |photo_info|

      p = Photo.new
      p.image_url = photo_info["images"]["standard_resolution"]["url"]
      if photo_info["caption"] != nil
        p.caption = photo_info["caption"]["text"]
      end
      # p.save!
      p
    end
  end

  def self.find_by_location(location) 
    coordinates = Geocoder.coordinates(location)
    lat = coordinates[0].to_s
    lng = coordinates[1].to_s

    Instagram.media_search(lat,lng).map do |photo_info|

      p = Photo.new
      p.latitude = photo_info["location"]["latitude"]
      p.longitude = photo_info["location"]["longitude"]
      p.image_url = photo_info["images"]["standard_resolution"]["url"]

      if photo_info["caption"] != nil
        p.caption = photo_info["caption"]["text"]
      end
      # p.save!
      p

    end

  end

end

# module Instagram
#   def self.media_popular
#     JSON(File.read('spec/fixtures/popular.json'))
#   end
# end
