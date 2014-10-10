require 'rails_helper'

RSpec.describe "companies/new", :type => :view do
  before(:each) do
    assign(:company, Company.new(
      :name => "MyString",
      :last_share_issued => 1
    ))
  end

  it "renders new company form" do
    render

    assert_select "form[action=?][method=?]", companies_path, "post" do

      assert_select "input#company_name[name=?]", "company[name]"

      assert_select "input#company_last_share_issued[name=?]", "company[last_share_issued]"
    end
  end
end
