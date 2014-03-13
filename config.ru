require "rubygems"

require "rack"
require "json"


def update_with_commit_for_lang(commit, language)
  system "LANG=#{language} COMMIT=#{commit} ./update-git.sh"
end

def deal_with_payload(payload)
  commit = payload["commits"].first["id"]
  language = payload["repository"]["name"][-2,2].downcase
  ref = payload["ref"]
  
  
  if (ref == 'refs/heads/master')
    update_with_commit_for_lang(commit, language)
  end
end

run lambda { |env|
  req = Rack::Request.new(env)
  
  # this is not set if we get simple "ping" request
  if (req['payload'])
    deal_with_payload(JSON.parse(req['payload']))

  [
    200,
    {
    },
    ["woo"]
  ]
}