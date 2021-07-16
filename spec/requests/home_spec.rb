RSpec.describe HomeController, type: :request do
  describe "GET #index" do
    before { get home_index_path }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template "home/index" }
  end
end
