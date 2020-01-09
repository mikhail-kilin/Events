class Event < ApplicationRecord
  validates :period, inclusion: { in: %w(one-time daily weekly monthly annual),
                                message: "'%{value} ' is not a period`" }
  validates :title, length: {minimum: 3, maximum: 20}
  validates :content, length: {minimum: 10}
  validates_presence_of :title, :content
end
