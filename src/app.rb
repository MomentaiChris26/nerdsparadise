# frozen_string_literal: true

require_relative 'module.rb'
require_relative 'class.rb'

system 'clear'

stored_games = []
DATA = 'saved_data.csv'
OpenSavedData.application_open(stored_games, DATA)

if ARGV[0] == 'display'
  Database.display_all_games(stored_games)
  ExitAndStore.argv_exit(stored_games)
elsif ARGV[0] == 'add'
  _first_arg, *the_rest = ARGV
  game_to_be_added = the_rest.join(' ')
  Selection.argv_add(stored_games, game_to_be_added)
  ExitAndStore.argv_exit(stored_games)
end

puts TTY::Font.new(:doom).write("NERD'S PARADISE")

choices = { 'Select a game to play' => 1,
            'Add game' => 2,
            'Search games' => 3,
            'Edit game' => 4,
            'Delete game' => 5,
            'Quit application' => 6 }

def main_menu(stored_games, menu)
  loop do
    case Ancillaries.prompt.select('Make your selection', menu)
    when 1 then Selection.random_selection(stored_games)
    when 2 then Selection.add_game(stored_games)
    when 3 then Selection.search_games(stored_games)
    when 4 then Selection.edit_game_menu(stored_games)
    when 5 then Selection.delete_game(stored_games)
    when 6 then ExitAndStore.exit_and_store(stored_games)
    end
  end
end

main_menu(stored_games, choices)
