class ImagePolicy < ApplicationPolicy
  def initialize(user, image)
    @user = user
    @image = image
  end

  def edit?
    update?
  end
  def update?
    admin? || @image.user == @user
  end
  def destroy?
    admin? || (owned? && recently_made?)
  end

  def owned?
    @image.user == @user
  end

  def admin?
    @user.try(:level) == 'admin'
  end

  def recently_made?
    @image.created_at < 1.day.ago
  end
end
