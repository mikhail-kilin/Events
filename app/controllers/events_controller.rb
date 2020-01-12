class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def by_date
    begin
      @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    rescue
      render file: "#{Rails.root}/public/404.html", layout: false, :status => 404 and return
    end
    if params[:group] == 'all'
      @events = Event.search(@date).order(:time_of_event)
    else
      @events = current_user.events.search(@date).order(:time_of_event)
    end
  end

  def by_month
    year = params[:year].nil? ? Date.today.year : params[:year].to_i
    month = params[:month].nil? ? Date.today.month : params[:month].to_i
    begin
      @date = Date.new(year, month, 1)
    rescue
      render file: "#{Rails.root}/public/404.html", layout: false, :status => 404 and return
    end
    @count_of_days = Time.days_in_month(month, year)
    @first_day_of_week = @date.wday
    if params[:group] == 'all'
      @group = :all
    end
    render :index
  end

  def index
    date = Date.today
    redirect_to by_month_events_url(month: date.month, year: date.year)
  end

  def show
  end

  def new
    @event = current_user.events.new
    @event.time_of_event = Date.today.at_beginning_of_day
  end

  def edit
  end

  def create
    @event = current_user.events.new(event_params)

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :content, :time_of_event, :period)
    end

end
