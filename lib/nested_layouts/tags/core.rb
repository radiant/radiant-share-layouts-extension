module NestedLayouts
  module Tags
    module Core
      
      include Radiant::Taggable
  
      class TagError < StandardError; end

      desc %{
        Renders the contents of the tag inside of a "parent" layout, which is selected via the +name+
        attribute.  The contents of this tag are placed at a corresponding <r:content_for_layout/> tag
        within the parent layout.  This tag is intended to be used within your layouts, and should
        only appear once per layout.
    
        *Usage:*

        <r:inside_layout name="master">
          <div id="main-column">
            <r:content_for_layout/>
          </div>
        </r:inside_layout>
      }
      tag 'inside_layout' do |tag|
        if name = tag.attr['name']
          # Prepare the stacks
          tag.globals.nested_layouts_content_stack ||= []
          tag.globals.nested_layouts_layout_stack ||= []

          # Remember the original layout to support the +layout+ tag
          tag.globals.page_original_layout ||= tag.globals.page.layout # Remember the original layout
      
          # Find the layout
          name.strip!
          if layout = Layout.find_by_name(name)
            # Track this layout on the stack
            tag.globals.nested_layouts_layout_stack << name
        
            # Save contents of inside_layout for later insertion
            tag.globals.nested_layouts_content_stack << tag.expand
        
            # Set the page layout that Radiant should use for rendering, which is different than the actual
            # page's layout when layouts are nested.  The final/highest +inside_layout+ tag will set or 
            # overwrite this value for the last time.
            tag.globals.page.layout = layout
            tag.globals.page.render
          else
            raise TagError.new(%{Error (nested_layouts): Parent layout "#{name.strip}" not found for "inside_layout" tag})
          end
        else
          raise TagError.new(%{Error (nested_layouts): "inside_layout" tag must contain a "name" attribute})
        end
      end
    
      desc %{
        Allows nested layouts to target this layout.  The contents of <r:inside_layout> tag blocks in another
        layout will have their contents inserted at the location given by this tag (if they target this
        layout).  This tag also behaves like a standard <r:content/> tag if this layout is specified directly
        by a page.
      
        This tag is intended to be used inside layouts.
      
        *Usage:*
      
        <html>
          <body>
            <r:content_for_layout/>
          </body>
        </html>
    
      }
      tag 'content_for_layout' do |tag|
        tag.globals.nested_layouts_content_stack ||= []
    
        # return the saved content if any, or mimic a default +<r:content/>+ tag (render the body part)
        tag.globals.nested_layouts_content_stack.pop || tag.globals.page.render_snippet(tag.locals.page.part('body'))
      end
    
      desc %{
        Return the layout name of the current page.
      
        *Usage:*
      
        <html>
          <body id="<r:layout/>"
            My body tag has an id corresponding to the layout I use.  Sweet!
          </body>
        </html>
      }
      tag 'layout' do |tag|
        current_layout_name(tag)
      end
    
      desc %{ output the contents of tag if layout equals name }
      tag 'if_layout' do |tag|
        if name = tag.attr['name']
          if layout = tag.globals.page_original_layout
            tag.expand if layout.name == name
          elsif layout = tag.globals.page.layout
            tag.expand if layout.name == name
          end
        else
          raise TagError.new(%{Error (nested_layouts): "if_layout" tag must contain a "name" attribute})
        end
      end
    
      desc %{ output the contents of tag unless layout equals name }
      tag 'unless_layout' do |tag|
        if name = tag.attr['name']
          if layout = tag.globals.page_original_layout
            tag.expand if layout.name != name
          elsif layout = tag.globals.page.layout
            tag.expand if layout.name != name
          else
            tag.expand
          end
        else
          raise TagError.new(%{Error (nested_layouts): "if_layout" tag must contain a "name" attribute})
        end
      end
      
      tag 'body' do  |tag|
        %{<body id="#{tag.locals.page.slug}" class="#{current_layout_name(tag)}#{tag.attr['class'].present? ? " #{tag.attr['class']}" : nil}">#{tag.expand}</body>}
      end
      
      protected
      
      def current_layout_name(tag)
        result = ''
        
        if layout = tag.globals.page_original_layout
          result = layout.name
        elsif layout = tag.globals.page.layout
          result = layout.name
        end
        
        result
      end
      
    end
  end
end