class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new # for guest
    @user.roles.each { |role| send(role.name) }

    if @user.roles.size == 0
      can :create, User
    end
  end

  def staff
    can :due_today, :show, Policy
    can :details, Policy
    can :due_today, Policy
    can [:read], PolicyResolution
    can [:show, :edit], User do |user|
      user == user
    end
    can [:show, :edit], Profile do |profile|
      profile.user == user
    end
    can :read, Rank
  end

  def manager
    can :manage, PolicyResolution
    can :manage, Policy
    can :manage, Approval
    can [:show, :edit], User do |user|
      user == user
    end
    can [:show, :edit], Profile do |profile|
      profile.user == user
    end
  end

  def supervisor
    can :manage, PolicyResolution
    can :manage, Policy
    can :manage, Approval
    can [:show, :edit], User do |user|
      user == user
    end
    can [:show, :edit], Profile do |profile|
      profile.user == user
    end
  end

  def superadmin
    can :manage, :all
  end

end
