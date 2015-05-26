require 'rails_helper'

RSpec.describe "certificates/new", :type => :view do
  before(:each) do
    assign(:certificate, Certificate.new(
      :identifier => "MyString",
      :shares_info => "MyString",
      :share_holder => nil
    ))
  end

  it "renders new certificate form" do
    render

    assert_select "form[action=?][method=?]", certificates_path, "post" do

      assert_select "input#certificate_identifier[name=?]", "certificate[identifier]"

      assert_select "input#certificate_shares_info[name=?]", "certificate[shares_info]"

      assert_select "input#certificate_share_holder_id[name=?]", "certificate[share_holder_id]"
    end
  end
end
