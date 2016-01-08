-- 控件列表
local g_Control_Window    = {}


function	OpeningBattleShow_PreLoad()
	this:RegisterEvent("OPENINGBATTLE_LOAD")
end


function	OpeningBattleShow_OnLoad()
	g_Control_Window[1] = OpeningBattleShow_FrontScene
	g_Control_Window[2] = OpeningBattleShow_Skip_Button
end


function	OpeningBattleShow_OnEvent(event)
	if ( event == "OPENINGBATTLE_LOAD" ) then
		this:Show()
		g_Control_Window[1]:updataSkeletonState()
		g_Control_Window[1]:setAnimation("animation", false)
		g_Control_Window[2]:Show()
    end
end

--=====================================
--			   播放动画结束回调事件
--=====================================
function OpeningBattleShow_OnPlayEnd()
	OpeningBattleShow_Close()
	
	PushEvent("CHOOSECHARACTER_LOAD")
end

--=====================================
--			  关闭界面
--=====================================
function    OpeningBattleShow_Close()

	this:Hide()
end

function OpeningBattleShow_OnSkipEvent()

	OpeningBattleShow_Close()
	
	PushEvent("CHOOSECHARACTER_LOAD")


end

