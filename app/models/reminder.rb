class Reminder < ActiveRecord::Base
  belongs_to :user
  has_many :payments,    :dependent => :destroy
  validates :description, :presence => true, :length => { :maximum => 140 }
end
