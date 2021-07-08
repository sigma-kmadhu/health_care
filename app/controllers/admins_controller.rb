class AdminsController < ApplicationController
  
  def index
    @companies = Company.includes(patients: [:daywise_infos]).all
  end
end
