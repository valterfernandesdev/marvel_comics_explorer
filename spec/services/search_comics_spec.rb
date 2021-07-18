RSpec.describe SearchComics do
  describe "#call" do
    subject(:call) { described_class.call(title: title) }

    before { stub_request(:get, /#{base_url}/).to_return(body: search_response_body.to_json) }

    let(:base_url) { "https://gateway.marvel.com/v1/public/comics" }

    shared_examples "return results array" do
      it { is_expected.to eq search_response_body["data"]["results"] }
      it { is_expected.to be_kind_of(Array) }
    end

    context "when title is present" do
      let(:title) { "deadpool" }
      let(:search_response_body) do
        JSON.parse(File.read("spec/fixtures/search_response_with_title.json"))
      end

      include_examples "return results array"
    end

    context "when title is blank" do
      let(:title) { "" }
      let(:search_response_body) do
        JSON.parse(File.read("spec/fixtures/search_response_without_title.json"))
      end

      include_examples "return results array"
    end

    context "when result is empty" do
      let(:title) { "spidermen" }
      let(:search_response_body) do
        JSON.parse(File.read("spec/fixtures/search_response_without_comics.json"))
      end

      include_examples "return results array"

      it { is_expected.to be_empty }
    end
  end
end
