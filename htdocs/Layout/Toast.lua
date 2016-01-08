local 	g_Toast_Windows = {}
local	BEGIN = 0
local	MOVED = 1
local	ENDED = 2
local	STATE = 0
function	Toast_PreLoad()
	this:RegisterEvent("TOAST_LOAD")						-- 载入窗口
end

function	Toast_OnLoad()
	g_Toast_Windows[1] = Toast_Window
	g_Toast_Windows[2] = Toast_Background
	g_Toast_Windows[3] = Toast_Content_Text
	g_Toast_Windows[4] = Toast_TimeMich
end
------------------------------------------------------------------------------------
--	if you need this page for cpp programe ,like this ->
--	CGameProcedure::s_pEventSystem->PushEvent(GM_TOAST_LOAD,"#{TXSS_2000_048}");
------------------------------------------------------------------------------------
function	Toast_OnEvent(event)
	if event == "TOAST_LOAD" then

		local str = tostring(arg0)
		g_Toast_Windows[3]:SetText(str)
		
		this:Show()
		STATE = BEGIN
		g_Toast_Windows[1]:SetPosition(0,0)
		Toast_FadeIn()
		g_Toast_Windows[4]:StartTime(3, 0, 1, 1)
		
	end
end

function	Toast_Update()
	if STATE == MOVED then
	
		Toast_FadeOut()

		STATE = ENDED
		
	elseif STATE == ENDED then

		this:Hide()
		
		g_Toast_Windows[4]:StopTime()
		
	else
		STATE = MOVED
	end
end

--	UI 淡入
function	Toast_FadeIn()
	
	g_Toast_Windows[1]:MoveTo(0.3,0,65)

	g_Toast_Windows[3]:FadeIn(0.3)

	g_Toast_Windows[2]:FadeIn(0.3)

end

--	UI 淡出
function	Toast_FadeOut()
	
	g_Toast_Windows[1]:MoveTo(0.3,0,130)
	
	g_Toast_Windows[3]:FadeOut(0.3)

	g_Toast_Windows[2]:FadeOut(0.3)
end