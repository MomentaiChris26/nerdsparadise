# frozen_string_literal: true

require 'tty-prompt'
require 'tty-font'
require 'colorize'
require 'terminal-table'
require 'tty-spinner'

# Adds methods for the menu selection in the main menu
module Selection
  def self.add_game(games)
    system 'clear'
    name = Ancillaries.prompt.ask('Title of your game?', required: true)
    duplicate = Ancillaries.duplicate_game_search(games, name)
    return if duplicate == 'break'

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
    Ancillaries.prompt.select(text, TextHolder.genre, required: true)
  end

  def self.console_options(text)
    Ancillaries.prompt.select(text, TextHolder.consoles, required: true)
  end

  def self.completed_menu
    Ancillaries.prompt.select('Search by Completion Status') do |menu|
      menu.choice 'Completed', true
      menu.choice 'Not completed', false
    end
  end

  def self.toggle_change_prompt(boolean, answer)
    if answer == 'Yes'
      puts 'Your changes have been saved!'.colorize(:green)
      boolean
    elsif answer == 'No'
      puts 'No changes have been made'.colorize(:yellow)
      nil
    end
  end

  def self.comp_toggle(text)
    "Change game to #{text}?".colorize(:yellow)
  end

  def self.toggle_completion(toggle_status)
    if toggle_status == true
      answer = Ancillaries.prompt.select(comp_toggle('incomplete'), %w[Yes No])
      toggle_change_prompt(false, answer)
    else
      answer = Ancillaries.prompt.select(comp_toggle('completed'), %w[Yes No])
      toggle_change_prompt(true, answer)
    end
  end

  def self.select_form_db
    editable_choices = { 'Title' => 1,
                         'Genre' => 2,
                         'Platform' => 3,
                         'Completion Status' => 4,
                         'Return to main menu' => 5 }
    Ancillaries.prompt.select('attribute to edit?', editable_choices)
  end

  def self.confirm_prompt(text)
    Ancillaries.prompt.select(text, %w[Yes No])
  end

  def self.random_selection(games)
    system 'clear'
    Ancillaries.spinner('Looking for a game to play', 'Done!')
    if games.empty?
      system 'clear'
      puts '----------------------------------------------------'.colorize(:red)
      puts 'No games in the database!'.colorize(:red)
      puts '----------------------------------------------------'.colorize(:red)
      return
    else
      all_games = []
      games.each do |game|
        if game.status == true
          next
        else
          game.status == true ? 'YES' : 'NO'
          indvidual_game_data = game.title
          all_games << indvidual_game_data
          system 'clear'
          puts ''
          puts '--------------------------------------------'.colorize(:magenta)
          puts "THE GAME YOU SHOULD PLAY IS #{all_games.sample.upcase}!".colorize(:green)
          puts '--------------------------------------------'.colorize(:magenta)
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
          answer = Selection.confirm_prompt(TextHolder.make_changes)
          if answer == 'Yes'
            games[index].title = new_title
            TextHolder.changed('Title')
          elsif answer == 'No'
            TextHolder.no_changes
            break
          end
        when 2
          new_genre = Selection.genre_options('select a new genre')
          answer = Selection.confirm_prompt(TextHolder.make_changes)
          if answer == 'Yes'
            games[index].genre = new_genre
            TextHolder.changed('Genre')
          elsif answer == 'No'
            TextHolder.no_changes
            break
          end
        when 3
          new_platform = Selection.console_options('Select a new platform')
          answer = Selection.confirm_prompt(TextHolder.make_changes)
          if answer == 'Yes'
            games[index].platform = new_platform
            TextHolder.changed('Platform')
          elsif answer == 'No'
            TextHolder.no_changes
            break
          end
        when 4
          system 'clear'
          answer = Selection.toggle_completion(games[index].status)
          games[index].status = answer
        when 5
          break
        end
      end
    end
  end

  def self.delete_game(games)
    # system 'clear'
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

        answer = Selection.confirm_prompt(TextHolder.confirm_delete)
        case answer
        when 'Yes'
          games.delete_at(games.index(games[index]))
          Ancillaries.spinner('Deleting game from database', 'Deleted!')
          puts 'Game successfully deleted!'.colorize(:green)
        when 'No'
          TextHolder.no_changes
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
        next unless game.title.downcase == game_to_delete

        answer = Selection.confirm_prompt(TextHolder.confirm_delete)
        case answer
        when 'Yes'
          games.delete_at(games.index(games[index]))
          Ancillaries.spinner('Deleting game from database', 'Deleted!')
          puts 'Game successfully deleted!'.colorize(:green)
          break
        when 'No'
          TextHolder.no_changes
          break
        end
      end
      TextHolder.not_found
    end
  end
end

# Holds callable text items
module TextHolder
  def self.confirm_delete
    'Are you sure you want to delete this game?'.colorize(:yellow)
  end

  def self.consoles
    %w[Xbox PlayStation Switch PC Others]
  end

  def self.make_changes
    'Do you want to make this change?'
  end

  def self.no_changes
    puts 'No changes have been made!'.colorize(:green)
  end

  def self.not_found
    puts '------------------------------------------------'.colorize(:red)
    puts 'game not found'.colorize(:red)
    puts '------------------------------------------------'.colorize(:red)
  end

  def self.genre
    %w[Action Adventure Beat-em-up Fighting Shooter
       Simulator Strategy Role-playing Others]
  end

  def self.changed(text)
    puts "#{text} of your game has been changed!".colorize(:green)
  end
end

# Module to store complex search module code
module SearchFeature
  def self.search_by_attribute(_games, choice)
    case choice
    when 1
      puts 'what game are you looking for?'
      gets.chomp.downcase
    when 2 then Selection.genre_options('Select a genre')
    when 3 then Selection.console_options('Select a platform')
    when 4 then Selection.completed_menu
    end
  end
end

# Holds methods that isn't specific to a module or class
module Ancillaries
  def self.no_game
    puts '------------------------------------------------------'.colorize(:red)
    puts 'No games in the database!'.colorize(:red)
    puts '------------------------------------------------------'.colorize(:red)
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
    spinner = TTY::Spinner.new("[:spinner] #{text}....", format: :bouncing_ball)
    spinner.auto_spin # Automatic animation with default interval
    sleep(1.5) # Perform task
    spinner.stop(stop_text) # Stop animation
  end

  def self.duplicate_game_search(games, title)
    games.each do |game|
      if game.title.downcase == title.downcase
        puts 'Game already exist!'.colorize(:yellow)
        return 'break'
      end
    end
  end
end

# Retrieves the saved data from csv file containing user's data
module OpenSavedData
  def self.application_open(game_array, data_file)
    arr_data = []
    begin
      File.open(data_file, 'r').each_with_index do |data, index|
        index.zero? ? next : arr_data << data
      end
    rescue StandardError => e
      p "There is no file called saved_data. Please ensure the file exist #{e}"
    end
    store_instance(game_array, arr_data)
  end

  def self.store_instance(game_array, arr_data)
    arr_data.each do |data|
      split = data.split(/[,\n]+/)
      status = split[3] == 'true'
      game_array << Database.new(split[0], split[1], split[2], status)
    end
  end
end

# Stores the data into a csv and exits the program
module ExitAndStore
  def self.store_data(database)
    File.open(DATA, 'w') do |line|
      database.each_with_index do |data, index|
        line << "Title,Genre,Platform,Status \n" if index.zero?
        line << data + "\n"
      end
    end
  end

  def self.exit_and_store(games)
    stored_array = []
    Database.store_to_file(games, stored_array)
    store_data(stored_array)
    Ancillaries.spinner('Saving Data', 'Saved!')
    system 'clear'
    puts '--------------------------------------------------'.colorize(:magenta)
    puts "All data has been saved! \nGoodbye!".colorize(:cyan)
    puts '--------------------------------------------------'.colorize(:magenta)
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
