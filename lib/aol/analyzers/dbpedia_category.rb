module Aol
  module Analyzers
    class DbpediaCategory
      def self.name
        :dbpedia_category
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
            dbpedia_category: {
              terms: {
                field: 'dbpedia_category',
                size: 2**31 - 1
              }
            }
          }
        }
      end
    end
  end
end
