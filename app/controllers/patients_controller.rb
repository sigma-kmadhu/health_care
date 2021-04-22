class PatientsController < ApplicationController
  def index
    @company = Company.first
  end

  def update
    byebug
  end
end
