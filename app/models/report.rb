class Report < ActiveRecord::Base
		
	belongs_to :user
	
	scope :confirmed, lambda{ where( :confirmed => true) }
	accepts_nested_attributes_for :user
	
end
