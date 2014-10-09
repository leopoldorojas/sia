require 'rails_helper'

RSpec.describe "share_operations/edit", :type => :view do
  before(:each) do
    @share_operation = assign(:share_operation, ShareOperation.create!(
      :operation_date => "",
      :share_holder => nil,
      :shares_number => 1,
      :cash => "9.99",
      :dividends => "9.99",
      :adjustment => "9.99"
    ))
  end

  it "renders the edit share_operation form" do
    render

    assert_select "form[action=?][method=?]", share_operation_path(@share_operation), "post" do

      assert_select "input#share_operation_operation_date[name=?]", "share_operation[operation_date]"

      assert_select "input#share_operation_share_holder_id[name=?]", "share_operation[share_holder_id]"

      assert_select "input#share_operation_shares_number[name=?]", "share_operation[shares_number]"

      assert_select "input#share_operation_cash[name=?]", "share_operation[cash]"

      assert_select "input#share_operation_dividends[name=?]", "share_operation[dividends]"

      assert_select "input#share_operation_adjustment[name=?]", "share_operation[adjustment]"
    end
  end
end
