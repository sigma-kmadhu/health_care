class Company < ApplicationRecord
    has_many :users
    has_many :patients

    accepts_nested_attributes_for :patients, allow_destroy: true
end
