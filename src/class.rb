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
  end

  def self.store_to_file(games, stored_array)
    games.each do |game|
      stored_array << "#{game.title},#{game.genre},#{game.platform},#{game.status}"
    end
  end

  def self.display_all_games(game_array)
    if game_array.empty?
      Ancillaries.no_game
    else
      all_games = []
      game_array.each do |game|
        Selection.search_store(game, all_games)
      end
      system 'clear'
      Selection.searched_result(all_games)
    end
  end

  def self.search_by(games)
    if games.empty?
      Ancillaries.no_game
      nil
    else
      system 'clear'
      puts 'what attribute of the data would you like to search for?'
      choice = Ancillaries.prompt.select('Make your selection', Ancillaries.number_menu)
      all_games = []
      searched = SearchFeature.search_by_attribute(games, choice)
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
