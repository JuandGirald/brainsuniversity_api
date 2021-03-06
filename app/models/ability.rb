class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
      can :assign_roles, User if user.admin?
    elsif user.teacher?
      can :read, Teacher
      can :update, Teacher, id: user.id
      can [:update, :read], Schedule, teacher: user
      can [:read, :update], BankInformation, teacher: user
      can :session, Schedule
    elsif user.student?
      can :create, Schedule
      can :session, Schedule
      can :apply_promo, Schedule
      can [:update, :read], Schedule, student: user
      can :read, Teacher do |user|
        user.status == 'complete'
      end
      can [:read, :update], Student, id: user.id
    else
      can :read, Teacher do |user|
        user.status == 'complete'
      end
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
