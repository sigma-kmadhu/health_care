class Company < ApplicationRecord
    self.primary_key = 'actual_company_id'
    has_many :users, dependent: :destroy
    has_many :patients, dependent: :destroy

    accepts_nested_attributes_for :patients, allow_destroy: true
end
