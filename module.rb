# frozen_string_literal: true

require 'tty-prompt'
require 'tty-box'
require 'tty-font'
require 'colorize'
require 'terminal-table'

# Adds methods for the menu selection in the main menu
module Selection
  def self.prompt
    TTY::Prompt.new
  end

  def self.add_game(games)
    name = prompt.ask('What is the title of your game?', required: true)
    genre = genre_options('Select a genre')
    platform = console_options('Select a platform')
    completed = completed_menu
    games << Database.new(name, genre, platform, completed)
    system 'clear'
    puts "#{name} has been added to your database!".colorize(:green)
  end

  def self.search_games(game_array)
    choices = { 'List all games' => 1,
                'Search by attribute' => 2,
                'Return to main menu' => 3 }
    choice = prompt.select('Make your selection', choices)
    case choice
    when 1 then Database.display_all_games(game_array)
    when 2 then Database.search_by(game_array)
    when 3 then return
    end
  end

  def self.searched_result(games)
    rows = []
    table = Terminal::Table.new rows: rows do |row|
      row.title = TTY::Font.new(:doom).write('GAMES')
      row.headings = 'Title', 'Genre', 'Platform', 'Completed?'
      games.each do |data|
        row << data
      end
    end
    table.style = { width: 100, padding_left: 3, border_x: '=', border_i: 'x' }
    puts table
  end

  def self.search_store(game, all_games)
    status = game.status == true ? 'YES' : 'NO'
    indvidual_game_data = [game.title, game.genre, game.platform, status]
    all_games << indvidual_game_data
  end

  def self.genre_options(text)
    prompt.select(text, %w[Action Adventure Beat-em-up Fighting Shooter Simulator Strategy Role-playing Others], required: true, filter: true)
  end

  def self.console_options(text)
    prompt.select(text, %w[Xbox PlayStation Switch PC], required: true)
  end

  def self.completed_menu
    prompt.select('Search by Completion Status') do |menu|
      menu.choice 'Completed', true
      menu.choice 'Not completed', false
    end
  end

  def self.toggle_completion(toggle_status)
    if toggle_status == true
      answer = prompt.select('Change game to incomplete?'.colorize(:yellow), %w[Yes No])
      if answer == 'Yes'
        puts 'Your changes have been saved!'.colorize(:green)
        return false
      elsif answer == 'No'
        puts 'No changes have been made'.colorize(:yellow)
        return
      end
    else
      answer = prompt.select('Change game to completed?'.colorize(:yellow), %w[Yes No])
      if answer == 'Yes'
        puts 'Your changes have been saved!'.colorize(:green)
        return true
      elsif answer == 'No'
        puts 'No changes have been made'.colorize(:yellow)
        return
      end
    end
  end

  def self.select_form_db
    editable_choices = { 'Title' => 1,
                         'Genre' => 2,
                         'Platform' => 3,
                         'Completion Status' => 4 }
    TTY::Prompt.new.select('which attribute would you like to edit?', editable_choices)
  end

  def self.confirm_changes(text)
    TTY::Prompt.new.select(text, %w[Yes No])
  end
end
