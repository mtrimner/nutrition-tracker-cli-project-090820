class CommonFood

    attr_accessor :food_name

    @@all = []
    
    def initialize(food)
        @food_name = food[:food_name]
        @@all << self
        
    end

    def self.all
        @@all
    end
end

        