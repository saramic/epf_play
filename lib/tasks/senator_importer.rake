namespace :import do
  desc "import senators"
  task senators: :environment do
    SenatorImporter.new(File.join(Rails.root, %w(spec fixtures Senator_photos.html))).import
  end
end
