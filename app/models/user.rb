class User < ApplicationRecord
  has_many :contacts
  has_many :messages
  has_many :contacts
  has_many :sent_messages, class_name: "Conversation", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Conversation", foreign_key: "receiver_id"
end
