require 'rails_helper'

RSpec.describe "share_holders/edit", :type => :view do
  before(:each) do
    @share_holder = assign(:share_holder, ShareHolder.create!(
      :name => "MyString",
      :identifier => "MyString",
      :contact => "MyString",
      :phone => "MyString",
      :email => "MyString",
      :location => nil
    ))
  end

  it "renders the edit share_holder form" do
    render

    assert_select "form[action=?][method=?]", share_holder_path(@share_holder), "post" do

      assert_select "input#share_holder_name[name=?]", "share_holder[name]"

      assert_select "input#share_holder_identifier[name=?]", "share_holder[identifier]"

      assert_select "input#share_holder_contact[name=?]", "share_holder[contact]"

      assert_select "input#share_holder_phone[name=?]", "share_holder[phone]"

      assert_select "input#share_holder_email[name=?]", "share_holder[email]"

      assert_select "input#share_holder_location_id[name=?]", "share_holder[location_id]"
    end
  end
end
