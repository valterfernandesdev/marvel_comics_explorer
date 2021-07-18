RSpec.describe MarvelApi::SearchCharacters do
  describe "#call" do
    subject(:call) { described_class.call(name: name) }

    let(:base_url) { "https://gateway.marvel.com/v1/public/characters?" }

    shared_examples "return results string with ids" do
      it { is_expected.to eq ids }
      it { is_expected.to be_kind_of(String) }
    end

    context "when characters are found" do
      before { stub_request(:get, /#{base_url}/).to_return(body: search_response_body.to_json) }

      let(:name) { "deadpool" }
      let(:ids) { "1009268,1017316,1017336,1017474" }
      let(:search_response_body) do
        JSON.parse(File.read("spec/fixtures/search_characters/with_characters.json"))
      end

      include_examples "return results string with ids"
    end

    context "when characters aren't found" do
      before { stub_request(:get, /#{base_url}/).to_return(body: search_response_body.to_json) }

      let(:name) { "character_that_doesnt_exist_on_marvel_adhjadhk" }
      let(:ids) { "" }
      let(:search_response_body) do
        JSON.parse(File.read("spec/fixtures/search_characters/without_characters.json"))
      end

      include_examples "return results string with ids"
    end

    context "when an exception occurs" do
      before { stub_request(:get, /#{base_url}/).and_raise(RestClient::Exception) }

      let(:name) { "character that generates errors" }
      let(:ids) { "" }

      include_examples "return results string with ids"
    end
  end
end
