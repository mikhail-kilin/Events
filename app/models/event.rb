class Event < ApplicationRecord
  belongs_to :user

  validates :period, inclusion: { in: %w(one-time daily weekly monthly annual),
                                message: "'%{value} ' is not a period`" }
  validates :title, length: {minimum: 3, maximum: 20}
  validates_presence_of :title, :time_of_event

  scope :search_by_date, ->(date) { where("time_of_event <= ? AND time_of_event >= ? AND period = 'one-time'", date.end_of_day, date.beginning_of_day) }
  scope :search_daily, -> { where(period: :daily) }
  scope :search_weekly, ->(date) { where("extract(dow from time_of_event) = ? AND period = 'weekly'", date.wday) }
  scope :search, ->(date) { search_by_date(date).or search_daily.or search_weekly(date).or search_monthly(date).or search_annual(date) }

  def self.search_monthly(date)
    if (date.at_end_of_month.day == date.day)
      where("extract(DAY from time_of_event) >= ? AND period = 'monthly'", date.day)
    else
      where("extract(DAY from time_of_event) = ? AND period = 'monthly'", date.day)
    end
  end

  def self.search_annual(date) 
    if (date.at_end_of_month.day == date.day)
      where("extract(MONTH from time_of_event) = ? AND extract(DAY from time_of_event) >= ? AND period = 'annual'", date.month, date.day)
    else
      where("extract(MONTH from time_of_event) = ? AND extract(DAY from time_of_event) = ? AND period = 'annual'", date.month, date.day)
    end
  end
end
