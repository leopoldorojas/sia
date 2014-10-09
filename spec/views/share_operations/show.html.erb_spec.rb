require 'rails_helper'

RSpec.describe "share_operations/show", :type => :view do
  before(:each) do
    @share_operation = assign(:share_operation, ShareOperation.create!(
      :operation_date => "",
      :share_holder => nil,
      :shares_number => 1,
      :cash => "9.99",
      :dividends => "9.99",
      :adjustment => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
  end
end
