module ShareLayouts
  module Controllers
    module ActionController
      
      def self.included(base)
        base.extend ClassMethods
      end
      
      module ClassMethods
        def radiant_layout(name=nil, options={}, &block)
          raise ArgumentError, "A layout name or block is required!" unless name || block
          write_inheritable_attribute 'radiant_layout', name || block
          before_filter :set_radiant_layout
          layout 'radiant', options
        end
      end
      
      def set_radiant_layout
        @radiant_layout = self.class.read_inheritable_attribute 'radiant_layout'
        @radiant_layout = @radiant_layout.call(self) if @radiant_layout.is_a? Proc
      end
      
    end
  end
end
