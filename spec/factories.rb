Factory.define :zip_code_range do |f|
  f.start_zip   { Faker::Address.zip_code }
  f.end_zip     { Faker::Address.zip_code } # TODO: Rework this to ensure start_zip < end_zip.
  
  # TODO: zone_member association
  # TODO: zone association
end
