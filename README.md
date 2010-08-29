# Layouts

Merges share_layouts and nested_layouts, making the whole layout adventure a lot more enjoyable

## Share Layouts

### Introduction

Allows Rails controllers/actions to use Radiant layouts as their "layout".
content_for blocks are mapped to page parts, with the exception of :title and
:breadcrumbs, which map to their specific default tags. The default content, 
or @content_for_layout, is mapped to the 'body' part.

== What to do in your controllers

  radiant_layout 'Layout name'

-or-

  radiant_layout { |controller| # some code to determine layout name }

radiant_layout takes the same options as the built-in layout.  To specifically
override the Radiant layout and use a standard Rails one use 
:layout => "mine", or :layout => false for no layout, as options to render.

To choose a different Radiant layout, set the @radiant_layout instance 
variable to the name of a Radiant layout in your controller or view.

### Acknowledgments

* Merged into 
* Updated to work with 0.8 RC1 by: Johannes Fahrenkrug (http://springenwerk.com), May 22, 2009
* Created by: Sean Cribbs (seancribbs AT gmail DOT com), September 20, 2007

* Thanks to John Long for clarifying and simplifying the process for me!
* Thanks to xtoddx for improving the tests and support for tags that use the  request and response.
* Thanks to Digital Pulp, Inc. for funding the initial development of this extension as part of the Redken.com project.

## Nested Layouts

### Introduction

Provides the ability to include a layout outside of the current one. Meaning you can define things
like a doctype without having to repeat yourself.

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

_coming soon, sorry_