class Patient < ApplicationRecord
    belongs_to :company
    has_many :daywise_infos
    accepts_nested_attributes_for :daywise_infos, allow_destroy: true
end
