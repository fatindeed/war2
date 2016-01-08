local g_TaskCompleted_Main = {}

	
function TaskCompleted_PreLoad()
	this:RegisterEvent("TASK_COMPLETED_SHOW")
end

function TaskCompleted_OnLoad()
	g_TaskCompleted_Main[1] = Task_Completed_Skeleton

end

function TaskCompleted_OnEvent(event)
	if ( event == "TASK_COMPLETED_SHOW" ) then
		this:Show()
		--HideLoading()
        g_TaskCompleted_Main[1]:setAnimation("animation",false)
	end
end

function TaskCompleted_SkeletonAnimationEnd()
    this:Hide()
    
    local scriptId = DataPool:GetMissionCompleteScript()
		if scriptId ~= -1 then
			ClearScript()
			SetFunction("OnMissionSubmit")
			SetScriptID(scriptId)
			SendScript()	
		end
	PushEvent("GUIDE_UI_UPDATE", 2)
    
	--PushToast("=======")
end
