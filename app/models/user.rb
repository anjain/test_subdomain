class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :role

  ROLES = {
  	Admin: 'admin',
  	Seller: 'seller',
  	Buyer: 'buyer'
  }

  after_create :set_role

  def set_role
  	self.add_role role.to_sym
  end

end
