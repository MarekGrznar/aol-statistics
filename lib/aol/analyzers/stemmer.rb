module Aol
  module Analyzers
    class Stemmer
      def self.name
        :stemmer
      end

      def self.mapping
        { stemmer: { type: :string, analyzer: :english_stemmer }}
      end

      def self.settings
        {
          analysis: {
            analyzer: {
              english_stemmer: {
                type: :custom,
                tokenizer: :keyword,
                filter: [:lowercase, :my_stemmer]
              }
            },

            filter: {
              my_stemmer: {
                type: :stemmer,
                name: :english
              }
            }
          }
        }
      end

      def self.search
        {
          facets: {
            stemmer: {
              terms: {
                field: 'query.stemmer',
                size: 2**31 - 1
              }
            }
          }
        }
      end
    end
  end
end
