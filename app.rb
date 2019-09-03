# frozen_string_literal: true

require_relative 'module.rb'
require_relative 'class.rb'
prompt = TTY::Prompt.new
font = TTY::Font.new(:doom)

puts font.write("NERD'S PARADISE")

stored_games = []

choice = 0
def main_menu(prompt,stored_games)
    loop do
    choices = { 'Add game' => 1,
                'Search games' => 2,
                'Edit game' => 3,
                'Delete game' => 4,
                'Quit application' => 5 }
    choice = prompt.select('Make your selection', choices)
    case choice
    when 1 then Selection.add_game(stored_games)
    when 2 then Selection.search_games(stored_games)
    when 3 then Database.edit_search_title(stored_games)
    when 4 then puts 'placeholder'
    when 5 then abort
    end
    end
end

main_menu(prompt,stored_games)
