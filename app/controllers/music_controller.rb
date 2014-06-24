class MusicController < ApplicationController
  def index
    @votes = Vote.all.group( :artist ).order('count_all desc').count.keys
  end
  
end
