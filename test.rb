require_relative 'module'
require_relative 'class'


# Dummy test database/array.
test_stored_games_array = []


# Testing the ability to add a game into the database.

# Calls the method from the module.rb file
Selection.add_game(test_stored_games_array)

def test_add_game(array_test)
    if array_test.length == 1
        # this should push an item into the array if it works correctly.
        puts "Test has passed".colorize(:green)
    else
        puts "Test has failed".colorize(:red)
    end
end

test_add_game(test_stored_games_array)

# Testing if the method will delete the game from the array.

# Calls the method from the module.rb file
Selection.delete_game(test_stored_games_array)


def test_delete_game(array_test)
    if array_test.length == 0
        # This should remove the data from the array.
        puts "Test has passed".colorize(:green)
    else
        puts "Test has failed".colorize(:red)
    end
end

test_delete_game(test_stored_games_array)




