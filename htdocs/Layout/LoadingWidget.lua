local g_WidgetLoading_Main = {}

function	LoadingWidget_PreLoad()
	this:RegisterEvent("LOADINGWIDGET_LOAD")					--���봰��
	this:RegisterEvent("LOADINGWIDGET_UNLOAD")					--�رմ���
	this:RegisterEvent("LOADINGWIDGET_UPDATE")					--�رմ���
end

function	LoadingWidget_OnLoad()
	g_WidgetLoading_Main[1] = LoadingWidget_PromptBg_Image			--��ɫ��ͼ
	g_WidgetLoading_Main[2] = LoadingWidget_Prompt_Text				--�ı���
	g_WidgetLoading_Main[3] = LoadingWidget_Time 					--��ʱ��
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
		if this:IsVisible() == true then			-->��ʾ״̬ 
			LoadingWidget_Update()
		end
	end
end

--=======================================
-- 				��ʼ������ 
--=======================================
function	LoadingWidget_Init()
	CloseAllWidget()	---�ر����жԻ���
	this:Show()			---��ʾ����
	g_WidgetLoading_Main[3]:StartTime(6000, 0, 1, 5)

	g_WidgetLoading_Main[1]:Hide()
	g_WidgetLoading_Main[5]:StartRotation(1, 180, true)
	g_WidgetLoading_Main[6]:StartRotation(1, -180,true)
end

--========================================
-- 				�رս���
--========================================
function	LoadingWidget_Close()
	this:Hide()
	-- �رն�ʱ��
	g_WidgetLoading_Main[3]:StopTime()						
end

--========================================
--			  ������ʾ����
--			�����ʾһ����ʾ
--========================================
function	LoadingWidget_Update()					
	--math.randomseed(tostring(os.time()):reverse():sub(1, 6))	
	--local index = math.random(10)

	--local tContent = string.format("#{TIPS_1000_%03d}", index)
	local tContent = "#{GUSS_1000_010}"
	g_WidgetLoading_Main[2]:SetText(tContent)
end









