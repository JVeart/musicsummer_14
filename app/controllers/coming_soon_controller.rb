class ComingSoonController < ApplicationController
  def index
    @festivals = Festival.all
    
    @upcoming = {}
    @past = {}
    @festivals.each do |festival|
      month = festival.start_date.month < 6 ? 6 : festival.start_date.month
      
      if festival.end_date > Date.today
        unless @upcoming.has_key?(month)
          @upcoming[month] = []
        end
        @upcoming[month].push(festival)
      else
        unless @past.has_key?(month)
          @past[month] = []
        end
        @past[month].push(festival)
      end
      
    end
  end
end
