require 'rails_helper'

RSpec.describe "certificates/edit", :type => :view do
  before(:each) do
    @certificate = assign(:certificate, Certificate.create!(
      :identifier => "MyString",
      :shares_info => "MyString",
      :share_holder => nil
    ))
  end

  it "renders the edit certificate form" do
    render

    assert_select "form[action=?][method=?]", certificate_path(@certificate), "post" do

      assert_select "input#certificate_identifier[name=?]", "certificate[identifier]"

      assert_select "input#certificate_shares_info[name=?]", "certificate[shares_info]"

      assert_select "input#certificate_share_holder_id[name=?]", "certificate[share_holder_id]"
    end
  end
end
