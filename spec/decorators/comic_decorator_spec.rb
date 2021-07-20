RSpec.describe ComicDecorator do
  describe "#comic_img_url" do
    subject(:comic_img_url) { described_class.new(comic).comic_img_url }

    let(:comic) do
      {
        "thumbnail" => {
          "path" => "http://imgs.xkcd.com/comics/pizza",
          "extension" => "jpg",
        },
      }
    end

    it "returns the url of the comic image" do
      expect(comic_img_url).to eq "http://imgs.xkcd.com/comics/pizza/portrait_uncanny.jpg"
    end
  end
end
