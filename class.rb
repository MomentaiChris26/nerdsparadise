# frozen_string_literal: true

require_relative 'module.rb'

# Contains the methods for creation of instances and storage.
class Database
  include Selection
  attr_accessor :title, :genre, :status, :platform

  def initialize(title, genre, platform, status)
    @title = title
    @genre = genre
    @platform = platform
    @status = status
    @completion_date
  end

  def self.store_to_file(games,stored_array)
    games.each do |game|
      stored_array << "#{game.title},#{game.genre},#{game.platform},#{game.status}"
    end
  end

  def self.display_all_games(game_array)
    if game_array.empty?
      puts 'No games in database!'.colorize(:red)
    else
      all_games = []
      game_array.each do |game|
        status = game.status == true ? 'YES'.colorize(:green) : 'NO'.colorize(:red)
        indvidual_game_data = [game.title, game.genre, game.platform, status]
        all_games << indvidual_game_data
      end
      system 'clear'
      Selection.searched_result(all_games)
    end
  end

  def self.search_by(games)
    if games.empty?
      puts 'There are no games in your database'.colorize(:red)
      nil
    else
      system 'clear'
      puts 'what attribute of the data would you like to search for?'
      choice = Selection.prompt.select('Make your selection', 'Title' => 1, 'Genre' => 2, 'Platform' => 3, 'Completion status' => 4)
      all_games = []
      case choice
      when 1
        puts 'what game are you looking for?'
        searched = gets.chomp.downcase
      when 2 then searched = Selection.genre_options('Select a genre')
      when 3 then searched = Selection.console_options('Select a platform')
      when 4 then searched = Selection.completed_menu
      end
      games.each do |game|
        case choice
        when 1
          if game.title.downcase == searched
            Selection.search_store(game, all_games)
            return Selection.searched_result(all_games)
          end
        when 2 then Selection.search_store(game, all_games) if game.genre == searched
        when 3 then Selection.search_store(game, all_games) if game.platform == searched
        when 4 then Selection.search_store(game, all_games) if game.status == searched
        end
      end
      if all_games.empty?
        puts 'No results found!'.colorize(:red)
      else
        Selection.searched_result(all_games)
      end
    end
  end





end
