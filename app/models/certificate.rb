class Certificate < ActiveRecord::Base
  belongs_to :share_holder
  validates :certificate_date, :shares_info, presence: true
  validates :shares_info, format: { with: /\A(\d+|\d+-\d+)(\s*,\s*(\d+|\d+-\d+))*\s*\Z/,  message:  I18n.t('certificate.share_info_invalid') }, unless: "shares_info.empty?"
  validate :only_one_share_holder

  def shares
    shares_set = []
    shares_info.split(',').each do | share_item |
      range_limits = share_item.split '-'
      range_limits.first.to_i.upto(range_limits.last.to_i) { |item_into_range| shares_set << item_into_range }
    end

    shares_set.uniq
  end

  def shares_info_parsed
    shares_parsed = ""
    shares_info.split(',').each_with_index do | share_item, index |
      if index > 0
        shares_parsed += ", "
      end

      share_item_splitted = share_item.split('-').map(&:strip)
      if share_item != share_item_splitted.first
        shares_parsed += "#{index > 0 ? 'd' : 'D'}e la acción No. #{share_item_splitted.first} hasta la No. #{share_item_splitted.last}"
      else 
        shares_parsed += "No. #{share_item}"
      end
    end

    shares_parsed
  end

private

  def only_one_share_holder
    shares_to_look_for = shares
    shares_found = Share.where(identifier: shares_to_look_for)

    if shares_found.size != shares_to_look_for.size
      errors[:base] << I18n.t('certificate.at_least_one_share_not_found')
    elsif (share_holders = shares_found.pluck(:share_holder_id).uniq).size > 1
      errors.add(:shares_info, I18n.t('certificate.only_one_share_holder_required'))
    else
      self.share_holder = ShareHolder.where(id: share_holders.first).first
    end

  end

end
