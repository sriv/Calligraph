module Calligraph
	class ActionContent < ActiveRecord::Base
		validates_presence_of :controller, :action
		has_many :content, as: :content_template
	end
end