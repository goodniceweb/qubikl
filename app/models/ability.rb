# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    else
      # Allow users to manage only their own QR codes
      can :manage, QRCode, user_id: user.id

      # Allow users to manage only their own user domains
      can :manage, UserDomain, user_id: user.id

      # Allow users to manage only their own user domains
      can :manage, APIKey, user_id: user.id

      # Allow users to manage only their own user record
      can :manage, User, id: user.id
    end
  end
end
