class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    [object.first_name, object.last_name].join(' ')
  end
  
  def as_json
    {
      user: user,
      session: {}
    }
  end

end
