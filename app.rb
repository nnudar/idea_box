require 'sinatra/reloader'
require './idea'


class IdeaBoxApp < Sinatra::Base
	configure :development do
		register Sinatra::Reloader
	end 

  get '/' do
    erb :index, locals: {ideas: Idea.all}
  end

  not_found do
    erb :error
  end

  post '/' do
  	idea = Idea.new(params['idea_title'], params['idea_description'])
	idea.save
   	redirect '/'
  end
end

class Idea
  def self.all
    raw_ideas.map do |data|
      Idea.new(data[:title], data[:description])
    end
  end

  def self.raw_ideas
      database.transaction do |db|
        db['ideas']
      end
  end

  def self.database
    @database ||= YAML::Store.new('ideabox')
  end


  def database
    Idea.database
  end
end