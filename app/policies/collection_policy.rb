class CollectionPolicy < ApplicationPolicy
  def initialize(user, collection)
    @user = user
    @collection = collection
  end

  def update?
    admined? && non_innate?
  end
  def destroy?
    admined? && non_innate?
  end

  protected

  def non_innate?
    case @collection.type
    when "Favorite"
      false
    when "Creation"
      false
    else
      true
    end
  end

  def admined?
    c = Curatorship.where(user: @user,
                          collection: @collection)
    c.try(:first).try(:level) == "admin"
  end
end
