class Ability
  include CanCan::Ability

  def initialize(user,params)
    user ||= User.new

    if user.is_admin?
      can :manage, :all
    else
      if params[:controller] == "plans"
        can :index, :all
        can :create, Plan
        can :show, Plan
      end
    end
  end

end
