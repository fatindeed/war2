local g_ChatAlert_Main = {}
local SYSTEM 	  = 0
local GAMEMANAGER = 1
local PLAYER	  = 2
local Limit		  = 5 ---提交时限 10 秒
local CanSumit = true
function	ChatAlert_PreLoad()
	this:RegisterEvent("CHAT_ALERT_LOAD") 	-- 显示聊天主界面 
	this:RegisterEvent("CHAT_ALERT_UPDATE")	-- 更新聊天主界面
	this:RegisterEvent("CHAT_HISTORY_UPDATE")--打开聊天界面查看历史信息
end

function	ChatAlert_OnLoad()
	g_ChatAlert_Main[1] = ChatAlert_ScrollView			-- 聊天滑动框
	g_ChatAlert_Main[2] = ChatAlert_TextBox_ListHistory	-- 显示内容
	g_ChatAlert_Main[3] = ChatAlert_Input_Box_Text		-- 聊天输入框
	g_ChatAlert_Main[4] = ChatAlert_Enter
	g_ChatAlert_Main[5] = ChatAlert_Time_Mich			-- 定时器
	g_ChatAlert_Main[6] = ChatAlert_Text				-- 标题
end

function	ChatAlert_OnEvent(event)

	if event == "CHAT_ALERT_LOAD" then
	
		--显示窗口
		this:Show()
		g_ChatAlert_Main[6]:SetText("#{CHAT_1000_003}")	
		
		g_ChatAlert_Main[2]:SetText("")
		--设置保存最大聊天记录
		Talk:SetMaxSaveNumber(16)
		
		--读取历史聊天记录
		Talk:InsertHistory()
		g_CharAlert_Main[1]:Touch(-1)
		
	elseif (event == "CHAT_ALERT_UPDATE") then
		ChatAlert_HistoryUpdate()
	elseif(event == "CHAT_HISTORY_UPDATE")then
		ChatAlert_HistoryUpdate()
	end
	
end

---------------------刷新数据--------------------
function	ChatAlert_Update(chatContent)
		
	ChatAlert_HistoryUpdate()

end

---------------------更新历史信息--------------------
function	ChatAlert_HistoryUpdate()	
	local pNumber = Talk:GetMessageNumber()
	if pNumber < 1 then			----没有聊天记录
		return ;	
	end
	local x,y = 2,14
	g_ChatAlert_Main[1]:CleanAllElement()
	if pNumber > 12 then
		for i = pNumber - 1 ,pNumber - 13 ,-1 do 
			local 	pChannel,pName,pRecv = Talk:GetChatMessage(i,80)
			pRecv = g_ChatAlert_Main[2]:SetChangeChar(pRecv,600)
			local pTip = string.find(pRecv,"\n")
			if (pTip ~=nil)then
				y = y + 22
			end	
			ChatAlert_Templete(pChannel,pName,pRecv,x,y)
			y = y + 22			
		end		
		return
	end
	
	local X,Y = 2,280
	for i=0,pNumber-1,1 do 
		local 	pChannel,pName,pRecv = Talk:GetChatMessage(i,80)

		pRecv = g_ChatAlert_Main[2]:SetChangeChar(pRecv,600)
		ChatAlert_Templete(pChannel,pName,pRecv,X,Y)
		local pTip = string.find(pRecv,"\n")
		if (pTip ~=nil)then
			Y = Y - 22
		end	
		Y = Y - 25
	end
	
end

--------------------世界聊天----------------------
function	ChatAlert_World()
	
end

---------------------发送聊天内容----------------
function	ChatAlert_OnEnter()
	local mContent = g_ChatAlert_Main[3]:GetText()
	local filterStr=FilterKeyWordsStar(tostring(mContent))
	if mContent ~= "" then
		if CanSumit == true then
		    local isForbid=Player:GetForbid()
			if isForbid==1 then				
			Talk:DelatlyMessage("#{CHAT_1000_004}","#{TXSS_1000_102}")
			return 
		    end
			Talk:SendChatMessage("world",filterStr)
			CanSumit = false
			g_ChatAlert_Main[5]:StartTime(Limit, 0, 1, 1)
			g_ChatAlert_Main[3]:InitText()
		elseif CanSumit == false then
			Talk:DelatlyMessage("#{CHAT_1000_004}","#{TXSS_2000_052}")
		end
	end
end

-------------------聊天发送限制>>>>>>>>>>>>
function	ChatAlert_SumbitLimit()
	CanSumit = true	--- 可以再次发送内容
end

-------------------刷新模板>>>>>>>>>>>>>>>>>>>>>>>
function	ChatAlert_Templete(Channel,Name,Recv,x,y)
		if Channel == 1 then --- 玩家世界聊天 
			local length = g_ChatAlert_Main[1]:AddItemText("["..Name.."] ",x ,y,0,0,"0 228 255",18)
		
			local pTip = string.find(Recv,"\n")
			if (pTip == nil)then	-- 没有换行
				g_ChatAlert_Main[1]:AddItemText(Recv,x + length ,y,0,0,"255 255 255",18)	
			else					-- 换行
				g_ChatAlert_Main[1]:AddItemText(Recv,x + length ,y - 22 ,0,0,"255 255 255",18)
			end
		elseif Channel == 2 then
			local length = g_ChatAlert_Main[1]:AddItemText("["..Name.."] ",x ,y,0,0,"255 228 0",18)
		
			local pTip = string.find(Recv,"\n")
			if (pTip == nil)then	-- 没有换行
				g_ChatAlert_Main[1]:AddItemText(Recv,x + length ,y,0,0,"255 228 0",18)	
			else					-- 换行
				g_ChatAlert_Main[1]:AddItemText(Recv,x + length ,y - 22 ,0,0,"255 228 0",18)
			end
		end
end

--------------------关闭事件---------------------
function	ChatAlert_Close()
	g_ChatAlert_Main[2]:SetText("")
	this:Hide()
	PushEvent("MAIN_MENU_LOAD")
	PushEvent("RESOURCE_BAR_LOAD")
	PushEvent("PORTRAIT_LEFT_LOAD")
	PushEvent("TASK_LIST_LOAD")
	PushEvent("MAIN_CHAT_LOAD")
end 