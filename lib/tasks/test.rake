namespace :test do
    desc "Reset actions table and re-seed it"
    task reset: :environment do
        Folder.destroy_all
        Action.destroy_all
        Rake::Task["db:seed"].invoke
        puts "Actions table reset and re-seeded"
    end
end
