class Festival < ActiveRecord::Base
	
	default_scope { order("start_date ASC, end_date ASC") }
	
	has_many :votes

end
