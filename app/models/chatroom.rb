class Chatroom < ApplicationRecord
    has_many :messages, dependent: :destroy
    has_many :userchatrooms
    has_many :users, through: :userchatrooms
end
