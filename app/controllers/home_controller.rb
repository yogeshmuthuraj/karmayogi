class HomeController < ApplicationController

  require 'openssl'
  require 'Base64'

  def index
  end

  def leaderboard
  end

  def service
    # now st: wSg5K8wLhk1OFHi1GddsfGJ5XtC1B6+yEi+V82wUVqk=
    team_id = params[:channelData][:teamsTeamId]

    if Team.exists?(team_id: team_id)
      p 'in ifTeam.exists?(team_id: team_id)'
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
      received_msg = ActionController::Base.helpers.strip_tags(params[:text]).gsub(/\R+/, '').split(' ')

      p 'received_msg'
      p received_msg[1]

      # TODO: Change to switch
      if received_msg[1] == 'leaderboard'
        p 'params[:text]'
        p params[:text]
      else
        mentioned_name = params[:entities][0][:mentioned][:name]
        # Whether ++ or --
        charge = ActionController::Base.helpers.strip_tags(params[:text]).gsub(/\R+/, '').split(mentioned_name)[1]

        p 'charge'
        p charge
      end

      response_msg = '{ "type": "message", "text": "Error: Team is not registered." }'

      render plain: response_msg
    else
      response_msg = '{ "type": "message", "text": "Error: Team is not registered." }'

      render plain: response_msg
    end
  end
end
