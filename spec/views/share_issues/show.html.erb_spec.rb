require 'rails_helper'

RSpec.describe "share_issues/show", :type => :view do
  before(:each) do
    @share_issue = assign(:share_issue, ShareIssue.create!(
      :initial_share => 1,
      :final_share => 2,
      :company => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
