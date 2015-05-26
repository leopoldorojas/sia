require 'rails_helper'

RSpec.describe "certificates/show", :type => :view do
  before(:each) do
    @certificate = assign(:certificate, Certificate.create!(
      :identifier => "Identifier",
      :shares_info => "Shares Info",
      :share_holder => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Identifier/)
    expect(rendered).to match(/Shares Info/)
    expect(rendered).to match(//)
  end
end
