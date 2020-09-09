require_relative '../lib/branded_food'
require_relative '../lib/common_food'
require_relative '../lib/cli'

class CLI 
 

    def list_foods
        puts "Common Suggestions:"
        CommonFood.all.each.with_index(1) do |food, i|
            puts "#{i}. #{food.food_name}"
        end
        puts "Popular Brands:"
        BrandedFood.all.each.with_index(1) do |food, i|
            puts "#{i}. #{food.brand_name} - #{food.food_name}"
        end

    end
end