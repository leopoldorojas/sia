require 'rails_helper'

RSpec.describe "ShareOperations", :type => :request do
  describe "GET /share_operations" do
    it "works! (now write some real specs)" do
      get share_operations_path
      expect(response).to have_http_status(200)
    end
  end
end
