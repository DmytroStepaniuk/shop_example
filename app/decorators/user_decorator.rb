class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    [first_name, last_name].join(' ')
  end

  def as_json
    {
      email: object.email,
      full_name: object.full_name
    }
  end
  
end
