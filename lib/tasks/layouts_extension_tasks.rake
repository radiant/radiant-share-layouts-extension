namespace :radiant do
  namespace :extensions do
    namespace :layouts do
      
      desc "Runs the migration of the Laid extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          LayoutsExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          LayoutsExtension.migrator.migrate
        end
      end
      
      desc "nothing to do"
      task :update => :environment do
        puts "nothing to do"
      end
    
    end
  end
end