class User < ApplicationRecord
  has_many :posts

  audited
end
