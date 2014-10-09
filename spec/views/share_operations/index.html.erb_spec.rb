require 'rails_helper'

RSpec.describe "share_operations/index", :type => :view do
  before(:each) do
    assign(:share_operations, [
      ShareOperation.create!(
        :operation_date => "",
        :share_holder => nil,
        :shares_number => 1,
        :cash => "9.99",
        :dividends => "9.99",
        :adjustment => "9.99"
      ),
      ShareOperation.create!(
        :operation_date => "",
        :share_holder => nil,
        :shares_number => 1,
        :cash => "9.99",
        :dividends => "9.99",
        :adjustment => "9.99"
      )
    ])
  end

  it "renders a list of share_operations" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
