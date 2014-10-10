require 'rails_helper'

RSpec.describe "share_issues/new", :type => :view do
  before(:each) do
    assign(:share_issue, ShareIssue.new(
      :initial_share => 1,
      :final_share => 1,
      :company => nil
    ))
  end

  it "renders new share_issue form" do
    render

    assert_select "form[action=?][method=?]", share_issues_path, "post" do

      assert_select "input#share_issue_initial_share[name=?]", "share_issue[initial_share]"

      assert_select "input#share_issue_final_share[name=?]", "share_issue[final_share]"

      assert_select "input#share_issue_company_id[name=?]", "share_issue[company_id]"
    end
  end
end
