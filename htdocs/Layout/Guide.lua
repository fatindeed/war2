local g_Guide_Main = {}
-----------------------------------------------------
--新手指引流程
--参数
--类型 1: NPC文字引导 2: 箭头引导
-----------------------------------------------------
local g_GuideTable =
{	
-- 建造胶囊民居		
	{Type = 2, PosX = 80,  PosY = 330, OffsetX = -70,  OffsetY = -10,  Width = 60,  Height = 60,  FlipX = false},-- 建造图标【显示箭头】	  
	{Type = 2, PosX = 667, PosY = 401, OffsetX = -70,  OffsetY = -20,  Width = 42,  Height = 42,  FlipX = false},-- 任务描述列表 关闭界面按键
	{Type = 2, PosX = 615, PosY = 86,  OffsetX = 125,  OffsetY = -15,  Width = 68,  Height = 60,  FlipX = true },-- 主菜单建筑按键	
	{Type = 2, PosX = 230, PosY = 275, OffsetX = -106, OffsetY = 19,   Width = 148, Height = 148, FlipX = false},-- 建筑选择一级界面										 													 		
	{Type = 2, PosX = 520, PosY = 40,  OffsetX = 125,  OffsetY = -12,  Width = 120, Height = 40,  FlipX = true },-- 建筑选择二级界面
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_074}"},	 -- NPC建筑无法移动介绍 【NPC显示，隐藏箭头】	
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -76,  OffsetY = -26,  Width = 55,  Height = 55,  FlipX = false},-- 建筑选择位置
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -70,  OffsetY = -45,  Width = 65,  Height = 140, FlipX = false},-- 胶囊民居剪裁
-- 建造光合农苑 
	{Type = 2, PosX = 80,  PosY = 330, OffsetX = -70,  OffsetY = -10,  Width = 60,  Height = 60,  FlipX = false},-- 建造图标【显示箭头】	  	
	{Type = 2, PosX = 667, PosY = 401, OffsetX = -70,  OffsetY = -20,  Width = 42,  Height = 42,  FlipX = false},-- 任务描述列表 关闭界面按键
	{Type = 2, PosX = 615, PosY = 86,  OffsetX = 125,  OffsetY = -15,  Width = 68,  Height = 60,  FlipX = true },-- 主菜单建筑按键
	{Type = 2, PosX = 475, PosY = 275, OffsetX = 135,  OffsetY = 19,   Width = 148, Height = 148, FlipX = true },-- 建筑选择一级界面																				
	{Type = 2, PosX = 520, PosY = 40,  OffsetX = 125,  OffsetY = -12,  Width = 120, Height = 40,  FlipX = true },-- 建筑选择二级界面
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_074}"},	 -- NPC建筑无法移动介绍 【NPC显示，隐藏箭头】		
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -76,  OffsetY = -26,  Width = 55,  Height = 55,  FlipX = false},-- 建筑选择位置
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -70,  OffsetY = -45,  Width = 65,  Height = 140, FlipX = false},-- 光合农苑剪裁
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -70,  OffsetY = -45,  Width = 65,  Height = 140, FlipX = false},-- 光合农苑等待状态
	{Type = 2, PosX = 596, PosY = 70,  OffsetX = -100, OffsetY = -25,  Width = 116, Height = 42,  FlipX = false},-- 光合农苑等待界面
	{Type = 2, PosX = 596, PosY = 70,  OffsetX = -100, OffsetY = -25,  Width = 116, Height = 42,  FlipX = false},-- 光合农苑收集
	{Type = 2, PosX = 552, PosY = 391, OffsetX = 98,   OffsetY = -17,  Width = 38,  Height = 38,  FlipX = true },-- 光合农苑关闭	
-- 建造资源储备库
	{Type = 2, PosX = 80,  PosY = 330, OffsetX = -70,  OffsetY = -10,  Width = 60,  Height = 60,  FlipX = false},-- 建造图标【显示箭头】	  
	{Type = 2, PosX = 667, PosY = 401, OffsetX = -70,  OffsetY = -20,  Width = 42,  Height = 42,  FlipX = false},-- 任务描述列表 关闭界面按键
	{Type = 2, PosX = 615, PosY = 86,  OffsetX = 125,  OffsetY = -15,  Width = 68,  Height = 60,  FlipX = true },-- 主菜单建筑按键
	{Type = 2, PosX = 230, PosY = 129, OffsetX = -106, OffsetY = -30,  Width = 148, Height = 148, FlipX = false},-- 建筑选择一级界面							 													 		
	{Type = 2, PosX = 520, PosY = 40,  OffsetX = 125,  OffsetY = -12,  Width = 120, Height = 40,  FlipX = true },-- 建筑选择二级界面
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_074}"},	 -- NPC建筑无法移动介绍 【NPC显示，隐藏箭头】		
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -76,  OffsetY = -26,  Width = 55,  Height = 55,  FlipX = false},-- 建筑选择位置
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -70,  OffsetY = -45,  Width = 65,  Height = 140, FlipX = false},-- 资源储备库剪裁	
-- 建造士兵训练营
	{Type = 2, PosX = 80,  PosY = 330, OffsetX = -70,  OffsetY = -10,  Width = 60,  Height = 60,  FlipX = false},-- 建造图标【显示箭头】
	{Type = 2, PosX = 667, PosY = 401, OffsetX = -70,  OffsetY = -20,  Width = 42,  Height = 42,  FlipX = false},-- 任务描述列表 关闭界面按键
	{Type = 2, PosX = 615, PosY = 86,  OffsetX = 125,  OffsetY = -15,  Width = 68,  Height = 60,  FlipX = true },-- 主菜单建筑按键	
	{Type = 2, PosX = 475, PosY = 275, OffsetX = -106, OffsetY = 19,   Width = 148, Height = 148, FlipX = false},-- 建筑选择一级界面							
	{Type = 2, PosX = 520, PosY = 40,  OffsetX = 125,  OffsetY = -12,  Width = 120, Height = 40,  FlipX = true },-- 建筑选择二级界面
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_074}"},	 -- NPC建筑无法移动介绍 【NPC显示，隐藏箭头】			
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -76,  OffsetY = -26,  Width = 55,  Height = 55,  FlipX = false},-- 建筑选择位置
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -70,  OffsetY = -45,  Width = 65,  Height = 140, FlipX = false},-- 士兵训练营剪裁
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -70,  OffsetY = -45,  Width = 65,  Height = 140, FlipX = false},-- 士兵训练营等待状态
	{Type = 2, PosX = 580, PosY = 70,  OffsetX = -100, OffsetY = -25,  Width = 116, Height = 42,  FlipX = false},-- 士兵训练营等待界面	
	{Type = 2, PosX = 580, PosY = 70,  OffsetX = -100, OffsetY = -25,  Width = 116, Height = 42,  FlipX = false},-- 士兵训练营收集
	{Type = 2, PosX = 627, PosY = 421, OffsetX = 91,   OffsetY = -20,  Width = 38,  Height = 38,  FlipX = true },-- 士兵训练营关闭	
-- 建造老式民居(一)
	{Type = 2, PosX = 80,  PosY = 330, OffsetX = -70,  OffsetY = -10,  Width = 60,  Height = 60,  FlipX = false}, -- 建造图标【显示箭头】
	{Type = 2, PosX = 667, PosY = 401, OffsetX = -70,  OffsetY = -20,  Width = 42,  Height = 42,  FlipX = false}, -- 任务描述列表 关闭界面按键
	{Type = 2, PosX = 615, PosY = 86,  OffsetX = 125,  OffsetY = -15,  Width = 68,  Height = 60,  FlipX = true }, -- 主菜单建筑按键	
	{Type = 2, PosX = 230, PosY = 275, OffsetX = -106, OffsetY = 19,   Width = 148, Height = 148, FlipX = false}, -- 建筑选择一级界面										 													 		
	{Type = 2, PosX = 373, PosY = 269, OffsetX = -115, OffsetY = 0,    Width = 146, Height = 172, FlipX = false}, -- 建筑选择二级界面选项卡
	{Type = 2, PosX = 520, PosY = 40,  OffsetX = 125,  OffsetY = -12,  Width = 120, Height = 40,  FlipX = true }, -- 建筑选择二级界面建造按键	
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_074}"},	 -- NPC建筑无法移动介绍 【NPC显示，隐藏箭头】				
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -76,  OffsetY = -26,  Width = 55,  Height = 55,  FlipX = false}, -- 建筑选择位置
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -70,  OffsetY = -45,  Width = 65,  Height = 140, FlipX = false}, -- 老式民居剪裁		
-- 建造老式民居(二)
	{Type = 2, PosX = 615, PosY = 86,  OffsetX = 125,  OffsetY = -15,  Width = 68,  Height = 60,  FlipX = true }, -- 主菜单建筑按键	
	{Type = 2, PosX = 230, PosY = 275, OffsetX = -106, OffsetY = 19,   Width = 148, Height = 148, FlipX = false}, -- 建筑选择一级界面										 													 		
	{Type = 2, PosX = 373, PosY = 269, OffsetX = -115, OffsetY = 0,    Width = 146, Height = 172, FlipX = false}, -- 建筑选择二级界面选项卡
	{Type = 2, PosX = 520, PosY = 40,  OffsetX = 125,  OffsetY = -12,  Width = 120, Height = 40,  FlipX = true }, -- 建筑选择二级界面建造按键	
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_074}"},	 -- NPC建筑无法移动介绍 【NPC显示，隐藏箭头】					
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -76,  OffsetY = -26,  Width = 55,  Height = 55,  FlipX = false}, -- 建筑选择位置
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -70,  OffsetY = -45,  Width = 65,  Height = 140, FlipX = false}, -- 老式民居剪裁		
-- PVE 关卡
	{Type = 2, PosX = 380, PosY = 25,  OffsetX = 105,  OffsetY = -25,  Width = 68,  Height = 60, FlipX = true},  -- 主菜单关卡按键
	{Type = 2, PosX = 185, PosY = 335,  OffsetX = -95,  OffsetY = -25,  Width = 118, Height = 166,FlipX = false}, -- 关卡一级界面	选项卡
	{Type = 2, PosX = 438, PosY = 81,   OffsetX = 139,  OffsetY = -25,  Width = 116, Height = 44, FlipX = true},  -- 关卡二级界面	攻击按键	 			
-- PVE 战斗
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_058}"},	 -- NPC介绍 【NPC显示，隐藏箭头】
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_059}"},	 -- NPC介绍 【NPC显示，隐藏箭头】
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_060}"},	 -- NPC介绍 【NPC显示，隐藏箭头】
	{Type = 2, PosX = 105, PosY = 33,  OffsetX = -71,  OffsetY = -25,  Width = 74,  Height = 70,  FlipX = false},							     -- 战斗单元列表 选项卡按键	 				
	{Type = 2, PosX = 101, PosY = 295, OffsetX = -81,  OffsetY = -25,  Width = 100,  Height = 38,  FlipX = false},							 -- 战斗菜单 开战按键	 				
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_061}"},	 -- NPC介绍
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_062}"},	 -- NPC介绍
}

-- 新手引导最大步骤数量
local g_nMaxStep = 66

-- 当前操作步骤
local g_nCurStep = 1

-- NPC指引类型
local TYPE_NPC = 1

-- 箭头指引类型
local TYPE_ARROW = 2

-- 生产状态
local g_Produce_State = {STATE_WORK_WAIT=3, STATE_COLSE=5, STATE_PRODUCE_TING=6, STATE_HARVEST=7}

-- 缓存坐标
local POINT =
{
	POS_X = 0,
	POS_Y = 0
}

local EVENT = 
{
	LEVELUP_LOAD = 1,
	TASK_COMPLETE_LOAD = 2,
	GUIDE_UI_UPDATE = 3,
}

-- 等待加载数据
local bWaitLoadData = false 

function	Guide_PreLoad()
	this:RegisterEvent("GUIDE_LOAD")			  		-- 载入新手引导
	this:RegisterEvent("GUIDE_UI_UPDATE")		  		-- UI更新新手引导
	this:RegisterEvent("GUIDE_ENTITY_UPDATE")			-- 实体更新新手引导	
	this:RegisterEvent("GUIDE_HIDE")					-- 隐藏新手引导	
	
	this:RegisterEvent("TASK_LIST_LOAD")				-- 任务图标列表载入
	this:RegisterEvent("TASK_LIST_UPDATE")				-- 任务图标列表更新
	this:RegisterEvent("TASK_DESCRIBLE_LOAD")			-- 任务文字列表
	this:RegisterEvent("BUILD_CHOOSE_LOAD")				-- 建筑选择主界面
	this:RegisterEvent("BUILD_CHOOSE_TOBUILD")			-- 建筑选择子界面
	this:RegisterEvent("MOVE_MENU_LOAD")				-- 移动菜单 
	this:RegisterEvent("MOVE_MENU_UPDATE")				-- 移动菜单更新 
	this:RegisterEvent("MOVE_MENU_UNLOAD")				-- 移动菜单隐藏 
	this:RegisterEvent("TASK_COMPLETE_LOAD")			-- 任务完成界面 
	this:RegisterEvent("NPC_Dialog_LOAD")				-- NPC对话 
	this:RegisterEvent("PRODUCE_LOAD")					-- 初始化生产界面 
	this:RegisterEvent("PRODUCE_UPDATE")				-- 更新生产界面
	this:RegisterEvent("TRAIN_SOLIDER_LOAD")			-- 初始化士兵训练营界面 
	this:RegisterEvent("TRAIN_SOLIDER_UPDATE")			-- 更新士兵训练营界面	
	this:RegisterEvent("MISSION_MONSTER_LOAD")			-- 更新关卡界面
	this:RegisterEvent("COMBATPROCESS_LOAD")			-- 战斗界面
	this:RegisterEvent("LOADINGWIDGET_UNLOAD")			-- 隐藏载入界面
end

function	Guide_OnLoad()
	g_Guide_Main[1] = Guide_ImageBox_arrow				-- 箭头 	
	g_Guide_Main[2] = Guide_ImageBox_GreyBG				-- 半透明蒙板
	g_Guide_Main[3] = Guide_NpcPanel					-- NPC
	g_Guide_Main[4] = Guide_Button_NextStep				-- 下一步按键
	g_Guide_Main[5] = Guide_DetailPanel					-- 详情面板
	g_Guide_Main[6] = Guide_TextDetail					-- 步骤操作说明
end

function	Guide_OnEvent(event)	
	if (event ~= "LOADINGWIDGET_UNLOAD") then -- LOADINGWIDGET_UNLOAD 这个事件在登录时，玩家信息还没有获得
		local bNewPlayer = Player:GetIsNewPlayer()
		if tonumber(bNewPlayer) == 0 then
			this:Hide()	
			return 
		end
	end
	if g_nCurStep > g_nMaxStep then
		return	
	end
	if ( event == "GUIDE_LOAD" ) then			
		--初始化数据
		Guide_Init()
	elseif (event == "GUIDE_HIDE") then
		this:Hide()
	elseif (event == "GUIDE_ENTITY_UPDATE") then
		if (arg0 ~= nil) then
			local PosX, PosY = BuildData:GetBuildInfoFromID("BuildInfoFromID_ScreenPos", tonumber(arg0)) 
			local IndexID = BuildData:GetBuildInfoFromID("BuildInfoFromID_IndexID", tonumber(arg0))
 
			if g_nCurStep == 8 						 					   -- 胶囊民居剪裁
			or ((g_nCurStep == 16 or g_nCurStep == 17) and IndexID == 3)  -- 光合农苑剪裁	  --光合农苑等待
			or (g_nCurStep == 28 and IndexID == 10) 					   -- 资源储备库剪裁
			or ((g_nCurStep == 36 or g_nCurStep == 37) and IndexID == 8)  -- 士兵训练营剪裁 --士兵训练营等待
			or (g_nCurStep == 49 or g_nCurStep == 56) 					   -- 老式民居剪裁
			then	
				this:Show()	
				local Type, _, _, OffsetX, OffsetY, Width, Height, bFlipX = Guide_GetCurStepData()	
				POINT.POS_X = PosX
				POINT.POS_Y = PosY + 110						
				Guide_ShowGuide(Type, PosX + 40, PosY + 110, OffsetX, OffsetY, Width, Height, bFlipX)	
			end	
		end	
	elseif (event == "GUIDE_UI_UPDATE") then
		if arg0 == nil then
			return		
		end	
		arg0 = tonumber(arg0)
		if (g_nCurStep == 3  and arg0 == EVENT.GUIDE_UI_UPDATE)
		or (g_nCurStep == 6  and arg0 == EVENT.GUIDE_UI_UPDATE)
		or (g_nCurStep == 9  and arg0 == EVENT.LEVELUP_LOAD) 
		or (g_nCurStep == 11 and arg0 == EVENT.GUIDE_UI_UPDATE)
		or (g_nCurStep == 14  and arg0 == EVENT.GUIDE_UI_UPDATE)		
		or (g_nCurStep == 20 and arg0 == EVENT.LEVELUP_LOAD)
		or (g_nCurStep == 21 and arg0 == EVENT.GUIDE_UI_UPDATE)
		or (g_nCurStep == 23 and arg0 == EVENT.GUIDE_UI_UPDATE)
		or (g_nCurStep == 26  and arg0 == EVENT.GUIDE_UI_UPDATE)
		or (g_nCurStep == 29 and arg0 == EVENT.LEVELUP_LOAD)	
		or (g_nCurStep == 31 and arg0 == EVENT.GUIDE_UI_UPDATE)
		or (g_nCurStep == 34 and arg0 == EVENT.GUIDE_UI_UPDATE)						
		or (g_nCurStep == 40 and arg0 == EVENT.LEVELUP_LOAD)
		or (g_nCurStep == 43 and arg0 == EVENT.GUIDE_UI_UPDATE)	
		or (g_nCurStep == 47 and arg0 == EVENT.GUIDE_UI_UPDATE)				
		or (g_nCurStep == 50 and arg0 == EVENT.GUIDE_UI_UPDATE)
		or (g_nCurStep == 54 and arg0 == EVENT.GUIDE_UI_UPDATE)		
		or (g_nCurStep == 57 and arg0 == EVENT.TASK_COMPLETE_LOAD)		
		or (g_nCurStep == 59 and arg0 == EVENT.GUIDE_UI_UPDATE)	
		or (g_nCurStep == 64 and arg0 == EVENT.GUIDE_UI_UPDATE)			
		then
			this:Show()	
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX = Guide_GetCurStepData()	
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX)	
		end
	elseif (event == "PRODUCE_LOAD" or event == "PRODUCE_UPDATE") then 
		if g_nCurStep == 18 or g_nCurStep == 19 then	
			this:Show()					
			local pState = BuildData:GetMainTargetBuildState("MainTargetBuild_State_ID")
			if g_Produce_State.STATE_PRODUCE_TING == pState then
				Guide_HideGuide()		
				return	
			end	
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX  = Guide_GetCurStepData()
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX )	
		end		
	elseif (event == "TRAIN_SOLIDER_LOAD" or event == "TRAIN_SOLIDER_UPDATE") then
		if g_nCurStep == 38 or 	g_nCurStep == 39 then
			this:Show()			
			local pState = BuildData:GetMainTargetBuildState("MainTargetBuild_State_ID")
			if g_Produce_State.STATE_PRODUCE_TING == pState then
				Guide_HideGuide()		
				return	
			end	
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX  = Guide_GetCurStepData()
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX )				
		end	
	elseif (event == "TASK_COMPLETE_LOAD") then 
		if g_nCurStep == 9 or g_nCurStep == 20 or g_nCurStep == 29 or g_nCurStep == 40 then	
			this:Hide()				
		end
	elseif (event == "MOVE_MENU_LOAD" or event == "MOVE_MENU_UPDATE") then
		if arg0 ~= nil and arg1 ~= nil then			
			arg0 = tonumber(arg0)
			arg1 = tonumber(arg1)			
			if g_nCurStep == 7 or g_nCurStep == 15 or g_nCurStep == 27 or g_nCurStep == 35 or g_nCurStep == 48 or g_nCurStep == 55 then
				this:Show()	
				local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX = Guide_GetCurStepData()			
				Guide_ShowGuide(Type, arg0 + 100, arg1 - 40, OffsetX, OffsetY, Width, Height, bFlipX)	
			end
		end 
	elseif (event == "MOVE_MENU_UNLOAD" ) then
		if g_nCurStep == 8 or g_nCurStep == 16 or g_nCurStep == 28 or g_nCurStep == 36 or g_nCurStep == 49 or g_nCurStep == 56 then --当开始建造建筑时
			Guide_HideGuide()			
		end
	elseif (event == "BUILD_CHOOSE_LOAD") then		
		if g_nCurStep == 4 or g_nCurStep == 12 or g_nCurStep == 24 or g_nCurStep == 32 or g_nCurStep == 44 or g_nCurStep == 51 then
			this:Show()					
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX  = Guide_GetCurStepData()
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX )
		end
	elseif event == "BUILD_CHOOSE_TOBUILD" then
		if g_nCurStep == 5 or g_nCurStep == 13 or g_nCurStep == 25 or g_nCurStep == 33 or g_nCurStep == 45 or g_nCurStep == 46 or g_nCurStep == 52 or g_nCurStep == 53 then					
			this:Show()			
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX = Guide_GetCurStepData()
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX)
		end	
	elseif (event == "TASK_LIST_LOAD") then
		if g_nCurStep == 1 or g_nCurStep == 9 or g_nCurStep == 10 or g_nCurStep == 21 or g_nCurStep == 22 or g_nCurStep == 29 or g_nCurStep == 30 or g_nCurStep == 41 then
			this:Show()				
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX = Guide_GetCurStepData()	
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX)
		end
	elseif (event == "TASK_LIST_UPDATE") then
		if g_nCurStep == 1 or g_nCurStep == 2 or g_nCurStep == 10 or g_nCurStep == 22 or g_nCurStep == 30 or g_nCurStep == 41 then
			this:Show()				
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX = Guide_GetCurStepData()	
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX)
		end	
	elseif (event == "TASK_DESCRIBLE_LOAD") then
		if g_nCurStep == 2 or g_nCurStep == 11 or g_nCurStep == 23 or g_nCurStep == 30 or g_nCurStep == 42 then
			this:Show()				
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX  = Guide_GetCurStepData()
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX)		
		end
	elseif (event == "NPC_Dialog_LOAD") then
		this:Hide()
				
	elseif (event == "MISSION_MONSTER_LOAD") then
		if g_nCurStep == 58 then
			this:Show()				
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX  = Guide_GetCurStepData()
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX)						
		end
	elseif (event == "COMBATPROCESS_LOAD") then
		if g_nCurStep == 60 then
			this:Show()				
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX  = Guide_GetCurStepData()
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX)	
			PushEvent("COMBATPROCESS_RETREAT_HIDE")		
			PushEvent("COMBATPROCESS_UNITLIST_VISIBLE", 0)			
		end 
	elseif (event == "LOADINGWIDGET_UNLOAD") then
		if g_nCurStep == 65 then
			this:Show()		
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX  = Guide_GetCurStepData()
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX)	
		end
	end
end

--===================================
--			初始化数据
--===================================
function    Guide_Init()
	g_nCurStep = 1
end

--===================================
--			获得当前步骤数据
--===================================
function   Guide_GetCurStepData()
	return g_GuideTable[g_nCurStep]["Type"], g_GuideTable[g_nCurStep]["PosX"], g_GuideTable[g_nCurStep]["PosY"]
	, g_GuideTable[g_nCurStep]["OffsetX"], g_GuideTable[g_nCurStep]["OffsetY"], g_GuideTable[g_nCurStep]["Width"]
	, g_GuideTable[g_nCurStep]["Height"], g_GuideTable[g_nCurStep]["FlipX"]
end

--===================================
--		显示全屏半透明灰色蒙板
--===================================
function   Guide_ShowGreyMask()
	g_Guide_Main[2]:Show()
	g_Guide_Main[2]:SetScale(40)
	g_Guide_Main[2]:SetOpacity(100)	
end

--===================================
--		隐藏全屏半透明灰色蒙板
--===================================
function   Guide_HideMask()
	g_Guide_Main[2]:Hide()
end

--===================================
--			显示新手引导
--===================================
function Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, FlipX)
	if Type == TYPE_NPC then			
		Guide_ShowGreyMask()	
		Guide_ShowNpc()
		Guide_HideArrow()
		Guide_HideNextStep()
		
		bWaitLoadData = false
	elseif Type == TYPE_ARROW then
		Guide_HideMask()	
		Guide_ShowArrow(PosX, PosY, FlipX)
		Guide_ShowNextStep(PosX + OffsetX, PosY + OffsetY, Width, Height)
		Guide_HideNpc()
		
		bWaitLoadData = false
	end
end

--===================================
--				隐藏新手引导
--===================================
function Guide_HideGuide()
	Guide_HideArrow()
	Guide_HideNextStep()
	Guide_HideMask()	
	Guide_HideNpc()
end

--===================================
--				显示NPC指引
--===================================
function Guide_ShowNpc()
	g_Guide_Main[3]:Show()
	g_Guide_Main[5]:Show()
	g_Guide_Main[6]:SetText(tostring(g_GuideTable[g_nCurStep].Intro))
end

--===================================
--				隐藏NPC指引
--===================================
function Guide_HideNpc()
	g_Guide_Main[3]:Hide()
	g_Guide_Main[5]:Hide()
end

--===================================
--			显示下一步按键
--===================================
function Guide_ShowNextStep(PosX, PosY, Width, Height)
	g_Guide_Main[4]:Show()
	g_Guide_Main[4]:SetPosition(PosX, PosY)
	g_Guide_Main[4]:SetButton9PatchContentSize(Width, Height)	
end

--===================================
--			隐藏下一步按键
--===================================
function Guide_HideNextStep()
	g_Guide_Main[4]:Hide()
end

--===================================
--			显示箭头指引
--===================================
function Guide_ShowArrow(PosX, PosY, FlipX)		
	g_Guide_Main[1]:Show()	
	g_Guide_Main[1]:SetPosition(PosX, PosY)
	g_Guide_Main[1]:SetFlipX(FlipX)
	g_Guide_Main[1]:StartMoveAction(-10, 0, 0.3, true)
end

--===================================
--			隐藏箭头指引
--===================================
function Guide_HideArrow()
	g_Guide_Main[1]:Hide()
	g_Guide_Main[1]:StopAnimation()
end

--===================================
--			重置操作步骤 
--	在某一步骤关闭 需要返回到指定步骤
--===================================
function Guide_ResetStep(backStep)
	g_nCurStep = backStep	
end

--===================================
--			添加下一步
--===================================
function Guide_AddNextStep()
	g_nCurStep = g_nCurStep + 1		
end

--===================================
--			点击箭头指引区
--===================================
function Guide_ClickOK()
	if(bWaitLoadData) then
		return 
	end
	bWaitLoadData = true
	
	if g_nCurStep == 1 then 		-- 点击建造胶囊民居的任务图标
		ClearScript()
		SetFunction("OnDefaultEvent")
		SetScriptID(2)
		SendScript()
	elseif g_nCurStep == 2 then	 	-- 任务描述列表 关闭界面按键
		PushEvent("TASK_DESCRIBLE_HIDE")
	elseif g_nCurStep == 3 then  	-- 主菜单建筑按键
		PushEvent("BUILD_CHOOSE_LOAD")
	elseif g_nCurStep == 4 then		-- 建筑类型选择界面
		PushEvent("BUILD_CHOOSE_TOBUILD", 0, 0)		
	elseif g_nCurStep == 5 then	 	-- 点击建造按键【胶囊民居】 
		CloseAllWidget()		
	elseif g_nCurStep == 7 then	 	-- 点击移动菜单确定键
		PushEvent("MOVE_MENU_UNLOAD")
		Move_OK()	
	elseif g_nCurStep == 8 then	 	-- 胶囊民居剪裁
		TouchesEnd(POINT.POS_X, POINT.POS_Y)
	elseif g_nCurStep == 9 then	 	-- 点击建造光合农苑的任务图标
		ClearScript()
		SetFunction("OnDefaultEvent")
		SetScriptID(3)
		SendScript()	
	elseif g_nCurStep == 10 then	 	-- 任务描述列表 关闭界面按键
		PushEvent("TASK_DESCRIBLE_HIDE")		
	elseif g_nCurStep == 11 then 	-- 主菜单建筑按键
		PushEvent("BUILD_CHOOSE_LOAD")	
	elseif g_nCurStep == 12 then	-- 建筑类型选择界面
		PushEvent("BUILD_CHOOSE_TOBUILD", 2, 3)	
	elseif g_nCurStep == 13 then	-- 点击建造按键【光合农苑】 
		CloseAllWidget()		
	elseif g_nCurStep == 15 then	-- 点击移动菜单确定键
		PushEvent("MOVE_MENU_UNLOAD")
		Move_OK()	
	elseif g_nCurStep == 16 then	-- 光合农苑剪裁
		Guide_HideNextStep()		
		TouchesEnd(POINT.POS_X, POINT.POS_Y)	
	elseif g_nCurStep == 17 then	-- 打开光合农苑信息面板
		TouchesEnd(POINT.POS_X, POINT.POS_Y)
	elseif g_nCurStep == 18 then	-- 点击生产按键【胡萝卜】
		BuildData:ProduceIndex(5)
		Guide_HideGuide()
	elseif g_nCurStep == 19 then	-- 点击收集按键【胡萝卜】
		BuildData:RecviedBuildProduct()	
	elseif g_nCurStep == 20 then	-- 关闭生产界面 
		CloseAllWidget()
		PushEvent("MAIN_MENU_LOAD")
		PushEvent("RESOURCE_BAR_LOAD")
		PushEvent("PORTRAIT_LEFT_LOAD")
		PushEvent("TASK_LIST_LOAD")
		PushEvent("MAIN_CHAT_LOAD")	
		PushEvent("GUIDE_UI_UPDATE", 3)			
	elseif g_nCurStep == 21 then	-- 点击建造资源储备库的任务图标
		ClearScript()
		SetFunction("OnDefaultEvent")
		SetScriptID(4)
		SendScript()
	elseif g_nCurStep == 22 then 	-- 任务描述列表 关闭界面按键
		PushEvent("TASK_DESCRIBLE_HIDE")
	elseif g_nCurStep == 23 then  	-- 主菜单建筑按键	
		PushEvent("BUILD_CHOOSE_LOAD")		
	elseif g_nCurStep == 24 then	-- 建筑类型选择界面
		PushEvent("BUILD_CHOOSE_TOBUILD", 3, 10)	
	elseif g_nCurStep == 25 then	-- 点击建造按键【资源储备库】 
		CloseAllWidget()		
	elseif g_nCurStep == 27 then	-- 点击移动菜单确定键
		PushEvent("MOVE_MENU_UNLOAD")
		Move_OK()	
	elseif g_nCurStep == 28 then	-- 资源储备库剪裁
		TouchesEnd(POINT.POS_X, POINT.POS_Y)	
	elseif g_nCurStep == 29 then    -- 点击建造士兵训练营的任务图标
		ClearScript()
		SetFunction("OnDefaultEvent")
		SetScriptID(5)
		SendScript()	 
	elseif g_nCurStep == 30 then	 -- 任务描述列表 跳转到建筑选择界面的按键
		PushEvent("TASK_DESCRIBLE_HIDE")
	elseif g_nCurStep == 31 then  	 -- 主菜单建筑按键	
		PushEvent("BUILD_CHOOSE_LOAD")
	elseif g_nCurStep == 32 then     -- 建筑类型选择界面
		PushEvent("BUILD_CHOOSE_TOBUILD", 1, 8)		
	elseif g_nCurStep == 33 then	 -- 点击建造按键【士兵训练营】 
		CloseAllWidget()		
	elseif g_nCurStep == 35 then	 -- 点击移动菜单确定键
		PushEvent("MOVE_MENU_UNLOAD")
		Move_OK()	
	elseif g_nCurStep == 36 then	 -- 士兵训练营剪裁
		Guide_HideNextStep()	
		TouchesEnd(POINT.POS_X, POINT.POS_Y)	
	elseif g_nCurStep == 37 then	 -- 打开士兵训练营信息面板
		TouchesEnd(POINT.POS_X, POINT.POS_Y)
	elseif g_nCurStep == 38 then	 -- 点击训练按键【步兵】
		BuildData:TrainSoliderSubmit(0)
		Guide_HideGuide()
	elseif g_nCurStep == 39 then	 -- 点击收集按键【步兵】
		BuildData:RecviedBuildProduct()	
	elseif g_nCurStep == 40 then	 -- 关闭训练界面 
		-- 卸载主目标 【士兵训练营】
		BuildData:UnMainTarget() 		
		CloseAllWidget()
		PushEvent("MAIN_MENU_LOAD")
		PushEvent("RESOURCE_BAR_LOAD")
		PushEvent("PORTRAIT_LEFT_LOAD")
		PushEvent("TASK_LIST_LOAD")
		PushEvent("MAIN_CHAT_LOAD")			
		PushEvent("GUIDE_UI_UPDATE", 3)		
	elseif g_nCurStep == 41 then	 -- 点击建造老式民居的任务图标
		ClearScript()
		SetFunction("OnDefaultEvent")
		SetScriptID(6)
		SendScript()	
	elseif g_nCurStep == 42 then	 -- 任务描述列表 关闭界面按键
		PushEvent("TASK_DESCRIBLE_HIDE")
	elseif g_nCurStep == 43 then  	-- 主菜单建筑按键
		PushEvent("BUILD_CHOOSE_LOAD")
	elseif g_nCurStep == 44 then	-- 建筑类型选择界面
		PushEvent("BUILD_CHOOSE_TOBUILD", 0, 0)		
	elseif g_nCurStep == 45 then	-- 建筑类型选择界面
		PushEvent("BUILD_CHOOSE_TOBUILD", 0, 1)			
	elseif g_nCurStep == 46 then	 -- 点击建造按键【老式民居(一)】 
		CloseAllWidget()		
	elseif g_nCurStep == 48 then	 -- 点击移动菜单确定键
		PushEvent("MOVE_MENU_UNLOAD")
		Move_OK()	
	elseif g_nCurStep == 49 then	 -- 老式民居(一)剪裁
		TouchesEnd(POINT.POS_X, POINT.POS_Y)		
	elseif g_nCurStep == 50 then  	 -- 主菜单建筑按键
		PushEvent("BUILD_CHOOSE_LOAD")
	elseif g_nCurStep == 51 then	 -- 建筑类型选择界面
		PushEvent("BUILD_CHOOSE_TOBUILD", 0, 0)		
	elseif g_nCurStep == 52 then	 -- 建筑类型选择界面
		PushEvent("BUILD_CHOOSE_TOBUILD", 0, 1)			
	elseif g_nCurStep == 53 then	 -- 点击建造按键【老式民居(二)】 
		CloseAllWidget()		
	elseif g_nCurStep == 55 then	 -- 点击移动菜单确定键
		PushEvent("MOVE_MENU_UNLOAD")
		Move_OK()	
	elseif g_nCurStep == 56 then	 -- 老式民居(二)剪裁
		TouchesEnd(POINT.POS_X, POINT.POS_Y)	
	elseif g_nCurStep == 57 then	 -- 主菜单关卡按键
		OpenRequestWaitProgress()		
		CloseAllWidget()
		--发送打开副本界面消息
		ClearScript()
		SetFunction("OnDefaultEvent")
		SetScriptID(100501)
		SendScript()	
		AskSoliderList()					
	elseif g_nCurStep == 58 then	 -- 关卡一级界面	选项卡
		Instance_TaskClick(1)	
	elseif g_nCurStep == 59 then	 -- 关卡二级界面	攻击按键
		local scriptId = DataPool:GetBossEventItem(0, "desc")
		-- 关闭所有界面
		CloseAllWidget()	
		-- 显示进度条
		PushEvent("LOADINGWIDGET_LOAD")
		ClearScript()
		SetFunction("OnDefaultEvent")
		SetScriptID(scriptId)
		SetParameter(0, 1)
		SetParamCount(1)
		SendScript()		
	elseif g_nCurStep == 63 then		-- 战斗单元列表 选项卡按键		
		CombatProcess_ArrmyOnClick(0)
	elseif g_nCurStep == 64 then		-- 战斗菜单 开战按键
		CombatProcess_StartBattle()
		
		this:Hide()
	end
	
	Guide_AddNextStep()			 	 -- 当前步骤的标记位增加
	
	
	if (g_nCurStep == 6) then			 -- NPC建筑无法移动介绍 【NPC显示，隐藏箭头】
		PushEvent("GUIDE_UI_UPDATE", 3)	
	elseif (g_nCurStep == 14) then		 -- NPC建筑无法移动介绍 【NPC显示，隐藏箭头】
		PushEvent("GUIDE_UI_UPDATE", 3)		
	elseif (g_nCurStep == 26) then		 -- NPC建筑无法移动介绍 【NPC显示，隐藏箭头】
		PushEvent("GUIDE_UI_UPDATE", 3)					
	elseif (g_nCurStep == 34) then		 -- NPC建筑无法移动介绍 【NPC显示，隐藏箭头】
		PushEvent("GUIDE_UI_UPDATE", 3)		
	elseif (g_nCurStep == 47) then		 -- NPC建筑无法移动介绍 【NPC显示，隐藏箭头】
		PushEvent("GUIDE_UI_UPDATE", 3)			
	elseif (g_nCurStep == 50)  then		 -- 【老式民居(一)】剪裁跳转 主菜单建筑按键
		PushEvent("GUIDE_UI_UPDATE", 3)	
	elseif (g_nCurStep == 54)  then		 -- 【老式民居(一)】剪裁跳转 主菜单建筑按键
		PushEvent("GUIDE_UI_UPDATE", 3)			
	elseif (g_nCurStep == 59) then  	 -- 关卡二级界面	攻击按键
		PushEvent("GUIDE_UI_UPDATE", 3)			
	elseif (g_nCurStep == 64) then	 	 -- 战斗单元列表 选项卡按键	
		PushEvent("GUIDE_UI_UPDATE", 3)
	end
	
end

--===================================
-- 				关闭NPC界面
--===================================
function Guide_OnClickNPC()
	Guide_AddNextStep()			
	-- 验证是否继续下一步
	if g_nCurStep <= g_nMaxStep then	
		local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, FlipX = Guide_GetCurStepData()
		Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, FlipX)		
		if (g_nCurStep == 7) then
			BuildData:CreateNewBuild(0)
		elseif (g_nCurStep == 15) then
			BuildData:CreateNewBuild(3)		
		elseif (g_nCurStep == 27) then			
			BuildData:CreateNewBuild(10)
		elseif (g_nCurStep == 35) then					
			BuildData:CreateNewBuild(8)	
		elseif (g_nCurStep == 48) then	
			BuildData:CreateNewBuild(1)	
		elseif (g_nCurStep == 55) then				
			BuildData:CreateNewBuild(1)							
		elseif (g_nCurStep == 62) then
			PushEvent("COMBATPROCESS_UNITLIST_VISIBLE", 1)		
		end	
	else	
		-- 关闭新手引导界面	
		this:Hide()
		SendNewPlayerDone()
		PushToast("#{CUPY_5000_195}")
	end
end
