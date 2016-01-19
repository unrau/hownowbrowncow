class HomeController < ApplicationController

  def index
    @tweets = tweets 5
  end

end
