namespace :lanyrd do    

  desc "import"
  task :import => :environment do
    LanyrdImporter.import!
  end

end

