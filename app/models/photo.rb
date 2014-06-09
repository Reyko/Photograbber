class Photo < ActiveRecord::Base

  def self.import_popular_photos_from_instagram
    Instagram.media_popular.map do |photo_info|
      p = Photo.new
      # binding.pry
      p.image_url = photo_info["images"]["standard_resolution"]["url"]

      if photo_info["caption"] != nil
         p.caption = photo_info["caption"]["text"]
      end
      p.save!
      p

    end
  end

end

# module Instagram
#   def self.media_popular
#     JSON(File.read('spec/fixtures/popular.json'))
#   end
# end
