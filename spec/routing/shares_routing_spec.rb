require "rails_helper"

RSpec.describe SharesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/shares").to route_to("shares#index")
    end

    it "routes to #new" do
      expect(:get => "/shares/new").to route_to("shares#new")
    end

    it "routes to #show" do
      expect(:get => "/shares/1").to route_to("shares#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/shares/1/edit").to route_to("shares#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/shares").to route_to("shares#create")
    end

    it "routes to #update" do
      expect(:put => "/shares/1").to route_to("shares#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/shares/1").to route_to("shares#destroy", :id => "1")
    end

  end
end
