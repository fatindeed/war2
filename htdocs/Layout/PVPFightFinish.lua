local g_FightFinish_ImageBox = {}
local g_FightFinish_TextBox = {}
local g_FightFinish_Main = {}

local TRUE  = 1
local FALSE = 0

function	PVPFightFinish_PreLoad()
	this:RegisterEvent("PVP_FIGHT_FINISH_LOAD")
end

function	PVPFightFinish_OnLoad()
	g_FightFinish_TextBox[1]  = PVPFightFinish_ScoreDesc_Text  		  -- 积分变化描述文本
	g_FightFinish_TextBox[2]  = PVPFightFinish_Tip_Label			  --【点击任意位置退出】文本	
	g_FightFinish_TextBox[3]  = PVPFightFinish_Score_Text			  -- 积分变化文本
	
	g_FightFinish_ImageBox[1] = PVPFightFinish_Light				  -- 闪光背景
	g_FightFinish_ImageBox[2] = PVPFightFinish_Title				  -- 标题
end

--窗口事件
function	PVPFightFinish_OnEvent(event)
	if(event=="PVP_FIGHT_FINISH_LOAD")then		
		this:Show()

	    local bSuccess ,nFlag = DataPool:GetFightSuccess()		
		
		PVPFightFinish_ShowFlashLight(bSuccess)		
		
	    PVPFightFinish_InitTitle(bSuccess)
		g_FightFinish_TextBox[1]:SetText("#{UITT_1000_026}")
		g_FightFinish_TextBox[2]:SetText("#{TXSS_1000_081}")		  -- 点击任意位置退出
		
		local count = DataPool:GetFightBonus(0)		
		if(bSuccess == TRUE)then
			g_FightFinish_TextBox[3]:SetColor("0 255 0")		
			g_FightFinish_TextBox[3]:SetText("+" .. tostring(count))
		else 
			g_FightFinish_TextBox[3]:SetColor("255 0 0")
			g_FightFinish_TextBox[3]:SetText(tostring(count))			
		end	

	end	
end

--初始化标题
function  PVPFightFinish_InitTitle(bSuccess)
	if (bSuccess == TRUE) then
		g_FightFinish_ImageBox[2]:SetAtlasTexture("uitt_shengli.png")
	elseif (bSuccess == FALSE)then	
		g_FightFinish_ImageBox[2]:SetAtlasTexture("uitt_shibai.png")
	end
end

--显示闪光背景
function PVPFightFinish_ShowFlashLight(bSuccess)
	if (bSuccess == TRUE) then
		g_FightFinish_ImageBox[1]:Show()

		g_FightFinish_ImageBox[1]:StartRotation(1, 180, true)
	else 
		g_FightFinish_ImageBox[1]:Hide()
	end
end

--===================================================
--					确定按键事件
--===================================================
function PVPFightFinish_OnClick()
	
	CloseAllWidget()
	
	PushEvent("LOADINGWIDGET_LOAD")
	--PushEvent("SCENESWITCH_OPEN")
	local scriptID = DataPool:GetFightScript()
	if scriptID ~= -1 then
		ClearScript()
		SetFunction("OnGoHome")
		SetScriptID(scriptID)
		SendScript()
	end
	
	SendCombatBalance()	
end

