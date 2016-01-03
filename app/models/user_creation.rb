class UserCreation < ActiveRecord::Base
  belongs_to :user, touch: true
  belongs_to :creation, class_name: "Image", touch: true
end
