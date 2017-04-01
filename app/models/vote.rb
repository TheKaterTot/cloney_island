class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, :polymorphic => true

  validates_inclusion_of :value, :in => [-1, 0, 1]
end