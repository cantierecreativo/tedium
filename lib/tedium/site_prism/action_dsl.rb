module Tedium
  module SitePrism
    module ActionDsl
      def action(name, role = name)
        element "#{name}_element", :role, role

        define_method "#{name}!" do
          send("#{name}_element").click
        end
      end

      def actions(*names)
        names.each { |n| action n }
      end
    end
  end
end

