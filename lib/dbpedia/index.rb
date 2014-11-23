module Dbpedia
  class Index < Es::Index
    def name
      @name ||= :dbpedia
    end

    def type
      @type ||= :label
    end

    def settings
      @settings ||= {
        analysis: {
          analyzer: {
            dbpedia_label_analyzer: {
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
        type => {
          properties: {
            title: { type: :string, analyzer: :dbpedia_label_analyzer },
            resource: { type: :string, index: :not_analyzed }
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
              default_field: :title,
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

      labels = Dbpedia::Parser.parse(File.new(path).read)

      labels.each_slice(10000) do |array|
        client.bulk body: array.map { |label|
          [
            { index: { _index: name, _type: type }},
            label
          ]
        }.flatten
      end

      flush
    end
  end
end
