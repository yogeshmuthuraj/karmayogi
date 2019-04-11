# frozen_string_literal: true

module HomeConcern
  include ApplicationHelper

  def leaderboard(team_id, current_user)
    leaderboard_message = "\n\n<h1>Leader Board</h1>\n\n"
    not_in_board = 'not in the board yet'
    current_user_in_board = User.exists?(team_id: team_id, user_id: current_user[:id])
    p 'current_user_in_board?'
    p current_user_in_board
    position = current_user_in_board ? 1 : not_in_board

    leaders = User.where(team_id: team_id).order('karmas DESC')
    table = tp_pre leaders, [:name, :karmas]

    if leaders.count != 0
      top_user_record = leaders.order('karmas DESC').first
      top_user = {
        id: top_user_record[:user_id],
        name: top_user_record[:name],
      }

      top_user_message = "\n\nHey <at>#{top_user[:name]}</at> you are at the top.\n\n"
      current_user_message = "\n\n<at>#{current_user[:name]}</at> you are #{position}.\n\n"

      %Q({
        "type": "message",
        "text": "#{leaderboard_message} #{top_user_message} #{table} #{current_user_message}",
        "entities": [
          {
            "type": "mention",
            "mentioned":
              {
                "id": "#{current_user[:id]}",
                "name": "#{current_user[:name]}",
              },
            "text": "<at>#{current_user[:name]}</at>",
          },
          {
            "type": "mention",
            "mentioned":
              {
                "id": "#{top_user[:id]}",
                "name": "#{top_user[:name]}",
              },
            "text": "<at>#{top_user[:name]}</at>",
          },
        ],
      })
    else
      %Q({
        "type": "message",
        "text": "#{leaderboard_message} The leaderboard is empty."
      })
    end
  end

  def help
    # 1. Giving Karmas:
    # 2. leaderboard:
    # 3. Help:
    %Q({
      "type": "message",
      "text": "<h2>Karmayogi</h2>\n\n
      1. Adding karma(points): @karmayogi @user++
      2. Removing karma(points): @karmayogi @user--
      3. Leaderboard for the team: @karmayogi leaderboard
      4. Help: @karmayogi help"
    })
  end

  def decide_karma(current_user, mentioned_user, charge, team_id)
    case charge
    when '++'
      add_karma(current_user, mentioned_user, team_id)
    when '--'
      remove_karma(current_user, mentioned_user, team_id)
    else
      %Q({ "type": "message", "text": "Error: Some problem, try again!" })
    end
  end
end

def add_karma(current_user, mentioned_user, team_id)
  ActiveRecord::Base.transaction do
    user = User.where(user_id: mentioned_user[:id], name: mentioned_user[:name], team_id: team_id).first_or_create!()
    user.increment!(:karmas)
    karmas = user.karmas
    message = 'p'

    %Q({ "type": "message", "text": "Karmas: #{karmas}. #{message}" })
  end
rescue ActiveRecord::RecordNotFound
  %Q({ "type": "message", "text": "Error: Some problem, try again!" })
end

def remove_karma(current_user, mentioned_user, team_id)
  ActiveRecord::Base.transaction do
    user = User.where(user_id: mentioned_user[:id], name: mentioned_user[:name], team_id: team_id).first_or_create!()
    user.decrement!(:karmas)
    karmas = user.karmas
    message = 'p'

    %Q({ "type": "message", "text": "Karmas: #{karmas}. #{message}" })
  end
rescue ActiveRecord::RecordNotFound
  %Q({ "type": "message", "text": "Error: Some problem, try again!" })
end
