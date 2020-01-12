class PagesController < ApplicationController
  before_action :authenticate_user!, only: :user

  def welcome
  end

  def user
    @user = current_user
  end
end
