class Movie < ActiveRecord::Base
  has_many :crate_entries
  has_many :users, through: :crate_entries
end
