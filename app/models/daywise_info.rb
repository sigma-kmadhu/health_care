class DaywiseInfo < ApplicationRecord
    belongs_to :patient
    serialize :status, Array
    before_update :trim_status
    validate :status_presence, on: :update

    default_scope { order(:t_date) }

    def status_presence
        errors.add(:status, "cannot be blank") if !self.status.reject(&:empty?).present?
    end

    def trim_status
        self.status = self.status.reject(&:empty?)
    end
end
