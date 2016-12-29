class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }
  validate :not_self




  private

  def create_inverse_relationship
    friend.friendships.create(friend: user)
  end

  def destroy_inverse_relationship
    friendship = friend.friendships.find_by(friend: user)
    friendship.destroy if friendship
  end

  def not_self
    errors.add(:friend, "You cannot be friends with yourself") if user == friend
  end


end
