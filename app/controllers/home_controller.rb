class HomeController < ApplicationController
  def index
  end

  def service
    p 'params p'
    p params[:channelData][:teamsTeamId]
    team_id = params[:channelData][:teamsTeamId]
    validate_request(team_id)
    # render plain: params
    responseMsg = '{ "type": "message", "text": "Error: message sender cannot be authenticated." }'
    render plain: responseMsg
  end

  def validate_request(team_id)
    registered_team_id =
    team_id.downcase
  end
end
