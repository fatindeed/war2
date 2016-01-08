local g_Move_Main = {}	
function	Move_PreLoad()
	this:RegisterEvent("MOVE_LOAD")
	this:RegisterEvent("MOVE_UNLOAD")
end

function	Move_OnLoad()
	g_Move_Main[1] = Move_Content			---�ƶ���ʾ����
	g_Move_Main[2] = Move_MoveFinisn_Text	--��ɰ����ı���
end

function	Move_OnEvent(event)
	if ( event == "MOVE_LOAD" ) then
		this:Show()
		g_Move_Main[1]:SetText("#{TXSS_2000_015}")
		g_Move_Main[2]:SetText("#{TXSS_1000_065}")
	elseif event == "MOVE_UNLOAD" then
		this:Hide()
	end
end

--*****************************************
--				�ƶ����
--*****************************************
function	Move_MoveFinish()
	CloseAllWidget()
	PushEvent("MAIN_MENU_LOAD")
	PushEvent("RESOURCE_BAR_LOAD")
	PushEvent("PORTRAIT_LEFT_LOAD")
	PushEvent("TASK_LIST_LOAD")
	PushEvent("MAIN_CHAT_LOAD")	
	Move_State(false)
end