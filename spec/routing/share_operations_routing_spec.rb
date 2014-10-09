require "rails_helper"

RSpec.describe ShareOperationsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/share_operations").to route_to("share_operations#index")
    end

    it "routes to #new" do
      expect(:get => "/share_operations/new").to route_to("share_operations#new")
    end

    it "routes to #show" do
      expect(:get => "/share_operations/1").to route_to("share_operations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/share_operations/1/edit").to route_to("share_operations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/share_operations").to route_to("share_operations#create")
    end

    it "routes to #update" do
      expect(:put => "/share_operations/1").to route_to("share_operations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/share_operations/1").to route_to("share_operations#destroy", :id => "1")
    end

  end
end
