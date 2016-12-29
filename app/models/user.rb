class User < ApplicationRecord
	has_many :tasks
  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  def remove_friend(friend)
    Current.user.friends.destroy(friend)
  end

  def not_friends_with?(friend_id)
    friendships.where(friend_id: friend_id).count < 1
  end

  def except_current_user(users)
    users.reject {|user| user.id == self.id}
  end

  def self.search(param)
    return User.none if param.blank?
    param.strip!
    param.downcase!
    (display_name_matches(param) + email_matches(param)).uniq
  end



  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.display_name_matches(param)
    matches('last_name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def self.matches(field_name, param)
    where("lower(#{field_name}) like ?", "%#{param}%")
  end

	has_secure_password

  validates :password, :presence => true,
            :confirmation => true,
            :length => {:within => 4..40},
            :on => :create
  validates :password, :confirmation => true,
            :length => {:within => 4..40},
            :allow_blank => true,
            :on => :update
has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", mini:"55x55" }, default_url: "/images/:style/missing.png"
validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
before_save { self.email = email.downcase }
validates :display_name,  presence: true, length: { maximum: 25 }
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, presence: true, length: { maximum: 75 },
                  format: { with: VALID_EMAIL_REGEX },
                  uniqueness: { case_sensitive: false }
# validates :password, presence: true, length: { minimum: 6 }
# Returns the hash digest of the given string.
  def User.digest(string)
cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
end
end
