class Main
require 'net/http'
require 'colorize'
require 'lolize'
colorizer = Lolize::Colorizer.new
require 'json'
puts "Input address:".red
address = gets.chomp
puts "Input port:".blue
port = gets.chomp
uri = URI("https://ddosnik.site/api/query/?host="+ address +"&port="+ port)

request = Net::HTTP::Get.new(uri)
request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36"

response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => (uri.scheme == 'https')) {|http|
  http.request(request)
}
if JSON.parse(response.body)['status'] === "Offline"
colorizer.write 'Данный сервер недоступен, либо он перегружен.'
else
colorizer.write "\nGAME: #{JSON.parse(response.body)['platform']}"
colorizer.write "\nMOTD: #{JSON.parse(response.body)['motd']['clean']}"
colorizer.write "\nMODE: #{JSON.parse(response.body)['gametype']}"
colorizer.write "\nVERSION: #{JSON.parse(response.body)['version']['version']}"
colorizer.write "\nCORE: #{JSON.parse(response.body)['version']['software']}"
colorizer.write "\nONLINE: #{JSON.parse(response.body)['players']['online']} из #{JSON.parse(response.body)['players']['max']}\n\n\n\n\n\n\n\n"
end
end
