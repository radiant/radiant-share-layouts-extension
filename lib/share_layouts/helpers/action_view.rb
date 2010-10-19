module ShareLayouts
  module Helpers
    module ActionView
  
        def self.included(base)
          base.class_eval do
            
            def radiant_layout(name = @radiant_layout)
              page = find_page
              assign_attributes!(page, name)
              page.build_parts_from_hash!(extract_captures) 
              page.render
            end
            
            def assign_attributes!(page, name = @radiant_layout)
              page.layout = Layout.find_by_name(name) || page.layout
              page.title = @title || @content_for_title || page.title || ''
              page.breadcrumb = @breadcrumb || @content_for_breadcrumb || page.breadcrumb || page.title
              page.breadcrumbs = @breadcrumbs || @content_for_breadcrumbs || nil
              page.url = request.path
              page.slug = page.url.split("/").last
              page.published_at ||= Time.now 
              page.request = request
              page.response = response
            end
            
            def extract_captures
              variables = instance_variables.grep(/@content_for_/)
              variables.inject({}) do |h, var|
                var =~ /^@content_for_(.*)$/
                key = $1.intern
                key = :body if key == :layout
                unless key == :title || key == :breadcrumbs
                  h[key] = instance_variable_get(var)
                end
                h
              end
            end
            
            def find_page
              page = Page.find_by_url(request.path) rescue nil
              page.is_a?(RailsPage) ? page : RailsPage.new(:class_name => "RailsPage")
            end
            
          end
        end
      
    end
  end
end