class StaticPagesController < ApplicationController

  def home
    @tweets = tweets 3
  end

  def about
  end

end
