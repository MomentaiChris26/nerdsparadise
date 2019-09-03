require 'terminal-table'
require 'colorize'

array_data = [["halo",["Not Completed","completed"],"Not completed"]]

table = Terminal::Table.new do |t|
    array_data.each_with_index do |item,index|
        if item.kind_of?(Array)
            item.each do |i|
                t << i
            end
        else
        t << [item][index]
        end
    end
    # t.style = {:all_separators => true}
  end

  puts table