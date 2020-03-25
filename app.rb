require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
set :database, { adapter: "sqlite3", database: "mydb.db" }

require './models/user'
require './models/team'

get "/" do
    @users = User.all
    erb :user_list
end    

get "/teams" do
    @teams = Team.all
    erb :team_list
end 
get "/user" do
    erb :user
end

get "/team" do
    erb :team
end


post "/find" do
    @user = User.find_by(name: params[:name])
    if @user.nil?
        'That Player was not found. Try again <a href="/find">here</a>!'
    end
    erb :user_info
end


post "/search" do
    @team = Team.find_by(name: params[:name])
    @players = @team.users
    if @team.nil?
        'That Team does not exist.'
    end    
    erb :team_info
end