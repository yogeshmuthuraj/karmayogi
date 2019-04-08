class HomeController < ApplicationController

  require 'openssl'
  require 'Base64'

  def index
  end

  def service
    # now st: wSg5K8wLhk1OFHi1GddsfGJ5XtC1B6+yEi+V82wUVqk=
    team_id = params[:channelData][:teamsTeamId]

    if Team.exists?(team_id: team_id)
      p 'request.env'
      p request.env['HTTP_AUTHORIZATION']

      key = 'SwahCt15L2rZyKpaBVNOUgubN4veD8A8xCGKylr+NDg='
      data = request.env.inspect.encode("iso-8859-1").force_encoding("utf-8")
      digest = OpenSSL::Digest.new('sha256')

      p 'digest gen'
      p digest

      p 'digest'
      p OpenSSL::HMAC.digest(digest, key, data)
      #=> "\xDE|\x9B\x85\xB8\xB7\x8A\xA6\xBC\x8Az6\xF7\n\x90p\x1C\x9D\xB4\xD9"
      p 'hexp digest'
      p OpenSSL::HMAC.hexdigest(digest, key, data)
      #=> "de7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9"


      responseMsg = '{ "type": "message", "text": "Error: Team is not registered." }'

      render plain: responseMsg
    else
      responseMsg = '{ "type": "message", "text": "Error: Team is not registered." }'

      render plain: responseMsg
    end
  end
end
