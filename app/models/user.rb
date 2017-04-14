class User < ActiveRecord::Base#[5.0]?
  has_many :books
  has_secure_password

  def slug
    self.username.gsub(" ","-").downcase
  end

  def self.find_by_slug(slug)
    self.all.detect {|user| user.slug == slug}
  end
  
end
