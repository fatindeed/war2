local g_TaskList_Main = {}	
local g_TaskList_Count = 30

local MD_xinshouyindao_flag = 0

----------------Ԥ���ؽű�-----------------
function	TaskList_PreLoad()
	this:RegisterEvent("TASK_LIST_LOAD")		----��ʾ�����б�
	this:RegisterEvent("TASK_LIST_UPDATE")		----ˢ�������б�	
end

----------------���ؽű�-------------------
function	TaskList_OnLoad()
	g_TaskList_Main[1] = Task_List
	g_TaskList_Main[2] = TaskList_Window
end

---------------��Ӧ�¼�--------------------
function	TaskList_OnEvent(event)
	if event == "TASK_LIST_LOAD" then
		this:Show()
				
		--if(Player:GetLevel() == 1) then --����ҵȼ�����1��
		--	PlayVideo()
		--end
	elseif event == "TASK_LIST_UPDATE" then
		TaskList_ReLoadData()
	end
end

---------------ˢ������------------------
function	TaskList_ReLoadData()

	g_TaskList_Main[1]:CleanAllElement()
	
	local x, y = 0, 0
	local contentHeight = 300

	local bScrollContainerEmpty = true	
	-- ����30��������Ϣ
	for i = g_TaskList_Count - 1, 0, -1 do
		local tScript_id, tTask_id = DataPool:GetMissionData(i)
		if tScript_id ~= -1 and tTask_id ~= -1 then
			local Type,tIMG_id = DataPool:GetMissionTxtDesc(tTask_id)
			-- ��������������������ʾ
			if Type ~= 2 and tIMG_id ~= -1 then			
				local Function = string.format("%s%d%s","TaskList_OnClick(",tScript_id,")")
				g_TaskList_Main[1]:AddItemSelect(tIMG_id, tIMG_id, x + 35, y + 25, Function)
				
				bScrollContainerEmpty = false	
				
				y = y + 60
				if y > 300 then
					contentHeight = contentHeight + ((y - 300 >= 60 and 60) or y - 300)
				end
			end
		end
	end
	
	if bScrollContainerEmpty then
		g_TaskList_Main[2]:Hide()
	else
		g_TaskList_Main[2]:Show()
	
		g_TaskList_Main[1]:SetContentSize(80, contentHeight)
		if(contentHeight > 300) then			
			g_TaskList_Main[1]:SetContentOffset(0, -(contentHeight - 300))	
			g_TaskList_Main[1]:Touch(1)		
		else
			g_TaskList_Main[1]:SetContentOffset(0, (contentHeight - y))		
			g_TaskList_Main[1]:Touch(-1)
		end
	end
end

---------------����¼�------------------
function	TaskList_OnClick(arg)
	OpenRequestWaitProgress()	
		
	local scriptid = tonumber(arg)
	ClearScript()
	SetFunction("OnDefaultEvent")
	SetScriptID(scriptid)
	SendScript()
end