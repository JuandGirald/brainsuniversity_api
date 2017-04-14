class Availability < ApplicationRecord
  belongs_to :teacher, dependent: :destroy
end
