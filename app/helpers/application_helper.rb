module ApplicationHelper

  def current_company
  	@company
  end

  def as_decimal number
  	number_to_currency(number, unit: "", separator: ".", delimiter: ",")
  end

  def as_integer number
  	number_to_currency(number, unit: "", separator: ".", delimiter: ",", precision: 0)
  end

  def as_money number
  	number_to_currency(number, unit: "", separator: ".", delimiter: ",")
  end

  def as_percentage number
    number_to_percentage(number, precision: 2, separator: ".")
  end

end
