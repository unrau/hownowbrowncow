class HomeController < ApplicationController

  def index
    @tweets = tweets 3
  end

end
