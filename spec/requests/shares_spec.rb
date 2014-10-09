require 'rails_helper'

RSpec.describe "Shares", :type => :request do
  describe "GET /shares" do
    it "works! (now write some real specs)" do
      get shares_path
      expect(response).to have_http_status(200)
    end
  end
end
