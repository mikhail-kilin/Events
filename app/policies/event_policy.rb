class EventPolicy
  def initialize(event, user)
    @event = event
    @user = user
  end

  def can_use?
    @event.user == @user
  end
end