RSpec.describe FavouritComicsController, type: :request do
  describe "POST #create" do
    subject(:post_create) do
      post favourit_comics_path, xhr: true, params: { user_id: user_id, comic_id: comic_id }
    end

    context "when creating favourit comic" do
      let(:user_id) { Faker::Internet.uuid }
      let(:comic_id) { Faker::Number.unique.number }

      it "render create template with :ok status" do
        post_create

        expect(response).to have_http_status(:ok)
        expect(response).to render_template "favourit_comics/create"
      end

      it "creates favourit comic" do
        expect do
          post_create
        end.to change(FavouritComic, :count)
      end
    end

    context "when not creating favourit comic" do
      let!(:favourit_comic) { create(:favourit_comic) }
      let(:user_id) { favourit_comic.user_id }
      let(:comic_id) { favourit_comic.comic_id }

      it "render error template with :ok status" do
        post_create

        expect(response).to have_http_status(:ok)
        expect(response).to render_template "favourit_comics/error"
      end

      it "doesn't create favourit comic" do
        expect do
          post_create
        end.not_to change(FavouritComic, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    subject(:delete_destroy) do
      delete favourit_comics_path, xhr: true, params: { user_id: user_id, comic_id: comic_id }
    end

    context "when destroying favourit comic" do
      let!(:favourit_comic) { create(:favourit_comic) }
      let(:user_id) { favourit_comic.user_id }
      let(:comic_id) { favourit_comic.comic_id }

      it "render destroy template with :ok status" do
        delete_destroy

        expect(response).to have_http_status(:ok)
        expect(response).to render_template "favourit_comics/destroy"
      end

      it "destroys favourit comic" do
        expect do
          delete_destroy
        end.to change(FavouritComic, :count)
      end
    end

    context "when not destroying favourit comic" do
      let(:user_id) { 1 }
      let(:comic_id) { 1 }

      it "render destroy error template with :ok status" do
        delete_destroy

        expect(response).to have_http_status(:ok)
        expect(response).to render_template "favourit_comics/error"
      end

      it "doesn't destroy favourit comic" do
        expect do
          delete_destroy
        end.not_to change(FavouritComic, :count)
      end
    end
  end
end
