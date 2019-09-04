# frozen_string_literal: true

require 'tty-prompt'
require 'tty-box'
require 'tty-font'
require 'colorize'
require 'terminal-table'
require 'tty-spinner'

# Adds methods for the menu selection in the main menu
module Selection
  def self.add_game(games)
    system 'clear'
    name = Ancillaries.prompt.ask('What is the title of your game?', required: true)
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
    choice = Ancillaries.prompt.select('Make your selection', choices)
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
    status = game.status == true ? 'YES'.colorize(:green) : 'NO'.colorize(:red)
    indvidual_game_data = [game.title, game.genre, game.platform, status]
    all_games << indvidual_game_data
  end

  def self.genre_options(text)
    Ancillaries.prompt.select(text, %w[Action Adventure Beat-em-up Fighting Shooter Simulator Strategy Role-playing Others], required: true, filter: true)
  end

  def self.console_options(text)
    Ancillaries.prompt.select(text, %w[Xbox PlayStation Switch PC], required: true)
  end

  def self.completed_menu
    Ancillaries.prompt.select('Search by Completion Status') do |menu|
      menu.choice 'Completed', true
      menu.choice 'Not completed', false
    end
  end

  def self.toggle_completion(toggle_status)
    if toggle_status == true
      answer = Ancillaries.prompt.select('Change game to incomplete?'.colorize(:yellow), %w[Yes No])
      if answer == 'Yes'
        puts 'Your changes have been saved!'.colorize(:green)
        return false
      elsif answer == 'No'
        puts 'No changes have been made'.colorize(:yellow)
        return
      end
    else
      answer = Ancillaries.prompt.select('Change game to completed?'.colorize(:yellow), %w[Yes No])
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
                         'Completion Status' => 4,
                         'Return to main menu' => 5 }
    Ancillaries.prompt.select('which attribute would you like to edit?', editable_choices)
  end

  def self.confirm_changes(text)
    Ancillaries.prompt.select(text, %w[Yes No])
  end

  def self.random_selection(games)
    system 'clear'
    Ancillaries.spinner('Looking for a game to play', 'Done!')
    if games.empty?
      system 'clear'
      puts '------------------------------------------------------------'.colorize(:red)
      puts 'No games in the database!'.colorize(:red)
      puts '------------------------------------------------------------'.colorize(:red)
      return
    else
      all_games = []
      games.each do |game|
        if game.status == true
          next
        else
          status = game.status == true ? 'YES' : 'NO'
          indvidual_game_data = game.title
          all_games << indvidual_game_data
          system 'clear'
          puts ''
          puts '------------------------------------------------------------'.colorize(:magenta)
          puts 'THE GAME YOU SHOULD PLAY IS '.colorize(:green) + all_games.sample.upcase.colorize(:red).to_s
          puts '------------------------------------------------------------'.colorize(:magenta)
          puts ''
        end
      end

    end
    puts 'All games completed!'.colorize(:green)
  end

  def self.edit_game_menu(games)
    system 'clear'
    if games.empty?
      Ancillaries.no_game
    else
      all_games = []
      games.each do |game|
        indvidual_game_data = [game.title]
        all_games << indvidual_game_data
      end
      system 'clear'
      game_to_edit = Ancillaries.prompt.select('Select the game you want edit', all_games)
      games.each_with_index do |game, index|
        next unless game.title == game_to_edit

        choice = Selection.select_form_db
        case choice
        when 1
          puts 'Enter a new title'
          new_title = gets.chomp
          answer = Selection.confirm_changes('Are you sure you want to make this change?')
          if answer == 'Yes'
            games[index].title = new_title
            puts 'the title of your game has been changed!'.colorize(:green)
          elsif answer == 'No'
            puts 'changes have not been saved.'.colorize(:red)
            return
          end
        when 2
          new_genre = Selection.genre_options('select a new genre')
          answer = Selection.confirm_changes('Are you sure you want to make this change?')
          if answer == 'Yes'
            games[index].genre = new_genre
            puts 'the genre of your game has been changed!'.colorize(:green)
          elsif answer == 'No'
            puts 'changes have not been saved.'.colorize(:red)
            return
          end
        when 3
          new_platform = Selection.console_options('Select a new platform')
          answer = Selection.confirm_changes('Are you sure you want to make this change?')
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
        when 5
          return
        end
      end
    end
  end

  def self.delete_game(games)
    system 'clear'
    if games.empty?
      Ancillaries.no_game
    else
      all_games = []
      games.each do |game|
        indvidual_game_data = [game.title]
        all_games << indvidual_game_data
      end
      game_to_delete = Ancillaries.prompt.select('Select the game you want delete', all_games)
      games.each_with_index do |game, index|
        next unless game.title == game_to_delete

        answer = Selection.confirm_changes('Are you sure you want to delete this game?'.colorize(:yellow))
        case answer
        when 'Yes'
          games.delete_at(games.index(games[index]))
          Ancillaries.spinner('Deleting game from database', 'Deleted!')
          puts 'Game successfully deleted!'.colorize(:green)
        when 'No'
          puts 'No changes have been made!'.colorize(:green)
        end
      end
    end
    end

  def self.argv_delete(games, argv_data)
    if games.empty?
      Ancillaries.no_game
    else
      all_games = []
      games.each do |game|
        indvidual_game_data = [game.title]
        all_games << indvidual_game_data
      end

      game_to_delete = argv_data.to_s
      games.each_with_index do |game, index|
        if game.title.downcase == game_to_delete
          answer = Selection.confirm_changes('Are you sure you want to delete this game?'.colorize(:yellow))
          case answer
          when 'Yes'
            games.delete_at(games.index(games[index]))
            Ancillaries.spinner('Deleting game from database', 'Deleted!')
            puts 'Game successfully deleted!'.colorize(:green)
          when 'No'
            puts 'No changes have been made!'.colorize(:green)
          end
        else
          puts '------------------------------------------------------------'.colorize(:red)
          puts 'game not found'.colorize(:red)
          puts '------------------------------------------------------------'.colorize(:red)
        end
      end
    end
  end
end

module Search_feature

  def self.search_by_attribute(games,choice)
    case choice
    when 1
      puts 'what game are you looking for?'
      searched = gets.chomp.downcase
    when 2 then searched = Selection.genre_options('Select a genre')
    when 3 then searched = Selection.console_options('Select a platform')
    when 4 then searched = Selection.completed_menu
    end
  end
end


module Ancillaries
  def self.no_game
    puts '------------------------------------------------------------'.colorize(:red)
    puts 'No games in the database!'.colorize(:red)
    puts '------------------------------------------------------------'.colorize(:red)
  end

  def self.prompt
    TTY::Prompt.new
  end

  def self.number_menu
    { 'Title' => 1,
      'Genre' => 2,
      'Platform' => 3,
      'Completion status' => 4 }
  end

  def self.spinner(text, stop_text)
    spinner = TTY::Spinner.new("[:spinner] #{text}.......", format: :bouncing_ball)
    spinner.auto_spin # Automatic animation with default interval
    sleep(1.5) # Perform task
    spinner.stop(stop_text) # Stop animation
  end
end

module Open_saved_data
  def self.application_open(game_array, data_file)
    arr_header = []
    arr_data = []
    begin
      File.open(data_file, 'r').each_with_index do |data, index|
        if index == 0
          arr_header << data
        else
          arr_data << data
        end
      end
    rescue StandardError => e
      p 'There is no file called saved_data. Please ensure the file exist'
      p "error code #{e}"
    end

    arr_data.each do |data|
      split = data.split(/[,\n]+/)
      status = split[3] == 'true'
      game_array << Database.new(split[0], split[1], split[2], status)
    end
  end
end

module Exit_and_store
  def self.exit_and_store(games)
    stored_array = []
    Database.store_to_file(games, stored_array)
    File.open(DATA, 'w') do |line|
      stored_array.each_with_index do |data, index|
        line << "Title,Genre,Platform,Status \n" if index == 0
        line << data + "\n"
      end
    end
    Ancillaries.spinner('Saving Data', 'Saved!')
    system 'clear'
    puts '------------------------------------------------------------'.colorize(:magenta)
    puts "All data has been saved! \nGoodbye!".colorize(:cyan)
    puts '------------------------------------------------------------'.colorize(:magenta)
    abort
  end

  def self.argv_exit(games)
    stored_array = []
    Database.store_to_file(games, stored_array)
    File.open(DATA, 'w') do |line|
      stored_array.each_with_index do |data, index|
        line << "Title,Genre,Platform,Status \n" if index.zero?
        line << data + "\n"
      end
    end
    abort
  end
end
