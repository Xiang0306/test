{
	"events"=>[
		{
			#replyToken：是我們要回覆訊息時必須傳回的值，他代表收件者以及你的回覆權。
			"replyToken"=>"00000000000000000000000000000000",
			#type：通知類型，這是一則訊息 
			"type"=>"message", 
			#timestamp：傳送時間，我們通常會忽略他
			"timestamp"=>1530785803256, 
			#source：發信者
			"source"=>{
				"type"=>"user", 
				"userId"=>"Udeadbeefdeadbeefdeadbeefdeadbeef"
			}, 
			#message：訊息內容
			"message"=>{
				"id"=>"100001", 
				"type"=>"text",
				"text"=>"Hello, world"
			}
		}, 
		{
			"replyToken"=>"ffffffffffffffffffffffffffffffff", 
			"type"=>"message", 
			"timestamp"=>1530785803256, 
			"source"=>{
				"type"=>"user", 
				"userId"=>"Udeadbeefdeadbeefdeadbeefdeadbeef"
			}, 
			"message"=>{
				"id"=>"100002", 
				"type"=>"sticker", 
				"packageId"=>"1", 
				"stickerId"=>"1"
			}
		}
	], 
	"kamigo"=>{
		"events"=>[
			{
				"replyToken"=>"00000000000000000000000000000000", 
				"type"=>"message", 
				"timestamp"=>1530785803256, 
				"source"=>{
					"type"=>"user", 
					"userId"=>"Udeadbeefdeadbeefdeadbeefdeadbeef"
				}, 
				"message"=>{
					"id"=>"100001",
					"type"=>"text", 
					"text"=>"Hello, world"
				}
			}, 
			{
				"replyToken"=>"ffffffffffffffffffffffffffffffff", 
				"type"=>"message", 
				"timestamp"=>1530785803256, 
				"source"=>{
					"type"=>"user", 
					"userId"=>"Udeadbeefdeadbeefdeadbeefdeadbeef"
				}, 
				"message"=>{
					"id"=>"100002", 
					"type"=>"sticker", 
					"packageId"=>"1", 
					"stickerId"=>"1"
				}
			}
		]
	}
}
{"events"=>[{"type"=>"message", 
	"replyToken"=>"243a9f7b409742e7b2ad4c519aa16169", 
	"source"=>{"userId"=>"U379b2293730ff9b88f25d7c1374327d5", 
		"type"=>"user"}, 
		"timestamp"=>1530786754455, 
		"message"=>{"type"=>"text", 
			"id"=>"8217561825876", "text"=>"hihi"}}], 
			"kamigo"=>
			{
				"events"=>[
					{
						"type"=>"message", 
						"replyToken"=>"243a9f7b409742e7b2ad4c519aa16169", 
						"source"=>{
							"userId"=>"U379b2293730ff9b88f25d7c1374327d5", 
							"type"=>"user"
						}, 
						"timestamp"=>1530786754455, 
						"message"=>{
							"type"=>"text", 
							"id"=>"8217561825876", 
							"text"=>"hihi"
						}
					}
				]
			}
		}