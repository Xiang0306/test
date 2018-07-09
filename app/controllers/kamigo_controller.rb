require 'line/bot'

class KamigoController < ApplicationController
	protect_from_forgery with: :null_session
	#主程式
	def webhook
	    # 學說話
	    reply_text = learn(channel_id, received_text)

	    # 關鍵字回覆
	    reply_text = keyword_reply(channel_id, received_text) if reply_text.nil?

	    # 推齊
	    reply_text = echo2(channel_id, received_text) if reply_text.nil?

	    # 記錄對話
	    save_to_received(channel_id, received_text)
	    save_to_reply(channel_id, reply_text)

	    # 傳送訊息到 line
	    response = reply_to_line(reply_text)

	    # 回應 200
	    head :ok
	end 

	# 頻道 ID
	def channel_id
	    source = params['events'][0]['source']
	    source['groupId'] || source['roomId'] || source['userId']
	end

	# 儲存對話
	def save_to_received(channel_id, received_text)
	    return if received_text.nil?
	    Received.create(channel_id: channel_id, text: received_text)
	end

	# 儲存回應
	def save_to_reply(channel_id, reply_text)
	    return if reply_text.nil?
	    Reply.create(channel_id: channel_id, text: reply_text)
	end
	  
	def echo2(channel_id, received_text)
	    # 如果在 channel_id 最近沒人講過 received_text，金田醫就不回應
	    recent_received_texts = Received.where(channel_id: channel_id).last(5)&.pluck(:text)
	    return nil unless received_text.in? recent_received_texts
	    
	    # 如果在 channel_id金田醫上一句回應是 received_text，金田醫就不回應
	    last_reply_text = Reply.where(channel_id: channel_id).last&.text
	    return nil if last_reply_text == received_text

	    received_text
	end

	# 取得對方說的話
	def received_text
	    message = params['events'][0]['message']
	    message['text'] unless message.nil?
	end

	# 學說話
	def learn(channel_id, received_text)
	    #如果開頭不是 金田醫學說話; 就跳出
	    return nil unless received_text[0..6] == '金田醫學說話;'
	    
	    received_text = received_text[7..-1]
	    semicolon_index = received_text.index(';')

	    # 找不到分號就跳出
	    return nil if semicolon_index.nil?

	    keyword = received_text[0..semicolon_index-1]
	    message = received_text[semicolon_index+1..-1]

		KeywordMapping.create(channel_id: channel_id, keyword: keyword, message: message)
	end

	# 關鍵字回覆
	def keyword_reply(channel_id, received_text)
	   message = KeywordMapping.where(channel_id: channel_id, keyword: received_text).last&.message
	   return message unless message.nil?
	   KeywordMapping.where(keyword: received_text).last&.message
	end

	# 傳送訊息到 line
	def reply_to_line(reply_text)
	   return nil if reply_text.nil?
	    
	   # 取得 reply token
	   reply_token = params['events'][0]['replyToken']
	    
	   # 設定回覆訊息
	   message = {
	    type: 'text',
	    text: reply_text
	   } 

	   # 傳送訊息
	   line.reply_message(reply_token, message)
	end

	  # Line Bot API 物件初始化
	def line
	    @line ||= Line::Bot::Client.new { |config|
	      config.channel_secret = 'eece025edf10f155d1ffcb5b72b25eb5'
	      config.channel_token = 'fUyIMlig56XW3vw8v2ZMwe0Nsjml2kEr1cbpUXoZbWKWwy2DI7TgvAlX0ccqyZPNWuSCK+DK7gWASFYk0bnqk+ffJ6DLuCnsJXPjkIl2FwOV2nNuKDmQ5D8SN7Pm2CSvmJ/ge0X69WYOZGcAphniKwdB04t89/1O/w1cDnyilFU='
	    }
	end



	def eat
		render plain: "吃土啦"
	end	

	#http://localhost:3000/kamigo/request_headers
	def request_headers
    	render plain: request.headers.to_h.reject{ |key, value|
      		key.include? '.'
    	}.map{ |key, value|
      		"#{key}: #{value}"
    	}.sort.join("\n")
  	end

  	#http://localhost:3000/kamigo/request_body
  	def request_body
	    render plain: request.body
	end

	#http://localhost:3000/kamigo/response_headers
	def response_headers
	    response.headers['5566'] = 'QQ'
	    render plain: response.headers.to_h.map{ |key, value|
	      "#{key}: #{value}"
	    }.sort.join("\n")
  	end

  	#puts "xxx"顯示在小黑框上 http://localhost:3000/kamigo/response_body。
  	def show_response_body
    	puts "===這是設定前的response.body:#{response.body}==="
	    render plain: "虎哇花哈哈哈"
	    puts "===這是設定後的response.body:#{response.body}==="
  	end

  	#最簡單能發出 Request 的方法,我們先把網址字串轉換成URI物件,透過 Net::HTTP.get這個方法,他會接受一個網址,然後把Response的Body部分以字串的形式傳回。
  	#http://localhost:3000/kamigo/sent_request
  	def sent_request
  		uri = URI('http://localhost:3000/kamigo/eat')
	    http = Net::HTTP.new(uri.host, uri.port)
	    http_request = Net::HTTP::Get.new(uri)
	    http_response = http.request(http_request)

	    render plain: JSON.pretty_generate({
	      request_class: request.class,
	      response_class: response.class,
	      http_request_class: http_request.class,
	      http_response_class: http_response.class
	    })
	    #uri = URI('http://localhost:3000/kamigo/response_body')
	    #response = Net::HTTP.get(uri).force_encoding("UTF-8") # => String
	    #render plain: translate_to_korean(response)
	end

	def translate_to_korean(message)
	    "#{message}油~"
	end

	
end
