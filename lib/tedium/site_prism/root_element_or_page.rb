module Tedium
  module SitePrism
    module RootElementOrPage
      def root_element_or_page
        if defined?(self.root_element)
          root_element
        else
          page
        end
      end
    end
  end
end

