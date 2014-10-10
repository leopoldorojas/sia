require 'rails_helper'

RSpec.describe "share_issues/index", :type => :view do
  before(:each) do
    assign(:share_issues, [
      ShareIssue.create!(
        :initial_share => 1,
        :final_share => 2,
        :company => nil
      ),
      ShareIssue.create!(
        :initial_share => 1,
        :final_share => 2,
        :company => nil
      )
    ])
  end

  it "renders a list of share_issues" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
