local g_MainChat_Main = {}
local SYSTEM 	  = 0
local GAMEMANAGER = 1
local PLAYER	  = 2

local g_bool 	  = 0									-- 判断是否触发了点击事件

function	MainChat_PreLoad()
	this:RegisterEvent("MAIN_CHAT_LOAD") 				-- 显示聊天主界面 
	this:RegisterEvent("MAIN_ALERT_UPDATE")				-- 更新聊天主界面
end

function	MainChat_OnLoad()
	g_MainChat_Main[1] = MainChat_ScrollView			-- 聊天滑动框
	g_MainChat_Main[2] = MainChat_TextBox_ListHistory	-- 聊天内容
	g_MainChat_Main[3] = MainChat_Background			-- 聊天背景
	g_MainChat_Main[4] = MainChat_Alert_Button			-- 聊天框
	g_MainChat_Main[5] = MainChat_chat_Button			-- 聊天按钮

end

function	MainChat_OnEvent(event)
	if event == "MAIN_CHAT_LOAD" then
		this:Show()

		Talk:SetMaxSaveNumber(16)	
	elseif event == "MAIN_ALERT_UPDATE" then
		g_bool = 0

		MainChat_Update()
	end
end

--========================================
-- 				  进入聊天
--========================================
function	MainChat_Chat()
	CloseAllWidget()
	PushEvent("CHAT_ALERT_LOAD")
	g_MainChat_Main[4]:StopAction()
	g_bool = 1 
end

--=========================================
--
--=========================================
function	MainChat_ToChat()
	CloseAllWidget()
	PushEvent("CHAT_ALERT_LOAD")
	g_MainChat_Main[4]:StopAction()
	g_bool = 1
end

--=========================================
--				  刷新数据 
--=========================================
function	MainChat_Update()
	local pNumber = Talk:GetMessageNumber()
	if pNumber < 1 then			----没有聊天记录
		return ;	
	end

	g_MainChat_Main[1]:CleanAllElement()
	
	local x,y = 2,2

	if pNumber > 3 then		-- 主界面显示3条
		for i = pNumber - 1 ,pNumber - 3 , -1 do 
			local 	pChannel,pName,pRecv = Talk:GetChatMessage(i,35)	--32为字符串长度限制
			pRecv = g_MainChat_Main[2]:SetChangeChar(pRecv,226)
			local pTip = string.find(pRecv,"\n")	
			if (pTip ~= nil)then	-- 换行
				y = y + 16	
			end
			MainChat_Type(pChannel,pName,pRecv,x,y)
			y = y + 16		
		end
		return	
	end	
	
	local X , Y = 2,36
	for i=0,pNumber-1,1 do 
		local 	pChannel,pName,pRecv = Talk:GetChatMessage(i,35)	--32为字符串长度限制
		pRecv = g_MainChat_Main[2]:SetChangeChar(pRecv,226)
		MainChat_Type(pChannel,pName,pRecv,X,Y)
		local pTip = string.find(pRecv,"\n")
		if (pTip == nil)then	-- 没有换行
			Y = Y - 16
		else					-- 换行
			Y = Y - 32	
		end
	end		

end

--=============================================
-- 					聊天模板
--=============================================
function	MainChat_Type(Channel,Name,Recv,x,y)
	if Channel == 1 then
		local length = g_MainChat_Main[1]:AddItemText("["..Name.."] ",x ,y,0,0,"0 228 255",12)
		
		local pTip = string.find(Recv,"\n")
		if (pTip == nil)then	-- 没有换行
			g_MainChat_Main[1]:AddItemText(Recv,x + length ,y,0,0,"255 255 255",12)	
		else					-- 换行
			g_MainChat_Main[1]:AddItemText(Recv,x + length ,y - 16 ,0,0,"255 255 255",12)
		end
	elseif Channel == 2 then ---系统提示
		local length = g_MainChat_Main[1]:AddItemText("["..Name.."] ",x ,y,0,0,"255 228 0",12)
		
		local pTip = string.find(Recv,"\n")
		if (pTip == nil)then	-- 没有换行
			g_MainChat_Main[1]:AddItemText(Recv,x + length ,y,0,0,"255 228 0",12)	
		else					-- 换行
			g_MainChat_Main[1]:AddItemText(Recv,x + length ,y - 16 ,0,0,"255 228 0",12)
		end
	end
end

--==========================================
--	 在窗口等待秒数之内是否触发了点击事件
--==========================================
function	MainChat_Time_Show()		
	if(g_bool == 1) then 				
		return 	
	elseif(g_bool == 0) then
		g_MainChat_Main[4]:Hide()
		-- g_MainChat_Main[5]:Show()
	end
end