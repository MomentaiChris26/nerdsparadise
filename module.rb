# frozen_string_literal: true

require 'tty-prompt'
require 'tty-box'
require 'tty-font'
require 'colorize'
require 'terminal-table'

# Adds methods for the menu selection in the main menu
module Selection
  def self.add_game(games)
    prompt = TTY::Prompt.new
    name = prompt.ask('What is the title of your game?', required: true)
    choices_genre = %w[Action Adventure Beat-em-up Fighting Shooter Simulator Strategy Role-playing Others]
    genre = prompt.select('Select a genre?', choices_genre, required: true, filter: true)
    choices_platform = %w[Xbox PlayStation Switch PC]
    platform = prompt.select('Select a platform?', choices_platform, required: true)
    completed = prompt.select('Have you completed the game?') do |menu|
      menu.choice 'Yes', true
      menu.choice 'No', false
    end
    games << Database.new(name, genre, platform, completed)
    system 'clear'
    puts "#{name} has been added to your database!".colorize(:green)
  end

  def self.search_games(game_array)
    prompt = TTY::Prompt.new
    choices = { 'List all games' => 1, 'Search by attribute' => 2, 'Return to main menu' => 3 }
    choice = prompt.select('Make your selection', choices)
    case choice
    when 1 then Database.display_all_games(game_array)
    when 2 then Database.search_by(game_array)
    when 3 then return
    end
  end

  def self.searched_result(games)
    font = TTY::Font.new(:doom)
    rows = []
    table = Terminal::Table.new rows: rows do |row|
        row.title = font.write('GAMES')
      row.headings = 'Title', 'Genre', 'Platform', 'Completed?'
      games.each do |data|
        row << data
      end
    end
    table.style = { width: 100, padding_left: 3, border_x: '=', border_i: 'x' }
    puts table
  end

  def self.search_store(game,all_games)
    status = game.status == true ? 'YES' : 'NO'
    indvidual_game_data = [game.title, game.genre, game.platform, status]
    all_games << indvidual_game_data
  end
end
