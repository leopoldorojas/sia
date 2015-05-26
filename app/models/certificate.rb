class Certificate < ActiveRecord::Base
  belongs_to :share_holder
  validates :certificate_date, :shares_info, presence: true
  validates :shares_info, format: { with: /\A(\d+|\d+-\d+)(\s*,\s*(\d+|\d+-\d+))*\s*\Z/,  message:  I18n.t('certificate.share_info_invalid') }, unless: "shares_info.empty?"
end
