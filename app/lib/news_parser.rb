require 'rss/atom'
require 'net/https'

module NewsParser
  def self.get_news
    http = Net::HTTP.new("sites.google.com", 443)
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    req = Net::HTTP::Get.new("/a/umn.edu/msi-software-accounting/announcements/posts.xml")
    response = http.request(req)
    content = response.body
    RSS::Parser.parse(content, false)
  end
end