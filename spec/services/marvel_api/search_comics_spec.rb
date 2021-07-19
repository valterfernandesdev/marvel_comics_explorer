RSpec.describe MarvelApi::SearchComics do
  describe "#call" do
    subject(:call) { described_class.call(search_term: search_term) }

    let(:base_url) { "https://gateway.marvel.com/v1/public/comics" }

    shared_examples "return results array" do
      it { is_expected.to eq search_response_body["data"]["results"] }
      it { is_expected.to be_kind_of(Array) }
    end

    context "with search_term and return results" do
      before do
        allow(MarvelApi::SearchCharacters).to receive(:call).and_return(character_ids)
        stub_request(:get, /#{base_url}/).to_return(body: search_response_body.to_json)
      end

      let(:search_term) { "deadpool" }
      let(:character_ids) { "1009268,1017316,1017336,1017474" }
      let(:search_response_body) do
        JSON.parse(File.read("spec/fixtures/search_comics/with_search_term.json"))
      end

      include_examples "return results array"
    end

    context "with search_term but doesn't return result" do
      before do
        allow(MarvelApi::SearchCharacters).to receive(:call).and_return(character_ids)
        stub_request(:get, /#{base_url}/).to_return(body: search_response_body.to_json)
      end

      let(:search_term) { "fake search term that does not return results" }
      let(:character_ids) { "" }
      let(:search_response_body) do
        JSON.parse(File.read("spec/fixtures/search_comics/with_invalid_search_term.json"))
      end

      include_examples "return results array"
    end

    context "when search_term isn't present" do
      before do
        allow(MarvelApi::SearchCharacters).to receive(:call).and_return(character_ids)
        stub_request(:get, /#{base_url}/).to_return(body: search_response_body.to_json)
      end

      let(:search_term) { "" }
      let(:character_ids) do
        "1011334,1017100,1009144,1010699,1009146,1016823,1009148,1009149,1010903,1011266,1010354,1010846,1011297,"\
        "1011031,1009150,1011198,1011175,1011136,1011176,1010870"
      end
      let(:search_response_body) do
        JSON.parse(File.read("spec/fixtures/search_comics/without_search_term.json"))
      end

      include_examples "return results array"
    end

    context "when an exception occurs" do
      before do
        allow(MarvelApi::SearchCharacters).to receive(:call).and_return(character_ids)
        stub_request(:get, /#{base_url}/).and_raise(RestClient::Exception)
      end

      let(:search_term) { "" }
      let(:character_ids) { "" }

      it { is_expected.to eq [] }
    end
  end
end
