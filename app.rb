# frozen_string_literal: true

require_relative 'module.rb'
require_relative 'class.rb'

prompt = TTY::Prompt.new

puts TTY::Font.new(:doom).write("NERD'S PARADISE")

choices = { 'Add game' => 1,
            'Search games' => 2,
            'Edit game' => 3,
            'Delete game' => 4,
            'Quit application' => 5 }

stored_games = []

def main_menu(prompt, stored_games, menu)
  loop do
    choice = prompt.select('Make your selection'.colorize(:light_blue), menu)
    case choice
    when 1 then Selection.add_game(stored_games)
    when 2 then Selection.search_games(stored_games)
    when 3 then Database.edit_game_menu(stored_games)
    when 4 then Database.delete_game(stored_games)
    when 5 then abort
    end
  end
end

main_menu(prompt, stored_games, choices)
