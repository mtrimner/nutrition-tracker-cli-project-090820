require_relative '../lib/branded_food'
require_relative '../lib/common_food'
require_relative '../lib/cli'
require 'uri'
require 'httpclient'
require 'json'
require 'pry'
require 'net/http'

class CLI 
 
    attr_accessor :selected_food_name
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
            binding.pry
            selected_food_name = food_choice.food_name
            API.get_common_food_nutrients(selected_food_name)
            binding.pry
        elsif input.to_i.between?(CommonFood.all.length+1, BrandedFood.all.length+CommonFood.all.length)
            food_choice = BrandedFood.all[CommonFood.all.length + input.to_i-1]
            selected_food_id = food_choice.nix_item_id
        else puts "Number not valid, please try again."
        end
    end

    # def find_common_food_from_input(input)
    #     selected_hash = CommonFood.all[input.to_i-1]
    #     selected_hash

end
