class HomeController < ApplicationController
  include HomeConcern

  def index
    # Based on format we should change the service end point
    # respond_to do |format|
    #   format.html
    #   format.json service
    # end
  end

  def service
    team_id = params[:channelData][:teamsTeamId]

    if Team.exists?(team_id: team_id)
      current_user = {
        id: params[:from][:id],
        name: params[:from][:name],
      }

      if params[:text].downcase.match?('leaderboard')
        response_msg = leaderboard(team_id, current_user)
      elsif params[:text].downcase.match?('help')
        response_msg = help
      else
        mentioned_user = {
          id: params[:entities][0][:mentioned][:id],
          name: params[:entities][0][:mentioned][:name],
        }
        charge = ActionController::Base.helpers.strip_tags(params[:text].html_safe[/.*\>(.*?)\n/,1]) # Whether ++ or --

        response_msg = decide_karma(current_user, mentioned_user, charge, team_id)
      end
    else
      response_msg = %Q({ "type": "message", "text": "Error: The Team is not registered." })
    end

    render plain: response_msg
  end
end
