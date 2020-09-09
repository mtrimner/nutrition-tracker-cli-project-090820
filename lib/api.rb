require_relative 'food'
require 'uri'
require 'httpclient'
require 'json'
require 'pry'
require 'net/http'

# X-APP-ID = 288d43cd
# X-APP-KEY = 8fec0adf08110aaf257cb4d4665594e6

#AUTOFILL (Natural Language)

url = URI("https://trackapi.nutritionix.com/v2/search/instant?query=pizza")

https = Net::HTTP.new(url.host, url.port);
https.use_ssl = true

request = Net::HTTP::Get.new(url)
request["x-app-id"] = "288d43cd"
request["x-app-key"] = "8fec0adf08110aaf257cb4d4665594e6"

response = https.request(request)
food_hash = JSON.parse(response.read_body, symbolize_names:true)

common_foods = food_hash[:common]
branded_foods = food_hash[:branded]


#SEACH ITEM(Branded)


url = URI("https://trackapi.nutritionix.com/v2/search/item?nix_item_id=59b0f0f2d05c47746fececac")

https = Net::HTTP.new(url.host, url.port);
https.use_ssl = true

request = Net::HTTP::Get.new(url)
request["x-app-id"] = "288d43cd"
request["x-app-key"] = "8fec0adf08110aaf257cb4d4665594e6"

response = https.request(request)
branded_food_hash = JSON.parse(response.read_body, symbolize_names:true)

binding.pry


#COMMON FOODS
# url = URI("https://trackapi.nutritionix.com/v2/natural/nutrients")

# https = Net::HTTP.new(url.host, url.port);
# https.use_ssl = true

# request = Net::HTTP::Post.new(url)
# request["x-app-id"] = "288d43cd"
# request["Content-Type"] = "application/x-www-form-urlencoded"
# request["x-app-key"] = "8fec0adf08110aaf257cb4d4665594e6"
# request.body = "query=Real Good Pizza Co. Snack Size Pizza, Uncured Pepperoni"



# response2 = https.request(request)


# nutrient_hash = JSON.parse(response2.read_body, symbolize_names:true)
# nutrient_array = nutrient_hash[:foods]

# binding.pry