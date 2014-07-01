class Vote < ActiveRecord::Base
	
	belongs_to :user
	belongs_to :festival
	
	validates_uniqueness_of :artist, :scope => :user_id
	validates_presence_of :festival_id, :artist, :user_id
	
	attr_accessor :song
	
	accepts_nested_attributes_for :user
end
