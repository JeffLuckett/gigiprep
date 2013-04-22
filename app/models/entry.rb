class Entry < ActiveRecord::Base
  attr_accessible :term, :definition, :translation
  require 'csv'
  def self.seed
  	CSV.foreach(File.join(Rails.root, 'db/seeds/LegalGlossary.csv')) do | row |
  		Entry.where(:term=>row[0]).first_or_create(
  				:definition=>row[1],
  				:translation=>row[2]
  			)
  	end
  end
end
