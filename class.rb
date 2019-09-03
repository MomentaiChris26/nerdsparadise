
# Contains the methods that will allow the creation of instances and storage into array.
class Database
    attr_accessor :title, :genre, :status
    def initialize(title,genre,platform,status)
        @title = title
        @genre = genre
        @platform = platform
        @status = status

    end

    def self.display_games(game_array)
        game_array.each do |game|
            p game.title
            p game.genre
            p game.status
        end
    end

end