# X-APP-ID = 288d43cd
# X-APP-KEY = 8fec0adf08110aaf257cb4d4665594e6


class API
    #This will allow users to search in natural language and provide and "autofilled" list of options.
    def self.food_search(food)
        url = URI("https://trackapi.nutritionix.com/v2/search/instant?query=#{food}")
        https = Net::HTTP.new(url.host, url.port);
        https.use_ssl = true
        request = Net::HTTP::Get.new(url)
        request["x-app-id"] = "288d43cd"
        request["x-app-key"] = "8fec0adf08110aaf257cb4d4665594e6"
        response = https.request(request)
        food_hash = JSON.parse(response.read_body, symbolize_names:true)
        common_foods_array = food_hash[:common]
        branded_foods_array = food_hash[:branded]
    
        common_foods_array.map do |food|
         CommonFood.new(food)
        end

        branded_foods_array.map do |food|
            BrandedFood.new(food)
        end
    end



    #This method will allow users to access a database of brandnamed foods and restaurant menus.""
    def self.get_branded_food_nutrients(food_id)
        url = URI("https://trackapi.nutritionix.com/v2/search/item?nix_item_id=#{food_id}")
        https = Net::HTTP.new(url.host, url.port);
        https.use_ssl = true
        request = Net::HTTP::Get.new(url)
        request["x-app-id"] = "288d43cd"
        request["x-app-key"] = "8fec0adf08110aaf257cb4d4665594e6"
        response = https.request(request)
        response_hash = JSON.parse(response.read_body, symbolize_names:true)[:foods][0]
    end


    # This will allow users access to a large USDA database of common foods.
    def self.get_common_food_nutrients(food)
        url = URI("https://trackapi.nutritionix.com/v2/natural/nutrients")
        https = Net::HTTP.new(url.host, url.port);
        https.use_ssl = true
        request = Net::HTTP::Post.new(url)
        request["x-app-id"] = "288d43cd"
        request["Content-Type"] = "application/x-www-form-urlencoded"
        request["x-app-key"] = "8fec0adf08110aaf257cb4d4665594e6"
        request.body = "query=#{food}"      
        response = https.request(request)
        response_hash = JSON.parse(response.read_body, symbolize_names:true)[:foods][0]
    end
end



