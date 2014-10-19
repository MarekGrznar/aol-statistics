module Aol
  class Results
    attr_accessor :response

    def initialize(response)
      @response = response
    end

    def facets
      @facets ||= @response['facets'].inject(Hash.new) do |facets, (name, facet)|
        facets[name.to_sym] = facet['terms'].inject(Hash.new) do |hash, value|
          hash[value['term']] = value['count']

          hash
        end

        facets
      end
    end
  end
end
