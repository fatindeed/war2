
local g_MoveMenu_Main = {}	

local g_nBuildingSellPrice = {90, 150, 240, 60, 150, 300, 150, 6000, 150, 1500, 30, 15000, 6000, 30000, 6000}

function	MoveMenu_PreLoad()
	this:RegisterEvent("MOVE_MENU_LOAD")			  -- ����(��ʾ)
	this:RegisterEvent("MOVE_MENU_UNLOAD")			  -- �������(����)
	this:RegisterEvent("MOVE_MENU_DESTORY_OK")		  -- ����OK��ť
	this:RegisterEvent("MOVE_MENU_DESTORY_SELL")	  -- ���ó��۰�ť
	this:RegisterEvent("MOVE_MENU_USE_OK")			  -- ȡ��OK��ť�Ľ���
	this:RegisterEvent("MOVE_MENU_USE_SELL")		  -- ȡ��������ť�Ľ���
	this:RegisterEvent("MOVE_MENU_TO_MAIN")			  -- �ص�������
	this:RegisterEvent("MOVE_MENU_MOVE_BUILD")		  -- �ƶ�����
	this:RegisterEvent("MOVE_MENU_UPDATE")			  -- �ƶ��˵��������
end

function	MoveMenu_OnLoad()
	g_MoveMenu_Main[1] = MoveMenu_Background		  -- ����ͼ
	g_MoveMenu_Main[2] = MoveMenu_OnCancel			  -- ȡ����ť
	g_MoveMenu_Main[3] = MoveMenu_OnSell			  -- ���۰�ť
	g_MoveMenu_Main[4] = MoveMenu_OnOk				  -- ȷ�ϰ�ť
end

function	MoveMenu_OnEvent(event)
	if  event == "MOVE_MENU_LOAD"  then
		if arg0 ~= nil and arg1 ~= nil then
--=========================================
--				���콨����ʱ��
--=========================================
			this:Show()
			arg0 = tonumber(arg0)
			arg1 = tonumber(arg1)
			this:SetPosition(arg0 - 93, arg1 - 75)
		end
	elseif event == "MOVE_MENU_MOVE_BUILD" then
		if arg0 ~= nil and arg1 ~= nil then
--=========================================
--				�ƶ�������ʱ��
--				2013��5��21��	�޸�:���ܳ��۱�Ӫ
--				log:�޸Ľ�����Ϣ���ʱ��һ��Ҫ�޸��������
--=========================================
			this:Show()
			--g_MoveMenu_Main[2]:SetPosition(5,0)
			g_MoveMenu_Main[3]:Show()
			--g_MoveMenu_Main[4]:SetPosition(115,0)
			arg0 = tonumber(arg0)
			arg1 = tonumber(arg1)
			this:SetPosition(arg0 - 93, arg1 - 75)
			
			--local buildID = BuildData:GetMainTargetBuildState("MainTargetBuild_ID")
			--if( buildID == 10 ) then	-- {ҽԺ����Դ������} ��ֹ����			
			--	PushEvent("MOVE_MENU_DESTORY_SELL")			
			--end
		end	
	elseif event == "MOVE_MENU_UNLOAD" then 		
--=========================================
--				���ز˵���ʱ��
--=========================================
			--CloseAllWidget()
			this:Hide()
	elseif event == "MOVE_MENU_DESTORY_OK" then
--=========================================
--				�����ύ��ť
--=========================================
			g_MoveMenu_Main[4]:DestoryButton()
	elseif event == "MOVE_MENU_DESTORY_SELL" then
--=========================================
--				���ó��۰�ť
--=========================================
			g_MoveMenu_Main[3]:DestoryButton()
	elseif event == "MOVE_MENU_USE_OK" then
--=========================================
--				ȡ��ȷ������
--=========================================
			g_MoveMenu_Main[4]:UNDestoryButton()
	elseif event == "MOVE_MENU_USE_SELL" then
--=========================================
--				ȡ����������
--=========================================
			g_MoveMenu_Main[3]:UNDestoryButton()			
	elseif event == "MOVE_MENU_TO_MAIN" then
--=========================================
--				�ص�������
--=========================================
			--CloseAllWidget()
			PushEvent("MAIN_MENU_LOAD")
			PushEvent("RESOURCE_BAR_LOAD")
			PushEvent("PORTRAIT_LEFT_LOAD")
			PushEvent("TASK_LIST_LOAD")
			PushEvent("MAIN_CHAT_LOAD")	
	elseif event == "MOVE_MENU_UNLOAD" then 		
	
--=========================================
--				���ز˵���ʱ��
--=========================================
		--CloseAllWidget()
		this:Hide()
	elseif event == "MOVE_MENU_UPDATE" then
	
--=========================================
--				�ƶ��˵��������
--=========================================
		if arg0 ~= nil and arg1 ~= nil then
			local x = tonumber(arg0)
			local y = tonumber(arg1)
			MoveMenu_ResetPos(x, y)
		end
	end
end

--=========================================
--				�ƶ�ȷ��
--=========================================
function	MoveMenu_YES()
	local Index	= BuildData:GetMainTargetBuildState("MainTargetBuild_ID")
	local TYPE  = BuildData:GetMainTargetBuildState("MainTargetBuild_State_ID")
	if TYPE == -1 then
		local g_Ptb = BuildData:GetBuildInfo("Use_Money", Index)
		local mPtb	=	Player:GetDiamond()
		if g_Ptb > 0 then
			if mPtb >= g_Ptb then
				PushEvent("COMMON_TIP_BUY",0,Index)	
			else
				--[[����ƽ̨�Ҳ���--]]	
			end
		else
			PushEvent("MOVE_MENU_UNLOAD")
			Move_OK()	
		end
	else	
		PushEvent("MOVE_MENU_UNLOAD")
		Move_OK()	
	end

end

--=========================================
--				�ƶ�ȡ��
--=========================================
function	MoveMenu_NO()
	this:Hide()
	Move_NO()
end

--=========================================
--					����
--=========================================
function	MoveMenu_Sell()
	--��������Ľ�������Ϊס����
	--��֤����ס��֮������˿��Ƿ� < ��ǰ�����˿�
	local BuildType, BuildIndexID = BuildData:GetMainTargetBuildState("MainTargetBuild_TYPE_ID")
	
	if (BuildType == 0) then -- ��֤��������Ϊס��
		local _,_,personCount,_,_,_ = BuildData:GetHouseInfo(BuildIndexID)	--ס�����ӵ��˿�
		-- ��ǰ�����˿ں�����˿�
		local curPerson, maxPerson = Player:GetPerson()
		
		if (maxPerson - personCount < curPerson) then
			PushMessageBox("#{TXSS_2000_018}")
			Move_OK()	
			PushEvent("MOVE_LOAD")
			return 
		end	
	end	
	
	PushEvent("COMMON_TIP_TOSELL", g_nBuildingSellPrice[BuildIndexID + 1])
	
	-- this:Hide()	
end

--=========================================
--				  ����λ��
--=========================================
function  MoveMenu_ResetPos(x, y)
	x = x - 93
	y = y - 75
	this:SetPosition(x, y)
end