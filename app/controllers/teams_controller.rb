class TeamsController < ApplicationController
  def create
    team_registered = Team.exists?(team_id: team_params[:team_id])

    if team_registered
      render json: { message: 'Team has already been registered with Karmayogi.', type: 'alert' }
    else
      @team = Team.new(team_params)

      if @team.save
        render json: { message: 'Team registered successfully.', type: 'success' }
      else
        render json: { message: @team.errors, type: 'alert' }
      end
    end
  end

  private

  def team_params
    params.permit(*Team.new.attributes.keys)
  end
end
