class HomeController < ApplicationController
  include HomeConcern
  include BuddyConcern
  include JokeConcern

  def index
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
      elsif params[:text].downcase.match?('jokeme')
        response_msg = %Q({
          "type": "message",
          "text": "#{eval(get_joke)[:joke]}"
        })
      elsif params[:text].downcase.match?('findbuddy')
        response_msg = find_buddy_tester(team_id)
      elsif params[:text].downcase.match?('techverify')
        response_msg = %Q({
          "type": "message",
          "text": "I can't do Tech veriifcations now."
        })
      elsif params[:text].downcase.match?('warmup')
        response_msg = %Q({
          "type": "message",
          "text": "Warmed up!"
        })
      elsif params[:text].downcase.match?('addbuddy')
        mentioned_user = {
          id: params[:entities][0][:mentioned][:id],
          name: params[:entities][0][:mentioned][:name],
        }

        response_msg = add_buddy(team_id, mentioned_user)
      elsif params[:text].downcase.match?('removebuddy')
        mentioned_user = {
          id: params[:entities][0][:mentioned][:id],
          name: params[:entities][0][:mentioned][:name],
        }

        response_msg = remove_buddy(team_id, mentioned_user)
      elsif params[:text].downcase.match?('buddylist')
        response_msg = buddy_list(team_id)
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

    p 'debugy response_msg'
    p response_msg

    render plain: response_msg
  end
end
