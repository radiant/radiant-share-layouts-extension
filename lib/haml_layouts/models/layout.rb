module HamlLayouts
  module Models
    module Layout
      
      def self.included(base)
        base.class_eval do
          
          def content
            if is_haml?
              Haml::Engine.new(self[:content]).render 
            else
              self[:content]
            end
          end
          
          # Overwrites the standard Radiant Render and pumps out haml if necessary
          def is_haml?
            result = false
            
            if File.extname(name) == '.haml'
              result = true
            elsif content_type == 'haml'
              warn 'DEPRECATED: Set HAML layout filename to end in `.haml`. Content/Type support to be removed in 1.1.0'
              result = true
            end
            
            result
          end
          
        end
      end
      
    end
  end
end