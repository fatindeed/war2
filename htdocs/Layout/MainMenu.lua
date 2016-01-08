local g_MainMenu_Main = {}	
local g_MainMenuBar_Visible = true

local HIDE_BUTTON_GETMORE = 1 					 -- 隐藏获得更多平台币的按键 

function	MainMenu_PreLoad()
	this:RegisterEvent("MAIN_MENU_LOAD")
end

function	MainMenu_OnLoad()
	g_MainMenu_Main[1] = MainMenu_LeftWindow	   -- 选项左菜单窗口			
	g_MainMenu_Main[2] = MainMenu_Switch_Button    -- 主界面菜单开关图片
	g_MainMenu_Main[3] = MainMenu_TopWindow	   	   --选项右菜单窗口			
end

function	MainMenu_OnEvent(event)
	if ( event == "MAIN_MENU_LOAD" ) then		
		this:Show()

		PushEvent("MAIN_BUTTON_LOAD")
	end
end

--=============================================
--				移动整个UI界面
--=============================================
function	MainMenu_MoveMenu()
	if (g_MainMenu_Main[1]:NumberOfRunningActions() ~= 0 and g_MainMenu_Main[3]:NumberOfRunningActions() ~= 0) then
		return 	
	end
	if g_MainMenuBar_Visible == true then	
		g_MainMenuBar_Visible = false		

		g_MainMenu_Main[2]:SetNormal9PatchImg("uiicon_out1.png")
		g_MainMenu_Main[2]:SetSelect9PatchImg("uiicon_out1.png")
		g_MainMenu_Main[1]:MoveTo(0.2, 350, 0)
		g_MainMenu_Main[3]:MoveBy(0, -430, 0.2, false)
	elseif g_MainMenuBar_Visible == false then
		g_MainMenuBar_Visible = true		

		g_MainMenu_Main[2]:SetNormal9PatchImg("uiicon_out2.png")
		g_MainMenu_Main[2]:SetSelect9PatchImg("uiicon_out2.png")
		g_MainMenu_Main[1]:MoveTo(0.2, 0, 0)
		g_MainMenu_Main[3]:MoveBy(0, 430, 0.2, false)
	end
end

--=============================================
--				建筑选择界面
--=============================================
function	MainMenu_Build()
	CloseAllWidget()
	PushEvent("BUILD_CHOOSE_LOAD")
	PushEvent("RESOURCE_BAR_LOAD")	
end

--=============================================
--				移动建筑界面
--=============================================
function	MainMenu_Move()
	CloseAllWidget()
	PushEvent("MOVE_LOAD")
	Move_State(true)
end

--=============================================
--				军事界面
--=============================================
function	MainMenu_Arrmy()
	CloseAllWidget()
	PushEvent("ARRMY_LOAD")
end

--=============================================
--				设置界面
--=============================================
function	MainMenu_System()
	-- CloseAllWidget()
	PushEvent("SYSTEM_LOAD")
end

--=============================================
--				世界界面
--=============================================
function	MainMenu_ClickWorld()
  --  PushEvent("SCENESWITCH_CLOSE")
    PushEvent("SCENESWITCH_CLOSE")
	--PushEvent("WORLDPLAYER_LOAD")
	
end

--=============================================
--				关卡界面
--=============================================
function	MainMenu_Mission()
	OpenRequestWaitProgress()		
	
	CloseAllWidget()
	
	--发送打开副本界面消息
	ClearScript()
	SetFunction("OnDefaultEvent")
	SetScriptID(100501)
	SendScript()	
	
	AskSoliderList()	
end

--=============================================
--					帮助界面
--=============================================
function	MainMenu_OnHelpEvent()
	local bNewPlayer = Player:GetIsNewPlayer()
	if tonumber(bNewPlayer) == 1 then
		return 
	end	
	PushEvent("HELP_LOAD")
end
