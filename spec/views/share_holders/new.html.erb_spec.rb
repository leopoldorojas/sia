require 'rails_helper'

RSpec.describe "share_holders/new", :type => :view do
  before(:each) do
    assign(:share_holder, ShareHolder.new(
      :name => "MyString",
      :identifier => "MyString",
      :contact => "MyString",
      :phone => "MyString",
      :email => "MyString",
      :location => nil
    ))
  end

  it "renders new share_holder form" do
    render

    assert_select "form[action=?][method=?]", share_holders_path, "post" do

      assert_select "input#share_holder_name[name=?]", "share_holder[name]"

      assert_select "input#share_holder_identifier[name=?]", "share_holder[identifier]"

      assert_select "input#share_holder_contact[name=?]", "share_holder[contact]"

      assert_select "input#share_holder_phone[name=?]", "share_holder[phone]"

      assert_select "input#share_holder_email[name=?]", "share_holder[email]"

      assert_select "input#share_holder_location_id[name=?]", "share_holder[location_id]"
    end
  end
end
