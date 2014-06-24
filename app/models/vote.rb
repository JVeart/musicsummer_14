class Vote < ActiveRecord::Base
	
	belongs_to :user
	belongs_to :festival
	
	attr_accessor :song
	
	accepts_nested_attributes_for :user
end
