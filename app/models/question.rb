class Question < ApplicationRecord
  has_many :options, dependent: :destroy
  accepts_nested_attributes_for :options,
                                :reject_if => :all_blank,
                                :allow_destroy => :true

  belongs_to :survey, optional: true
  has_many :responses
end
