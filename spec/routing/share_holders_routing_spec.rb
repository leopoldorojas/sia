require "rails_helper"

RSpec.describe ShareHoldersController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/share_holders").to route_to("share_holders#index")
    end

    it "routes to #new" do
      expect(:get => "/share_holders/new").to route_to("share_holders#new")
    end

    it "routes to #show" do
      expect(:get => "/share_holders/1").to route_to("share_holders#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/share_holders/1/edit").to route_to("share_holders#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/share_holders").to route_to("share_holders#create")
    end

    it "routes to #update" do
      expect(:put => "/share_holders/1").to route_to("share_holders#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/share_holders/1").to route_to("share_holders#destroy", :id => "1")
    end

  end
end
