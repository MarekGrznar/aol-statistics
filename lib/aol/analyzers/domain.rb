module Aol
  module Analyzers
    class Domain
      def self.name
        :domain
      end

      def self.mapping
        { domain: { type: :string, analyzer: :domain }}
      end

      def self.settings
        {
          analysis: {
            filter: {
              domain_filter: {
                type: :pattern_replace,
                pattern: '(www.|\.\w{2})',
                replacement: ''
              }
            },

            analyzer: {
              domain: {
                type: :custom,
                tokenizer: :standard,
                filter: [:lowercase, :domain_filter]
              }
            }
          }
        }
      end

      def self.search
        {
          facets: {
            domain: {
              terms: {
                field: 'query.domain',
                size: 2**31 - 1
              }
            }
          }
        }
      end
    end
  end
end
