require 'rails_helper'

RSpec.describe "shares/index", :type => :view do
  before(:each) do
    assign(:shares, [
      Share.create!(
        :number => 1,
        :share_holder => nil,
        :share_issue => nil
      ),
      Share.create!(
        :number => 1,
        :share_holder => nil,
        :share_issue => nil
      )
    ])
  end

  it "renders a list of shares" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
