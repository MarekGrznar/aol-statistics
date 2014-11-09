require 'spec_helper'

describe Dbpedia::Parser do
  describe '.parse' do
    it 'parses categories' do
      categories = Dbpedia::Parser.parse(fixture('dbpedia/categories.txt').read)

      expect(categories.size).to eql(9)
      expect(categories).to eql(["Futurama", "World War II", "Programming languages", "Professional wrestling", "Algebra", "Anime", "Abstract algebra", "Mathematics", "Linear algebra"])
    end
  end
end
