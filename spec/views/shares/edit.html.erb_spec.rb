require 'rails_helper'

RSpec.describe "shares/edit", :type => :view do
  before(:each) do
    @share = assign(:share, Share.create!(
      :number => 1,
      :share_holder => nil,
      :share_issue => nil
    ))
  end

  it "renders the edit share form" do
    render

    assert_select "form[action=?][method=?]", share_path(@share), "post" do

      assert_select "input#share_number[name=?]", "share[number]"

      assert_select "input#share_type[name=?]", "share[type]"

      assert_select "input#share_share_holder_id[name=?]", "share[share_holder_id]"

      assert_select "input#share_share_issue_id[name=?]", "share[share_issue_id]"
    end
  end
end
