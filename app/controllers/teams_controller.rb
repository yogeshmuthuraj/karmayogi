class TeamsController < ApplicationController
  def create
    Team.create!(team_params)

    render json: { type: 'success' , message: 'Team registered successfully.' }
  rescue ActiveRecord::RecordInvalid =>  error
    render json: { type: 'danger' , message: error }
  end

  private

  def team_params
    params.permit(*Team.new.attributes.keys)
  end
end
