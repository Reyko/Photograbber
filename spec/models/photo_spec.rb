require 'spec_helper'

describe Photo do

  describe "importing popular photos from Instagram" do
    before do
      our_example_from_earlier = JSON(File.read('spec/fixtures/popular.json'))
      Instagram.stubs(:media_popular).returns(our_example_from_earlier)
      @photos = Photo.import_popular_photos_from_instagram
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

  describe "search photos by location" do

    before do
      location_json = JSON(File.read('spec/fixtures/search.json'))
      Instagram.stubs(:media_search).returns(location_json)

         Geocoder.configure(:lookup => :test)

      Geocoder::Lookup::Test.add_stub(
        "New York, NY", [
          {
            'latitude'     => 40.7143528,
            'longitude'    => -74.0059731,
            'address'      => 'New York, NY, USA',
            'state'        => 'New York',
            'state_code'   => 'NY',
            'country'      => 'United States',
            'country_code' => 'US'
          }
        ]
      )
      @photos = Photo.find_by_location("New York, NY")

    end

    it "should have location" do
      expect(@photos.first.latitude).to eq(40.707628088)
      expect(@photos.first.longitude).to eq(-74.007360501)
    end

    it "should find photos by location" do
      expect(@photos.length).to eq(19)
      expect(@photos.first.is_a? Photo).to eq(true)
      expect(@photos.first.image_url).to eq("http://scontent-b.cdninstagram.com/hphotos-xap1/t51.2885-15/10401849_326762884143826_222597175_n.jpg")
      expect(@photos.first.caption).to match("😩😩😩😩😩😩😩")
    end

  end

end
