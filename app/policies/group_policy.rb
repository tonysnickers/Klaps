class GroupPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      user.my_groups.where(archive: false)
    end
  end

    def show?
      true
    end

    def create?
      true
    end

    def update?
      record.user == user
    end

    def results?
      true
    end
end
