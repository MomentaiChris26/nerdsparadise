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
arr_header = []
arr_data = []

begin
  DATA_FILE = 'game_database/saved_data.csv'
  File.open(DATA_FILE, 'r').each_with_index do |data, index|
    if index == 0
      arr_header << data
    else
      arr_data << data
    end
  end
rescue StandardError => e
  p 'There is no file called saved_data. Please ensure the file exist'
end

arr_data.each do |data|
  split_data = data.split(/[,\n]+/)
  status = split_data[3] == 'true'
  stored_games << Database.new(split_data[0], split_data[1], split_data[2], status)
end

def main_menu(prompt, stored_games, menu)
  loop do
    choice = prompt.select('Make your selection'.colorize(:light_blue), menu)
    case choice
    when 1 then Database.select_random(stored_games)
    when 2 then Selection.add_game(stored_games)
    when 3 then Selection.search_games(stored_games)
    when 4 then Database.edit_game_menu(stored_games)
    when 5 then Database.delete_game(stored_games)
    when 6 then Exit_and_store.exit_and_store(stored_games)
    end
  end
end

main_menu(prompt, stored_games, choices)
