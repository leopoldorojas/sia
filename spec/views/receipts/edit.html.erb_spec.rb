require 'rails_helper'

RSpec.describe "receipts/edit", :type => :view do
  before(:each) do
    @receipt = assign(:receipt, Receipt.create!(
      :number => "MyString",
      :type => "",
      :description => "MyText",
      :share_operation => nil
    ))
  end

  it "renders the edit receipt form" do
    render

    assert_select "form[action=?][method=?]", receipt_path(@receipt), "post" do

      assert_select "input#receipt_number[name=?]", "receipt[number]"

      assert_select "input#receipt_type[name=?]", "receipt[type]"

      assert_select "textarea#receipt_description[name=?]", "receipt[description]"

      assert_select "input#receipt_share_operation_id[name=?]", "receipt[share_operation_id]"
    end
  end
end
