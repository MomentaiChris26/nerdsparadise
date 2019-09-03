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
        status = game.status == true ? 'YES'.colorize(:green) : 'NO'.colorize(:red)
        indvidual_game_data = [game.title, game.genre, game.platform, status]
        all_games << indvidual_game_data
      end
      system 'clear'
      Selection.searched_result(all_games)
    end
  end
  def self.edit_title(games)
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
    if games.empty?
      puts "There are no games in your database".colorize(:red)
      return
    else
      puts "what attribute of the data would you like to search for?"
      prompt = TTY::Prompt.new
      choices = { 'Title' => 1, 'Genre' => 2, 'Platform' => 3, 'Completion status' => 4 }
      choice = prompt.select('Make your selection', choices)
      all_games = []
      case choice
      when 1
        puts "what game are you looking for?"
        searched = gets.chomp
      when 2
        choices_genre = %w[Action Adventure Beat-em-up Fighting Shooter Simulator Strategy Role-playing Others]
        searched = prompt.select('Select a genre?', choices_genre)
      when 3
        choices_platform = %w[Xbox PlayStation Switch PC]
        searched = prompt.select('Select a platform?', choices_platform)
      when 4
        searched = prompt.select('Search by Completion Status') do |menu|
          menu.choice 'Completed', true
          menu.choice 'Not completed', false
        end
      end
      games.each do |game|
                case choice
                when 1
                  if game.title == searched
                    Selection.search_store(game,all_games)
                    return Selection.searched_result(all_games)
                  end
                when 2
                  if game.genre == searched
                    Selection.search_store(game,all_games)
                  end
                when 3
                  if game.platform == searched
                    Selection.search_store(game,all_games)
                  end
                when 4
                  if game.status == searched
                    Selection.search_store(game,all_games)
                  end
                end
            end
            if all_games.empty?
              puts "No results found!".colorize(:red)
            else
            Selection.searched_result(all_games)
            end
    end
  end

  def self.edit_game(game)
    puts game
    end
end
