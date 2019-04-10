# frozen_string_literal: true

module HomeConcern
  def leaderboard(team_id, current_user)
    response_msg = '{
      "type": "message",
      "text": "Hey <at>Jothinathan,Vidhya</at> check out this message",
      "entities": [
        {
          "type": "mention",
          "mentioned":
            {
              "id": "29:1TiQn0czlgSWUvL-iY5q5HFUQdztx0ygh2iy3ZkOjQl_0UPyT1bK3RyFLLaz76-KSKACdgKTsVEnRIT_ZTbGYRg",
              "name": "Jothinathan,Vidhya",
            },
          "text": "<at>Jothinathan,Vidhya</at>",
        },
      ],
    }'

    render plain: response_msg
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
      '{ "type": "message", "text": "Error: Some problem, try again!" }'
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
  '{ "type": "message", "text": "Error: Some problem, try again!" }'
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
  '{ "type": "message", "text": "Error: Some problem, try again!" }'
end
