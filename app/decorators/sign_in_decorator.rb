class SignInDecorator < Draper::Decorator
  delegate_all

  decorates_association :user

  def as_json(*args)
    {
      user:       user,
      auth_token: session.auth_token
    }
  end
end