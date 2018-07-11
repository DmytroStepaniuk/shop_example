class SignInDecorator < Draper::Decorator
  delegate_all

  decorates_association :user

  def as_json(*args)
    {
      user:       {
                    email: user.email,
                    full_name: user.decorate.full_name,
                    pending_orders_count: user.orders.where(status: :pending).count
                  },
      auth_token: session.auth_token
    }
  end
end