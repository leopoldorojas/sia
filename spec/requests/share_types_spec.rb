require 'rails_helper'

RSpec.describe "ShareTypes", :type => :request do
  describe "GET /share_types" do
    it "works! (now write some real specs)" do
      get share_types_path
      expect(response).to have_http_status(200)
    end
  end
end
