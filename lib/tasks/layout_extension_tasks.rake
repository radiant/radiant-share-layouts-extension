namespace :radiant do
  namespace :extensions do
    namespace :layout do
      
      desc "Runs the migration of the Laid extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          LayoutExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          LayoutExtension.migrator.migrate
        end
      end
    
    end
  end
end