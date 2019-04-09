class HomeController < ApplicationController
  def index
    # Based on format we should change the service end point
    # respond_to do |format|
    #   format.html
    #   format.json service
    # end
  end

  def leaderboard(team_id)
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

  def mentioned(team_id)
    p "team_id: #{team_id}"

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

    p response_msg

    render plain: response_msg
  end

  def tests
    response_msg = '{
      "type": "message",
      "text": "Hey <at>Halder, Tanushree</at> check out this message",
      "attachments": [
        {
          "contentType": "image/png",
          "contentUrl": "https://upload.wikimedia.org/wikipedia/en/a/a6/Bender_Rodriguez.png",
          "name": "Bender_Rodriguez.png"
        }
      ],
    }'

    p response_msg

    render plain: response_msg
  end

  def security
    # TODO check for security token match
    # var payload = '';
    # // Process the request
    # request.on('data', function (data) {
    # 	payload += data;
    # });
    # const bufSecret = Buffer(sharedSecret, "base64");
    # var msgBuf = Buffer.from(payload, 'utf8');
    # "HMAC " + crypto.createHmac('sha256', bufSecret).update(msgBuf).digest("base64");


    # key = 'wSg5K8wLhk1OFHi1GddsfGJ5XtC1B6+yEi+V82wUVqk='
    # data = request.body.read.encode('UTF-8').bytes
    # hash  = OpenSSL::Digest::Digest.new('sha256')
    # calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(hash, key, data)).strip
    #
    # p 'calculated_hmac'
    #
    # p "HMAC #{calculated_hmac}"
    #
    # responseMsg = '{ "type": "message", "text": "Error: Team is not registered." }'
    #
    # render plain: responseMsg
    # p 'HTTP_AUTHORIZATION'
    # p request.env['HTTP_AUTHORIZATION']

    # Remove new line and HTML tags
    # "text"=>"<at>app</at>&nbsp;leaderboard\n"
    # received_msg = ActionController::Base.helpers.strip_tags(params[:text]).gsub(/\R+/, '').split(' ')
  end

  def help
  end

  def mentioned_name(charge)
    if charge == '++'
      response_msg = '{ "type": "message", "text": "Plus one for you" }'
    elsif charge == '--'
      response_msg = '{ "type": "message", "text": "Minus one for you" }'
    else
      response_msg = '{ "type": "message", "text": "Some problem!" }'
    end

    render plain: response_msg
  end

  def service
    team_id = params[:channelData][:teamsTeamId]

    if Team.exists?(team_id: team_id)
      # TODO: Change to switch
      if params[:text].downcase.match?('leaderboard')
        leaderboard(team_id)
      elsif params[:text].downcase.match?('help')
        help
      else
        mentioned_name = params[:entities][0][:mentioned][:name]
        # Whether ++ or --
        charge = ActionController::Base.helpers.strip_tags(params[:text].html_safe[/.*\>(.*?)\n/,1])

        mentioned_name(charge)
      end
    else
      response_msg = '{ "type": "message", "text": "Error: Team is not registered." }'

      render plain: response_msg
    end
  end
end
