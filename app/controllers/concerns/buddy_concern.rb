# frozen_string_literal: true

module BuddyConcern
  include ApplicationHelper

  def find_buddy_tester(team_id)
    users = User.where(buddy: true, team_id: team_id)

    if users.count > 0
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
    else
      %Q({
        "type": "message",
        "text": "<h1>Buddy List</h1>\n\n
        No Buddy Tester added yet."
      })
    end
  end

  def add_buddy(team_id, mentioned_user)
    ActiveRecord::Base.transaction do
      user = User.where(user_id: mentioned_user[:id], name: mentioned_user[:name], team_id: team_id).first_or_create!()
      user.toggle!(:buddy)

      buddy_user = {
        id: user[:user_id],
        name: user[:name],
      }

      %Q({
        "type": "message",
        "text": "<at>#{buddy_user[:name]}</at> added as a buddy",
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
    end
  end

  def remove_buddy(team_id, mentioned_user)
    ActiveRecord::Base.transaction do
      user = User.where(user_id: mentioned_user[:id], name: mentioned_user[:name], team_id: team_id).first_or_create!()
      user.toggle!(:buddy)

      buddy_user = {
        id: user[:user_id],
        name: user[:name],
      }

      %Q({
        "type": "message",
        "text": "<at>#{buddy_user[:name]}</at> removed as a buddy",
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
    end
  end

  def buddy_list(team_id)
    buddy_users = User.where(buddy: true, team_id: team_id)

    if buddy_users.count > 0
      buddy_users.each_with_index do | buddy_user, index |
        stringyfied_buddy_users << "\n #{index.to_i + 1} #{buddy_user[:name]}"
      end

      %Q({
        "type": "message",
        "text": "<h1>Buddy List</h1>\n\n
        #{stringyfied_buddy_users}"
      })
    else
      %Q({
        "type": "message",
        "text": "<h1>Buddy List</h1>\n\n
        No Buddy Tester added yet."
      })
    end
  end
end
