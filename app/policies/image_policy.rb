class ImagePolicy < ApplicationPolicy
  def initialize(user, image)
    @user = user
    @image = image
  end

  def edit?
    @user.try(:level) == 'admin' || @image.user == @user
  end
  def update?
    @user.try(:level) == 'admin' || @image.user == @user
  end

end
