require 'rails_helper'

RSpec.describe "share_holders/index", :type => :view do
  before(:each) do
    assign(:share_holders, [
      ShareHolder.create!(
        :name => "Name",
        :identifier => "Identifier",
        :contact => "Contact",
        :phone => "Phone",
        :email => "Email",
        :location => nil
      ),
      ShareHolder.create!(
        :name => "Name",
        :identifier => "Identifier",
        :contact => "Contact",
        :phone => "Phone",
        :email => "Email",
        :location => nil
      )
    ])
  end

  it "renders a list of share_holders" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Identifier".to_s, :count => 2
    assert_select "tr>td", :text => "Contact".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
