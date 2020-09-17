class CLI 
 
    def run
        puts "Welcome to the Nutrition Database Lookup!"
        puts "Please TYPE a food below!"
        search
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
            food_choice = CommonFood.all[input.to_i-1].food_name
            selected_food_info = API.get_common_food_nutrients(food_choice)
            displays_food_info(selected_food_info)
        elsif input.to_i.between?(CommonFood.all.length+1, BrandedFood.all.length+CommonFood.all.length)
            food_choice = BrandedFood.all[input.to_i-1 - CommonFood.all.length].nix_item_id
            selected_food_info = API.get_branded_food_nutrients(food_choice)
            displays_food_info(selected_food_info)
        else 
            puts "Number not valid, please try again."
            menu
        end
        puts "Would you like to lookup more food?"
        look_up_more_food
    end

    def search
    input = gets.chomp
        food_search_result = API.food_search(input)
        if food_search_result == []
            puts "Ooops! We didn't quite understand. Try again!"
            search
        else list_foods
        end
    end

    def displays_food_info(food)
        puts "#{food[:food_name]} has the following per #{food[:serving_qty]} #{food[:serving_unit]}"
        puts "Total calories = #{food[:nf_calories].round(1)}"
        puts "Protein = #{food[:nf_protein].round(1)}g"
        puts "Total Fat = #{food[:nf_total_fat].round(1)}g"
        puts "Carbs = #{food[:nf_total_carbohydrate].round(1)}g"
    end

    def look_up_more_food
        puts "Please enter Y or N."
        another_lookup = gets.strip.downcase
        if another_lookup == "y"
            BrandedFood.reset
            CommonFood.reset
            puts "Please search for another food!"
            search
            list_foods
            menu
        elsif another_lookup == "n"
            puts "Goodbye!"
            exit
        else puts "Not recognized."
        end
        look_up_more_food
    end
end
