class Post < ApplicationRecord
  belongs_to :account, optional: true
  belongs_to :user, optional: true
end
