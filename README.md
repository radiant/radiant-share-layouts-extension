# Layouts

Merges share_layouts and nested_layouts, making the whole layout adventure a lot more enjoyable

## Share Layouts

### Introduction

Allows Rails controllers/actions to use Radiant layouts as their "layout".
content_for blocks are mapped to page parts, with the exception of :title and
:breadcrumbs, which map to their specific default tags. The default content, 
or @content_for_layout, is mapped to the 'body' part.

#### Inside a controller Controller

    SomeController < SiteController
      radiant_layout 'Layout name'

    # or

      radiant_layout { |controller| c.action_name == "index" ? "main" : "alt" }
    
    # and
    
      def delete
        @radiant_layout = 'delete'
      end
      
    end

radiant_layout takes the same options as the built-in layout.  To specifically
override the Radiant layout and use a standard Rails one use 
:layout => "mine", or :layout => false for no layout, as options to render.

To choose a different Radiant layout, set the @radiant_layout instance 
variable to the name of a Radiant layout in your controller or view.

### Acknowledgments

* Merged into radiant-layouts-extension, Dirk Kelly, August 2010
* Updated to work with 0.8 RC1 by: Johannes Fahrenkrug (http://springenwerk.com), May 22, 2009
* Created by: Sean Cribbs (seancribbs AT gmail DOT com), September 20, 2007

* Thanks to John Long for clarifying and simplifying the process for me!
* Thanks to xtoddx for improving the tests and support for tags that use the  request and response.
* Thanks to Digital Pulp, Inc. for funding the initial development of this extension as part of the Redken.com project.

## Nested Layouts

### Introduction

Nested Layouts enables reuse of a top-level "master" layout (one that contains your <html> tags and the overall
structure/wrapper of your site) for several different "nested" layouts (i.e. a one-column layout and a
two-column layout).  Keep your layouts DRY!

A simple example is of the following wrapper and page layout

    <!-- Application Layout -->
    <!html>
      <body class="<r:layout />">
        <r:content_for_layout />
      </body>
    </html>
    
    <!-- Page Layout -->
    <r:inside_layout name='Application'>
      <h1>Hi</h1>
    </r:inside_layout>
    
This would render the following if Page Layout was called

    <!html>
      <body class="<r:layout />">
        <h1>Hi</h1>
      </body>
    </html>
    
### Acknowledgments

* Merged into radiant-layouts-extension, Dirk Kelly, August 2010
* Original Source: http://github.com/moklett/radiant-nested-layouts-extension

## Haml Layouts

[http://haml-lang.com/](http://haml-lang.com/)

### Introduction

Write your layouts and radius tags in haml, with support for nested layouts

    // Parent Layout
    %div{:id=>"parent"}
      %r:content_for_layout
      
    // Child Layout
    %r:inside_layout{:name=>"Parent"}
      %h2
        %:title
        
Note: Within Layouts you must set the name to end in `.haml`
        
Integrates the work of [SaturnFlyer](http://github.com/saturnflyer) creating a haml_filter on pages and snippets. Additional task involved
changing the order which objects with this type are renders. The content is turned into html before the 
radius tags are passed.

### Caveats 

You can't yet put a radiant tag inside an attribute of a haml element. ie:

    %div.product{:id=>"<r:id />"} // Will not work
    
    %div.product{:id=>"%r:id"} // Will not work
    
    %div.product{:id=><r:id />} // Will not work

In the mean time use a plain filter whilst we come up with something awesome

    %body
      #primary
        :plain
          <div id="<r:id />" class="product">
            <r:snippet name='product' />

### Acknowledgments

* [SaturnFlyer](http://github.com/saturnflyer) [@SaturnFlyer](http://twitter.com/saturnflyer) (Jim Gay)  | Original idea http://github.com/saturnflyer/radiant-haml_filter-extension
* [Tissak](http://github.com/tissak) [@Tissak](http://twitter.com/tissak) (Tony Issakov)  | Insisted that this was possible, and then wrote up an implementation in 10 minutes
* [DirkKelly](http://github.com/dirkkelly) [@DirkKelly](http://twitter.com/dirkkelly) (Dirk Kelly) | Merged into radiant-layouts-extension and hooked page parse_object to support snippets and content haml radius tags