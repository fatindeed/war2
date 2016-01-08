local g_MainMenu_Main = {}	
local g_MainMenuBar_Visible = true

local HIDE_BUTTON_GETMORE = 1 					 -- ���ػ�ø���ƽ̨�ҵİ��� 

function	MainMenu_PreLoad()
	this:RegisterEvent("MAIN_MENU_LOAD")
end

function	MainMenu_OnLoad()
	g_MainMenu_Main[1] = MainMenu_LeftWindow	   -- ѡ����˵�����			
	g_MainMenu_Main[2] = MainMenu_Switch_Button    -- ������˵�����ͼƬ
	g_MainMenu_Main[3] = MainMenu_TopWindow	   	   --ѡ���Ҳ˵�����			
end

function	MainMenu_OnEvent(event)
	if ( event == "MAIN_MENU_LOAD" ) then		
		this:Show()

		PushEvent("MAIN_BUTTON_LOAD")
	end
end

--=============================================
--				�ƶ�����UI����
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
--				����ѡ�����
--=============================================
function	MainMenu_Build()
	CloseAllWidget()
	PushEvent("BUILD_CHOOSE_LOAD")
	PushEvent("RESOURCE_BAR_LOAD")	
end

--=============================================
--				�ƶ���������
--=============================================
function	MainMenu_Move()
	CloseAllWidget()
	PushEvent("MOVE_LOAD")
	Move_State(true)
end

--=============================================
--				���½���
--=============================================
function	MainMenu_Arrmy()
	CloseAllWidget()
	PushEvent("ARRMY_LOAD")
end

--=============================================
--				���ý���
--=============================================
function	MainMenu_System()
	-- CloseAllWidget()
	PushEvent("SYSTEM_LOAD")
end

--=============================================
--				�������
--=============================================
function	MainMenu_ClickWorld()
  --  PushEvent("SCENESWITCH_CLOSE")
    PushEvent("SCENESWITCH_CLOSE")
	--PushEvent("WORLDPLAYER_LOAD")
	
end

--=============================================
--				�ؿ�����
--=============================================
function	MainMenu_Mission()
	OpenRequestWaitProgress()		
	
	CloseAllWidget()
	
	--���ʹ򿪸���������Ϣ
	ClearScript()
	SetFunction("OnDefaultEvent")
	SetScriptID(100501)
	SendScript()	
	
	AskSoliderList()	
end

--=============================================
--					��������
--=============================================
function	MainMenu_OnHelpEvent()
	local bNewPlayer = Player:GetIsNewPlayer()
	if tonumber(bNewPlayer) == 1 then
		return 
	end	
	PushEvent("HELP_LOAD")
end
