class Vote < ActiveRecord::Base

	belongs_to :user
	belongs_to :festival

	validates_uniqueness_of :artist, :scope => [:user_id, :youtube_link]
	validates_presence_of :artist, :user_id

	attr_accessor :song

	accepts_nested_attributes_for :user
end
