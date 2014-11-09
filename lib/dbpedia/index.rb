module Dbpedia
  class Index < Es::Index
    def name
      @name ||= :dbpedia
    end

    def type
      @type ||= :category
    end

    def settings
      @settings ||= {
        analysis: {
          analyzer: {
            dbpedia_category_analyzer: {
              type: :custom,
              tokenizer: :standard,
              filter: [:lowercase]
            }
          }
        }
      }
    end

    def mappings
      @mappings ||= {
        category: {
          properties: {
            category: { type: :string, analyzer: :dbpedia_category_analyzer }
          }
        }
      }
    end

    def search(query)
      client.search(
        index: name,
        body: {
          query: {
            query_string: {
              query: query.gsub(/(\+|\-|&&|\||\||\(|\)|\{|\}|\[|\]|\^|~|\!|\\|\/|:)/) { |m| "\\#{m}" },
              default_field: :category,
              default_operator: :and,
              fuzziness: 'AUTO'
            }
          }
        }
      )
    end

    def import_from(path)
      delete
      create

      categories = Dbpedia::Parser.parse(File.new(path).read)

      categories.each_slice(10000) do |array|
        client.bulk body: array.map { |category|
          [
            { index: { _index: name, _type: type }},
            { type => category }
          ]
        }.flatten
      end

      flush
    end
  end
end
