class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :confirmable, :recoverable, :registerable, :trackable, :validatable, :rememberable
end
