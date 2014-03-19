require "tedium/virtual_date_element"
require "tedium/virtual_datetime_element"

module Tedium
  module SitePrism
    module FormDsl
      def field(name, attribute_name = name)
        @fields ||= []
        @fields << name
        element "#{name}_field", :input_for_field, attribute_name
      end

      def fields(*names)
        names.each { |n| field n }
      end

      def date_field(name, attribute_name = name)
        define_method "#{name}_field" do
          VirtualDateElement.new(root_element_or_page, attribute_name)
        end
      end

      def datetime_field(name, attribute_name = name)
        define_method "#{name}_field" do
          VirtualDateTimeElement.new(root_element_or_page, attribute_name)
        end
      end

      def submit_button(role = nil)
        element :submit_button, :submit_button, role

        define_method :submit! do
          submit_button.click
        end
      end

      def submission(name, fields = nil)
        fields ||= @fields
        define_method "#{name}!" do |*args|
          Array(fields).each_with_index do |field, i|
            send("#{field}_field").set(args[i])
          end
          submit!
        end
      end
    end
  end
end

