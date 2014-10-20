module Aol
  module Analyzers
    class Lowercase
      def self.name
        :lowercase
      end

      def self.mapping
        { lowercase: { type: :string, analyzer: :lowercase }}
      end

      def self.settings
        {
          analysis: {
            analyzer: {
              lowercase: {
                type: :custom,
                tokenizer: :standard,
                filter: [:lowercase]
              }
            }
          }
        }
      end

      def self.search
        {
          facets: {
            lowercase: {
              terms: {
                field: 'query.lowercase',
                size: 2**31 - 1
              }
            }
          }
        }
      end
    end
  end
end
