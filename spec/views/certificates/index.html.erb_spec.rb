require 'rails_helper'

RSpec.describe "certificates/index", :type => :view do
  before(:each) do
    assign(:certificates, [
      Certificate.create!(
        :identifier => "Identifier",
        :shares_info => "Shares Info",
        :share_holder => nil
      ),
      Certificate.create!(
        :identifier => "Identifier",
        :shares_info => "Shares Info",
        :share_holder => nil
      )
    ])
  end

  it "renders a list of certificates" do
    render
    assert_select "tr>td", :text => "Identifier".to_s, :count => 2
    assert_select "tr>td", :text => "Shares Info".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
