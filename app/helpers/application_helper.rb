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
  
  def share_type_selector form, klass
    share_types = ShareType.all

    if share_types.size == 1
      form.collection_select :share_type_id, [share_types.first], :id, :to_s
    else
      form.collection_select :share_type_id, share_types, :id, :to_s, prompt: t("#{klass}.prompt_share_type")
    end
  end

end
