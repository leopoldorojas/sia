require 'rails_helper'

RSpec.describe "receipts/show", :type => :view do
  before(:each) do
    @receipt = assign(:receipt, Receipt.create!(
      :number => "Number",
      :type => "Type",
      :description => "MyText",
      :share_operation => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Number/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
