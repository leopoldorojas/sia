require "rails_helper"

RSpec.describe ShareIssuesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/share_issues").to route_to("share_issues#index")
    end

    it "routes to #new" do
      expect(:get => "/share_issues/new").to route_to("share_issues#new")
    end

    it "routes to #show" do
      expect(:get => "/share_issues/1").to route_to("share_issues#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/share_issues/1/edit").to route_to("share_issues#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/share_issues").to route_to("share_issues#create")
    end

    it "routes to #update" do
      expect(:put => "/share_issues/1").to route_to("share_issues#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/share_issues/1").to route_to("share_issues#destroy", :id => "1")
    end

  end
end
