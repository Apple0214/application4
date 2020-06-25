class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attachment :profile_image, destroy: false
  has_many :books
  validates :name, presence: true, length: {maximum: 10, minimum: 2}
  validates :introduction, length: {maximum: 50}

  has_many :favorites
  has_many :relationships
  has_many :follower, class_name: :"Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: :"Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower

  def follow(user_id)
  	follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
  	follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
  	following_user.include?(user)
  end

end