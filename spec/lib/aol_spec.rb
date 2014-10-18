require 'spec_helper'

describe Aol do
  describe '.statistics' do
    it 'returns statistics for imported data' do
      path = File.dirname(fixture('aol/sample.txt').path)

      Aol.import_from_directory(path)

      facets = Aol.statistics.facets

      expect(facets.keys.sort).to eql(['domain', 'lowercase'].sort)
    end
  end
end
