class KamigoController < ApplicationController
	protect_from_forgery with: :null_session
	
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

	def webhook
    	head :ok
    end 
end
