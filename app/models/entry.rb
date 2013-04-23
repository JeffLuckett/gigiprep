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

  def self.get_random_n(n = 1, exclude = nil)
  	(
  		exclude.blank? ? Entry : Entry.where('id not in( :ids )', {:ids=>exclude})
  	).order('Random()').limit(n);
  end
end
