require 'rails_helper'

RSpec.describe "shares/new", :type => :view do
  before(:each) do
    assign(:share, Share.new(
      :number => 1,
      :type => "",
      :share_holder => nil,
      :share_issue => nil
    ))
  end

  it "renders new share form" do
    render

    assert_select "form[action=?][method=?]", shares_path, "post" do

      assert_select "input#share_number[name=?]", "share[number]"

      assert_select "input#share_type[name=?]", "share[type]"

      assert_select "input#share_share_holder_id[name=?]", "share[share_holder_id]"

      assert_select "input#share_share_issue_id[name=?]", "share[share_issue_id]"
    end
  end
end
