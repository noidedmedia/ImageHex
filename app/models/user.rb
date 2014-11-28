class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  validates :name, presence: true,  uniqueness: {case_sensitive: false}
  has_many :images
  validates :page_pref, inclusion: {:in => (1..100)}
end
