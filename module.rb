require 'tty-prompt'
require 'tty-box'
require 'tty-font'
require 'colorize'
require 'terminal-table'



# Adds methods for the menu selection in the main menu
module Selection
    def self.add_new_game(game_array)
        prompt = TTY::Prompt.new
        name = prompt.ask("What is the title of your game?",required: true)
        choices_genre = %w(Action Adventure Beat-em-up Fighting Shooter Simulator Strategy Role-playing Others) 
        genre = prompt.select('Select a genre?', choices_genre, required: true, filter: true)
        choices_platform = %w(Xbox PlayStation Switch PC)
        platform = prompt.select('Select a platform?', choices_platform, required: true)
        completed = prompt.select('Have you completed the game?') do |menu|
            menu.choice 'Yes', true
            menu.choice 'No', false
        end
        game_array << Database.new(name,genre,platform,completed)
        system 'clear'
        puts "#{name} has been added to your database!".colorize(:green)
    end
    
    def self.search_games(game_array)
        prompt = TTY::Prompt.new
        choices = {'List all games' => 1,'Search by name' => 2,'Search by genre' => 3,'Return to main menu' => 4}
        choice = prompt.select('Make your selection',choices)
        case choice
        when 1 then Database.display_all_games(game_array)
        when 2 then puts "test"
        when 3 then puts "test" 
        when 4 then return
        end
    end

    def self.box_it(all_games_array) 
        font = TTY::Font.new(:doom)
        rows = []
        table = Terminal::Table.new :rows => rows  do |t|
            t.title = font.write('ALL GAMES')
            t.headings = "Title",'Genre','Platform','Completed?'
            all_games_array.each do |data|
                t << data
            end
        end
        
        table.style = {:width => 100, :padding_left => 3, :border_x => "=", :border_i => "x"}

        puts table
    end

end