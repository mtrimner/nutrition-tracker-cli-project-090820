class BrandedFood

    attr_accessor :food_name, :nix_item_id, :brand_name

    @@all = []

    def initialize(food)
        @food_name = food[:food_name]
        @nix_item_id = food[:nix_item_id]
        @brand_name = food[:brand_name]
        @@all << self
        
    end

    def self.all
        @@all
    end
end
