require 'rails_helper'

RSpec.describe "share_types/show", :type => :view do
  before(:each) do
    @share_type = assign(:share_type, ShareType.create!(
      :name => "Name",
      :value => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/9.99/)
  end
end
