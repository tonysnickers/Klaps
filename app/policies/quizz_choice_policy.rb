class QuizzChoicePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
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

  def edit_genre?
    true
  end

  def add_keyword?
    true
  end

  def add_date?
    true
  end

  def add_duration?
    true
  end

  def add_actor?
    true
  end

  def change_step?
    true
  end

  def validate?
    record.user == user
  end
end
