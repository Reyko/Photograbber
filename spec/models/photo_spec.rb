require 'spec_helper'

describe Photo do
 
  describe "importing popular photos from Instagram" do
    before do
      our_example_from_earlier = JSON(File.read('spec/fixtures/popular.json'))
      Instagram.stubs(:media_popular).returns(our_example_from_earlier)

      @photos = Photo.import_popular_photos_from_instagram
      # binding.pry
    end

    it "should make photo objects" do
      expect(@photos.length).to eq(20)
      expect(@photos.first.is_a?Photo).to eq(true)
      expect(@photos.first.image_url).to eq("http://scontent-a.cdninstagram.com/hphotos-xpa1/t51.2885-15/10414004_295888470586619_1060616269_n.jpg")
      expect(@photos.first.caption).to match(/@zsn_1 \nFollow Zayed/)
    end

    it "save the photos in the database" do
      expect(Photo.count).to eq(20)
    end

  end

end
