require_relative 'modules.rb'
require_relative 'class.rb'
require 'tty-prompt'
require 'tty-box'
prompt = TTY::Prompt.new

games = []

choice = 0
loop do
choices = {'Add game' => 1,'Search games' => 2,'search game' => 3,'Edit games' => 4,'Quit application' => 5}
choice = prompt.select('Make your selection',choices)
p choice
case choice
when 1 then Selection.add_new_game(prompt,games)
when 2 then Database.display_games(games)
when 3 then puts "placeholder"
when 4 then puts "placeholder"
when 5 then abort
end
end