require 'rails_helper'

RSpec.describe "share_issues/edit", :type => :view do
  before(:each) do
    @share_issue = assign(:share_issue, ShareIssue.create!(
      :initial_share => 1,
      :final_share => 1,
      :company => nil
    ))
  end

  it "renders the edit share_issue form" do
    render

    assert_select "form[action=?][method=?]", share_issue_path(@share_issue), "post" do

      assert_select "input#share_issue_initial_share[name=?]", "share_issue[initial_share]"

      assert_select "input#share_issue_final_share[name=?]", "share_issue[final_share]"

      assert_select "input#share_issue_company_id[name=?]", "share_issue[company_id]"
    end
  end
end
