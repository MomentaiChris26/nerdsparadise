# frozen_string_literal: true

require_relative 'module.rb'
require_relative 'class.rb'

system 'clear'
prompt = TTY::Prompt.new

puts TTY::Font.new(:doom).write("NERD'S PARADISE")

choices = { 'Select game to play' => 1,
            'Add game' => 2,
            'Search games' => 3,
            'Edit game' => 4,
            'Delete game' => 5,
            'Quit application' => 6 }

stored_games = []
DATA = 'game_database/saved_data.csv'
Open_saved_data.application_open(stored_games, DATA)

def main_menu(stored_games, menu)
  loop do
    case Selection.prompt.select('Make your selection'.colorize(:light_blue), menu)
    when 1 then Selection.random_selection(stored_games)
    when 2 then Selection.add_game(stored_games)
    when 3 then Selection.search_games(stored_games)
    when 4 then Selection.edit_game_menu(stored_games)
    when 5 then Selection.delete_game(stored_games)
    when 6 then Exit_and_store.exit_and_store(stored_games)
    end
  end
end

main_menu(stored_games, choices)
