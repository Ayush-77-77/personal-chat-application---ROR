class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :contacts
  has_many :messages
  has_many :contacts
  has_many :sent_messages, class_name: "Conversation", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Conversation", foreign_key: "receiver_id"

  has_one_attached :avatar
end
