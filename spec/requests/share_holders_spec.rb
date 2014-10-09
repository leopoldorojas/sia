require 'rails_helper'

RSpec.describe "ShareHolders", :type => :request do
  describe "GET /share_holders" do
    it "works! (now write some real specs)" do
      get share_holders_path
      expect(response).to have_http_status(200)
    end
  end
end
