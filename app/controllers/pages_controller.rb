class PagesController < ApplicationController
  def welcome
  end

  def user
    @user = current_user
  end
end
