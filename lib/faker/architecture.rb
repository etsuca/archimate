module Faker
  class Architecture < Base
    class << self
      def building_name
        fetch('architecture.building_name')
      end

      def location
        fetch('address.city')
      end

      def architect_name
        fetch('name.name')
      end

      def description
        fetch('architecture.description')
      end
    end
  end
end
