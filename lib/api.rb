require_relative '../lib/branded_food'
require_relative '../lib/common_food'
require_relative '../lib/cli'
require 'uri'
require 'httpclient'
require 'json'
require 'pry'
require 'net/http'

# X-APP-ID = 288d43cd
# X-APP-KEY = 8fec0adf08110aaf257cb4d4665594e6

#AUTOFILL (Natural Language)
class API
def self.food_search(food)
url = URI("https://trackapi.nutritionix.com/v2/search/instant?query=chicken")

https = Net::HTTP.new(url.host, url.port);
https.use_ssl = true

request = Net::HTTP::Get.new(url)
request["x-app-id"] = "288d43cd"
request["x-app-key"] = "8fec0adf08110aaf257cb4d4665594e6"

response = https.request(request)
food_hash = JSON.parse(response.read_body, symbolize_names:true)

common_foods_array = food_hash[:common]
branded_foods_array = food_hash[:branded]
    # end

# def self.add_common_foods(common_foods_array)
    common_foods_array.map do |food|
        CommonFood.new(food)
    end
# end

# def self.add_branded_foods(branded_foods_array)
    branded_foods_array.map do |food|
        BrandedFood.new(food)
    # end
end
end


#SEACH ITEM(Branded)

def self.get_branded_food_nutrients(food_id)
url = URI("https://trackapi.nutritionix.com/v2/search/item?nix_item_id=#{food_id}")

https = Net::HTTP.new(url.host, url.port);
https.use_ssl = true

request = Net::HTTP::Get.new(url)
request["x-app-id"] = "288d43cd"
request["x-app-key"] = "8fec0adf08110aaf257cb4d4665594e6"

response = https.request(request)
branded_food_hash = JSON.parse(response.read_body, symbolize_names:true)
binding.pry

end



#COMMON FOODS

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
response_hash = JSON.parse(response.read_body, symbolize_names:true)
nutrient_hash = response_hash[:foods][0]

end
binding.pry
end

# def self.display_common_food_nutrients(food)

