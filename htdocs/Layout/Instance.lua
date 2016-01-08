local g_Instance_Main		= {}
local g_Instance_Text		= {}		
local g_Instance_ScrollView	= {}	
local g_Index				= -1	--当前关卡
local g_Section				= -1	--当前章节	

--第一章奖励
local g_Award_1 = 
{
	{award_gold = "560", award_exp = "1663", desc="#{CUPY_5000_001}"},		
	{award_gold = "565", award_exp = "1663", desc="#{CUPY_5000_002}"},	
	{award_gold = "570", award_exp = "1663", desc="#{CUPY_5000_003}"},		
	{award_gold = "575", award_exp = "1663", desc="#{CUPY_5000_004}"},		
	{award_gold = "580", award_exp = "1663", desc="#{CUPY_5000_005}"},		
	{award_gold = "585", award_exp = "1663", desc="#{CUPY_5000_006}"},		
	{award_gold = "590", award_exp = "1663", desc="#{CUPY_5000_007}"},		
	{award_gold = "595", award_exp = "1942", desc="#{CUPY_5000_008}"},		
	{award_gold = "600", award_exp = "1942", desc="#{CUPY_5000_009}"},	
	{award_gold = "605", award_exp = "1942", desc="#{CUPY_5000_010}"}
}

--第二章奖励
local g_Award_2 = 
{
	{award_gold = "610", award_exp = "1942", desc="#{CUPY_5000_011}"},		
	{award_gold = "615", award_exp = "1942", desc="#{CUPY_5000_012}"},	
	{award_gold = "620", award_exp = "1942", desc="#{CUPY_5000_013}"},		
	{award_gold = "625", award_exp = "1942", desc="#{CUPY_5000_014}"},		
	{award_gold = "630", award_exp = "1942", desc="#{CUPY_5000_015}"},		
	{award_gold = "635", award_exp = "2218", desc="#{CUPY_5000_016}"},		
	{award_gold = "640", award_exp = "2218", desc="#{CUPY_5000_017}"},		
	{award_gold = "645", award_exp = "2218", desc="#{CUPY_5000_018}"},		
	{award_gold = "650", award_exp = "2218", desc="#{CUPY_5000_019}"},	
	{award_gold = "655", award_exp = "2218", desc="#{CUPY_5000_020}"}
}

--第三章奖励
local g_Award_3 = 
{
	{award_gold = "660", award_exp = "2218", desc="#{CUPY_5000_021}"},		
	{award_gold = "665", award_exp = "2218", desc="#{CUPY_5000_022}"},	
	{award_gold = "670", award_exp = "2218", desc="#{CUPY_5000_023}"},		
	{award_gold = "675", award_exp = "2493", desc="#{CUPY_5000_024}"},		
	{award_gold = "680", award_exp = "2493", desc="#{CUPY_5000_025}"},		
	{award_gold = "685", award_exp = "2493", desc="#{CUPY_5000_026}"},		
	{award_gold = "690", award_exp = "2493", desc="#{CUPY_5000_027}"},		
	{award_gold = "695", award_exp = "2493", desc="#{CUPY_5000_028}"},		
	{award_gold = "700", award_exp = "2767", desc="#{CUPY_5000_029}"},		
	{award_gold = "705", award_exp = "2767", desc="#{CUPY_5000_030}"}	
}

--第四章奖励
local g_Award_4 = 
{
	{award_gold = "710", award_exp = "2767", desc="#{CUPY_5000_031}"},		
	{award_gold = "715", award_exp = "2767", desc="#{CUPY_5000_032}"},	
	{award_gold = "720", award_exp = "2767", desc="#{CUPY_5000_033}"},		
	{award_gold = "725", award_exp = "3041", desc="#{CUPY_5000_034}"},		
	{award_gold = "730", award_exp = "3041", desc="#{CUPY_5000_035}"},		
	{award_gold = "735", award_exp = "3041", desc="#{CUPY_5000_036}"},		
	{award_gold = "740", award_exp = "3041", desc="#{CUPY_5000_037}"},		
	{award_gold = "745", award_exp = "3041", desc="#{CUPY_5000_038}"},		
	{award_gold = "750", award_exp = "3314", desc="#{CUPY_5000_039}"},		
	{award_gold = "755", award_exp = "3314", desc="#{CUPY_5000_040}"}	
}

--第五章奖励
local g_Award_5 = 
{
	{award_gold = "760", award_exp = "3314", desc="#{CUPY_5000_041}"},		
	{award_gold = "765", award_exp = "3314", desc="#{CUPY_5000_042}"},	
	{award_gold = "770", award_exp = "3314", desc="#{CUPY_5000_043}"},		
	{award_gold = "775", award_exp = "3586", desc="#{CUPY_5000_044}"},		
	{award_gold = "780", award_exp = "3586", desc="#{CUPY_5000_045}"},		
	{award_gold = "785", award_exp = "3586", desc="#{CUPY_5000_046}"},		
	{award_gold = "790", award_exp = "3586", desc="#{CUPY_5000_047}"},		
	{award_gold = "795", award_exp = "3586", desc="#{CUPY_5000_048}"},		
	{award_gold = "800", award_exp = "3858", desc="#{CUPY_5000_049}"},		
	{award_gold = "805", award_exp = "3858", desc="#{CUPY_5000_050}"}	
}

--第六章奖励
local g_Award_6 = 
{
	{award_gold = "760", award_exp = "3314", desc="#{CUPY_5000_041}"},		
	{award_gold = "765", award_exp = "3314", desc="#{CUPY_5000_042}"},	
	{award_gold = "770", award_exp = "3314", desc="#{CUPY_5000_043}"},		
	{award_gold = "775", award_exp = "3586", desc="#{CUPY_5000_044}"},		
	{award_gold = "780", award_exp = "3586", desc="#{CUPY_5000_045}"},		
	{award_gold = "785", award_exp = "3586", desc="#{CUPY_5000_046}"},		
	{award_gold = "790", award_exp = "3586", desc="#{CUPY_5000_047}"},		
	{award_gold = "795", award_exp = "3586", desc="#{CUPY_5000_048}"},		
	{award_gold = "800", award_exp = "3858", desc="#{CUPY_5000_049}"},		
	{award_gold = "805", award_exp = "3858", desc="#{CUPY_5000_050}"}	
}

--第七章奖励
local g_Award_7 = 
{
	{award_gold = "760", award_exp = "3314", desc="#{CUPY_5000_041}"},		
	{award_gold = "765", award_exp = "3314", desc="#{CUPY_5000_042}"},	
	{award_gold = "770", award_exp = "3314", desc="#{CUPY_5000_043}"},		
	{award_gold = "775", award_exp = "3586", desc="#{CUPY_5000_044}"},		
	{award_gold = "780", award_exp = "3586", desc="#{CUPY_5000_045}"},		
	{award_gold = "785", award_exp = "3586", desc="#{CUPY_5000_046}"},		
	{award_gold = "790", award_exp = "3586", desc="#{CUPY_5000_047}"},		
	{award_gold = "795", award_exp = "3586", desc="#{CUPY_5000_048}"},		
	{award_gold = "800", award_exp = "3858", desc="#{CUPY_5000_049}"},		
	{award_gold = "805", award_exp = "3858", desc="#{CUPY_5000_050}"}	
}

--第八章奖励
local g_Award_8 = 
{
	{award_gold = "760", award_exp = "3314", desc="#{CUPY_5000_041}"},		
	{award_gold = "765", award_exp = "3314", desc="#{CUPY_5000_042}"},	
	{award_gold = "770", award_exp = "3314", desc="#{CUPY_5000_043}"},		
	{award_gold = "775", award_exp = "3586", desc="#{CUPY_5000_044}"},		
	{award_gold = "780", award_exp = "3586", desc="#{CUPY_5000_045}"},		
	{award_gold = "785", award_exp = "3586", desc="#{CUPY_5000_046}"},		
	{award_gold = "790", award_exp = "3586", desc="#{CUPY_5000_047}"},		
	{award_gold = "795", award_exp = "3586", desc="#{CUPY_5000_048}"},		
	{award_gold = "800", award_exp = "3858", desc="#{CUPY_5000_049}"},		
	{award_gold = "805", award_exp = "3858", desc="#{CUPY_5000_050}"}	
}

--第九章奖励
local g_Award_9 = 
{
	{award_gold = "760", award_exp = "3314", desc="#{CUPY_5000_041}"},		
	{award_gold = "765", award_exp = "3314", desc="#{CUPY_5000_042}"},	
	{award_gold = "770", award_exp = "3314", desc="#{CUPY_5000_043}"},		
	{award_gold = "775", award_exp = "3586", desc="#{CUPY_5000_044}"},		
	{award_gold = "780", award_exp = "3586", desc="#{CUPY_5000_045}"},		
	{award_gold = "785", award_exp = "3586", desc="#{CUPY_5000_046}"},		
	{award_gold = "790", award_exp = "3586", desc="#{CUPY_5000_047}"},		
	{award_gold = "795", award_exp = "3586", desc="#{CUPY_5000_048}"},		
	{award_gold = "800", award_exp = "3858", desc="#{CUPY_5000_049}"},		
	{award_gold = "805", award_exp = "3858", desc="#{CUPY_5000_050}"}	
}

--第十章奖励
local g_Award_10 = 
{
	{award_gold = "760", award_exp = "3314", desc="#{CUPY_5000_041}"},		
	{award_gold = "765", award_exp = "3314", desc="#{CUPY_5000_042}"},	
	{award_gold = "770", award_exp = "3314", desc="#{CUPY_5000_043}"},		
	{award_gold = "775", award_exp = "3586", desc="#{CUPY_5000_044}"},		
	{award_gold = "780", award_exp = "3586", desc="#{CUPY_5000_045}"},		
	{award_gold = "785", award_exp = "3586", desc="#{CUPY_5000_046}"},		
	{award_gold = "790", award_exp = "3586", desc="#{CUPY_5000_047}"},		
	{award_gold = "795", award_exp = "3586", desc="#{CUPY_5000_048}"},		
	{award_gold = "800", award_exp = "3858", desc="#{CUPY_5000_049}"},		
	{award_gold = "805", award_exp = "3858", desc="#{CUPY_5000_050}"}	
}

--第一章
local g_huangmo=
{ 
	{name="#{CUPY_4000_001}",icon = 18},
	{name="#{CUPY_4000_002}",icon = 18},
	{name="#{CUPY_4000_003}",icon = 18},
	{name="#{CUPY_4000_004}",icon = 18},
	{name="#{CUPY_4000_005}",icon = 18},
	{name="#{CUPY_4000_006}",icon = 18},
	{name="#{CUPY_4000_007}",icon = 18},
	{name="#{CUPY_4000_008}",icon = 18},
	{name="#{CUPY_4000_009}",icon = 18},
	{name="#{CUPY_4000_010}",icon = 18},
}

--第二章
local g_heishi=
{ 
	{name="#{CUPY_4000_011}",icon = 18},
	{name="#{CUPY_4000_012}",icon = 18},
	{name="#{CUPY_4000_013}",icon = 18},
	{name="#{CUPY_4000_014}",icon = 18},
	{name="#{CUPY_4000_015}",icon = 18},
	{name="#{CUPY_4000_016}",icon = 18},
	{name="#{CUPY_4000_017}",icon = 18},
	{name="#{CUPY_4000_018}",icon = 18},
	{name="#{CUPY_4000_019}",icon = 18},
	{name="#{CUPY_4000_020}",icon = 18},
}

--第三章
local g_buluo=
{ 
	{name="#{CUPY_4000_021}",icon = 18},
	{name="#{CUPY_4000_022}",icon = 18},
	{name="#{CUPY_4000_023}",icon = 18},
	{name="#{CUPY_4000_024}",icon = 18},
	{name="#{CUPY_4000_025}",icon = 18},
	{name="#{CUPY_4000_026}",icon = 18},
	{name="#{CUPY_4000_027}",icon = 18},
	{name="#{CUPY_4000_028}",icon = 18},
	{name="#{CUPY_4000_029}",icon = 18},
	{name="#{CUPY_4000_030}",icon = 18},
}

--第四章
local g_diguoziyun=
{ 
	{name="#{CUPY_4000_031}",icon = 18},
	{name="#{CUPY_4000_032}",icon = 18},
	{name="#{CUPY_4000_033}",icon = 18},
	{name="#{CUPY_4000_034}",icon = 18},
	{name="#{CUPY_4000_035}",icon = 18},
	{name="#{CUPY_4000_036}",icon = 18},
	{name="#{CUPY_4000_037}",icon = 18},
	{name="#{CUPY_4000_038}",icon = 18},
	{name="#{CUPY_4000_039}",icon = 18},
	{name="#{CUPY_4000_040}",icon = 18},
}

--第五章
local g_hongsejingye=
{ 
	{name="#{CUPY_4000_041}",icon = 18},
	{name="#{CUPY_4000_042}",icon = 18},
	{name="#{CUPY_4000_043}",icon = 18},
	{name="#{CUPY_4000_044}",icon = 18},
	{name="#{CUPY_4000_045}",icon = 18},
	{name="#{CUPY_4000_046}",icon = 18},
	{name="#{CUPY_4000_047}",icon = 18},
	{name="#{CUPY_4000_048}",icon = 18},
	{name="#{CUPY_4000_049}",icon = 18},
	{name="#{CUPY_4000_050}",icon = 18},
}

--第六章
local g_yunshujian=
{ 
	{name="#{CUPY_4000_051}",icon = 18},
	{name="#{CUPY_4000_052}",icon = 18},
	{name="#{CUPY_4000_053}",icon = 18},
	{name="#{CUPY_4000_054}",icon = 18},
	{name="#{CUPY_4000_055}",icon = 18},
	{name="#{CUPY_4000_056}",icon = 18},
	{name="#{CUPY_4000_057}",icon = 18},
	{name="#{CUPY_4000_058}",icon = 18},
	{name="#{CUPY_4000_059}",icon = 18},
	{name="#{CUPY_4000_060}",icon = 18},
}

--第七章
local g_buluo7=
{ 
	{name="#{CUPY_4000_061}",icon = 18},
	{name="#{CUPY_4000_062}",icon = 18},
	{name="#{CUPY_4000_063}",icon = 18},
	{name="#{CUPY_4000_064}",icon = 18},
	{name="#{CUPY_4000_065}",icon = 18},
	{name="#{CUPY_4000_066}",icon = 18},
	{name="#{CUPY_4000_067}",icon = 18},
	{name="#{CUPY_4000_068}",icon = 18},
	{name="#{CUPY_4000_069}",icon = 18},
	{name="#{CUPY_4000_070}",icon = 18},
}

--第八章
local g_buluo8=
{ 
	{name="#{CUPY_4000_071}",icon = 18},
	{name="#{CUPY_4000_072}",icon = 18},
	{name="#{CUPY_4000_073}",icon = 18},
	{name="#{CUPY_4000_074}",icon = 18},
	{name="#{CUPY_4000_075}",icon = 18},
	{name="#{CUPY_4000_076}",icon = 18},
	{name="#{CUPY_4000_077}",icon = 18},
	{name="#{CUPY_4000_078}",icon = 18},
	{name="#{CUPY_4000_079}",icon = 18},
	{name="#{CUPY_4000_080}",icon = 18},
}

--第九章
local g_buluo9=
{ 
	{name="#{CUPY_4000_081}",icon = 18},
	{name="#{CUPY_4000_082}",icon = 18},
	{name="#{CUPY_4000_083}",icon = 18},
	{name="#{CUPY_4000_084}",icon = 18},
	{name="#{CUPY_4000_085}",icon = 18},
	{name="#{CUPY_4000_086}",icon = 18},
	{name="#{CUPY_4000_087}",icon = 18},
	{name="#{CUPY_4000_088}",icon = 18},
	{name="#{CUPY_4000_089}",icon = 18},
	{name="#{CUPY_4000_090}",icon = 18},
}

--第十章
local g_buluo10=
{ 
	{name="#{CUPY_4000_091}",icon = 18},
	{name="#{CUPY_4000_092}",icon = 18},
	{name="#{CUPY_4000_093}",icon = 18},
	{name="#{CUPY_4000_094}",icon = 18},
	{name="#{CUPY_4000_095}",icon = 18},
	{name="#{CUPY_4000_096}",icon = 18},
	{name="#{CUPY_4000_097}",icon = 18},
	{name="#{CUPY_4000_098}",icon = 18},
	{name="#{CUPY_4000_099}",icon = 18},
	{name="#{CUPY_4000_100}",icon = 18},
}

function	Instance_PreLoad()
	this:RegisterEvent("INSTANCE_LOAD")
	this:RegisterEvent("MISSION_MONSTER_LOAD")
end


function	Instance_OnLoad()
	g_Instance_Main[1] = Instance_UpData					-- 关卡详细说明弹窗
	g_Instance_Main[2] = Instance_ImageBox_Mask				-- 灰色遮罩
		
	g_Instance_Text[1] = Instance_Text						-- 主线关卡标题文字
	g_Instance_Text[2] = Instance_Up_Text					-- 关卡名称标题文字
	g_Instance_Text[3] = Instance_reward_Text				-- 励物品文字
	g_Instance_Text[4] = Instance_acquire_Text				-- 有几率获得文字
	g_Instance_Text[5] = Instance_Attack_Text				-- 攻击按钮文字	
	g_Instance_Text[6] = Instance_describe_Text				-- 关卡说明文字
	
	g_Instance_ScrollView[1] = Instance_Task_ScrollView		-- 关卡滑动框
	g_Instance_ScrollView[2] = Instance_Section_ScrollView	-- 章节滑动框
	g_Instance_ScrollView[3] = Instance_rewardScrollView	-- 奖励物品滑动框
	g_Instance_ScrollView[4] = Instance_acquireScrollView	-- 有几率获得滑动框

end

function	Instance_OnEvent(event)
	if ( event == "INSTANCE_LOAD" ) then
	
		-- 关闭主界面
		CloseAllWidget()		
		this:Show()
		
		g_Section = -1
		
		-- 初始化
		Instance_Init()
		-- 更新章节
		Instance_Update_Section()
		
	elseif ( event == "MISSION_MONSTER_LOAD" ) then
		-- 更新关卡
		Instance_Update_Task()
		
		CloseRequestWaitProgress()		
	end
end

-- 初始化界面
function	Instance_Init()
	-- 隐藏弹窗
	g_Instance_Main[1]:Hide()
	
	-- 清理滑动框
	for i = 1, 4, 1 do
		g_Instance_ScrollView[i]:CleanAllElement()
	end
	-- 更新标题文字
	g_Instance_Text[1]:SetText("#{CUPY_1000_001}")
	-- 关卡列表禁止滑动
	g_Instance_ScrollView[1]:Touch(-1)
	-- 请求第一章节数据
	Instance_Section(1)
	
	Instance_HideMask()
end

--======================================
-- 			  章节点击事件 
--======================================
function	Instance_Section(arg)
	if g_Section == arg then  -- 重复点击相同章节 
		return	
	end
	g_Section = arg 		  -- 赋值当前章节
	
	local Num = DataPool:GetCopyEventNum()	
	if(arg > 0 and arg <= Num) then
		local index, script = DataPool:GetCopyEventItem(arg-1, "desc")
		if script ~= -1 then
			OptionClicked(index, script)
		end
	end
end

--======================================
--				更新章节
--======================================
function	Instance_Update_Section()
	local x, y = 0, 0
	local instanceNum = DataPool:GetCopyEventNum()
	g_Instance_ScrollView[2]:CleanAllElement()
	if instanceNum > 0 then
		local Width, Height = 460, 60
		for i = 1, instanceNum, 1 do 
			local state, str = DataPool:GetCopyEventItem(i - 1,"text")			
			local Function = string.format("%s%d%s","Instance_Section(",i,")")
			g_Instance_ScrollView[2]:AddItemSelect9Patch("c_button.png", "c_button.png", x + 58, y + 21, 116, 42, 4, Function)
			g_Instance_ScrollView[2]:AddItemText( str, x + 8, y, 100, 42, "255 255 255", 23, "Center")
			x = x + 164
			if Width < x then
				Width = x			
			end
		end
		g_Instance_ScrollView[2]:SetContentSize(Width, Height)
	end
end

--======================================
-- 				更新关卡
--======================================
function	Instance_Update_Task()

	-- 必须先清空
	g_Instance_ScrollView[1]:CleanAllElement()
	
	local x, y, z = 12, 234, 1

	local MissionParam_Index = 0 -- 记录当前任务完成情况
	
	-- 获得任务ID
	local nMissionID = DataPool:GetBossMissionIndex()
	
	-- 通过ID返回任务索引
	local Mission_Index=DataPool:GetMissionListIndex(nMissionID) 
	
	local Width, Height= 705, 360

	-- 10个关卡列表
	for i = 1, 10, 1 do
		
		-- 关卡完成(1:没打 2:小胜 3:大胜 4:完胜)
		local p_Task_Round = DataPool:GetMissionVariable(Mission_Index,MissionParam_Index)
		
		-- 背景
		for i = 0, 2, 1 do
			g_Instance_ScrollView[1]:AddImage9Patch("customs_starbdi.png", x + 2 + i * 40, y - 43, 2, 32, 30, true)
		end
		
		g_Instance_ScrollView[1]:AddImage9Patch("di_shadow.png", x - 2, y - 48, 2, 118, 40, true)

		
		-- 开启
		if(p_Task_Round >= 1) then
		
			--星星
			for j = 0, 2, 1 do
				if p_Task_Round > j+1 then
					g_Instance_ScrollView[1]:AddImage9Patch("customs_star.png", x + 2 + j * 40, y - 43, 2, 32, 30, true)
				end
			end
			
			local Function = string.format("%s%d%s","Instance_TaskClick(",i,")")
			g_Instance_ScrollView[1]:AddImage9Patch("customs_outk.png",x, y, 2, 116, 116, true)
			g_Instance_ScrollView[1]:AddImage9Patch("customs_outkperson.png",x, y, 2, 116, 116, true)
			g_Instance_ScrollView[1]:AddItemSelect9Patch("empty.png", "empty.png", x + 58, y + 58, 116, 116, 2, Function)
			g_Instance_ScrollView[1]:AddItemIcon(4, x, y)
			
		
		else
		
			g_Instance_ScrollView[1]:AddImage9Patch("customs_kdlock.png",x, y, 2, 116, 116, true)
			g_Instance_ScrollView[1]:AddImage9Patch("customs_lock.png",x + 38, y + 32, 2, 39, 51, true)
			
		end
		g_Instance_ScrollView[1]:AddImage9Patch("di_news.png", x + 2, y + 8, 2, 112, 26, true)	
		
		if g_Section == 1 then
			g_Instance_ScrollView[1]:AddItemText(g_huangmo[i].name, x + 2, y + 8, 112, 26, "10 255 240", 20, "Center")
		elseif( g_Section== 2 )then
			g_Instance_ScrollView[1]:AddItemText(g_heishi[i].name, x + 2, y + 8, 112, 26, "10 255 240", 20, "Center")
		elseif( g_Section== 3 )then
			g_Instance_ScrollView[1]:AddItemText(g_buluo[i].name, x + 2, y + 8, 112, 26, "10 255 240", 20, "Center")
		elseif( g_Section== 4 )then
			g_Instance_ScrollView[1]:AddItemText(g_diguoziyun[i].name, x + 2, y + 8, 112, 26, "10 255 240", 20, "Center")
		elseif( g_Section== 5 )then
			g_Instance_ScrollView[1]:AddItemText(g_hongsejingye[i].name, x + 2, y + 8, 112, 26, "10 255 240", 20, "Center")
		elseif( g_Section== 6 )then
			g_Instance_ScrollView[1]:AddItemText(g_yunshujian[i].name, x + 2, y + 8, 112, 26, "10 255 240", 20, "Center")
		elseif( g_Section== 7 )then
			g_Instance_ScrollView[1]:AddItemText(g_buluo7[i].name, x + 2, y + 8, 112, 26, "10 255 240", 20, "Center")
		elseif( g_Section== 8 )then
			g_Instance_ScrollView[1]:AddItemText(g_buluo8[i].name, x + 2, y + 8, 112, 26, "10 255 240", 20, "Center")
		elseif( g_Section== 9 )then
			g_Instance_ScrollView[1]:AddItemText(g_buluo9[i].name, x + 2, y + 8, 112, 26, "10 255 240", 20, "Center")
		elseif( g_Section== 10 )then
			g_Instance_ScrollView[1]:AddItemText(g_buluo10[i].name, x + 2, y + 8, 112, 26, "10 255 240", 20, "Center")
		end

		x = x + 139
		if x > Width then
			x = 12
			y = y - (z * 179)
			z = z + 1
		end 
		
		-- 索引加1
		MissionParam_Index = MissionParam_Index + 1
		
	end	
	
	g_Instance_ScrollView[1]:SetContentSize(Width, Height)
	
end

-- 关卡点击事件 -->就是点击单个关卡 弹框
function	Instance_TaskClick(Index)
	g_Instance_Main[1]:Show()
	g_Index = Index
	Instance_ShowMask()
	Instance_Task_Describe(Index)
end

-- 更新关卡描述
function	Instance_Task_Describe(Index)
	if g_Section == 1 then
		g_Instance_Text[2]:SetText(g_huangmo[Index].name)
		g_Instance_Text[6]:SetText(g_Award_1[Index].desc)
	elseif g_Section== 2 then
		g_Instance_Text[2]:SetText(g_heishi[Index].name)		
		g_Instance_Text[6]:SetText(g_Award_2[Index].desc)		
	elseif g_Section== 3 then
		g_Instance_Text[2]:SetText(g_buluo[Index].name)		
		g_Instance_Text[6]:SetText(g_Award_3[Index].desc)	
	elseif g_Section == 4 then
		g_Instance_Text[2]:SetText(g_buluo[Index].name)		
		g_Instance_Text[6]:SetText(g_Award_4[Index].desc)		
	elseif g_Section == 5 then
		g_Instance_Text[2]:SetText(g_buluo[Index].name)		
		g_Instance_Text[6]:SetText(g_Award_5[Index].desc)	
	elseif g_Section == 6 then
		g_Instance_Text[2]:SetText(g_buluo[Index].name)		
		g_Instance_Text[6]:SetText(g_Award_6[Index].desc)	
	elseif g_Section == 7 then
		g_Instance_Text[2]:SetText(g_buluo[Index].name)		
		g_Instance_Text[6]:SetText(g_Award_7[Index].desc)	
	elseif g_Section == 8 then
		g_Instance_Text[2]:SetText(g_buluo[Index].name)		
		g_Instance_Text[6]:SetText(g_Award_8[Index].desc)			
	elseif g_Section == 9 then
		g_Instance_Text[2]:SetText(g_buluo[Index].name)		
		g_Instance_Text[6]:SetText(g_Award_9[Index].desc)				
	elseif g_Section == 9 then
		g_Instance_Text[2]:SetText(g_buluo[Index].name)		
		g_Instance_Text[6]:SetText(g_Award_10[Index].desc)		
	elseif g_Section == 10 then
		g_Instance_Text[2]:SetText(g_buluo[Index].name)		
		g_Instance_Text[6]:SetText(g_Award_10[Index].desc)										
	end
	g_Instance_Text[3]:SetText("#{CUPY_3000_003}")
	g_Instance_Text[4]:SetText("#{CUPY_3000_004}")
	g_Instance_Text[5]:SetText("#{TXSS_1000_057}")
	

	
	Instance_Reward(Index)
	Instance_Acquire()
end

-- 更新通关奖励奖励
function	Instance_Reward(Index)
	g_Instance_ScrollView[3]:CleanAllElement()
	local x, y = 5, 12
	local award_gold, award_exp = 0, 0
	
	if g_Section == 1 then
		award_gold = g_Award_1[Index].award_gold
		award_exp = g_Award_1[Index].award_exp
	elseif g_Section == 2 then
		award_gold = g_Award_2[Index].award_gold
		award_exp = g_Award_2[Index].award_exp
	elseif  g_Section == 3 then
		award_gold = g_Award_3[Index].award_gold
		award_exp = g_Award_3[Index].award_exp	
	elseif  g_Section == 4 then
		award_gold = g_Award_4[Index].award_gold
		award_exp = g_Award_4[Index].award_exp	
	elseif  g_Section == 5 then
		award_gold = g_Award_5[Index].award_gold
		award_exp = g_Award_5[Index].award_exp			
	elseif  g_Section == 6 then
		award_gold = g_Award_6[Index].award_gold
		award_exp = g_Award_6[Index].award_exp	
	elseif  g_Section == 7 then
		award_gold = g_Award_7[Index].award_gold
		award_exp = g_Award_7[Index].award_exp	
	elseif  g_Section == 8 then
		award_gold = g_Award_8[Index].award_gold
		award_exp = g_Award_8[Index].award_exp	
	elseif  g_Section == 9 then
		award_gold = g_Award_9[Index].award_gold
		award_exp = g_Award_9[Index].award_exp	
	elseif  g_Section == 10 then
		award_gold = g_Award_10[Index].award_gold
		award_exp = g_Award_10[Index].award_exp														
	end

	g_Instance_ScrollView[3]:AddItemIcon(84 ,x, y)
	g_Instance_ScrollView[3]:AddItemIcon(90 ,x + 230, y)
	
	g_Instance_ScrollView[3]:AddItemText(award_gold, x + 60, y + 5, 100, 30, "255 240 0", 24)
	g_Instance_ScrollView[3]:AddItemText(award_exp, x + 295, y + 5, 100, 30, "255 255 255", 24)
	g_Instance_ScrollView[3]:Touch(-1)
end

--//更新有一定几率获得
function	Instance_Acquire()
	g_Instance_ScrollView[4]:CleanAllElement()
	local x, y = 5, 12

	g_Instance_ScrollView[4]:AddItemIcon(89, x, y)
	g_Instance_ScrollView[4]:Touch(-1)
end

--点击事件关闭弹窗
function	Instance_UpClose()
	g_Instance_Main[1]:Hide()
	Instance_HideMask()
end

--点击事件返回主界面
function	Instance_Close()
	this:Hide()
	for i = 1, 4, 1 do
		g_Instance_ScrollView[i]:CleanAllElement()
	end	
	g_Section = -1
	PushEvent("MAIN_MENU_LOAD")
	PushEvent("RESOURCE_BAR_LOAD")
	PushEvent("PORTRAIT_LEFT_LOAD")
	PushEvent("TASK_LIST_LOAD")
	PushEvent("MAIN_CHAT_LOAD")	
end

--//点击事件进攻按钮
function	Instance_Attack()

	--验证选择关卡ID
	if g_Index < 0 then
		return
	end
	
	local scriptId = DataPool:GetBossEventItem(g_Index - 1,"desc")
	if scriptId < 0 then
		PushToast("#{TIP_1000_044}")
		return
	end
	
	--请求士兵列表 验证兵数量 > 0

	local g_SoliderCount = DataPool:GetSoliderCount()
	if g_SoliderCount <= 0 then
		PushToast("#{TIP_1000_044}")
		return
	end	
	
	--验证体力 >=5
	local g_PlayerVitality = Player:GetVitality()
	if g_PlayerVitality < 5 then
		PushToast("#{TIP_1000_022}")
		return
	end
	
	--//关闭所有界面
	CloseAllWidget()	
	
	--//显示进度条
	PushEvent("LOADINGWIDGET_LOAD")
	--PushEvent("SCENESWITCH_CLOSE")
	ClearScript()
	SetFunction("OnDefaultEvent")
	SetScriptID(scriptId)
	SetParameter(0,g_Index)
	SetParamCount(1)
	SendScript()
	
end


--显示全屏半透明灰色模板
function  Instance_ShowMask()
	g_Instance_Main[2]:Show()
	g_Instance_Main[2]:SetOpacity(100)	
end

--========================================
--		  显示全屏半透明灰色模板
--========================================
function  Instance_HideMask()
	g_Instance_Main[2]:Hide()
end
