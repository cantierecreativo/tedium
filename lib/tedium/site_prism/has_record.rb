module Tedium
  module SitePrism
    module HasRecord
      def has_record?(record)
        element_exists?(:record, record)
      end
    end
  end
end

