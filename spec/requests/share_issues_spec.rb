require 'rails_helper'

RSpec.describe "ShareIssues", :type => :request do
  describe "GET /share_issues" do
    it "works! (now write some real specs)" do
      get share_issues_path
      expect(response).to have_http_status(200)
    end
  end
end
