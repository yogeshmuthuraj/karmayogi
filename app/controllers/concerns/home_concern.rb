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

  def decide_karma(current_user, mentioned_user, charge)
    case charge
    when '++'
      add_karma(current_user, mentioned_user)
    when '--'
      remove_karma(current_user, mentioned_user)
    else
      '{ "type": "message", "text": "Error: Some problem, try again!" }'
    end
  end
end

def add_karma(current_user, mentioned_user)
  # total_karma =
  '{ "type": "message", "text": "Plus one for you" }'
end

def remove_karma(current_user, mentioned_user)
  # total_karma =
  '{ "type": "message", "text": "Minus one for you" }'
end
