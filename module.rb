require 'tty-prompt'
require 'tty-box'
require 'tty-font'



# Adds methods for the menu selection in the main menu
module Selection
    def self.add_new_game(prompt,game_array)
        name = prompt.ask("What is the title of your game?")
        
        choices = %w(Action Adventure Beat-em-up Fighting Shooter Simulator Strategy Role-playing) 
                    
        genre = prompt.multi_select('Select a genre?', choices, filter: true)
        
        choices = %w(Xbox PlayStation Switch PC)
        platform = prompt.multi_select('Select a platform?', choices, filter: true)

        completed = prompt.select('Have you completed the game?') do |menu|
            menu.choice 'Yes', true
            menu.choice 'No', false
        end
    
        game_array << Database.new(name,genre,platform,completed)
        # system 'clear'
        p "#{name} has been added to your database!"
    end

end