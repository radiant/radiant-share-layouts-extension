namespace :radiant do
  namespace :extensions do
    namespace :laid do
      
      desc "Runs the migration of the Laid extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          LaidExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          LaidExtension.migrator.migrate
        end
      end
    
    end
  end
end