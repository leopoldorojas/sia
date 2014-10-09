require 'rails_helper'

RSpec.describe "share_holders/show", :type => :view do
  before(:each) do
    @share_holder = assign(:share_holder, ShareHolder.create!(
      :name => "Name",
      :identifier => "Identifier",
      :contact => "Contact",
      :phone => "Phone",
      :email => "Email",
      :location => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Identifier/)
    expect(rendered).to match(/Contact/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(//)
  end
end
