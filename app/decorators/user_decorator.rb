class UserDecorator < Draper::Decorator
  delegate_all
  
  decorates_association :user
  
  def full_name
    [first_name, last_name].join(' ')
  end

  def as_json
    {
      email: email,
      full_name: full_name
    }
  end
  
end
