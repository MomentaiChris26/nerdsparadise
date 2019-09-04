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
      choice = TTY::Prompt.new.select('Make your selection', 'Title' => 1, 'Genre' => 2, 'Platform' => 3, 'Completion status' => 4)
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

  def self.edit_game_menu(games)
    if games.empty?
      puts 'No games in the database!'.colorize(:red)
    else
      all_games = []
      games.each do |game|
        indvidual_game_data = [game.title]
        all_games << indvidual_game_data
      end
      system 'clear'
      game_to_edit = TTY::Prompt.new.select('Select the game you want edit', all_games)
      games.each_with_index do |game, index|
        next unless game.title == game_to_edit
        choice = Selection.select_form_db
        case choice
        when 1
          puts 'Enter a new title'
          new_title = gets.chomp
          answer = Selection.confirm_changes("Are you sure you want to make this change?")
          if answer == 'Yes'
            games[index].title = new_title
            puts 'the title of your game has been changed!'.colorize(:green)
          elsif answer == 'No'
            puts 'changes have not been saved.'.colorize(:red)
            return
          end
        when 2
          new_genre = Selection.genre_options('select a new genre')
          answer = Selection.confirm_changes("Are you sure you want to make this change?")
          if answer == 'Yes'
            games[index].genre = new_genre
            puts 'the genre of your game has been changed!'.colorize(:green)
          elsif answer == 'No'
            puts 'changes have not been saved.'.colorize(:red)
            return
          end
        when 3
          new_platform = Selection.console_options('Select a new platform')
          answer = Selection.confirm_changes("Are you sure you want to make this change?")
          if answer == 'Yes'
            games[index].platform = new_platform
            puts 'the platform of your game has been changed!'.colorize(:green)
          elsif answer == 'No'
            puts 'changes have not been saved.'.colorize(:red)
            return
          end
        when 4
          system 'clear'
          answer = Selection.toggle_completion(games[index].status)
          games[index].status = answer
        end
      end
    end
  end

  def self.delete_game(games)
    system 'clear'
    if games.empty?
      puts 'No games in the database!'.colorize(:red)
    else
      all_games = []
      games.each do |game|
        indvidual_game_data = [game.title]
        all_games << indvidual_game_data
      end
      game_to_delete = TTY::Prompt.new.select('Select the game you want delete', all_games)
      games.each_with_index do |game, index|
        next unless game.title == game_to_delete
          answer = Selection.confirm_changes("Are you sure you want to delete this game?".colorize(:yellow))
          case answer
          when "Yes"
            games.delete_at(games.index games[index])
            puts "Game successfully deleted!".colorize(:green)
          when "No"
            puts "No changes have been made!".colorize(:green)
          end
      end
    end
    end

    def self.select_random(games)
      Selection.random_selection(games)
    end

end
