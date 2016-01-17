class ImagePolicy < ApplicationPolicy
  def initialize(user, image)
    @user = user
    @image = image
  end

  def created?
    @image.allow_new_creators
  end

  # Checks if the user can edit the image.
  def edit?
    update?
  end

  # Checks if the user can update the image.
  # Must either be an admin or own the image.
  def update?
    admin? || @image.user == @user
  end

  # Checks if the user has permission to delete the image.
  # Either via being an admin or owning the image.
  # Owner can only delete images that have recently been uploaded.
  def destroy?
    admin? || (owned? && recently_made?)
  end

  # Checks if the user owns the image.
  # This essentially means: did the user originally upload the image?
  def owned?
    @image.user == @user
  end

  # Checks if the user is an admin.
  def admin?
    @user.try(:role) == 'admin'
  end

  ##
  # Checks if the image's creation date was within the last 24 hours.
  def recently_made?
    @image.created_at > 1.day.ago
  end
end
