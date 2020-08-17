# frozen_string_literal: true

module BuddyConcern
  include ApplicationHelper

  def find_buddy_tester(team_id)
    users = User.where(buddy: true, team_id: team_id)

    offset = rand(users.count)

    buddy_user = users.offset(offset).first

    if buddy_user
      buddy_user = {
        id: buddy_user[:user_id],
        name: buddy_user[:name],
      }

      %Q({
        "type": "message",
        "text": "Your buddy tester is <at>#{buddy_user[:name]}</at>",
        "entities": [
          {
            "type": "mention",
            "mentioned":
              {
                "id": "#{buddy_user[:id]}",
                "name": "#{buddy_user[:name]}",
              },
            "text": "<at>#{buddy_user[:name]}</at>",
          },
        ],
      })
    else
      %Q({
        "type": "message",
        "text": "Your buddy tester is <at>#{buddy_tester}</at>"
      })
    end
  end

  def add_buddy(mentioned_user, team_id)
    ActiveRecord::Base.transaction do
      user = User.where(user_id: mentioned_user[:id], name: mentioned_user[:name], team_id: team_id).first_or_create!()
      user.toggle!(:buddy)

      %Q({ "type": "message", "text": "#{user[:name]} added as a buddy" })
    end
  end

  def remove_buddy(mentioned_user, team_id)
    ActiveRecord::Base.transaction do
      user = User.where(user_id: mentioned_user[:id], name: mentioned_user[:name], team_id: team_id).first_or_create!()
      user.toggle!(:buddy)

      %Q({ "type": "message", "text": "#{user[:name]} removed as a buddy" })
    end
  end

  def buddy_list(team_id)
    buddy_users = User.where(buddy: true, team_id: team_id)
    buddy_users.each_with_index do | buddy_user, index |
      stringyfied_buddy_users << "\n #{index.to_i + 1} #{buddy_user[:name]}"
    end

    %Q({
      "type": "message",
      "text": "<h1>Buddy List</h1>\n\n
      #{stringyfied_buddy_users}"
    })
  end
end
