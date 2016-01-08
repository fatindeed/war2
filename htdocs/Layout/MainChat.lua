local g_MainChat_Main = {}
local SYSTEM 	  = 0
local GAMEMANAGER = 1
local PLAYER	  = 2

local g_bool 	  = 0									-- �ж��Ƿ񴥷��˵���¼�

function	MainChat_PreLoad()
	this:RegisterEvent("MAIN_CHAT_LOAD") 				-- ��ʾ���������� 
	this:RegisterEvent("MAIN_ALERT_UPDATE")				-- ��������������
end

function	MainChat_OnLoad()
	g_MainChat_Main[1] = MainChat_ScrollView			-- ���컬����
	g_MainChat_Main[2] = MainChat_TextBox_ListHistory	-- ��������
	g_MainChat_Main[3] = MainChat_Background			-- ���챳��
	g_MainChat_Main[4] = MainChat_Alert_Button			-- �����
	g_MainChat_Main[5] = MainChat_chat_Button			-- ���찴ť

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
-- 				  ��������
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
--				  ˢ������ 
--=========================================
function	MainChat_Update()
	local pNumber = Talk:GetMessageNumber()
	if pNumber < 1 then			----û�������¼
		return ;	
	end

	g_MainChat_Main[1]:CleanAllElement()
	
	local x,y = 2,2

	if pNumber > 3 then		-- ��������ʾ3��
		for i = pNumber - 1 ,pNumber - 3 , -1 do 
			local 	pChannel,pName,pRecv = Talk:GetChatMessage(i,35)	--32Ϊ�ַ�����������
			pRecv = g_MainChat_Main[2]:SetChangeChar(pRecv,226)
			local pTip = string.find(pRecv,"\n")	
			if (pTip ~= nil)then	-- ����
				y = y + 16	
			end
			MainChat_Type(pChannel,pName,pRecv,x,y)
			y = y + 16		
		end
		return	
	end	
	
	local X , Y = 2,36
	for i=0,pNumber-1,1 do 
		local 	pChannel,pName,pRecv = Talk:GetChatMessage(i,35)	--32Ϊ�ַ�����������
		pRecv = g_MainChat_Main[2]:SetChangeChar(pRecv,226)
		MainChat_Type(pChannel,pName,pRecv,X,Y)
		local pTip = string.find(pRecv,"\n")
		if (pTip == nil)then	-- û�л���
			Y = Y - 16
		else					-- ����
			Y = Y - 32	
		end
	end		

end

--=============================================
-- 					����ģ��
--=============================================
function	MainChat_Type(Channel,Name,Recv,x,y)
	if Channel == 1 then
		local length = g_MainChat_Main[1]:AddItemText("["..Name.."] ",x ,y,0,0,"0 228 255",12)
		
		local pTip = string.find(Recv,"\n")
		if (pTip == nil)then	-- û�л���
			g_MainChat_Main[1]:AddItemText(Recv,x + length ,y,0,0,"255 255 255",12)	
		else					-- ����
			g_MainChat_Main[1]:AddItemText(Recv,x + length ,y - 16 ,0,0,"255 255 255",12)
		end
	elseif Channel == 2 then ---ϵͳ��ʾ
		local length = g_MainChat_Main[1]:AddItemText("["..Name.."] ",x ,y,0,0,"255 228 0",12)
		
		local pTip = string.find(Recv,"\n")
		if (pTip == nil)then	-- û�л���
			g_MainChat_Main[1]:AddItemText(Recv,x + length ,y,0,0,"255 228 0",12)	
		else					-- ����
			g_MainChat_Main[1]:AddItemText(Recv,x + length ,y - 16 ,0,0,"255 228 0",12)
		end
	end
end

--==========================================
--	 �ڴ��ڵȴ�����֮���Ƿ񴥷��˵���¼�
--==========================================
function	MainChat_Time_Show()		
	if(g_bool == 1) then 				
		return 	
	elseif(g_bool == 0) then
		g_MainChat_Main[4]:Hide()
		-- g_MainChat_Main[5]:Show()
	end
end