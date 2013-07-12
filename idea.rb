require 'yaml/store'

class Idea
	attr_reader :title, :description

	def save
		database.transaction do
    		database['ideas'] ||= []
    		database['ideas'] << {title: title, description: description}
  		end
	end

	def initialize(title, description)
		 @title = title
   		 @description = description
	end 

	def database
		@database ||= YAML::Store.new "ideabox"
	end 

end