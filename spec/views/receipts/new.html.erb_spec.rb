require 'rails_helper'

RSpec.describe "receipts/new", :type => :view do
  before(:each) do
    assign(:receipt, Receipt.new(
      :number => "MyString",
      :type => "",
      :description => "MyText",
      :share_operation => nil
    ))
  end

  it "renders new receipt form" do
    render

    assert_select "form[action=?][method=?]", receipts_path, "post" do

      assert_select "input#receipt_number[name=?]", "receipt[number]"

      assert_select "input#receipt_type[name=?]", "receipt[type]"

      assert_select "textarea#receipt_description[name=?]", "receipt[description]"

      assert_select "input#receipt_share_operation_id[name=?]", "receipt[share_operation_id]"
    end
  end
end
