module Aol
  module Analyzers
    class DbpediaResource
      def self.name
        :dbpedia_resource
      end

      def self.mapping
        {}
      end

      def self.settings
        {}
      end

      def self.search
        {
          facets: {
            dbpedia_resource: {
              terms: {
                field: 'dbpedia_resource',
                size: 2**31 - 1
              }
            }
          }
        }
      end
    end
  end
end
