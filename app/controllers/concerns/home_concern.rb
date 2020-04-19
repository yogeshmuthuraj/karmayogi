# frozen_string_literal: true

module HomeConcern
  include ApplicationHelper

  def leaderboard(team_id, current_user)
    leaderboard_message = "\n\n<h1>Leaderboard</h1>\n\n"
    not_in_board = 'you are not on the board yet, he he.'
    current_user_in_board = User.exists?(team_id: team_id, user_id: current_user[:id])

    leaders = User.where(team_id: team_id).order('karma DESC')
    table = print_table_as_preformatted leaders, [:name, :karma]

    position = current_user_in_board ? leaders.map(&:user_id).index(current_user[:id]) : not_in_board
    position = "your position: #{position + 1}" if current_user_in_board

    if leaders.count != 0
      top_user_record = leaders.order('karma DESC').first
      top_user = {
        id: top_user_record[:user_id],
        name: top_user_record[:name],
      }

      top_user_message = "\n\nHey <at>#{top_user[:name]}</at> you are at the top.\n\n"
      current_user_message = "\n\n<at>#{current_user[:name]}</at> #{position}.\n\n"

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
    %Q({
      "type": "message",
      "text": "<h1>karmayogi</h1>\n\n
      1. Adding karma(points): @karmayogi @user++
      2. Removing karma(points): @karmayogi @user--
      3. Leaderboard for the team: @karmayogi leaderboard
      4. Get random joke: @karmayogi jokeme
      5. Find buddy tester: @karmayogi findbuddy
      6. Help: @karmayogi help"
    })
  end

  def decide_karma(current_user, mentioned_user, charge, team_id)
    if charge.match?('\+\+')
      add_karma(current_user, mentioned_user, team_id)
    elsif charge.match?('\-\-')
      remove_karma(current_user, mentioned_user, team_id)
    else
      %Q({ "type": "message", "text": "Error: Some problem, try again!" })
    end
  end

  def find_buddy_tester(team_id)
    engineers = File.readlines('app/assets/files/associates.txt', chomp: true)

    buddy_tester = engineers[rand(0..engineers.length - 1)]

    p 'buddy_tester'
    p buddy_tester

    buddy_user = User.where(name: buddy_user, team_id: team_id)

    p 'buddy_user'
    p buddy_user
    p buddy_user.first

    buddy_user = {
      id: buddy_user.first[:user_id],
      name: buddy_user.first[:name],
    }

    %Q({
      "type": "message",
      "text": "Your buddy tester is <at>#{buddy_user}</at>"
      "entities": [
        {
          "type": "mention",
          "mentioned":
            {
              "id": "#{buddy_user[:id]}",
              "name": "#{buddy_user[:name]}",
            },
          "text": "<at>#{buddy_user[:name]}</at>",
        }
      }
    })
  end
end

def add_karma(current_user, mentioned_user, team_id)
  ActiveRecord::Base.transaction do
    user = User.where(user_id: mentioned_user[:id], name: mentioned_user[:name], team_id: team_id).first_or_create!()
    user.increment!(:karma)
    karma = user.karma
    positive_messages = Message.where(positive: true)
    message = positive_messages.find(positive_messages.ids.shuffle.first)

    %Q({ "type": "message", "text": "Karma: #{karma}. #{message[:text]}" })
  end
rescue ActiveRecord::RecordNotFound
  %Q({ "type": "message", "text": "Error: Sorry, karmayogi is experiencing a problem, try again!" })
end

def remove_karma(current_user, mentioned_user, team_id)
  ActiveRecord::Base.transaction do
    user = User.where(user_id: mentioned_user[:id], name: mentioned_user[:name], team_id: team_id).first_or_create!()
    user.decrement!(:karma)
    karma = user.karma
    negative_messages = Message.where(positive: false)
    message = negative_messages.find(negative_messages.ids.shuffle.first)

    %Q({ "type": "message", "text": "Karma: #{karma}. #{message[:text]}" })
  end
rescue ActiveRecord::RecordNotFound
  %Q({ "type": "message", "text": "Error: Sorry, karmayogi is experiencing a problem, try again!" })
end
