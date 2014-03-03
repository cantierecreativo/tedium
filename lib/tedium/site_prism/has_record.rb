module Tedium
  module SitePrism
    module HasRecord
      def self.included(base)
        base.element :record, :record
      end
    end
  end
end

