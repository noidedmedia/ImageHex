class UserCreation < ActiveRecord::Base
  belongs_to :user
  belongs_to :creation, class_name: "Image"
end
