class ShareOperation < ActiveRecord::Base
  has_one :receipt
  has_many :shares
  default_scope { order operation_date: :desc }

  class << self
    def since this_date
      where("operation_date >= ?", this_date)
    end

    def until this_date
      where("operation_date <= ?", this_date)
    end

    def receipt_like this_receipt
      joins(:receipt).where("upper(receipts.number) LIKE upper(?)", "%#{this_receipt}%")
    end
  end

  def share_type
    shares.try(:first).try(:share_type)
  end
end
