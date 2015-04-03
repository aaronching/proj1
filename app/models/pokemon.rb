class Pokemon < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  belongs_to :trainer
end
