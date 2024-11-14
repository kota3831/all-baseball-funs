class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, uniqueness: true
  validates :name, length: { minimum: 2, maximum: 20, too_short: "is too short (minimum is 2 characters)", too_long: "is too long (maximum is 20 characters)" }
end
