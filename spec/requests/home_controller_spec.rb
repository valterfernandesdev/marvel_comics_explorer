RSpec.describe HomeController, type: :request do
  describe "GET #index" do
    subject(:get_index) { get home_index_path, params: { search_term: search_term } }

    before do
      allow(MarvelApi::SearchComics).to receive(:call).and_return(comics_data)

      get_index
    end

    shared_examples "render index with ok status" do
      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template "home/index" }
    end

    context "when comics are found" do
      let(:search_term) { "spider-man" }
      let(:comics_data) do
        JSON.parse(File.read("spec/fixtures/search_comics/with_search_term.json"))["data"]
      end

      include_examples "render index with ok status"

      it { expect(assigns(:comics)).not_to be_empty }
      it { expect(assigns(:comics_data)).not_to be_empty }
    end

    context "when comics are not found" do
      let(:search_term) { "spidermen" }
      let(:comics_data) { { "results" => [] } }

      include_examples "render index with ok status"

      it { expect(assigns(:comics)).to be_empty }
      it { expect(assigns(:comics_data)).not_to be_empty }
    end
  end
end
