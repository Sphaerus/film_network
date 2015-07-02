class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  mount_uploader :avatar, AvatarUploader       
         
  has_many :scores       
  has_many :reviews
  has_many :movies
  has_many :people
  
  def display_name
    return nickname if !nickname.blank?
    return email
  end
end
