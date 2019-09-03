require_relative 'module.rb'
require_relative 'class.rb'
prompt = TTY::Prompt.new
font = TTY::Font.new(:doom)

puts font.write("NERDS PARADISE")

stored_games = []

choice = 0
loop do
    choices = {'Add game' => 1,'Search games' => 2,'Edit game' => 3,'Delete game' => 4,'Quit application' => 5}
    choice = prompt.select('Make your selection',choices)
    case choice
    when 1 then Selection.add_new_game(stored_games)
    when 2 then Selection.search_games(stored_games)
    when 3 then puts "placeholder"
    when 4 then puts "placeholder"
    when 5 then abort
    end
end

