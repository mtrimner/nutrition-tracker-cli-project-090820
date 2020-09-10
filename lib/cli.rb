# require_relative '../lib/branded_food'
# require_relative '../lib/common_food'
# require_relative '../lib/cli'
# require 'uri'
# require 'json'
# require 'pry'
# require 'net/http'

class CLI 
 
    def run
        puts "Welcome to the Nutrition Database Lookup!"
        puts "Hello! Please TYPE a food below."
        input = gets.chomp
        API.food_search(input)
        list_foods
        menu
    end
    
    def list_foods
        puts "Please select number below!"
        puts "Common Suggestions:"
        CommonFood.all.each.with_index(1) do |food, i|
            puts "#{i}. #{food.food_name}"
        end
        puts "Popular Brands:"
        BrandedFood.all.each.with_index(CommonFood.all.length+1) do |food, i|
            puts "#{i}. #{food.brand_name} - #{food.food_name}"
        end
        puts "Please select a number above!"
    end
    


    def menu
            input = gets.chomp
        if input.to_i.between?(1, CommonFood.all.length)
            food_choice = CommonFood.all[input.to_i-1]
            selected_food_name = food_choice.food_name
            selected_food_info = API.get_common_food_nutrients(selected_food_name)
            displays_food_info(selected_food_info)
        elsif input.to_i.between?(CommonFood.all.length+1, BrandedFood.all.length+CommonFood.all.length)
            food_choice = BrandedFood.all[input.to_i-1 - CommonFood.all.length]
            selected_food_id = food_choice.nix_item_id
            selected_food_info = API.get_branded_food_nutrients(selected_food_id)
            displays_food_info(selected_food_info)
        else 
            puts "Number not valid, please try again."
            menu
        end
        puts "Would you like to lookup more food?"
        puts "Please enter Y or N"
        another_lookup = gets.strip.downcase
        if another_lookup == "y"
            BrandedFood.reset
            CommonFood.reset
            puts "Please search for another food!"
            input = gets.chomp
            API.food_search(input)
            # puts "Please select an option below!"
            list_foods
            menu
        else another_lookup == "no"
            puts "Goodbye!"
            exit
        end


    end

    def displays_food_info(food)
        puts "#{food[:food_name]} has the following per #{food[:serving_qty]} #{food[:serving_unit]}"
        puts "Total calories = #{food[:nf_calories].round(1)}"
        puts "Protein = #{food[:nf_protein].round(1)}g"
        puts "Total Fat = #{food[:nf_total_fat].round(1)}g"
        puts "Carbs = #{food[:nf_total_carbohydrate].round(1)}g"
    end

end
