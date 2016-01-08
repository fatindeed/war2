local 	g_HeavenLadderMatch_Windows = {}

-- ���а��б�������
local g_nRankListItemCount 		= 0

-- ��ǰ���а��б�����ݵ���ʾ�߶�
local g_nRankListContentHeight  = 0

-- ������ʣ��ʱ��
local g_nCountDownTime = 0

-- ���ڸ��µ�����
local UpdateEventType = 
{
	AddRankListData   = 1,		-- ˢ�����а��б�
	UpdateRanking	  = 2,      -- ˢ������
	UpdateArena		  = 3,      -- ˢ��������
}

function	HeavenLadderMatch_PreLoad()
	this:RegisterEvent("HEAVEN_LADDER_MATCH_LOAD")						 -- ���봰��
	this:RegisterEvent("HEAVEN_LADDER_MATCH_UPDATE")					 -- ���´���
end

function	HeavenLadderMatch_OnLoad()
	g_HeavenLadderMatch_Windows[1] = HeavenLadderMatch_RankList			 		-- ���а��б�
	g_HeavenLadderMatch_Windows[2] = HeavenLadderMatch_RankMidTitleText	 		-- ���а����
	g_HeavenLadderMatch_Windows[3] = HeavenLadderMatch_RankBottomMyselfCount	-- ���а��Լ�����������
	g_HeavenLadderMatch_Windows[4] = HeavenLadderMatch_RankBottomMyself	 		-- ���а� �ҵ����� ���ֵ䡿
	g_HeavenLadderMatch_Windows[5] = HeavenLadderMatch_RankTabText		 		-- ���а��ǩ��
	g_HeavenLadderMatch_Windows[6] = HeavenLadderMatch_HonourTitleText	 		-- ��������
	g_HeavenLadderMatch_Windows[7] = HeavenLadderMatch_HonourSubTitleText		-- ���������ӱ���
	g_HeavenLadderMatch_Windows[8] = HeavenLadderMatch_HonourPointSubText		-- ������������
	g_HeavenLadderMatch_Windows[9] = HeavenLadderMatch_HonourPredictObtainTitle	-- Ԥ�ƻ����������
	g_HeavenLadderMatch_Windows[10] = HeavenLadderMatch_HonourPredictObtainText -- Ԥ�ƻ��������
	g_HeavenLadderMatch_Windows[11] = HeavenLadderMatch_DetailCountDownDesc		-- ����������ʱ  ���ֵ䡿
	g_HeavenLadderMatch_Windows[12] = HeavenLadderMatch_DetailScoreText			-- �ܻ���
	g_HeavenLadderMatch_Windows[13] = HeavenLadderMatch_DetailScoreChangeDesc	-- ���ջ��ֱ仯 ���ֵ䡿
	g_HeavenLadderMatch_Windows[14] = HeavenLadderMatch_DetailScoreChangeText	-- ���ջ��ֱ仯
	g_HeavenLadderMatch_Windows[15] = HeavenLadderMatch_DetailVicDesc			-- ʤ��	���ֵ䡿
	g_HeavenLadderMatch_Windows[16] = HeavenLadderMatch_DetailVicText			-- ʤ����	
	g_HeavenLadderMatch_Windows[17] = HeavenLadderMatch_DetailDefDesc			-- �ܳ� ���ֵ䡿
	g_HeavenLadderMatch_Windows[18] = HeavenLadderMatch_DetailDefText			-- ʤ����		
	g_HeavenLadderMatch_Windows[19] = HeavenLadderMatch_DetailBankDesc			-- ��ǰ����  ���ֵ䡿
	g_HeavenLadderMatch_Windows[20] = HeavenLadderMatch_DetailBankText			-- ��ǰ����ֵ
	g_HeavenLadderMatch_Windows[21] = HeavenLadderMatch_DetailBankChangeRateIcon -- ���иı���ͼ��
	g_HeavenLadderMatch_Windows[22] = HeavenLadderMatch_DetailBankChangeRateText -- ���иı���ֵ
	g_HeavenLadderMatch_Windows[23] = HeavenLadderMatch_DetailCountDownText		 -- ����������ʱ
	g_HeavenLadderMatch_Windows[24] = HeavenLadderMatch_Time_Mich				 -- ����������ʱ��ʱ��
	g_HeavenLadderMatch_Windows[25] = HeavenLadderMatch_DetailSubScoreBG           --���ջ��ֱ仯 ����ı���
	
	g_HeavenLadderMatch_Windows[26] = HeavenLadderMatch_HonourPointBG			 -- �����㱳��
	g_HeavenLadderMatch_Windows[27] = HeavenLadderMatch_HonourSubTitleBG		 -- �����ӱ��ⱳ��
	g_HeavenLadderMatch_Windows[28] = HeavenLadderMatch_HonourExchange			 -- �����һ�����
end


function	HeavenLadderMatch_OnEvent(event)
	if event == "HEAVEN_LADDER_MATCH_LOAD" then
		this:Show()
		-- ��ʼ��
		HeavenLadderMatch_Init()	
		-- �����һҳ����
		RankData:CleanRankData()
		-- ��������� �����һҳ������
		RankData:GetRankNextPage()

	elseif event == "HEAVEN_LADDER_MATCH_UPDATE" then
		-- �¼������Ƿ�����Чֵ	
		if arg0 == nil then
			return 
		end
		-- ��ǰ������ʾ��������	
		if this:IsVisible() then
			local nEventType = tonumber(arg0)	
			if (nEventType == UpdateEventType.AddRankListData) then	
				-- �������а��б�		
				HeavenLadderMatch_UpdateRankList()	
			elseif (nEventType == UpdateEventType.UpdateRanking) then
				-- �����ҵ���������	
				local MySelfRank = RankData:GetMyselfRankPostion()				
				g_HeavenLadderMatch_Windows[20]:SetText(tostring(MySelfRank)) -- ��ǰ����ֵ
				g_HeavenLadderMatch_Windows[3]:SetText(tostring(MySelfRank))  -- �ҵ�����
			elseif (nEventType == UpdateEventType.UpdateArena) then		
				 local nScore  		= Player:GetScore()
				 local nHonour		= Player:GetHonour()
				 g_nCountDownTime   = Player:GetCountDown()
				 local nWinTimes	= Player:GetWinTimes()
				 local nLoseTimes	= Player:GetLoseTimes()			
				 g_HeavenLadderMatch_Windows[12]:SetText(tostring(nScore))	 -- �ܻ���
				-- g_HeavenLadderMatch_Windows[8]:SetText(tostring(nHonour))	 -- �����ܵ���				 	 				 				 
				 g_HeavenLadderMatch_Windows[16]:SetText(tostring(nWinTimes))	 -- ʤ����			
				 g_HeavenLadderMatch_Windows[18]:SetText(tostring(nLoseTimes)) -- �ܳ���
				 
				 
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
--					��ʼ��
--==============================================
function 	HeavenLadderMatch_Init()
	 
	 g_HeavenLadderMatch_Windows[4]:SetText(" #{UITT_1000_016}")
	 -- ����
	 g_HeavenLadderMatch_Windows[6]:SetText("#{UITT_1000_001}")    -- �ֵ䡾������	
	 g_HeavenLadderMatch_Windows[7]:SetText("#{UITT_1000_002}")	   -- �ֵ� ���ҵ�����������

	 g_HeavenLadderMatch_Windows[9]:SetText("#{UITT_1000_003}")    -- �ֵ䡾����Ԥ�ƻ�á� 
	 g_HeavenLadderMatch_Windows[10]:SetText("99")   			    -- ���������ֵ
	 g_HeavenLadderMatch_Windows[11]:SetText("#{UITT_1000_009}")   -- �ֵ䡾����������ʱ��

	 g_HeavenLadderMatch_Windows[13]:SetText("#{UITT_1000_005}")   -- �ֵ䡾���ջ��ֱ仯��
	 g_HeavenLadderMatch_Windows[14]:SetText("+99")				    -- ���ջ��ֱ仯ֵ
	 
	 g_HeavenLadderMatch_Windows[25]:Hide()  --���ջ��ֱ仯 ����ı���
	-- g_HeavenLadderMatch_Windows[13]:Hide()  -- �ֵ䡾���ջ��ֱ仯������
	-- g_HeavenLadderMatch_Windows[14]:Hide()  -- ���ջ��ֱ仯ֵ ����
	 
	 g_HeavenLadderMatch_Windows[15]:SetText("#{UITT_1000_006}")   -- �ֵ� ��ʤ����

	 g_HeavenLadderMatch_Windows[17]:SetText("#{UITT_1000_007}")    -- �ֵ� ���ܳ���

	 g_HeavenLadderMatch_Windows[19]:SetText("#{UITT_1000_008}")    -- �ֵ� ����ǰ������
	 g_HeavenLadderMatch_Windows[22]:SetText("1000")			     -- ������ֵ
	 
	 g_HeavenLadderMatch_Windows[21]:Hide()      ---- ���иı���ͼ�� ����
	 g_HeavenLadderMatch_Windows[22]:Hide()      -- ������ֵ ���� 
	 g_HeavenLadderMatch_Windows[23]:Hide()      -- ����������ʱ ����
	 g_HeavenLadderMatch_Windows[11]:Hide()      -- ����������ʱ[�ֵ�] ����
	 g_HeavenLadderMatch_Windows[2]:SetText("#{UITT_1000_012}") 	 -- �ֵ䡾���а�
	 
	 g_HeavenLadderMatch_Windows[5]:SetText(" #{UITT_1000_013} " .. "  #{UITT_1000_014}  " .. " #{UITT_1000_015}") -- �ֵ䡾���� �ǳ� ���֡�
	
	 g_HeavenLadderMatch_Windows[26]:Hide()			-- �����㱳��
	 g_HeavenLadderMatch_Windows[27]:Hide()			-- �����ӱ��ⱳ��
	 g_HeavenLadderMatch_Windows[28]:Hide()			-- �����һ�����
	 -- ��������
	 HeavenLadderMatch_ResetData()	
end

--==============================================
--			 ����������а��б�������
--==============================================
function    HeavenLadderMatch_AddRankListItemCount(ExtraRankListItemCount)
	g_nRankListItemCount = g_nRankListItemCount + ExtraRankListItemCount
end

--==============================================
--				����������ʱ����
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
--				���������б�
--				
--==============================================
function 	HeavenLadderMatch_UpdateRankList()
	local nExtraRankIncrement = RankData:GetRankData("CurPageCount")
	-- ��ӵ�ͳ�������� ��������
	HeavenLadderMatch_AddRankListItemCount(nExtraRankIncrement)	
	-- �б���߶�
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
--				������������а���
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
--				�һ������ĵ���¼�
--==============================================
function HeavenLadderMatch_HonourExchangeClick()
	PushToast("#{TIP_1000_027}")
end

--==============================================
--				�μ��������ĵ���¼�
--==============================================
function     HeavenLadderMatch_JoinMatchClick()
	
	CloseAllWidget()
	
	PushEvent("LOADINGWIDGET_LOAD")
	
	--���볡��
	ClearScript()
	SetFunction("OnDefaultEvent")
	SetScriptID(800000)
	SendScript()	
	
end

--==============================================
--				�����������һҳ�¼�
--==============================================
function 	 HeavenLadderMatch_GetNextPageClick()
	-- ��������� �����һҳ������
	RankData:GetRankNextPage()
	
end

--==============================================
--			     ��������
--==============================================
function     HeavenLadderMatch_ResetData()
	-- ��������б�����
	g_HeavenLadderMatch_Windows[1]:CleanAllElement()		
	-- ���а��б�������	
	g_nRankListItemCount = 0
	-- �������а��б�����ݵ���ʾ�߶�
	g_nRankListContentHeight = 0
end

--==============================================
--					�رմ���
--==============================================
function 	 HeavenLadderMatch_Close()
	-- ���ؽ���	
	this:Hide()	
	-- ����������ݳص�����
	RankData:CleanRankData()
	-- ��������
	HeavenLadderMatch_ResetData()
end

--==============================================
--					���ʣ��ʱ��
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