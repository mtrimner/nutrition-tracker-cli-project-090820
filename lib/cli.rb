require_relative '../lib/branded_food'
require_relative '../lib/common_food'
require_relative '../lib/cli'
require 'uri'
require 'httpclient'
require 'json'
require 'pry'
require 'net/http'

class CLI 
 
    def run
        puts "Hello! Please enter a food below."
        input = gets.chomp
        binding.pry
        API.food_search(input)
        binding.pry
        puts "Please select an option below!"
        list_foods
        menu
        # binding.pry
    end
    def list_foods
        puts "Common Suggestions:"
        CommonFood.all.each.with_index(1) do |food, i|
            puts "#{i}. #{food.food_name}"
        end
        puts "Popular Brands:"
        BrandedFood.all.each.with_index(CommonFood.all.length+1) do |food, i|
            puts "#{i}. #{food.brand_name} - #{food.food_name}"
        end

    end
    


    def menu
        puts "Please select a number to get food info."
            input = gets.chomp
        if input.to_i.between?(1, CommonFood.all.length)
            food_choice = CommonFood.all[input.to_i-1]
            # binding.pry
            selected_food_name = food_choice.food_name
            # binding.pry
            selected_food_info = API.get_common_food_nutrients(selected_food_name)
            # binding.pry
            displays_food_info(selected_food_info)
            # binding.pry
        elsif input.to_i.between?(CommonFood.all.length+1, BrandedFood.all.length+CommonFood.all.length)
            food_choice = BrandedFood.all[input.to_i-1 - CommonFood.all.length]
            # binding.pry
            selected_food_id = food_choice.nix_item_id
            # binding.pry
            selected_food_info = API.get_branded_food_nutrients(selected_food_id)
            # binding.pry
            displays_food_info(selected_food_info)
        else puts "Number not valid, please try again."
        end
        puts "Would you like to lookup more food?"
        puts "Please enter Y or N"
        another_lookup = gets.strip.downcase
        if another_lookup == "y"
            puts "Please search for another food below."
            input = gets.chomp
            API.food_search(input)
            puts "Please select an option below!"
            list_foods
            menu
        else another_lookup == "no"
            

    end

    def displays_food_info(selected_food_info)
        puts "#{selected_food_info[:food_name]} has the following per #{selected_food_info[:serving_qty]}#{selected_food_info[:serving_unit]}"
        puts "#{selected_food_info[:nf_protein]}g of protein"
        puts "#{selected_food_info[:nf_total_fat]}g of fat"
        puts "#{selected_food_info[:nf_total_carbohydrate]}g of carbs"
    end

end
