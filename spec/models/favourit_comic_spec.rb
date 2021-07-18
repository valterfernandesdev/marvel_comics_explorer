RSpec.describe FavouritComic, type: :model do
  describe "validations" do
    subject(:favourit_comic) { build(:favourit_comic) }

    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :comic_id }
    it { is_expected.to validate_uniqueness_of(:comic_id).scoped_to(:user_id) }
  end
end
