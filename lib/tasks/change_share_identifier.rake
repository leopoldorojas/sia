namespace :share_identifier do
  desc "Change the Share Identifier in order to have them with the same identifier that the actual id"

  task change_share_identifier: :environment do
    counter = 11862

    company = Company.first
    company.last_share_issued += counter
    company.save

    Receipt.all.each do |receipt|
      receipt.share_operation.shares.each do |share|
        counter += 1
        share.identifier = counter
        share.save
      end
    end

    Share.where("identifier < 11863").each do |share|
      counter += 1
      share.identifier = counter
      share.save
    end
  end
end