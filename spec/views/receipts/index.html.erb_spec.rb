require 'rails_helper'

RSpec.describe "receipts/index", :type => :view do
  before(:each) do
    assign(:receipts, [
      Receipt.create!(
        :number => "Number",
        :type => "Type",
        :description => "MyText",
        :share_operation => nil
      ),
      Receipt.create!(
        :number => "Number",
        :type => "Type",
        :description => "MyText",
        :share_operation => nil
      )
    ])
  end

  it "renders a list of receipts" do
    render
    assert_select "tr>td", :text => "Number".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
