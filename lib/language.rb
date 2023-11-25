# Google Cloud Natural Language APIを呼ぶためのライブラリを作成
require 'base64'
require 'json'
require 'net/https'

module Language
  class << self
    def get_data(text)
      # APIのURL作成
      api_url = "https://language.googleapis.com/v1/documents:analyzeSentiment?key=#{ENV.fetch('GOOGLE_API_KEY', nil)}"
      # APIリクエスト用のJSONパラメータ
      params = {
        document: {
          type: 'PLAIN_TEXT',
          content: text
        }
      }.to_json
      # Google Cloud Natural Language APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      # APIレスポンス出力
      response_body = JSON.parse(response.body)
      raise error['message'] if (error = response_body['error']).present?

      response_body['documentSentiment']['score']
    end
  end
end
