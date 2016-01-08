local g_SceneSwitch_Main = {}

	
function SceneSwitch_PreLoad()
	this:RegisterEvent("SCENESWITCH_CLOSE")  --�رճ���������ʶ
	this:RegisterEvent("SCENESWITCH_OPEN")   --�򿪳���������ʶ
	--PushToast("SceneSwitch_PreLoad")
end

function SceneSwitch_OnLoad()
	g_SceneSwitch_Main[1] = SceneSwitch_Skeleton_Close
    g_SceneSwitch_Main[2] = SceneSwitch_Skeleton_Open
	--PushToast("SceneSwitch_OnLoad")
end

function SceneSwitch_OnEvent(event)
     
	if ( event == "SCENESWITCH_CLOSE" ) then
	    --  HideLoading()--�ǵ���״̬��Ҫע�͵�
		this:Show()
		--PushToast("OnEvent==" .. tostring(event))
		g_SceneSwitch_Main[1]:Show()
	    g_SceneSwitch_Main[2]:Hide()
        g_SceneSwitch_Main[1]:setAnimation("animation",false)
	elseif ( event == "SCENESWITCH_OPEN" ) then
	    --HideLoading()--�ǵ���״̬��Ҫע�͵�
	    this:Show()
		g_SceneSwitch_Main[2]:Show()
		g_SceneSwitch_Main[1]:Hide()
		g_SceneSwitch_Main[2]:setAnimation("animation",false)

	end
end

--==============================================
--			�رն��������ӿ�
--==============================================

function SceneSwitch_Skeleton_Close_AnimationEnd()
   -- PushEvent("SCENESWITCH_OPEN")
     PushEvent("WORLDPLAYER_LOAD")
end

--==============================================
--			�򿪶��������ӿ�
--==============================================
function SceneSwitch_Skeleton_Open_AnimationEnd()
       --PushToast("=======")
	 this:Hide()
	  g_SceneSwitch_Main[1]:Hide()
	  g_SceneSwitch_Main[2]:Hide()
end