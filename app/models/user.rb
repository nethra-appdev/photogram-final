# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  comments_count  :integer
#  email           :string
#  likes_count     :integer
#  password_digest :string
#  private         :boolean
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

has_many :comments, :foreign_key => "author_id", :dependent => :nullify
has_many :likes, :foreign_key => "fan_id", :dependent => :destroy
has_many :received_follow_requests, :class_name => "FollowRequest", :foreign_key => "recipient_id", :dependent => :destroy
has_many :sent_follow_requests, :class_name => "FollowRequest", :foreign_key => "sender_id", :dependent => :destroy
has_many :photos, :foreign_key => "owner_id", :dependent => :destroy

has_many :commented_photos, :through => :comments, :source => :photo
has_many :liked_photos, :through => :likes, :source => :photo
has_many :recipients, :through => :sent_follow_requests, :source => :recipient
has_many :senders, :through => :received_follow_requests, :source => :sender
end
