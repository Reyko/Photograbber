require 'spec_helper'

describe Photo do
 
  describe "importing popular photos from Instagram" do
    before do
      @photos = Photo.import_popular_photos_from_instagram
    end

    it "should make photo objects" do
      expect(@photos.length).to eq(20)
      expect(@photos.first.is_a?Photo).to eq(true)
      expect(@photos.first.image_url).to eq("http://scontent-a.cdninstagram.com/hphotos-xfa1/t51.2885-15/915572_1540512816176341_1199559541_n.jpg")
      expect(@photos.first.caption).to eq("Y'all be sure to tune in to my girl @kandiburruss show tonight at 8 on Bravo. #kandiswedding ✔️💯")
    end

    it "save the photos in the database" do
      expect(Photo.count).to eq(20)
    end

  end

end
