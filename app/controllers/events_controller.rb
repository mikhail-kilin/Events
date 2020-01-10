class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def by_date
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
    @date = Date.today
    @count_of_days = Time.days_in_month(@date.month, @date.year)
    @first_day_of_week = Date.new(@date.year, @date.month, 1).wday
  end

  def show
  end

  def new
    @event = Event.new
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
