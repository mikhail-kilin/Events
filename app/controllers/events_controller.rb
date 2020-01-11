class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def by_date
    @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    @events = Event.search(@date).order(:time_of_event)
  end

  def by_month
    year = params[:year].to_i
    month = params[:month].to_i
    @date = Date.new(year, month, 1)
    @count_of_days = Time.days_in_month(month, year)
    @first_day_of_week = @date.wday
    render :index
  end

  def index
    date = Date.today
    redirect_to by_month_events_url(month: date.month, year: date.year)
  end

  def show
  end

  def new
    @event = Event.new
    @event.time_of_event = Date.today.at_beginning_of_day
  end

  def edit
  end

  def create
    @event = Event.new(event_params)

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
