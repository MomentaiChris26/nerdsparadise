# frozen_string_literal: true

require_relative 'module.rb'

# Contains the methods that will allow the creation of instances and storage into array.
class Database
  include Selection
  attr_accessor :title, :genre, :status, :platform

  def initialize(title, genre, platform, status)
    @title = title
    @genre = genre
    @platform = platform
    @status = status
  end

  def self.display_all_games(game_array)
    if game_array.empty?
      puts 'No games in database!'.colorize(:red)
    else
      all_games = []
      game_array.each do |game|
        status = game.status == true ? 'YES' : 'NO'
        indvidual_game_data = [game.title, game.genre, game.platform, status]
        all_games << indvidual_game_data
      end
      system 'clear'
      Selection.all_games_box(all_games)
    end
  end
  def self.edit_search_title(games)
    puts "Which game would you like to edit?"
    searched = gets.chomp
    games.each do |game|
            if game.title == searched
                edit_game(games)
                return 
            end
        end
        puts "game not found!".colorize(:red)
  end

  def self.search_by(games)
    no_games(games)
        puts "what game are you looking for?"
        searched = gets.chomp
        games.each do |game|
                if game.title == searched
                    edit_game(games)
                    return 
                end
            end
            puts "game not found!".colorize(:red)
    end

  def self.edit_game(games)
    puts "test"
    end
end
