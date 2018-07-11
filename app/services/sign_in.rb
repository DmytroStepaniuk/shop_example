class SignIn
  include ActiveModel::Validations

  include Draper::Decoratable

  validate do |model|
    if user
      model.errors.add :password, 'is invalid' unless user.authenticate @params[:password]
    else
      model.errors.add :email, 'not found'
    end
  end

  def initialize params
    @params = params
  end

  def save!
    raise ActiveModel::StrictValidationFailed unless valid?

    session
  end

  def user
    @user ||= User.find_by email: @params[:email]
  end

  def session
    @session ||= user.sessions.create!
  end
end