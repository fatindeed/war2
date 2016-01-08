local g_Home_Main = {}		  --存储仓库
local g_Home_Produce_Time = 0 --生产剩余时间
local g_Home_produce_TotalTime = 0 --生产总时间
local g_Home_produce_TotalGold = 0 --生产金币总数量
local g_Home_produce_TotalExp = 0 --生产金币总数量

local g_Supply_Depot = {}	--	仓库进度条

local g_Shop_Const = 600000	--	平台币兑换率

local g_Home_State = {STATE_NULL = -1,STATE_CREATE_ING = 0,STATE_CUROPEN = 1,STATE_NORMAL = 2,STATE_WORK_WAIT=3,STATE_WORK_STOP=4,STATE_COLSE=5,STATE_PRODUCE_TING=6,STATE_HARVEST=7}
local BUILDING_PRODUCTION = 2
function	Home_PreLoad()
	this:RegisterEvent("HOME_LOAD")
	this:RegisterEvent("HOME_UPDATE")
	this:RegisterEvent("SUPPLY_BASE_LOAD")	 		 --供给站生产中
	this:RegisterEvent("SUPPLY_BASE_UPDATE") 		 --供给站收集资源完成

	--this:RegisterEvent("HOME_NONE_HEART")			 --没有受伤单元
end

function	Home_OnLoad()
	--g_Home_Main[1] = Home_Work_Switch
	--g_Home_Main[2] = Home_Level_Button
	g_Home_Main[3] = Home_Name_Text
	--g_Home_Main[4] = Home_Level_Text
	g_Home_Main[5] = Home_People_Text
	
	g_Home_Main[6] = Home_Coin_Img
	g_Home_Main[7] = Home_Exp_Img
	g_Home_Main[8] = Home_Coin_Text
	g_Home_Main[9] = Home_Exp_Text
	
	g_Home_Main[10] = Home_Recv_Text
	g_Home_Main[11] = Home_Recv_Time_Text
	g_Home_Main[12] = Home_Close_Button
	g_Home_Main[13] = Home_AddSpeed_Button_Text	--加速按键文本
	g_Home_Main[14] = Home_Recv_Button
	g_Home_Main[15] = Home_Time_Mich
	
	g_Home_Main[16] = Home_Create_Text      --字典"建造中"文本
	g_Home_Main[17] = Home_CreateTime_Text
	g_Home_Main[18] = Home_AddSpeed_Button
	g_Home_Main[19] = Home_CreateExp_Background_Img
	g_Home_Main[20] = Home_CreateExp
	g_Home_Main[21] = Home_Exp_Light_Img
	g_Home_Main[22] = Home_BuildTime_Mich
	
	g_Home_Main[23] = Home_ToBuild
	g_Home_Main[24] = Home_People_Img
	g_Home_Main[25] = Home_Resource_Text
	g_Home_Main[26] = Home_ScrollView
	
	g_Home_Main[27] = Home_Res_Name
	g_Home_Main[28] = Home_Res_Icon
	g_Home_Main[29] = Home_Res_Num		
	
	g_Home_Main[30] = Home_ToBuild_Text	      	    --建造确定文本
	g_Home_Main[31] = Home_Recv_Button_Text	        --收集确定文本
	
	g_Home_Main[33] = Home_Name_GoldFrame_Bg		--收集金币进度条背景
	g_Home_Main[34] = Home_Name_GoldBar				--收集金币进度条
	g_Home_Main[35] = Home_Name_GoldBar_Frame	    --收集金币进度条外框
	
	g_Home_Main[36] = Home_Name_ExpFrame_Bg         --收集经验进度条背景
	g_Home_Main[37] = Home_Name_ExpBar			    --收集经验进度条
	g_Home_Main[38] = Home_Name_ExpBar_Frame	    --收集经验进度条外框
	
	g_Home_Main[39] = Home_BuildStorage_Button		--创建仓库按键
	g_Home_Main[40] = Home_BuildStorage_Button_Text	--创建仓库按键文本
	
	
	g_Supply_Depot[1] = Home_Coin_Icon
	g_Supply_Depot[2] = Home_Coin_Count_Bar
	g_Supply_Depot[3] = Home_Coin_Count
	
	g_Supply_Depot[4] = Home_Stell_Icon
	g_Supply_Depot[5] = Home_Stell_Count_Bar
	g_Supply_Depot[6] = Home_Stell_Count
	
	g_Supply_Depot[7] = Home_Oil_Icon
	g_Supply_Depot[8] = Home_Oil_Count_Bar
	g_Supply_Depot[9] = Home_Oil_Count
	
	g_Supply_Depot[10] = Home_Name_CoinFrame_Bg
	g_Supply_Depot[11] = Home_Coin_Frame
	
	g_Supply_Depot[12] = Home_Name_StellFrame_Bg
	g_Supply_Depot[13] = Home_Stell_Frame

	g_Supply_Depot[14] = Home_Name_OilFrame_Bg
	g_Supply_Depot[15] = Home_Oil_Frame
	
end

----	窗口事件		>>>>>>>>>>>>>>>>>>>>
function	Home_OnEvent(event)
	if event=="HOME_LOAD" then
		if arg0 == nil then
			this:Hide()
			return 		
		end	
		this:Show()	
		local Index = tonumber(arg0)
		g_Home_Main[10]:Show()
		g_Home_Main[11]:Show()
		g_Home_Main[14]:Hide()
		for i = 16,22,1 do 
			g_Home_Main[i]:Hide()		
		end	
		g_Home_Main[27]:Hide()
		g_Home_Main[28]:Hide()
		g_Home_Main[29]:Hide()
		g_Home_Main[39]:Hide()
		g_Home_Main[40]:Hide()		
		local pState = BuildData:GetMainTargetBuildState("MainTargetBuild_State_ID")
			
		if pState == g_Home_State.STATE_CREATE_ING then	-- 建造中	
			Home_ReadData(Index)	
			Home_Create()
			g_Home_Main[26]:Hide()		
			Home_VisibleSupplyDepot(false)	
		elseif pState == g_Home_State.STATE_PRODUCE_TING then	-- 生产中
			local pTYPE ,_ = BuildData:GetMainTargetBuildState("MainTargetBuild_TYPE_ID")
			if pTYPE == BUILDING_PRODUCTION then	
				Home_ResData(Index)
				Home_ReadData(Index)	
				g_Home_Main[27]:Show()
				g_Home_Main[28]:Show()
				g_Home_Main[29]:Show()

				for i = 6,11,1 do 
					g_Home_Main[i]:Hide()				
				end			
				for i = 14,23,1 do
					g_Home_Main[i]:Hide()				
				end
				g_Home_Main[25]:Hide()
				g_Home_Main[26]:Hide()
				for i = 33,38,1 do
					g_Home_Main[i]:Hide()				
				end				
			else
				Home_ReadData(Index)	
				Home_GetPortory(Index)
				g_Home_Main[26]:Hide()
			end
		end
		Home_VisibleSupplyDepot(false)
	elseif event == "HOME_UPDATE" then
		Home_Update_State()
		Home_VisibleSupplyDepot(false)	
	elseif event == "SUPPLY_BASE_LOAD" then		
		if arg0 == nil then
			this:Hide()
			return 		
		end	

		this:Show()	
		
		local Index = tonumber(arg0)	
		
		Home_HideOutOfSupply()
		
		Home_ReadData(Index)	
	
		g_Home_Main[26]:CleanAllElement()
		g_Home_Main[26]:Touch(-1)
		local surplusTime, totalTime = BuildData:GetMainTargetBuildState("MainTargetBuild_ProduceTime")
		g_Home_Produce_Time = surplusTime
		g_Home_Main[10]:SetText("#{TXSS_1000_016}")
		g_Home_Main[15]:StartTime(math.ceil(surplusTime/1000), 0, 1, 1)
		g_Home_Main[11]:SetText(" " .. Home_GetTime(g_Home_Produce_Time/1000))
--		Home_ShowResItemForList()
			
		g_Home_Main[10]:Show()

		g_Home_Main[11]:Show()

		g_Home_Main[15]:Show()

		g_Home_Main[12]:Show()

		g_Home_Main[24]:Show()

		Home_VisibleSupplyDepot(true)
		Home_InitSupplyDepot()
		
	elseif event == "SUPPLY_BASE_UPDATE" then			
		
		--g_Home_Main[14]:Show()

		g_Home_Main[31]:SetText("#{TXSS_1000_042}")
		--Home_VisibleSupplyDepot(false)
	end
end

----	读取数据			>>>>>>>>>>>>>>>
function	Home_ReadData(Index)
	local tTYPE, tNAME, tLEVEL, rTYPE, tIMG, uPopulation, unPopulation = BuildData:GetBuildInfo("Unmilitary_Title", Index)
	--g_Home_Main[1]:Hide()
	g_Home_Main[23]:Hide()
	g_Home_Main[25]:Hide()
	--g_Home_Main[13]:SetTexture(tIMG)	
	g_Home_Main[3]:SetText(tNAME)
	--g_Home_Main[4]:SetText("#{TXSS_1000_037}"..":   "..tLEVEL)	
	if tTYPE == 0 then		--->> 住房类建筑
		local _,_,tPopulation,_,_,_ = BuildData:GetHouseInfo(Index)
		g_Home_Main[5]:SetText("+"..tPopulation)
	else		
		--g_Home_Main[1]:Show()	
		g_Home_Main[5]:SetText("-"..uPopulation)
		if uPopulation == 0 then
			g_Home_Main[24]:Hide()
			g_Home_Main[5]:Hide()		
		end
	end
end

----	获取当前建筑的属性		>>>>>>>>>>>
function	Home_GetPortory(tIndex)
	local tNAME, tLEVEL, uIndex, tIMG = BuildData:GetBuildInfo("Unmilitary_HouseTitle", tIndex)
	local _,_,_,gEXP,gCOIN,_ = BuildData:GetHouseInfo(uIndex)
	
	for i = 6,9,1 do 
		g_Home_Main[i]:Show()		
	end	

	Home_Init_ProduceItem_Pos()
	
	g_Home_produce_TotalGold = gCOIN
	g_Home_produce_TotalExp = gEXP
	
	-- 生产总时间 和 剩余时间
	local surplusTime, totalTime = BuildData:GetMainTargetBuildState("MainTargetBuild_ProduceTime")
	g_Home_Produce_Time = surplusTime
	g_Home_produce_TotalTime = totalTime
	
	g_Home_Main[10]:SetText("#{TXSS_1000_016}")
	g_Home_Main[15]:StartTime(surplusTime/1000, 0, 1, 1)
	g_Home_Main[11]:SetText(" " .. Home_GetTime(g_Home_Produce_Time/1000))
	
	if gCOIN < 1 then	--->越界不显示
		g_Home_Main[6]:Hide()
		g_Home_Main[8]:Hide()
		g_Home_Main[33]:Hide()
		g_Home_Main[34]:Hide()
		g_Home_Main[35]:Hide()
	end
	if gEXP < 1 then	--->越界不显示
		g_Home_Main[7]:Hide()
		g_Home_Main[9]:Hide()	
		g_Home_Main[36]:Hide()
		g_Home_Main[37]:Hide()
		g_Home_Main[38]:Hide()			
		if gCOIN > 0 then
			g_Home_Main[6]:SetPosition(20, 155)
			g_Home_Main[8]:SetPosition(160, 165)		
			g_Home_Main[33]:SetPosition(35, 165)
			g_Home_Main[34]:SetPosition(35, 166)
			g_Home_Main[35]:SetPosition(35, 165)
		end
	end
	Home_Update_ProduceItem_Count()
	Home_Update_ProduceItem_ProcessBar(surplusTime)
end

--=========================================
-- 				更新剩余时间	
--=========================================
function	Home_Update_Time()
	g_Home_Produce_Time = g_Home_Produce_Time - 1000
	g_Home_Main[11]:SetText(" " .. Main_GetTimeS(g_Home_Produce_Time/1000))
	
	Home_Update_ProduceItem_Count()
	Home_Update_Resource()
end

--=========================================
--			更新建造剩余时间 
--=========================================
function	Home_Update_Build_Time()
	g_Home_Produce_Time = g_Home_Produce_Time - 1000
	
	if 	g_Home_Produce_Time < 0 then
		g_Home_Produce_Time = 0	
	end
	
	g_Home_Main[17]:SetText(Main_GetTimeS(g_Home_Produce_Time/1000))
	
	
	local uPtb = g_Home_Produce_Time / g_Shop_Const	
	
	g_Ptb = math.ceil(uPtb)
	
	g_Home_Main[13]:SetText(g_Ptb)
end

--=========================================
--      	初始化收集物品的位置 
--=========================================
function	Home_Init_ProduceItem_Pos() --321
	g_Home_Main[6]:SetPosition(20, 213)
	g_Home_Main[7]:SetPosition(20, 141)
	g_Home_Main[8]:SetPosition(160, 224)
	g_Home_Main[9]:SetPosition(160, 148)	
	g_Home_Main[33]:SetPosition(35, 226)
	g_Home_Main[34]:SetPosition(35, 225)
	g_Home_Main[35]:SetPosition(35, 224)
	g_Home_Main[36]:SetPosition(35, 151)
	g_Home_Main[37]:SetPosition(35, 150)
	g_Home_Main[38]:SetPosition(35, 149)
end

--=========================================
--			  更新生产物的数量 
--=========================================
function   	Home_Update_ProduceItem_Count()
	local CurProduceCount = math.modf((g_Home_produce_TotalTime - g_Home_Produce_Time) * g_Home_produce_TotalGold / g_Home_produce_TotalTime)
	g_Home_Main[8]:SetText("#{TXSS_1000_005}:"..tonumber(CurProduceCount).."/"..g_Home_produce_TotalGold)
	
	local CurProduceExpCount = math.modf((g_Home_produce_TotalTime - g_Home_Produce_Time) * g_Home_produce_TotalExp / g_Home_produce_TotalTime)
	g_Home_Main[9]:SetText("#{TXSS_1000_082}:"..tonumber(CurProduceExpCount).."/"..g_Home_produce_TotalExp)
end

--=========================================
--			 更新生产物的进度条 
--=========================================
function   	Home_Update_ProduceItem_ProcessBar(surplusTime)
	if (math.floor(g_Home_produce_TotalTime) <= 0) then
		return
	end	
	local tBegin = 100 - (100 *(surplusTime / g_Home_produce_TotalTime))		
	g_Home_Main[34]:RunFromTo(tBegin, 100, surplusTime/1000)	
	g_Home_Main[37]:RunFromTo(tBegin, 100, surplusTime/1000)
end

--=========================================
--				建筑收获事件		
--=========================================
function	Home_ToRecv()
	g_Home_Main[10]:Hide()
	g_Home_Main[11]:Hide()
	--g_Home_Main[14]:Show()
	g_Home_Main[31]:SetText("#{TXSS_1000_042}")
end

--=========================================
--				关闭点击事件	
--=========================================
function	Home_Close()
	this:Hide()
	BuildData:UnMainTarget()
	g_Home_Main[15]:StopTime()
	g_Home_Main[22]:StopTime()
	g_Home_Main[20]:RunFromTo(0,0,0)
	
	Home_Reset()
end

--=========================================
--		    	收集按钮点击事件	
--=========================================
function	Home_Recv_Click()
	BuildData:RecviedBuildProduct()	---> 发送收集请求
	local _,COIN,STELL,OIL,_,_,_ = BuildData:GetResourceInfo(0)	
	--PushToast("#{TIP_1000_030}:"..COIN.."#{TXSS_1000_005}"..STELL.."#{TXSS_1000_028}"..OIL.."#{TXSS_1000_029}!")
end

--=========================================
--			      加速请求		
--=========================================
function	Home_AddSpeed_Click()
	local Index =	BuildData:GetMainTargetBuildState("MainTargetBuild_ID")
	PushEvent( "COMMON_TIP_BUY",1,Index)
end

--=========================================
--				时间计算方法	
--=========================================
function 	Home_GetTime(sec)
	local strTime = Main_GetTimeS(sec)

	return strTime
end

--=========================================
--				更新房子的状态		
--=========================================
function	Home_Update_State()
	local pState = BuildData:GetMainTargetBuildState("MainTargetBuild_State_ID")
	if pState == g_Home_State.STATE_PRODUCE_TING then	-- 生产中
		local surplusTime, totalTime = BuildData:GetMainTargetBuildState("MainTargetBuild_ProduceTime")
		g_Home_Produce_Time = surplusTime
		g_Home_Main[10]:SetText("#{TXSS_1000_016}") --收集剩余时间文本
		g_Home_Main[15]:StartTime(surplusTime/1000, 0, 1, 1)
		g_Home_Main[11]:SetText(" " .. Main_GetTimeS(g_Home_Produce_Time/1000))
		
		g_Home_Main[10]:Show()	--收集剩余时间文本
		g_Home_Main[11]:Show()	--收集剩余时间数字
		g_Home_Main[14]:Hide()	--隐藏收集按键		
		Home_Update_ProduceItem_ProcessBar(surplusTime)					
	elseif pState == g_Home_State.STATE_HARVEST	then		-- 收获状态
		Home_ToRecv()
		g_Home_Main[10]:SetText("")
	elseif pState == g_Home_State.STATE_CUROPEN then		-- 剪彩状态
		Home_Close()
	end
end

--=========================================
--				建造中			
--=========================================
function	Home_Create()
	for i = 16,22,1 do 
		g_Home_Main[i]:Show()		
	end
	for i = 6,11,1 do 
		g_Home_Main[i]:Hide()	
	end
	for i = 33,38,1 do
		g_Home_Main[i]:Hide()				
	end	
	
	g_Home_Main[25]:Hide()
	g_Home_Main[16]:SetText("#{JZCD_3000_002}")	
	g_Home_Main[13]:SetText("#{TXSS_1000_085}")
	local tResTime,tTotalTime = BuildData:GetMainTargetBuildState("MainTargetBuild_ConstructTime")	-- 获取剩余时间 和 总时间

	if (tResTime >= 0 and tTotalTime > 0) then
		local tBegin = 100 - (100 *(tResTime / tTotalTime))
		g_Home_Produce_Time = tResTime
		g_Home_Main[20]:RunFromTo(tBegin,100,tResTime/1000)
		g_Home_Main[17]:SetText(Main_GetTimeS(tResTime/1000))		
		g_Home_Main[22]:StartTime(tResTime/1000, 0, 1, 1)
	end	

end

----	资源		
function	Home_Resource()
	this:Hide()
end

function	Home_AddResItemForList(ImgID, x, y, count, textID)	
	g_Home_Main[26]:AddItemText(count..textID, x, y, 60, 20,"255 255 255",14) 	
	g_Home_Main[26]:AddItemIcon(ImgID, x + 10, y + 30)
end

function	Home_ShowResItemForList()
	local x, y = 90, 10	
	local _,COIN,STELL,OIL,_,STONE,BOOM = BuildData:GetResourceInfo(0)	
	
	if(COIN > 0) then
		Home_AddResItemForList(84, x, y, COIN, "#{TXSS_1000_005}")
		x = x + 60
	end
	if(STELL > 0) then
		Home_AddResItemForList(87, x, y, STELL, "#{TXSS_1000_028}")
		x = x + 60
	end
	if(OIL > 0) then
		Home_AddResItemForList(88, x, y, OIL, "#{TXSS_1000_029}")
		x = x + 60
	end
	local surplusTime = BuildData:GetMainTargetBuildState("MainTargetBuild_ProduceTime")
end

function	Home_ResData(buildID)
	local NAME, LEVEL, ProductionID, ICON, WORKPERSON = BuildData:GetBuildInfo("ResourceDescribe_CollectTitle",buildID)
	local _,_,_,_, ResTime, ResCount, ResIcon = BuildData:GetResourceInfo(ProductionID)
	local MinCount = ResTime/1000/60	--总的分钟数
	
	if (math.floor(MinCount) <= 0) then
		return
	end	
		
	g_Home_Main[27]:SetText(math.modf(ResCount/MinCount).." /#{TXSS_1000_014}")
	g_Home_Main[28]:SetTexture(ResIcon)
	g_Home_Main[29]:SetText("#{TXSS_1000_083}")
	g_Home_Main[40]:SetText("#{TXSS_1000_040}".."#{TXSS_1000_084}")
end

function	Home_ToBuildA()
	this:Hide()
	PushEvent("BUILD_CHOOSE_TOBUILD", 3, 6)
end

--=========================================
--			隐藏资源点界面以外的控件
--=========================================
function 	Home_HideOutOfResource()
	g_Home_Main[3]:Hide()
	for i = 5, 12, 1 do
		g_Home_Main[i]:Hide()	
	end	
	for i = 14, 22, 1 do
		g_Home_Main[i]:Hide()	
	end		
	g_Home_Main[24]:Hide()
end

--===========================================
--			隐藏资源储备库以外的控件
----=========================================
function 	Home_HideOutOfSupply()
	for i = 6,9,1 do 
		g_Home_Main[i]:Hide()		
	end	
	g_Home_Main[14]:Hide()	
	for i = 16,23,1 do 
		g_Home_Main[i]:Hide()		
	end
	g_Home_Main[25]:Hide()	
	g_Home_Main[27]:Hide()
	g_Home_Main[28]:Hide()
	g_Home_Main[29]:Hide()
	for i = 33,38,1 do
		g_Home_Main[i]:Hide()				
	end	
	g_Home_Main[39]:Hide()
	g_Home_Main[40]:Hide()
	
end

--=========================================
--			显示供给站的UI
--=========================================
function	Home_VisibleSupplyDepot( bool )
	if bool == true then
		for i = 1, 15, 1 do 
			g_Supply_Depot[i]:Show()
		end
	elseif bool == false then
		for i = 1, 15, 1 do 
			g_Supply_Depot[i]:Hide()
		end
	end
end

--=========================================
--				初始化数据
--=========================================
function	Home_InitSupplyDepot()
	
	local surplusTime, totalTime = BuildData:GetMainTargetBuildState("MainTargetBuild_ProduceTime")
	local g_ExpPosition = ( totalTime - surplusTime ) / totalTime
	local g_ResTime = surplusTime / 1000
	local _,COIN,STELL,OIL,_,_,_ = BuildData:GetResourceInfo(0)	
		
	g_Supply_Depot[2]:RunFromTo( g_ExpPosition*100, 100, surplusTime/1000 )
	g_Supply_Depot[3]:SetText("#{TXSS_1000_005}: "..math.ceil( COIN * g_ExpPosition ).."/" ..COIN)
		
	g_Supply_Depot[5]:RunFromTo( g_ExpPosition*100, 100, surplusTime/1000 )
	g_Supply_Depot[6]:SetText("#{TXSS_1000_028}: "..math.ceil( STELL * g_ExpPosition ).."/"..STELL)
		
	g_Supply_Depot[8]:RunFromTo( g_ExpPosition*100, 100, surplusTime/1000 )
	g_Supply_Depot[9]:SetText("#{TXSS_1000_029}: "..math.ceil( OIL * g_ExpPosition ).."/"..OIL)

end

--=========================================
--				更新添加的资源数
--=========================================
function	Home_Update_Resource()
	if  g_Supply_Depot[3]:IsVisible() then
		local surplusTime, totalTime = BuildData:GetMainTargetBuildState("MainTargetBuild_ProduceTime")
		local g_ExpPosition = ( totalTime - surplusTime ) / totalTime
		
		local g_ResTime = surplusTime / 1000
		local _,COIN,STELL,OIL,_,_,_ = BuildData:GetResourceInfo(0)	
		
		local rCoin = math.ceil(COIN * g_ExpPosition)
		if rCoin > COIN then
			rCoin = COIN		
		end
		g_Supply_Depot[3]:SetText("#{TXSS_1000_005}: "..rCoin.."/" ..COIN)
		
		local rStell = math.ceil(STELL * g_ExpPosition)
		if rStell > STELL then
			rStell = STELL		
		end
		g_Supply_Depot[6]:SetText("#{TXSS_1000_028}: "..rStell.."/"..STELL)
		
		local rOil = math.ceil(OIL * g_ExpPosition) 
		if rOil > OIL then
			rOil = OIL	
		end
		g_Supply_Depot[9]:SetText("#{TXSS_1000_029}: "..rOil.."/"..OIL)
	end
end

function 	Home_Reset()
	 g_Home_Produce_Time 	  = 0 -- 生产剩余时间
	 g_Home_produce_TotalTime = 0 -- 生产总时间
	 g_Home_produce_TotalGold = 0 -- 生产金币总数量
	 g_Home_produce_TotalExp  = 0 -- 生产金币总数量
end

