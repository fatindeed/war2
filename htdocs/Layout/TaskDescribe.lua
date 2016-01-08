local g_Task_Main = {}
local g_Id = -1
local g_FrameInfo = -1
local FrameInfoList =
{
	x000002 = 2	--对应服务器脚本ID
}

function	TaskDescribe_PreLoad()
	this:RegisterEvent("TASK_DESCRIBLE_LOAD")
	this:RegisterEvent("TASK_DESCRIBLE_HIDE")
end

function	TaskDescribe_OnLoad()
	g_Task_Main[1] = TaskDescribe_Title_Text			-- 任务标题
	g_Task_Main[2] = TaskDescribe_ScrollView			-- 滑动框
end

function	TaskDescribe_OnEvent(event)
	if ( event == "TASK_DESCRIBLE_LOAD" ) then
		this:Show()
		TaskDescribe_ReadData()
		
		CloseRequestWaitProgress()		
	elseif ( event == "TASK_DESCRIBLE_HIDE") then
		this:Hide()
		PushEvent("GUIDE_UI_UPDATE", 3)
	end
end

--*******************************************************************
--						读取数据
--*******************************************************************
function	TaskDescribe_ReadData()

	g_Task_Main[2]:CleanAllElement()
	--坐标  430 345    (416 110 X 3)
	local x,y = 5,230
	
	local MissionParam_Index = 0 --记录当前任务完成情况
	
	local Mission_id = DataPool:GetMissionInfoById() --返回任务ID
	local Mission_Index=DataPool:GetMissionListIndex(Mission_id) --通过ID返回任务索引
	if 	Mission_Index < 0 and Mission_Index >= 30 then
		return
	end
	local MARK = 0
	local Num = DataPool:GetMissionEventNum()
	for i = 0, Num - 1 ,1 do 
		local id,p_Content,p_Icon,p_TaskNum,p_ScriotID  =	DataPool:GetMissionEvent(i) -- 内容
		if (id == "text") then	--找出任务名称
			g_Task_Main[1]:SetText(p_Content) 
		elseif (id =="id") then  --找出任务内容
			--g_Task_Main[2]:AddImage9Patch("arrmy_commond.png",x, y, 0, 417, 110)--加一张底图 arrmy_commond.png
			g_Task_Main[2]:AddButton9Patch("arrmy_commond.png", "arrmy_commond.png", x, y, 0, 417, 110, 4)
			g_Task_Main[2]:AddItemIcon(p_Icon,x + 10, y + 20)
			g_Task_Main[2]:AddItemText(p_Content,x + 120,y - 40,265,110,"255 255 255",16)--加文字
				
--			if (p_ScriotID > 0) then
				g_Id = 3
--				g_FrameInfo = p_ScriotID
--				PushDebugMessage(g_FrameInfo)
				local p_Task_Icon = string.format("%s%d%s", "TaskDescribe_Click(", g_Id, ")")
				g_Task_Main[2]:AddItemSelect9Patch("takebackan.png", "takebackan.png", x + 355 ,y + 59, 30, 38, 0, p_Task_Icon)	

--				g_Task_Main[2]:AddItemText("GO", x + 340, y, 50, 30, "0 0 0", 22)
--			else
--				local p_Task_Round = DataPool:GetMissionVariable(Mission_Index,MissionParam_Index) --任务当前完成情况
--				if p_Task_Round == p_TaskNum then
--					g_Task_Main[2]:AddItemIcon(97,x + 280, y + 30)
--				else
--					local p_TaskNum = string.format("%d%s%d",p_Task_Round,"/",p_TaskNum)
--					g_Task_Main[2]:AddItemText(p_TaskNum,x + 310, y + 45 ,0,0,"255 255 255",16)			
--				end
--				local p_TaskNum = string.format("%d%s%d",p_Task_Round,"/",p_TaskNum)
--				g_Task_Main[2]:AddItemText(p_TaskNum,x + 280,y + 22 ,0,0,"0 0 0",34)
--				MissionParam_Index = MissionParam_Index+1
--			end
			y = y - 110
			MARK = MARK + 1
		end
	end
	if MARK > 3 then
		g_Task_Main[2]:Touch(1)
	else 
		g_Task_Main[2]:Touch(-1)
	end
end

--*******************************************************************
--						关闭任务菜单
--*******************************************************************
function	TaskDescribe_Close()
	this:Hide()			-- 关闭窗口
end


--*******************************************************************
--					发送任务索引
--*******************************************************************
function TaskDescribe_Click(ID)
	--建筑脚本	
		PushEvent("BUILD_CHOOSE_TOBUILD", ID)
end