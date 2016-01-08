
local g_LevelTable = {}


function	LevelUp_PreLoad()
	this:RegisterEvent("LEVELUP_LOAD")
end

function	LevelUp_OnLoad()
    g_LevelTable[1]=LevelUp_Skeleton
end

function	LevelUp_OnEvent(event)

	if ( event == "LEVELUP_LOAD" ) then
			this:Show()
		
        g_LevelTable[1]:setAnimation("animation",false)

	end
	
end


function	LevelUp_SkeletonAnimationEnd()
	this:Hide()

	PushEvent("GUIDE_UI_UPDATE", 1)
end