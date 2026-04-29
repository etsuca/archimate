module Faker
  class Building < Base
    class << self
      def building_name
        fetch('building.building_name')
      end

      def location
        fetch('address.city')
      end

      def architect_name
        fetch('name.name')
      end

      def description
        fetch('building.description')
      end
    end
  end
end
