namespace :radiant do
  namespace :extensions do
    namespace :share_layouts do
      
      desc "Runs the migration of the Share Layouts extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          ShareLayoutsExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          ShareLayoutsExtension.migrator.migrate
        end
      end
    
    end
  end
end