class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie
  
  validates :title, :content, :movie_id, :user_id, presence: true
end
