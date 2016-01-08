local 	g_HeavenLadderMatch_Windows = {}

-- 排行榜列表项总数
local g_nRankListItemCount 		= 0

-- 当前排行榜列表的数据的显示高度
local g_nRankListContentHeight  = 0

-- 天梯赛剩余时间
local g_nCountDownTime = 0

-- 窗口更新的类型
local UpdateEventType = 
{
	AddRankListData   = 1,		-- 刷新排行榜列表
	UpdateRanking	  = 2,      -- 刷新名次
	UpdateArena		  = 3,      -- 刷新天梯赛
}

function	HeavenLadderMatch_PreLoad()
	this:RegisterEvent("HEAVEN_LADDER_MATCH_LOAD")						 -- 载入窗口
	this:RegisterEvent("HEAVEN_LADDER_MATCH_UPDATE")					 -- 更新窗口
end

function	HeavenLadderMatch_OnLoad()
	g_HeavenLadderMatch_Windows[1] = HeavenLadderMatch_RankList			 		-- 排行榜列表
	g_HeavenLadderMatch_Windows[2] = HeavenLadderMatch_RankMidTitleText	 		-- 排行榜标题
	g_HeavenLadderMatch_Windows[3] = HeavenLadderMatch_RankBottomMyselfCount	-- 排行版自己的所在数量
	g_HeavenLadderMatch_Windows[4] = HeavenLadderMatch_RankBottomMyself	 		-- 排行榜 我的名次 【字典】
	g_HeavenLadderMatch_Windows[5] = HeavenLadderMatch_RankTabText		 		-- 排行榜标签项
	g_HeavenLadderMatch_Windows[6] = HeavenLadderMatch_HonourTitleText	 		-- 荣誉标题
	g_HeavenLadderMatch_Windows[7] = HeavenLadderMatch_HonourSubTitleText		-- 荣誉点数子标题
	g_HeavenLadderMatch_Windows[8] = HeavenLadderMatch_HonourPointSubText		-- 荣誉点数总量
	g_HeavenLadderMatch_Windows[9] = HeavenLadderMatch_HonourPredictObtainTitle	-- 预计获得荣誉标题
	g_HeavenLadderMatch_Windows[10] = HeavenLadderMatch_HonourPredictObtainText -- 预计获得荣誉数
	g_HeavenLadderMatch_Windows[11] = HeavenLadderMatch_DetailCountDownDesc		-- 天梯赛倒计时  【字典】
	g_HeavenLadderMatch_Windows[12] = HeavenLadderMatch_DetailScoreText			-- 总积分
	g_HeavenLadderMatch_Windows[13] = HeavenLadderMatch_DetailScoreChangeDesc	-- 今日积分变化 【字典】
	g_HeavenLadderMatch_Windows[14] = HeavenLadderMatch_DetailScoreChangeText	-- 今日积分变化
	g_HeavenLadderMatch_Windows[15] = HeavenLadderMatch_DetailVicDesc			-- 胜场	【字典】
	g_HeavenLadderMatch_Windows[16] = HeavenLadderMatch_DetailVicText			-- 胜场数	
	g_HeavenLadderMatch_Windows[17] = HeavenLadderMatch_DetailDefDesc			-- 败场 【字典】
	g_HeavenLadderMatch_Windows[18] = HeavenLadderMatch_DetailDefText			-- 胜场数		
	g_HeavenLadderMatch_Windows[19] = HeavenLadderMatch_DetailBankDesc			-- 当前排行  【字典】
	g_HeavenLadderMatch_Windows[20] = HeavenLadderMatch_DetailBankText			-- 当前排行值
	g_HeavenLadderMatch_Windows[21] = HeavenLadderMatch_DetailBankChangeRateIcon -- 排行改变率图标
	g_HeavenLadderMatch_Windows[22] = HeavenLadderMatch_DetailBankChangeRateText -- 排行改变率值
	g_HeavenLadderMatch_Windows[23] = HeavenLadderMatch_DetailCountDownText		 -- 天梯赛倒计时
	g_HeavenLadderMatch_Windows[24] = HeavenLadderMatch_Time_Mich				 -- 天梯赛倒计时定时器
	g_HeavenLadderMatch_Windows[25] = HeavenLadderMatch_DetailSubScoreBG           --今日积分变化 后面的背景
	
	g_HeavenLadderMatch_Windows[26] = HeavenLadderMatch_HonourPointBG			 -- 荣誉点背景
	g_HeavenLadderMatch_Windows[27] = HeavenLadderMatch_HonourSubTitleBG		 -- 荣誉子标题背景
	g_HeavenLadderMatch_Windows[28] = HeavenLadderMatch_HonourExchange			 -- 荣誉兑换按键
end


function	HeavenLadderMatch_OnEvent(event)
	if event == "HEAVEN_LADDER_MATCH_LOAD" then
		this:Show()
		-- 初始化
		HeavenLadderMatch_Init()	
		-- 清空下一页数据
		RankData:CleanRankData()
		-- 请求服务器 获得下一页的数据
		RankData:GetRankNextPage()

	elseif event == "HEAVEN_LADDER_MATCH_UPDATE" then
		-- 事件类型是否是有效值	
		if arg0 == nil then
			return 
		end
		-- 当前界面显示更新数据	
		if this:IsVisible() then
			local nEventType = tonumber(arg0)	
			if (nEventType == UpdateEventType.AddRankListData) then	
				-- 更新排行榜列表		
				HeavenLadderMatch_UpdateRankList()	
			elseif (nEventType == UpdateEventType.UpdateRanking) then
				-- 更新我的排行名次	
				local MySelfRank = RankData:GetMyselfRankPostion()				
				g_HeavenLadderMatch_Windows[20]:SetText(tostring(MySelfRank)) -- 当前排名值
				g_HeavenLadderMatch_Windows[3]:SetText(tostring(MySelfRank))  -- 我的排名
			elseif (nEventType == UpdateEventType.UpdateArena) then		
				 local nScore  		= Player:GetScore()
				 local nHonour		= Player:GetHonour()
				 g_nCountDownTime   = Player:GetCountDown()
				 local nWinTimes	= Player:GetWinTimes()
				 local nLoseTimes	= Player:GetLoseTimes()			
				 g_HeavenLadderMatch_Windows[12]:SetText(tostring(nScore))	 -- 总积分
				-- g_HeavenLadderMatch_Windows[8]:SetText(tostring(nHonour))	 -- 荣誉总点数				 	 				 				 
				 g_HeavenLadderMatch_Windows[16]:SetText(tostring(nWinTimes))	 -- 胜场数			
				 g_HeavenLadderMatch_Windows[18]:SetText(tostring(nLoseTimes)) -- 败场数
				 
				 
				 g_HeavenLadderMatch_Windows[24]:StopTime()
				 local CountTime = HeavenLadderMatch_GetTime(g_nCountDownTime)
				 g_HeavenLadderMatch_Windows[23]:SetText(tostring(CountTime))
				 g_HeavenLadderMatch_Windows[24]:StartTime(g_nCountDownTime, 0, 1, 1)
			end
		end
		CloseRequestWaitProgress()	
	end
end

--==============================================
--					初始化
--==============================================
function 	HeavenLadderMatch_Init()
	 
	 g_HeavenLadderMatch_Windows[4]:SetText(" #{UITT_1000_016}")
	 -- 荣誉
	 g_HeavenLadderMatch_Windows[6]:SetText("#{UITT_1000_001}")    -- 字典【荣誉】	
	 g_HeavenLadderMatch_Windows[7]:SetText("#{UITT_1000_002}")	   -- 字典 【我的荣誉点数】

	 g_HeavenLadderMatch_Windows[9]:SetText("#{UITT_1000_003}")    -- 字典【今日预计获得】 
	 g_HeavenLadderMatch_Windows[10]:SetText("99")   			    -- 获得荣誉数值
	 g_HeavenLadderMatch_Windows[11]:SetText("#{UITT_1000_009}")   -- 字典【天梯赛倒计时】

	 g_HeavenLadderMatch_Windows[13]:SetText("#{UITT_1000_005}")   -- 字典【今日积分变化】
	 g_HeavenLadderMatch_Windows[14]:SetText("+99")				    -- 今日积分变化值
	 
	 g_HeavenLadderMatch_Windows[25]:Hide()  --今日积分变化 后面的背景
	-- g_HeavenLadderMatch_Windows[13]:Hide()  -- 字典【今日积分变化】隐藏
	-- g_HeavenLadderMatch_Windows[14]:Hide()  -- 今日积分变化值 隐藏
	 
	 g_HeavenLadderMatch_Windows[15]:SetText("#{UITT_1000_006}")   -- 字典 【胜场】

	 g_HeavenLadderMatch_Windows[17]:SetText("#{UITT_1000_007}")    -- 字典 【败场】

	 g_HeavenLadderMatch_Windows[19]:SetText("#{UITT_1000_008}")    -- 字典 【当前排名】
	 g_HeavenLadderMatch_Windows[22]:SetText("1000")			     -- 排行率值
	 
	 g_HeavenLadderMatch_Windows[21]:Hide()      ---- 排行改变率图标 隐藏
	 g_HeavenLadderMatch_Windows[22]:Hide()      -- 排行率值 隐藏 
	 g_HeavenLadderMatch_Windows[23]:Hide()      -- 天梯赛倒计时 隐藏
	 g_HeavenLadderMatch_Windows[11]:Hide()      -- 天梯赛倒计时[字典] 隐藏
	 g_HeavenLadderMatch_Windows[2]:SetText("#{UITT_1000_012}") 	 -- 字典【排行榜】
	 
	 g_HeavenLadderMatch_Windows[5]:SetText(" #{UITT_1000_013} " .. "  #{UITT_1000_014}  " .. " #{UITT_1000_015}") -- 字典【名次 昵称 积分】
	
	 g_HeavenLadderMatch_Windows[26]:Hide()			-- 荣誉点背景
	 g_HeavenLadderMatch_Windows[27]:Hide()			-- 荣誉子标题背景
	 g_HeavenLadderMatch_Windows[28]:Hide()			-- 荣誉兑换按键
	 -- 重置数据
	 HeavenLadderMatch_ResetData()	
end

--==============================================
--			 额外添加排行版列表项数量
--==============================================
function    HeavenLadderMatch_AddRankListItemCount(ExtraRankListItemCount)
	g_nRankListItemCount = g_nRankListItemCount + ExtraRankListItemCount
end

--==============================================
--				天梯赛倒计时更新
--==============================================
function HeavenLadderMatch_Update_Time()
	g_nCountDownTime = g_nCountDownTime - 1
	if 	g_nCountDownTime < 0 then
		g_nCountDownTime = 0	
	end
	local CountTime = HeavenLadderMatch_GetTime(g_nCountDownTime)
	g_HeavenLadderMatch_Windows[23]:SetText(tostring(CountTime))	
end

--==============================================
--				更新排行列表
--				
--==============================================
function 	HeavenLadderMatch_UpdateRankList()
	local nExtraRankIncrement = RankData:GetRankData("CurPageCount")
	-- 添加到统计容器中 保存总数
	HeavenLadderMatch_AddRankListItemCount(nExtraRankIncrement)	
	-- 列表项高度
	local nCellHeight = 35
	local nRankListHeight = 245
	for i = 0, nExtraRankIncrement - 1, 1 do
		local nRanking, nName, nScore = RankData:GetRankData("CurPageItem", tonumber(i))		
		HeavenLadderMatch_AddRankListItem(nRanking, nName, nScore)	
		
		g_nRankListContentHeight = g_nRankListContentHeight + nCellHeight	
	end
	
	g_HeavenLadderMatch_Windows[1]:SetContentSize(187, g_nRankListContentHeight)

	local  offsetY = g_nRankListContentHeight <= nRankListHeight and nRankListHeight - g_nRankListContentHeight or -(g_nRankListContentHeight - nRankListHeight)
		g_HeavenLadderMatch_Windows[1]:SetContentOffset(0, offsetY)

end

--==============================================
--				添加天梯赛排行榜项
--==============================================
function	HeavenLadderMatch_AddRankListItem(Ranking, Name, Score) 
	local TextColor = "255 255 255"	

	if Ranking % 2 == 1 then
		g_HeavenLadderMatch_Windows[1]:AddImage9Patch("uitianti_paihangbg.png", 0, (g_nRankListItemCount - Ranking) * 35, 2, 187, 35, true)	
	end
	if Ranking < 4 then  
		TextColor = "255 210 0"	
	end
	
	g_HeavenLadderMatch_Windows[1]:AddItemText(Ranking, 0,   (g_nRankListItemCount - Ranking) * 35, 50, 35, TextColor, 18, "Center")	
	g_HeavenLadderMatch_Windows[1]:AddItemText(Name,    39,  (g_nRankListItemCount - Ranking) * 35, 90, 35, TextColor, 18, "Center")	
	g_HeavenLadderMatch_Windows[1]:AddItemText(Score,   129, (g_nRankListItemCount - Ranking) * 35, 52, 35, TextColor, 18, "Center")	
	
end

--==============================================
--				兑换荣誉的点击事件
--==============================================
function HeavenLadderMatch_HonourExchangeClick()
	PushToast("#{TIP_1000_027}")
end

--==============================================
--				参加天梯赛的点击事件
--==============================================
function     HeavenLadderMatch_JoinMatchClick()
	
	CloseAllWidget()
	
	PushEvent("LOADINGWIDGET_LOAD")
	
	--进入场景
	ClearScript()
	SetFunction("OnDefaultEvent")
	SetScriptID(800000)
	SendScript()	
	
end

--==============================================
--				点击请求获得下一页事件
--==============================================
function 	 HeavenLadderMatch_GetNextPageClick()
	-- 请求服务器 获得下一页的数据
	RankData:GetRankNextPage()
	
end

--==============================================
--			     数据重置
--==============================================
function     HeavenLadderMatch_ResetData()
	-- 清空排行列表数据
	g_HeavenLadderMatch_Windows[1]:CleanAllElement()		
	-- 排行榜列表项总数	
	g_nRankListItemCount = 0
	-- 重置排行榜列表的数据的显示高度
	g_nRankListContentHeight = 0
end

--==============================================
--					关闭窗口
--==============================================
function 	 HeavenLadderMatch_Close()
	-- 隐藏界面	
	this:Hide()	
	-- 清空排行数据池的数据
	RankData:CleanRankData()
	-- 重置数据
	HeavenLadderMatch_ResetData()
end

--==============================================
--					获得剩余时间
--==============================================
function HeavenLadderMatch_GetTime(sec)
	local TimeFormat = os.date("*t", tonumber(sec))
	local strTime = ""
	if TimeFormat.day - 1 > 0 then
		strTime = string.format("%d%s",TimeFormat.day - 1, "#{UITT_1000_010}")
	end
	if TimeFormat.hour - 8 > 0	then
		strTime = string.format("%s%d%s",strTime, TimeFormat.hour - 8, "#{JZCD_1000_004}")
	end	
	if TimeFormat.min > 0 then
		strTime = string.format("%s%d%s",strTime, TimeFormat.min, "#{TXSS_1000_014}")
	end
	if TimeFormat.sec > 0 then
		strTime = string.format("%s%d%s",strTime, TimeFormat.sec, "#{TXSS_1000_015}")
	end	
	
	return strTime
end