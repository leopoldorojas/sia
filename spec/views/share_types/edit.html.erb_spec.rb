require 'rails_helper'

RSpec.describe "share_types/edit", :type => :view do
  before(:each) do
    @share_type = assign(:share_type, ShareType.create!(
      :name => "MyString",
      :value => "9.99"
    ))
  end

  it "renders the edit share_type form" do
    render

    assert_select "form[action=?][method=?]", share_type_path(@share_type), "post" do

      assert_select "input#share_type_name[name=?]", "share_type[name]"

      assert_select "input#share_type_value[name=?]", "share_type[value]"
    end
  end
end
