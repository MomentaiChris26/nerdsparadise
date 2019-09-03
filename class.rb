require_relative 'module.rb'


# Contains the methods that will allow the creation of instances and storage into array.
class Database
    include Selection
    attr_accessor :title, :genre, :status, :platform

    def initialize(title,genre,platform,status)
        @title = title
        @genre = genre
        @platform = platform
        @status = status
        @completion_date

    end

    def self.display_all_games(game_array)
        if game_array.empty?
            puts "No games in database!".colorize(:red)
        else
            all_games = []
            game_array.each do |game|
                if game.status == true
                    status = "YES"
                else
                    status = "NO"
                end
                indvidual_game_data = [game.title,game.genre,game.platform,status]
                all_games << indvidual_game_data
            end
            system 'clear'
            Selection.box_it(all_games)
            
        end
    end

end