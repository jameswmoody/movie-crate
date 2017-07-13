class User < ActiveRecord::Base
  has_many :crate_entries
  has_many :movies, through: :crate_entries
end
