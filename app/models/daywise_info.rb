class DaywiseInfo < ApplicationRecord
    belongs_to :patient
    validates :status, presence: true, on: :update

    default_scope { order(:t_date) }
end
