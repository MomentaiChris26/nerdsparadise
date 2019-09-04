class Test
    attr_accessor :name, :state
    def initialize(name)
        @name = name
        @state = true
    end

    def self.store_data(array,array_2)
        array.each do |x|
        array_2 << "#{x.name},#{x.state}"
        end
    end

end


test1 = Test.new("john")
test2 = Test.new("smith")
array = [test1,test2]

array_2 = []
Test.store_data(array,array_2)






p array_2

File.open("game_database/test.csv","w") do |line|
    array_2.each do |data|
            line << data.to_s + "\n"
    end
end
