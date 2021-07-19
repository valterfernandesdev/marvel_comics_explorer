RSpec.describe HomeController, type: :request do
  describe "GET #index" do
    subject(:get_index) { get home_index_path, params: { title: title } }

    before do
      allow(MarvelApi::SearchComics).to receive(:call).and_return(comics_array)

      get_index
    end

    shared_examples "render index with ok status" do
      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template "home/index" }
    end

    context "when comics are found" do
      let(:title) { "spider-man" }
      let(:comics_array) do
        JSON.parse(File.read("spec/fixtures/search_comics/with_search_term.json"))["data"]["results"]
      end

      include_examples "render index with ok status"

      it { expect(assigns(:comics)).not_to be_empty }
    end

    context "when comics are not found" do
      let(:title) { "spidermen" }
      let(:comics_array) { [] }

      include_examples "render index with ok status"

      it { expect(assigns(:comics)).to be_empty }
    end
  end
end
