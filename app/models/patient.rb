class Patient < ApplicationRecord
    self.primary_key = 'actual_patient_id'
    belongs_to :company
    has_many :daywise_infos, dependent: :destroy
    accepts_nested_attributes_for :daywise_infos, allow_destroy: true
    
    default_scope { order(:name) }
end
