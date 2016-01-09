class RecipesController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit, :create, :update, :destroy]
  before_action :admin_user,     only: [:new, :edit, :create, :update, :destroy]
  
end
