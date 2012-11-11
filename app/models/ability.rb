class Ability
  include CanCan::Ability
 
  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    roles = Ability.get_permissions(user.role)
        if roles.include?'admin'
            can :manage, :all
        elsif roles.include?'journalist'
            can :read, :all
            can :update, Article, :user => user
        elsif roles.include?'editor'
            can :read, :all
            can :manage, Article
        elsif roles.include?'chief_editor'
            can :read, :all
            can :manage, Article
        elsif roles.include?'chief_editor_country'
            can :read, :all
            can :manage, Article
        else
            can :read, Article
       end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end

  def self.get_permissions(number)
    binary = []
    permissions = []
    while number != 0
        binary.append(number%2)
        number = number/2
    end
    
    (0..binary.size-1).each do |i|
        if binary[i] == 1
            permissions.append(User::ROLES[i])
        end
    end
    return permissions
  end

end
