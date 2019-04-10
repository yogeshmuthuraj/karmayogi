# frozen_string_literal: true

module HomeConcern
  def leaderboard(team_id, current_user)
    # "text": "Hey <at>#{current_user[:name]},</at> you are #{position}.",
    # position = '7th'
    %Q({
      "type": "message",
      "text": "Hey <at>#{current_user[:name]},</at>.",
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
      ],
    })
  end

  def help
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
    user = User.where(user_id: mentioned_user[:id], name: mentioned_user[:name]).first_or_create!(team_id: team_id)
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
    user = User.where(user_id: mentioned_user[:id], name: mentioned_user[:name]).first_or_create!(team_id: team_id)
    user.decrement!(:karmas)
    karmas = user.karmas
    message = 'p'

    %Q({ "type": "message", "text": "Karmas: #{karmas}. #{message}" })
  end
rescue ActiveRecord::RecordNotFound
  %Q({ "type": "message", "text": "Error: Some problem, try again!" })
end
