class Permission
  extend Forwardable

  attr_reader :user, :controller, :action

  def_delegators :user, :registered_user?,
                        :admin?

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action     = action
    if admin?
      admin_permissions
    elsif registered_user?
      registered_user_permissions
    else
      guest_permissions
    end
  end

private

  def admin_permissions
    return true if controller == "sessions" || "home"
    return true if controller == "users" && action.in?(%w(show))
    return true if controller == "questions" && action.in?(%w(index show new create))
    return true if controller == "answers" && action.in?(%w(create))
  end

  def registered_user_permissions
    return true if controller == "sessions" || "home"
    return true if controller == "users" && action.in?(%w(show))
    return true if controller == "questions" && action.in?(%w(index show new create))
    return true if controller == "answers" && action.in?(%w(create))
  end

  def guest_permissions
    return true if controller == "sessions" || "home"
    return true if controller == "questions" && action.in?(%w(index show))
  end

end
