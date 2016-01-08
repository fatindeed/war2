local g_WidgetLoading_Main = {}

function	LoadingWidget_PreLoad()
	this:RegisterEvent("LOADINGWIDGET_LOAD")					--载入窗口
	this:RegisterEvent("LOADINGWIDGET_UNLOAD")					--关闭窗口
	this:RegisterEvent("LOADINGWIDGET_UPDATE")					--关闭窗口
end

function	LoadingWidget_OnLoad()
	g_WidgetLoading_Main[1] = LoadingWidget_PromptBg_Image			--灰色底图
	g_WidgetLoading_Main[2] = LoadingWidget_Prompt_Text				--文本框
	g_WidgetLoading_Main[3] = LoadingWidget_Time 					--定时器
	g_WidgetLoading_Main[4] = LoadingWidget_Meinv
	g_WidgetLoading_Main[5] = LoadingWidget_little
	g_WidgetLoading_Main[6] = LoadingWidget_big
end

function	LoadingWidget_OnEvent(event)
	if  event == "LOADINGWIDGET_LOAD"  then	
			LoadingWidget_Init()
			LoadingWidget_Update()
	elseif event == "LOADINGWIDGET_UNLOAD" then
			LoadingWidget_Close()
	elseif	event == "LOADINGWIDGET_UPDATE" then
		if this:IsVisible() == true then			-->显示状态 
			LoadingWidget_Update()
		end
	end
end

--=======================================
-- 				初始化界面 
--=======================================
function	LoadingWidget_Init()
	CloseAllWidget()	---关闭所有对话框
	this:Show()			---显示界面
	g_WidgetLoading_Main[3]:StartTime(6000, 0, 1, 5)

	g_WidgetLoading_Main[1]:Hide()
	g_WidgetLoading_Main[5]:StartRotation(1, 180, true)
	g_WidgetLoading_Main[6]:StartRotation(1, -180,true)
end

--========================================
-- 				关闭界面
--========================================
function	LoadingWidget_Close()
	this:Hide()
	-- 关闭定时器
	g_WidgetLoading_Main[3]:StopTime()						
end

--========================================
--			  更新显示数据
--			随机显示一个提示
--========================================
function	LoadingWidget_Update()					
	--math.randomseed(tostring(os.time()):reverse():sub(1, 6))	
	--local index = math.random(10)

	--local tContent = string.format("#{TIPS_1000_%03d}", index)
	local tContent = "#{GUSS_1000_010}"
	g_WidgetLoading_Main[2]:SetText(tContent)
end









