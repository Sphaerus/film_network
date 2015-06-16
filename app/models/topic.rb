class Topic < ActiveRecord::Base
  attr_accessor :resource
  
  belongs_to :user
  belongs_to :subject, polymorphic: true
  has_many :posts
  
  validates :title, :content, presence: true
end
