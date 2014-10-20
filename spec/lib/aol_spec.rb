require 'spec_helper'

describe Aol do
  describe '.statistics' do
    it 'returns statistics for imported data' do
      path = File.dirname(fixture('aol/sample.txt').path)

      Aol.import_from_directory(path)

      facets = Aol.statistics.facets

      expect(facets.keys.sort).to eql([:domain, :lowercase].sort)

      expect(facets[:domain]).to eql(
        {
          "broadwayrag"=>3,
          "staplem"=>2,
          "p"=>2,
          "newyorklawyersitem"=>2,
          "lottery"=>2,
          "dfdf"=>2,
          "ad2d"=>2,
          "530"=>2,
          "207"=>2,
          "whitepagesm"=>1,
          "westchesterv"=>1,
          "verag"=>1,
          "vaniqamh"=>1,
          "unitedm"=>1,
          "ucsxm"=>1,
          "susheme"=>1,
          "spacemhttp"=>1,
          "rentdirectm"=>1,
          "release"=>1,
          "rapnym"=>1,
          "prescriptionfortimem"=>1,
          "mizunom"=>1,
          "merit"=>1,
          "loislawm"=>1,
          "frankmellacem"=>1,
          "elaorg"=>1,
          "collegeuclau"=>1,
          "bonsaiffg"=>1,
          "attornylesliem"=>1,
          "ameriprisem" => 1,
          "appearance" => 1
        }
      )

      expect(facets[:lowercase]).to eql(
        {
          "broadway.vera.org"=>3,
          "www.newyorklawyersite.com"=>2,
          "staple.com"=>2,
          "p"=>2,
          "lottery"=>2,
          "dfdf"=>2,
          "ad2d"=>2,
          "530"=>2,
          "207"=>2,
          "www.prescriptionfortime.com"=>1,
          "www.elaorg"=>1,
          "www.collegeucla.edu"=>1,
          "www.bonsai.wbff.org"=>1,
          "whitepages.com"=>1,
          "westchester.gov"=>1,
          "vera.org"=>1,
          "vaniqa.comh"=>1,
          "united.com"=>1,
          "ucs.ljx.com"=>1,
          "susheme"=>1,
          "space.comhttp"=>1,
          "rentdirect.com"=>1,
          "release"=>1,
          "rapny.com"=>1,
          "mizuno.com"=>1,
          "merit"=>1,
          "loislaw.com"=>1,
          "frankmellace.com"=>1,
          "attornyleslie.com"=>1,
          "ameriprise.com" => 1,
          "appearance" => 1
        }
      )
    end
  end
end
