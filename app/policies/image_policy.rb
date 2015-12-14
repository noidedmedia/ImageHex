class ImagePolicy < ApplicationPolicy
  def initialize(user, image)
    @user = user
    @image = image
  end

  def created?
    @image.allow_new_creators
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
    @user.try(:role) == 'admin'
  end

  ##
  # Image's creation date is some time within the last 24 hours
  def recently_made?
    @image.created_at > 1.day.ago
  end
end
