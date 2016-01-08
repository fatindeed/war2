local g_SceneSwitch_Main = {}

	
function SceneSwitch_PreLoad()
	this:RegisterEvent("SCENESWITCH_CLOSE")  --关闭场景动画标识
	this:RegisterEvent("SCENESWITCH_OPEN")   --打开场景动画标识
	--PushToast("SceneSwitch_PreLoad")
end

function SceneSwitch_OnLoad()
	g_SceneSwitch_Main[1] = SceneSwitch_Skeleton_Close
    g_SceneSwitch_Main[2] = SceneSwitch_Skeleton_Open
	--PushToast("SceneSwitch_OnLoad")
end

function SceneSwitch_OnEvent(event)
     
	if ( event == "SCENESWITCH_CLOSE" ) then
	    --  HideLoading()--非调试状态需要注释掉
		this:Show()
		--PushToast("OnEvent==" .. tostring(event))
		g_SceneSwitch_Main[1]:Show()
	    g_SceneSwitch_Main[2]:Hide()
        g_SceneSwitch_Main[1]:setAnimation("animation",false)
	elseif ( event == "SCENESWITCH_OPEN" ) then
	    --HideLoading()--非调试状态需要注释掉
	    this:Show()
		g_SceneSwitch_Main[2]:Show()
		g_SceneSwitch_Main[1]:Hide()
		g_SceneSwitch_Main[2]:setAnimation("animation",false)

	end
end

--==============================================
--			关闭动画结束接口
--==============================================

function SceneSwitch_Skeleton_Close_AnimationEnd()
   -- PushEvent("SCENESWITCH_OPEN")
     PushEvent("WORLDPLAYER_LOAD")
end

--==============================================
--			打开动画结束接口
--==============================================
function SceneSwitch_Skeleton_Open_AnimationEnd()
       --PushToast("=======")
	 this:Hide()
	  g_SceneSwitch_Main[1]:Hide()
	  g_SceneSwitch_Main[2]:Hide()
end