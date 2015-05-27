class Certificate < ActiveRecord::Base
  belongs_to :share_holder
  validates :certificate_date, :shares_info, presence: true
  validates :shares_info, format: { with: /\A(\d+|\d+-\d+)(\s*,\s*(\d+|\d+-\d+))*\s*\Z/,  message:  I18n.t('certificate.share_info_invalid') }, unless: "shares_info.empty?"
  validate :only_one_share_holder

private

  def only_one_share_holder
    if (share_holders = Share.where(identifier: shares).pluck(:share_holder_id).uniq).length > 1
    	errors.add(:shares_info, I18n.t('certificate.only_one_share_holder_required'))
    else
      self.share_holder = ShareHolder.where(id: share_holders.first).first
    end
  end

  def shares
  	shares_set = []
  	shares_info.split(',').each do | share_item |
  		range_limits = share_item.split '-'
  		range_limits.first.to_i.upto(range_limits.last.to_i) { |item_into_range| shares_set << item_into_range }
  	end

  	shares_set.uniq
  end 

end
