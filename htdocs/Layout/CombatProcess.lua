local g_CombatProcess_User		= {}
local g_CombatProcess_Foe		= {}
local g_CombatProcess_LiftMenu	= {}
local g_CombatProcess_DownMenu	= {}
local g_CombatProcess_Main 		= {}
local g_CombatProcess_Show		= {}

local g_scriptID 				= -1
local g_functionName			= ""

local g_SolderCount				= 0							-- 军事单元类型数量
				
local g_unit					= 0							-- 加入战斗的单元的上限
local g_CurJoinCount	 		= 0							-- 当前加入战斗的单元数
local g_RoundCount				= 0							-- 回合次数

local g_OurMaxHp				= 0							-- 我方最大生命值
local g_EnmyMaxHp				= 0							-- 敌方最大生命值

local g_nMatchRemainTime		= 10						-- 倒计时匹配剩余时间  10秒
local g_nTakeTurnRemainTime     = 10						-- 倒计时轮换剩余时间  10秒
local g_nCurTakeTurnCamp        = -1						-- 当前攻击阵营方  0 我方 1 敌方

local g_nCombatType	= 										-- 战斗类型
{
	g_PVE_Combat		  		= 1,
	g_PVP_Combat		 		= 2,
	g_PVPE_Combat				= 3
}       

local g_nBattleState			= 1							-- 战斗状态缺省为战斗中

local BATTLE_STATE 	=
{
	BATTLE_STATE_PROCESSING	    = 1,						-- 战斗中
	BATTLE_STATE_FINISH			= 2							-- 战斗完成
}

local g_PortraitImageName = {"uidenglu_touxiang1.png", "uidenglu_touxiang2.png", "uidenglu_touxiang3.png", "uidenglu_touxiang4.png"}

-- 监听延迟下发数据
local g_DelayDataListenning = false

-- 注册事件
function	CombatProcess_PreLoad()
	this:RegisterEvent("COMBATPROCESS_LOAD")						-- 载入窗口
	this:RegisterEvent("UI_COMMAND") 								-- UI事件
	this:RegisterEvent("COMBATPROCESS_UPDATE")  					-- 更新
	this:RegisterEvent("COMBATPROCESS_SELFBLOOD_LOAD")  			-- 更新我方总血量
	this:RegisterEvent("COMBATPROCESS_ENEMYBLOOD_LOAD") 			-- 更新敌方总血量
	this:RegisterEvent("COMBATPROCESS_WIN_LOAD") 					-- 战斗胜利
	this:RegisterEvent("COMBATPROCESS_FAIL_LOAD") 					-- 战斗失败
	this:RegisterEvent("COMBATPROCESS_TAKETURN_UPDATE")				-- 更新轮换
	this:RegisterEvent("COMBATPROCESS_RETREAT_HIDE")				-- 隐藏撤退
	this:RegisterEvent("COMBATPROCESS_UNITLIST_VISIBLE")			-- 单元列表隐藏
	this:RegisterEvent("COMBATPROCESS_END_DELAY_LISTEN")		    -- 结束监听下发延迟数据
end

-- 预加载标签文件
function	CombatProcess_OnLoad()
	g_CombatProcess_User[1] = CombatProcess_UserHPBar						-- 用户血条
	g_CombatProcess_User[2] = CombatProcess_UserHead						-- 用户头像
	g_CombatProcess_User[3] = CombatProcess_UserNameText				-- 用户姓名
	g_CombatProcess_User[4] = CombatProcess_UserClass_Text			-- 用户等级

	g_CombatProcess_Foe[1] = CombatProcess_FoeHPBar							-- 敌人血条
	g_CombatProcess_Foe[2] = CombatProcess_FoeHead							-- 敌人头像
	g_CombatProcess_Foe[3] = CombatProcess_FoeNameText					-- 敌人姓名
	g_CombatProcess_Foe[4] = CombatProcess_FoeClass_Text				-- 敌人等级

	g_CombatProcess_LiftMenu[1] = CombatProcess_Kzan_Button			-- 开战按钮
	g_CombatProcess_LiftMenu[2] = CombatProcess_Handup_Button		-- 托管按钮背景
	g_CombatProcess_LiftMenu[3] = CombatProcess_Handup_ButtonOne	-- 托管  
	g_CombatProcess_LiftMenu[4] = CombatProcess_Handup_ButtonTwo	-- 取消
	g_CombatProcess_LiftMenu[5] = CombatProcess_Retreat_Button		-- 撤退按键

	g_CombatProcess_DownMenu[1] = CombatProcess_DownSubMenuWindow	-- 选兵栏窗口
	g_CombatProcess_DownMenu[2] = ComnatProcess_ScrollView			-- 选兵栏
	g_CombatProcess_DownMenu[3] = CombatProcess_Cure_Button			-- 血瓶按钮
	g_CombatProcess_DownMenu[4] = CombatProcess_Shift_Button		-- 速度按钮
	g_CombatProcess_DownMenu[5] = ComnatProcess_ArmyButtonOne		-- 用户军队
	-- g_CombatProcess_DownMenu[6] = ComnatProcess_ArmyButtonTwo		-- 雇佣兵
	g_CombatProcess_DownMenu[7] = ComnatProcess_Shift_ButtonTwo		-- 速度加成
	
	g_CombatProcess_Main[1] = CombatProcess_NextRound				-- 下一回合提示的按键
	g_CombatProcess_Main[2] = ComnatProcess_Unit_Text				-- 开战士兵人数限制		
	g_CombatProcess_Main[3] = CombatProcess_ReadyGoTipWindow		-- 准备开始战斗面板
	g_CombatProcess_Main[4] = CombatProcess_PvPArrangeCoord_Text	-- PVP布阵提示文本
	g_CombatProcess_Main[5] = CombatProcess_Image_ReadyTip			-- 准备图片
	g_CombatProcess_Main[6] = CombatProcess_Image_StartTip			-- 开始图片
	g_CombatProcess_Main[7] = CombatProcess_MyHpText				-- 自己的总血量 文本
	g_CombatProcess_Main[8] = CombatProcess_EnmyHpText				-- 对方的总血量 文本
	g_CombatProcess_Main[9] = CombatProcess_Content_Text            -- 字典	【治疗】
	g_CombatProcess_Main[11] = CombatProcess_MatchCountDown_Timer	 -- 匹配倒计时定时器
	g_CombatProcess_Main[12] = CombatProcess_MatchCountDown_BarBg	-- 匹配倒计时进度条背景
	g_CombatProcess_Main[13] = CombatProcess_MatchCountDown_Bar		 -- 匹配倒计时进度条
	g_CombatProcess_Main[14] = CombatProcess_MatchCountDown_Frame	 -- 匹配倒计时进度条罩
	g_CombatProcess_Main[15] = CombatProcess_MatchCountDown_Desc	 -- 匹配倒计时字典【匹配对手中（10S匹配一次对手,祈祷你的对手是菜鸟吧）】
	g_CombatProcess_Main[16] = CombatProcess_MatchCountDown_Text	 -- 匹配定时器时间
	g_CombatProcess_Main[17] = CombatProcess_AttackRamainTimeText	 -- 攻击轮换倒计时
	g_CombatProcess_Main[18] = CombatProcess_AttackRamainTime_Timer  -- 攻击轮换倒计时
	g_CombatProcess_Main[19] = CombatProcess_AttackTakeTurnDesc		 -- 轮换描述 字典【敌方正在思考】【请下令攻击】
	g_CombatProcess_Main[20] = CombatProcess_DelayData_Timer 		 -- 对方数据下发监听定时器
end

-- 响应事件
function	CombatProcess_OnEvent(event)

	if (event == "UI_COMMAND" and tonumber(arg0) == 100001) then		-- PVE消息
		
		g_functionName	= Get_XParam_STR(1)
		g_unit			= Get_XParam_INT(1)
		g_scriptID		= Get_XParam_INT(2)
		
		-- 显示头像框数据
		CombatProcess_Update()
		
		-- 敌人
		local level = Get_XParam_INT(0)
		local name  = Get_XParam_STR(0)	
		g_CombatProcess_Foe[1]:RunFromTo(0, 100, 0) 
		g_CombatProcess_Foe[3]:SetText(tostring(name))
		g_CombatProcess_Foe[4]:SetText(tostring(level))
		
		-- 显示撤退按键
		g_CombatProcess_LiftMenu[5]:Show()	

		-- 隐藏托管	
		g_CombatProcess_LiftMenu[2]:Hide() 	
		
		-- 隐藏布阵提示
		g_CombatProcess_Main[4]:Hide()	

		-- 隐藏治疗按键	
		g_CombatProcess_DownMenu[3]:Hide()
		
		-- 隐藏匹配定时器	
		CombatProcess_HideMatchCountDown()
		
		-- 隐藏轮换定时器
		CombatProcess_HideTakeTurn()
		
		-- 显示人数
		CombatProcess_PeopleNum()		
		
		-- 显示原速
		g_CombatProcess_DownMenu[7]:SetNormal9PatchImg("ms_sudu1.png")
		g_CombatProcess_DownMenu[7]:SetSelect9PatchImg("ms_sudu1.png")
		
	elseif (event == "UI_COMMAND" and tonumber(arg0) == 100002) then -- PVP消息
		
		g_functionName	= Get_XParam_STR(0)
		g_unit 	  		= Get_XParam_INT(0)
		g_scriptID 	  	= Get_XParam_INT(1)
		
		-- 更新上场人数
		CombatProcess_PeopleNum()
		
		-- 显示头像框数据
		CombatProcess_Update()
		
		-- 对方信息
		CombatProcess_FoeWindow:Hide()
		
		-- 隐藏血瓶
		g_CombatProcess_DownMenu[3]:Hide()
		CombatProcess_VS:Hide()
		
		-- 显示撤退按键
		g_CombatProcess_LiftMenu[5]:Show()	
		
		-- 显示布阵提示
		g_CombatProcess_Main[4]:Show()
		g_CombatProcess_Main[4]:SetText("#{UITT_1000_018}")
		
		-- 隐藏匹配定时器	
		CombatProcess_HideMatchCountDown()
		
		-- 隐藏轮换定时器
		CombatProcess_HideTakeTurn()
	elseif (event == "UI_COMMAND" and tonumber(arg0) == 100003) then	-- 对方信息
		
		local level 	  = Get_XParam_INT(0)
		local loop		  = Get_XParam_INT(1)
		local name 	  	  = Get_XParam_STR(0)
		-- 赋值攻击阵营方
		g_nCurTakeTurnCamp = loop
		
		-- 对方信息
		CombatProcess_FoeWindow:Show()
		g_CombatProcess_Foe[3]:SetText(tostring(name))
		g_CombatProcess_Foe[4]:SetText(tostring(level))
			
		-- 隐藏匹配定时器	
		CombatProcess_HideMatchCountDown()
		
		-- 谁先出手
		LoopRanking(loop)

		-- 显示轮换定时器
		CombatProcess_ShowTakeTurn(loop)
		
		-- 显示托管	
		g_CombatProcess_LiftMenu[2]:Show() 	
	elseif (event == "UI_COMMAND" and tonumber(arg0) == 100004) then -- 对方离线
		
		-- 离线消息
		PushToast("#{UITT_1000_025}")
		
		-- 对方信息
		CombatProcess_FoeWindow:Hide()
	elseif (event == "UI_COMMAND" and tonumber(arg0) == 100005) then -- PVPE   PVP模式在规定时间没有匹配到玩家，自动转换PVE
		
		g_functionName	= Get_XParam_STR(0)
		g_unit 	  		= Get_XParam_INT(0)
		g_scriptID 	  	= Get_XParam_INT(1)	
		--
		local name 	  	  = Get_XParam_STR(1)
		-- 对方信息
		CombatProcess_FoeWindow:Show()
		g_CombatProcess_Foe[3]:SetText(tostring(name))
		--		
		
		SetSceneType(g_nCombatType.g_PVPE_Combat)
		
		-- 显示撤退按键
		g_CombatProcess_LiftMenu[5]:Show()	

		-- 隐藏布阵提示
		g_CombatProcess_Main[4]:Hide()	

		-- 隐藏治疗按键	
		g_CombatProcess_DownMenu[3]:Hide()

		-- 对方信息
		CombatProcess_FoeWindow:Show()
		
		-- 显示托管	
		g_CombatProcess_LiftMenu[2]:Show() 	
		
		-- 隐藏匹配定时器	
		CombatProcess_HideMatchCountDown()
		
		-- 隐藏轮换定时器
		CombatProcess_HideTakeTurn()
		
		-- 显示人数
		CombatProcess_PeopleNum()		
		
		-- 显示原速
		g_CombatProcess_DownMenu[7]:SetNormal9PatchImg("ms_sudu1.png")
		g_CombatProcess_DownMenu[7]:SetSelect9PatchImg("ms_sudu1.png")				
	elseif (event == "COMBATPROCESS_WIN_LOAD") then

		local nType = GetSceneType()
		if nType == g_nCombatType.g_PVE_Combat then --PVE
			g_RoundCount = g_RoundCount + 1
			if g_RoundCount < 3 then
				-- 显示下一关按钮
				CombatProcess_ShowNextRound()
				
				g_EnmyMaxHp	= 0				-- 敌方最大生命值
			else
				local probability = tonumber(arg0)
				g_OurMaxHp	= 0				-- 我方最大生命值
				g_EnmyMaxHp	= 0				-- 敌方最大生命值
				-- 提示战斗胜利
				CombatProcess_Win(probability)	
				g_CombatProcess_Main[7]:SetText("")
			end
		elseif( nType == g_nCombatType.g_PVP_Combat or nType == g_nCombatType.g_PVPE_Combat) then --PVP PVPE
		
			-- 提示战斗胜利
			CombatProcess_Win(0)
			g_CombatProcess_Main[7]:SetText("")
		end
		
	elseif (event == "COMBATPROCESS_FAIL_LOAD") then
	
			-- 提示战斗失败
			local probability = tonumber(arg0)
						
			CombatProcess_Fail(probability)
	
			g_OurMaxHp	= 0				-- 我方最大生命值
			g_EnmyMaxHp	= 0				-- 敌方最大生命值
			
	elseif (event == "COMBATPROCESS_LOAD") then  -- 加载战斗界面
		-- 显示界面
		this:Show()
		-- 初始化回合数
		g_RoundCount = 0
		-- 获得军事单元类型数量
		g_SolderCount = Solider:GetArmyTypeCount()
		-- 请求军事单元列表
		AskSoliderList()
		-- 界面初始化
		CombatProcess_Init()
		-- 刷新士兵列表
		CombatProcess_InitArrmyList()
		-- 显示准备战斗字样
		CombatProcess_ShowReady()

		g_CombatProcess_Main[9]:SetText("#{TXSS_1000_054}")
	elseif (event == "COMBATPROCESS_UPDATE") then   -- 更新战斗数据
		g_CurJoinCount = DataPool:GetJoinSoliderCount(0)	
		
		if(g_CurJoinCount < 1) then
			g_CombatProcess_LiftMenu[1]:DestoryButton()
		else 		
			g_CombatProcess_LiftMenu[1]:UNDestoryButton()
		end		
		CombatProcess_InitArrmyList()	
		
		CombatProcess_PeopleNum()
	elseif (event == "COMBATPROCESS_SELFBLOOD_LOAD") then -- 更新我方总血量
		if arg0 ~= nil then
			arg0 = tonumber(arg0)	 					   -- 剩余血量
			local fromPercent = g_CombatProcess_User[1]:GetPercent() 		
			local duration  = math.abs(arg0 - fromPercent) / 14
			
			if fromPercent < arg0 then
				duration = 0
			end

			if g_OurMaxHp == 0 then
				g_OurMaxHp = GetMaxHpArmed()			    -- 我方士兵生命值总和	
			end

			local endValue = ( arg0 / g_OurMaxHp ) * 100
						
			g_CombatProcess_User[1]:RunFromTo(fromPercent, endValue, duration)

			g_CombatProcess_Main[7]:SetText("#{TXSS_1000_026}: "..arg0)
		end
	elseif (event == "COMBATPROCESS_ENEMYBLOOD_LOAD") then -- 更新敌方总血量	
		if arg0 ~= nil then
			arg0 = tonumber(arg0)	 -- 血量剩余百分比
			local fromPercent = g_CombatProcess_Foe[1]:GetPercent() 		
			local duration  = math.abs(arg0 - fromPercent) / 14
			if fromPercent < arg0 then
				duration = 0
			end
			
			if g_EnmyMaxHp == 0 then
				g_EnmyMaxHp =  GetMaxHpHostile()			-- 敌方士兵生命值总和		
			end

			local endValue = ( arg0 / g_EnmyMaxHp ) * 100
			
			g_CombatProcess_Foe[1]:RunFromTo(fromPercent, endValue, duration)	
			g_CombatProcess_Main[8]:SetText("#{TXSS_1000_026}: "..arg0)
		end		
	elseif (event == "COMBATPROCESS_TAKETURN_UPDATE") then  -- 轮换更新
		-- 轮换对方阵营	
		if arg0 ~= nil then
			g_nCurTakeTurnCamp = tonumber(arg0)
			
			if g_nBattleState == BATTLE_STATE.BATTLE_STATE_FINISH then
				return			
			end
			
			CombatProcess_ShowTakeTurn(g_nCurTakeTurnCamp)
		end
	elseif (event == "COMBATPROCESS_RETREAT_HIDE") then		-- 隐藏撤退
		g_CombatProcess_LiftMenu[5]:Hide()	
	elseif (event == "COMBATPROCESS_UNITLIST_VISIBLE") then -- 单元列表显示状态
		if arg0 ~= nil then
			local bVisible = tonumber(arg0)
			if bVisible == 1 then
				g_CombatProcess_DownMenu[1]:Show()		
			elseif bVisible == 0 then
				g_CombatProcess_DownMenu[1]:Hide()		
			end
		end
	elseif (event == "COMBATPROCESS_END_DELAY_LISTEN") then
		g_CombatProcess_Main[20]:StopTime()
		g_DelayDataListenning = false
		
		g_CombatProcess_LiftMenu[2]:Show() 						  -- 显示托管		
	end
end

-- 显示头像框数据
function	CombatProcess_Update()
	-- 用户
	local UserName	= Player:GetName()
	local UserLevel	= Player:GetLevel()
	g_CombatProcess_User[1]:RunFromTo(0,100,0)
	g_CombatProcess_User[3]:SetText(tostring(UserName))
	g_CombatProcess_User[4]:SetText(tostring(UserLevel))
end

--================================
--			界面初始化
--================================
function	CombatProcess_Init()
	-- 隐藏托管按钮
	g_CombatProcess_LiftMenu[2]:Hide()
	-- 显示开战按钮
	g_CombatProcess_LiftMenu[1]:Show()
	-- 隐藏下一关按钮
	g_CombatProcess_Main[1]:Hide()
	-- 隐藏加速按键
	g_CombatProcess_DownMenu[4]:Hide()
	-- 显示托管文字
	g_CombatProcess_LiftMenu[3]:Show()
	-- 隐藏取消文字
	g_CombatProcess_LiftMenu[4]:Hide()
	-- 初始化自己头像	
	CombatProcess_UpdatePortrait()
	-- 初始化战斗状态
	g_nBattleState = BATTLE_STATE.BATTLE_STATE_PROCESSING
end

--===========================================
--				 更新头像
--===========================================
function	CombatProcess_UpdatePortrait()
	local pPortraitID = Player:GetPortraitID()
	local n_PortraitCount = #g_PortraitImageName
	if pPortraitID <= 0 or pPortraitID > n_PortraitCount then
		return
	end
	g_CombatProcess_User[2]:SetAtlasTexture(g_PortraitImageName[pPortraitID])
end

--================================
--			显示参战人数限制
--================================
function	CombatProcess_PeopleNum()

	local unitText = g_CurJoinCount.."/"..g_unit.."#{TXSS_2000_022}"
	g_CombatProcess_Main[2]:SetText(unitText)
			
end

--============================================
--			显示下一关按钮
--============================================
function	CombatProcess_ShowNextRound()
	g_CombatProcess_Main[1]:SetPosition(433, 205)	
	g_CombatProcess_Main[1]:MoveBy(10, 10, 0.2, true)
	g_CombatProcess_Main[1]:Show()
	
	g_CombatProcess_LiftMenu[2]:Hide() -- 隐藏托管
	CombatProcess_CancelHandUp()
end

--========================================
--			刷新士兵列表
--========================================
function	CombatProcess_InitArrmyList()
	g_CombatProcess_DownMenu[2]:CleanAllElement()
	local Num = 0
	local X , Y = 0,0
	local width, height = 705, 65
	for i = 0 , g_SolderCount - 1 , 1 do 
		local id,ICON = Solider:GetMilitaryInfo("Military_BaseInfo", i)
		local MIN,MAX = DataPool:GetSoliderList(i)
		if MAX > 0 and MIN > 0 then		
			CombatProcess_CreateTemp( i , ICON , MIN , MAX ,X , Y)
			X = X + 80
			Num = Num + 1
			if(X > 760)then
				width = width + 80
			end
		end
	end
	if (Num >= 10)then
		g_CombatProcess_DownMenu[2]:Touch(0)
	else
		g_CombatProcess_DownMenu[2]:Touch(-1)
	end
	g_CombatProcess_DownMenu[2]:SetContentSize(width, height)
	i = nil
end

--========================================
--				 创建模板
--========================================
function	CombatProcess_CreateTemp(ID,ICON,MIN,MAX,X,Y)

	local Function = string.format("%s%d%s","CombatProcess_ArrmyOnClick(",ID,")")
	g_CombatProcess_DownMenu[2]:AddItemIcon(15, X, Y)
	g_CombatProcess_DownMenu[2]:AddItemSelect(ICON,ICON,X+32,Y+33,Function)
	g_CombatProcess_DownMenu[2]:AddItemIcon(16, X + 51, Y + 50)	
	g_CombatProcess_DownMenu[2]:AddItemText(MIN, X + 50, Y + 50, 0, 0, "181 251 255", 18)
end

--====================================
--			显示匹配倒计时
--====================================
function	CombatProcess_ShowMatchCountDown()
	g_CombatProcess_Main[12]:Show()
	g_CombatProcess_Main[13]:Show()
	g_CombatProcess_Main[14]:Show()
	g_CombatProcess_Main[15]:Show()
	g_CombatProcess_Main[16]:Show()
	
	g_CombatProcess_Main[13]:RunFromTo(0, 100, 10)
	g_CombatProcess_Main[15]:SetText("#{UITT_1000_019}")
	
	g_CombatProcess_Main[11]:StartTime(10, 0, 1, 1)
	g_CombatProcess_Main[16]:SetText("10" .. "#{TXSS_1000_015}")
	-- 重置匹配时间	
	g_nMatchRemainTime = 10
end

--====================================
--			隐藏匹配倒计时
--====================================
function	CombatProcess_HideMatchCountDown()
	g_CombatProcess_Main[12]:Hide()
	g_CombatProcess_Main[13]:Hide()
	g_CombatProcess_Main[14]:Hide()
	g_CombatProcess_Main[15]:Hide()
	g_CombatProcess_Main[16]:Hide()
	-- 重置
	g_CombatProcess_Main[13]:RunFromTo(0, 0, 0)	
	g_CombatProcess_Main[11]:StopTime()
end

--====================================
--			显示轮换倒计时
--====================================
function	CombatProcess_ShowTakeTurn(loop)
	-- 重置轮换时间
	g_nTakeTurnRemainTime = 10	
	
	g_CombatProcess_Main[18]:StopTime()	
	g_CombatProcess_Main[18]:StartTime(10, 0, 1, 1)
		
	g_CombatProcess_Main[17]:Show()
	g_CombatProcess_Main[17]:SetText("10" .. "#{TXSS_1000_015}")
	
	g_CombatProcess_Main[19]:Show()
	local strAttackRemainTimeDesc = loop == 0 and "#{UITT_1000_024}" or "#{UITT_1000_023}"
	g_CombatProcess_Main[19]:SetText(strAttackRemainTimeDesc)
end

--====================================
--			隐藏轮换倒计时
--====================================
function	CombatProcess_HideTakeTurn()
	g_CombatProcess_Main[17]:Hide()
	g_CombatProcess_Main[18]:StopTime()
	g_CombatProcess_Main[19]:Hide()
end

--====================================
--			更新轮换倒计时
--====================================
function CombatProcess_Update_TakeTurnTime()
	if g_nBattleState == BATTLE_STATE.BATTLE_STATE_FINISH then	-- 当战斗结束的时候
		g_CombatProcess_Main[18]:StopTime()						-- 停止轮换计时器 
		g_CombatProcess_Main[17]:SetText("0#{TXSS_1000_015}")	-- 重置0秒 
		return
	end
	
	g_nTakeTurnRemainTime = g_nTakeTurnRemainTime - 1
	g_CombatProcess_Main[17]:SetText(g_nTakeTurnRemainTime .. "#{TXSS_1000_015}")
end

--====================================
--			结束轮换倒计时
--====================================
function CombatProcess_End_TakeTurnTime()
	g_CombatProcess_Main[18]:StopTime()
	
	local bEntrusting = GetEntrustState() 
	if bEntrusting == false then
		CombatProcess_StartHandUp()
	end
end

--================================================
--				更新匹配倒计时
--================================================
function CombatProcess_Update_MatchingTime()
	g_nMatchRemainTime = g_nMatchRemainTime - 1
	g_CombatProcess_Main[16]:SetText(g_nMatchRemainTime .. "#{TXSS_1000_015}")

end

--==============================================
--				重新启动匹配倒计时
--==============================================
function CombatProcess_Restart_MatchingTime()
--[[
	g_nMatchRemainTime = 10
	g_CombatProcess_Main[16]:SetText(g_nMatchRemainTime .. "#{TXSS_1000_015}")	

	g_CombatProcess_Main[13]:RunFromTo(0, 0, 0)

	g_CombatProcess_Main[11]:StopTime()	
	g_CombatProcess_Main[11]:StartTime(10, 0, 1, 1)
	
	g_CombatProcess_Main[13]:RunFromTo(0, 100, 10)
--]]
	
	CombatProcess_HideMatchCountDown()
	ClearScript()
	SetFunction("OnDefaultEvent")
	SetScriptID(800001)
	SendScript()
	
end

--====================================
--				显示准备战斗
--====================================
function	CombatProcess_ShowReady()
	g_CombatProcess_Main[3]:Show()
	g_CombatProcess_Main[5]:Show()
	g_CombatProcess_Main[6]:Hide()
	g_CombatProcess_Main[5]:setAnimation("animation",false)
end

--====================================
--				准备战斗动画结束
--====================================
function CombatProcess_Ready_SkeletonAnimationEnd()
    g_CombatProcess_Main[5]:Hide()
end

--==========================================
--				显示开始战斗
--==========================================
function	CombatProcess_ShowStartBattle()
	g_CombatProcess_Main[5]:Hide()
	g_CombatProcess_Main[6]:Show()
	g_CombatProcess_Main[6]:setAnimation("animation",false)
end

--==========================================
--				开始战斗动画结束
--==========================================
function CombatProcess_Start_SkeletonAnimationEnd()
	g_CombatProcess_Main[3]:Hide()
	g_CombatProcess_Main[5]:Hide()
	g_CombatProcess_Main[6]:Hide()
	--PushToast("start combat end")
end

--==========================================
--				点击事件	选兵
--==========================================
function	CombatProcess_ArrmyOnClick(index)
	if index < 100 and index > -1 then
	
		local SCENE_TYPE = GetSceneType()

		-- 获得参加战斗的兵种数量
		local curSoldierJoinCount = DataPool:GetJoinSoliderCount(0)	
			
		local curSoldierUseCount, MaxSoldierCount = DataPool:GetSoliderList(index)-- 获得兵种类型的可使用数量
			
		if(curSoldierUseCount <= 0)then  					-- 验证当前类型兵种，是否还有可用的
			PushToast("#{TXSS_2000_024}")		
		elseif (curSoldierJoinCount >= g_unit)then	
			PushToast("#{TXSS_2000_021}"..g_unit.."#{TXSS_2000_022}")	
		else
			CreateSolider(index)
				
			curSoldierUseCount = curSoldierUseCount - 1
			DataPool:UpdateSoliderList(index, curSoldierUseCount, MaxSoldierCount)
				
			PushEvent("COMBATPROCESS_UPDATE")				 -- 更新战斗菜单
		end
	end
end

--==========================================
--			点击【开战】事件
--==========================================
function	CombatProcess_StartBattle()

	if g_CurJoinCount == 0 or g_CurJoinCount > g_unit then   -- 满足参战人数的数量要求	
		PushMessageBox("#{TXSS_2000_018}")					  -- 添加上限提示
		
		return
	end
	
	local nType = GetSceneType()
	
	if nType == g_nCombatType.g_PVE_Combat or nType == g_nCombatType.g_PVPE_Combat then
		
		BeginFight("PVE_COMBAT")
		-- 隐藏匹配定时器	
		CombatProcess_HideMatchCountDown()	
		-- 显示治疗按键	
		--g_CombatProcess_DownMenu[3]:Show()
		-- 打开请求等待界面
		OpenRequestWaitProgress()
		-- 开启延迟监听
		CombatProcess_Start_ListenDelayTime()
	elseif nType == g_nCombatType.g_PVP_Combat then
	
		BeginFight("PVP_COMBAT")
		
		-- 隐藏撤退按键
		g_CombatProcess_LiftMenu[5]:Show()
			
		-- 隐藏布阵提示	
		g_CombatProcess_Main[4]:Hide()

		-- 显示匹配定时器	
		CombatProcess_ShowMatchCountDown()
		
	end
	
	g_CombatProcess_DownMenu[1]:Hide()
	g_CombatProcess_LiftMenu[1]:Hide()

	CombatProcess_ShowStartBattle()	

end

--==========================================
--			 点击事件	托管
--==========================================
function	CombatProcess_Delegate()
	local bool = GetEntrustState() 
	if bool == true then
		CombatProcess_CancelHandUp()
	elseif bool == false then
		CombatProcess_StartHandUp()
	end
end

--==========================================
--				 开启托管 
--==========================================
function   CombatProcess_StartHandUp()

	g_CombatProcess_LiftMenu[3]:Hide()	--隐藏托管文字
	g_CombatProcess_LiftMenu[4]:Show()	--显示取消文字
	
	local nType = GetSceneType()
	if nType == g_nCombatType.g_PVE_Combat or nType == g_nCombatType.g_PVPE_Combat then
		g_CombatProcess_DownMenu[4]:Show()	--显示加速按键
		g_CombatProcess_DownMenu[3]:Hide()	--隐藏治疗按键
	end
	
	Entrust(true)
	
end

--==========================================
--				 取消托管 
--==========================================
function   CombatProcess_CancelHandUp()
	g_CombatProcess_LiftMenu[3]:Show()	--显示托管文字
	g_CombatProcess_LiftMenu[4]:Hide()	--隐藏取消文字
	
		
	local nType = GetSceneType()
	if nType == g_nCombatType.g_PVE_Combat then
		--g_CombatProcess_DownMenu[3]:Show()	--显示治疗按键
		g_CombatProcess_DownMenu[4]:Hide()	--隐藏加速按键
	end
	
	Entrust(false)
	
end


--==========================================
--			点击事件	加速
--==========================================
function	CombatProcess_ShiftOnEvent()
	local pSpeed = GetSpeed()
	if pSpeed == 0 then
		g_CombatProcess_DownMenu[7]:SetNormal9PatchImg("ms_sudu2.png")
		g_CombatProcess_DownMenu[7]:SetSelect9PatchImg("ms_sudu2.png")
		AddSpeed(1)
	elseif pSpeed == 1 then
		g_CombatProcess_DownMenu[7]:SetNormal9PatchImg("ms_sudu1.png")
		g_CombatProcess_DownMenu[7]:SetSelect9PatchImg("ms_sudu1.png")
		AddSpeed(0)
	end
end

--==========================================
--			点击事件	加血
--==========================================
function	CombatProcess_CureOnEvent()
	local pDiamond = Player:GetDiamond()
	if ( pDiamond - 10 ) < 1 then
		PushToast("#{TIP_1000_026}")
	else
		FightTreat()
	end		
end

--==========================================
--			点击事件	下一关
--==========================================
function	CombatProcess_NextRoundOnEvent()
	g_CombatProcess_Main[1]:Hide()
	
	if g_scriptID > 0 then
		ClearScript()
		SetFunction("OnNextMonster")
		SetScriptID(g_scriptID)
		SendScript()
	else
		PushToast(g_scriptID)
	end
	--FORCES_ARMED    = 0,	//我军
	--FORCES_HOSTILE  = 1,	//敌对军队 
	Solider:SetFightTarget(0);
	g_CombatProcess_LiftMenu[2]:Show() -- 显示托管
	
	OpenRequestWaitProgress()
	
	CombatProcess_Start_ListenDelayTime()
end

--==========================================
--				战斗胜利
--==========================================
function CombatProcess_Win( param )

	if g_scriptID > 0 then
		ClearScript()
		SetFunction("OnWin")
		SetScriptID(g_scriptID)
		SetParameter(0,param)
		SetParamCount(1)
		SendScript()
	else
		PushToast(g_scriptID)		
	end
	g_nBattleState = BATTLE_STATE.BATTLE_STATE_FINISH
end

--==========================================
--				战斗失败
--==========================================
function CombatProcess_Fail(param)

	if g_scriptID > 0 then
		ClearScript()
		SetFunction("OnFail")
		SetScriptID(g_scriptID)
		SetParameter(0,param)
		SetParamCount(1)
		SendScript()
	else
		PushToast(g_scriptID)
	end
	g_nBattleState = BATTLE_STATE.BATTLE_STATE_FINISH	
end

--==========================================
--				撤退按键 事件
--==========================================
function CombatProcess_RetreatOnEvent()
	CloseAllWidget()
	
	PushEvent("LOADINGWIDGET_LOAD")
	g_CombatProcess_Main[7]:SetText("")
	-- 隐藏轮换定时器
	CombatProcess_HideTakeTurn()
			
	if g_scriptID > 0 and  g_functionName ~= "" then
		ClearScript()
		SetFunction(g_functionName)
		SetScriptID(g_scriptID)
		SendScript()
	end
	
	local nType = GetSceneType()	
	if nType == g_nCombatType.g_PVE_Combat then		
		SendCombatBalance()
	end				
end

--==========================================
--		 开始对方数据下发监听定事件
--==========================================
function CombatProcess_Start_ListenDelayTime()
	g_DelayDataListenning = true
	g_CombatProcess_Main[20]:StartTime(10, 0, 1, 1)
end

--==========================================
--		 结束对方数据下发监听定事件
--==========================================
function CombatProcess_End_ListenDelayTime()
	if g_DelayDataListenning == true then
		
		PushMessageBox("#{CUPY_4000_070}")		
				
		g_CombatProcess_Main[20]:StopTime()
		g_DelayDataListenning = false
	end
end



