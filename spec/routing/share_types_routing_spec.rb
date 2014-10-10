require "rails_helper"

RSpec.describe ShareTypesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/share_types").to route_to("share_types#index")
    end

    it "routes to #new" do
      expect(:get => "/share_types/new").to route_to("share_types#new")
    end

    it "routes to #show" do
      expect(:get => "/share_types/1").to route_to("share_types#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/share_types/1/edit").to route_to("share_types#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/share_types").to route_to("share_types#create")
    end

    it "routes to #update" do
      expect(:put => "/share_types/1").to route_to("share_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/share_types/1").to route_to("share_types#destroy", :id => "1")
    end

  end
end
