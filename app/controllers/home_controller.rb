require 'news_parser'

class HomeController < ApplicationController

  def index
  end

  def news
    @rss = NewsParser.get_news
    render "news", :layout => false
  end

end
