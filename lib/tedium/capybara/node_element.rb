module Tedium
  module Capybara
    module NodeElement
      def self.included(base)
        base.send(:alias_method, :original_set, :set)
        base.send(:alias_method, :set, :augmented_select)
      end

      def augmented_select(*args)
        if tag_name == "select"
          find(:option_with_value_or_label, args[0]).select_option
        else
          original_set(*args)
        end
      end
    end
  end
end
