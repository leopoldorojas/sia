require 'rails_helper'

RSpec.describe "shares/show", :type => :view do
  before(:each) do
    @share = assign(:share, Share.create!(
      :number => 1,
      :type => "Type",
      :share_holder => nil,
      :share_issue => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
