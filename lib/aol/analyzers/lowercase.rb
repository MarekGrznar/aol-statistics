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
    end
  end
end
