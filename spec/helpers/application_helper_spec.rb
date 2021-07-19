RSpec.describe ApplicationHelper do
  describe "#show_next_btn?" do
    subject { helper.show_next_btn?(data) }

    context "when showing next btn" do
      let(:data) { { "offset" => "20", "total" => "100" } }

      it { is_expected.to be true }
    end

    context "when not showing next btn" do
      let(:data) { { "offset" => "90", "total" => "100" } }

      it { is_expected.to be false }
    end
  end

  describe "#show_previous_btn?" do
    subject { helper.show_previous_btn?(data) }

    context "when showing back btn" do
      let(:data) { { "offset" => "20", "total" => "100" } }

      it { is_expected.to be true }
    end

    context "when not showing back btn" do
      let(:data) { { "offset" => "0", "total" => "100" } }

      it { is_expected.to be false }
    end
  end

  describe "#next_offset_calculator" do
    subject { helper.next_offset_calculator(data) }

    context "when offset is 0" do
      let(:data) { { "offset" => "0" } }

      it { is_expected.to eq 20 }
    end

    context "when offset is more than 0" do
      let(:data) { { "offset" => "20" } }

      it { is_expected.to eq 40 }
    end
  end

  describe "#back_offset_calculator" do
    subject { helper.back_offset_calculator(data) }

    context "when offset is 0" do
      let(:data) { { "offset" => "0" } }

      it { is_expected.to eq 0 }
    end

    context "when offset is more than 0" do
      let(:data) { { "offset" => "20" } }

      it { is_expected.to eq 0 }
    end
  end
end
