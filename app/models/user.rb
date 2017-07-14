class User < ActiveRecord::Base
  include BCrypt

  has_many :crate_entries
  has_many :movies, through: :crate_entries

  validates :first_name, { :presence => true }
  validates :last_name, { :presence => true }
  validates :email, { :presence => true, uniqueness: true }
  validates :password, { :presence => true }

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(password)
    self.password == password
  end

  def crate
    crate = []
    if movies.any?
      movies.each do |movie|
        crate << movie.tmdb_id
      end
    end
    crate
  end
end
