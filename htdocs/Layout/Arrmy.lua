local 	g_Arrmy_Main = {}
local 	g_SolderCount 		 = 0						    -- 军事单元类型数量
local	SCENE_TYPE_GAMELOGIC = 0							-- 玩家自己的场景
local	SCENE_TYPE_COPY 	 = 1							-- 副本场景
local	SCENE_TYPE_NUMBERS   = 2
local 	g_unit 				 = 0							-- 单元信息
local 	g_crrent 			 = -1

function	Arrmy_PreLoad()
	this:RegisterEvent("ARRMY_LOAD")						-- 载入窗口
	this:RegisterEvent("ARRMY_UPDATE")						-- 刷新数据
	this:RegisterEvent("ARRMY_UNLOAD")						-- 卸载窗口
	this:RegisterEvent("UI_COMMAND") 						-- UI事件
end

function	Arrmy_OnLoad()
	g_Arrmy_Main[1] = Arrmy_ScrollView						-- 滑动框	
	g_Arrmy_Main[2] = Arrmy_Arrmy_Button					-- 士兵列表按钮
	g_Arrmy_Main[3] = Arrmy_Unit_Button						-- 军队列表按钮
	g_Arrmy_Main[5] = Arrmy_Content_Text					-- 内容
	g_Arrmy_Main[6] = Arrmy_SubWindow						-- 拦截区域
end

function	Arrmy_OnEvent(event)

	if (event == "UI_COMMAND" and tonumber(arg0) == 100001) then
		g_unit	= Get_XParam_INT(1)
	elseif ( event == "ARRMY_LOAD" ) then
		this:Show()

		g_SolderCount = Solider:GetArmyTypeCount()		
		
		AskSoliderList()
		Arrmy_ReadData()
		g_crrent = -1
		g_Arrmy_Main[2]:UNDestoryButton()
		g_Arrmy_Main[2]:Hide()
		
		g_Arrmy_Main[3]:DestoryButton()		
		local SCENE_TYPE = GetSceneType()
		if SCENE_TYPE_GAMELOGIC == SCENE_TYPE then		---->>>>>>>主场景的时候
			g_Arrmy_Main[5]:SetText("#{DYXX_1000_032}")
			g_Arrmy_Main[6]:Show()
			g_Arrmy_Main[2]:Show()				--士兵列表按钮
			g_Arrmy_Main[3]:Show()
		else											---->>>>>>>其他场景的时候				
			g_Arrmy_Main[5]:SetText("#{ZDXG_1000_005}")
			g_Arrmy_Main[6]:Hide()
			g_Arrmy_Main[2]:Hide()				--士兵列表按钮
			g_Arrmy_Main[3]:Hide()
		end

	elseif event == "ARRMY_UPDATE" then
		Arrmy_ReadData()								---->>>>>>>更新士兵列表
	elseif event == "ARRMY_UNLOAD" then
		this:Hide()
	end
end
--****************************************************
--		显示军事列表
--****************************************************
function	Arrmy_list()
	
end

--****************************************************
--		关闭窗口
--****************************************************
function	Arrmy_Close()
	CloseAllWidget()
	PushEvent("MAIN_MENU_LOAD")
	PushEvent("RESOURCE_BAR_LOAD")
	PushEvent("PORTRAIT_LEFT_LOAD")
	PushEvent("TASK_LIST_LOAD")
	PushEvent("MAIN_CHAT_LOAD")	
end

--****************************************************
--		显示出征士兵列表
--****************************************************
function	Arrmy_Waite()
	
end

--****************************************************
--		收集出征的士兵
--****************************************************
function	Arrmy_IsRecv()
	
end

--****************************************************
--				创建窗口模板
--****************************************************
function	Arrmy_CreateWindow( ID , PIC , MIN, MAX, X ,Y)
	local Function = string.format("%s%d%s","Arrmy_OnClick(",ID,")")
	g_Arrmy_Main[1]:AddItemIcon(15, X, Y)
	g_Arrmy_Main[1]:AddItemSelect(PIC,PIC,X+32,Y+33,Function)
	g_Arrmy_Main[1]:AddItemIcon(16, X + 51, Y + 50)	
	g_Arrmy_Main[1]:AddItemIcon(16, X + 51, Y)
	g_Arrmy_Main[1]:AddItemText(MIN, X + 50, Y + 50, 0, 0, "181 251 255", 18)
	g_Arrmy_Main[1]:AddItemText(MAX, X + 50, Y, 0, 0, "249 6 0", 18)
	
end

--****************************************************
--				读取数据
--****************************************************
function	Arrmy_ReadData()
	g_Arrmy_Main[1]:CleanAllElement()
	g_Arrmy_Main[1]:SetContentOffset(0,0)
	local Num = 0
	local X , Y = 0,0
	local width, height = 705, 65

	for i = 0 , g_SolderCount - 1 , 1 do 
		local _,ICON = Solider:GetMilitaryInfo("Military_BaseInfo", i)
		local MIN,MAX = DataPool:GetSoliderList(i)
		if MAX > 0 then
			Arrmy_CreateWindow( i , ICON , MIN , MAX ,X , Y)
			X = X + 80
			Num = Num + 1
			if(X > 760)then
				width = width + 80
			end
		end
	end
	if (Num >= 10)then
		g_Arrmy_Main[1]:Touch(0)
	else
		g_Arrmy_Main[1]:Touch(-1)
	end
	g_Arrmy_Main[1]:SetContentSize(width, height)
	i = nil
end

--****************************************************
--				军事界面点击事件
--****************************************************
function	Arrmy_OnClick(arg)
	local index = tonumber(arg)
	if index < 100 and index > -1 then
		local SCENE_TYPE = GetSceneType()
		if SCENE_TYPE_GAMELOGIC == SCENE_TYPE then
			-- 打开军事单元详情界面		
			PushEvent("UNITDETAILS_LOAD", index)	
			-- 请求属性
			Solider:AskUnitDesc(index)
		else -- 战斗场景
			-- 获得参加战斗的兵种数量
			local curSoldierJoinCount = DataPool:GetJoinSoliderCount(0)	
			-- 获得兵种类型的可使用数量
			local curSoldierUseCount, MaxSoldierCount = DataPool:GetSoliderList(index)
			-- 验证当前类型兵种，是否还有可用的
			if(curSoldierUseCount <= 0)then  
				PushMessageBox("#{TXSS_2000_024}")		
			elseif (curSoldierJoinCount >= g_unit)then	
				PushMessageBox("#{TXSS_2000_021}"..g_unit.."#{TXSS_2000_022}")	
			else
				CreateSolider(index)
				
				curSoldierUseCount = curSoldierUseCount - 1
				DataPool:UpdateSoliderList(index, curSoldierUseCount, MaxSoldierCount)
				--更新战斗菜单
				PushEvent("COMBATPROCESS_UPDATE")
			end
		end
	end
end

function	Arrmy_Arrmy()
	--g_Arrmy_Main[1]:Hide()
	--g_Arrmy_Main[2]:DestoryButton()
	--g_Arrmy_Main[3]:UNDestoryButton()
end

function	Arrmy_Unit()
	g_Arrmy_Main[1]:Show()
	-- g_Arrmy_Main[2]:UNDestoryButton()
	g_Arrmy_Main[3]:DestoryButton()
end

---------------------------创建军队信息选项卡>>>>>>>>>>>>>>
function	Arrmy_CreateMatch(tID,X,Y,PIC)
		local Function = string.format("Arrmy_MatchClick(",tID,")")
		g_Arrmy_Main[1]:AddItemButton(PIC,X,Y-20,Function)
end

---------------------------军队信息选项卡 点击事件>>>>>>>>>
function	Arrmy_MatchClick(arg)
	
end