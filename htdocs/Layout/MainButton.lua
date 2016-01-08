local g_MainButton_Main = {}	

local UpdateEventType = 
{
	AddRankListData   = 1,				  -- ˢ�����а��б�
}

local g_bHeavenLadderChampionNameAssigned = false  -- ���а�ھ������Ƿ񱻸�ֵ

function	MainButton_PreLoad()
	this:RegisterEvent("MAIN_BUTTON_LOAD")
	this:RegisterEvent("HEAVEN_LADDER_MATCH_UPDATE")
end

function	MainButton_OnLoad()
	g_MainButton_Main[1] = Main_Image						-- �̵걳����Ȧ
	g_MainButton_Main[2] = Main_TianTiName					-- �������ھ����� �ı���
	g_MainButton_Main[3] = Main_HeavenLadderBGLight			-- ������������Ȧ
end

function	MainButton_OnEvent(event)
	if ( event == "MAIN_BUTTON_LOAD" ) then
		this:Show()
		g_MainButton_Main[1]:Show()
		g_MainButton_Main[2]:Show()
		g_MainButton_Main[3]:Show()
		g_MainButton_Main[1]:StartRotation(1, 180, true)

		g_MainButton_Main[3]:StartRotation(1, 180, true)		
		if g_bHeavenLadderChampionNameAssigned == false then
			RankData:CleanRankData()
			RankData:GetRankNextPage()
		end
	elseif (event == "HEAVEN_LADDER_MATCH_UPDATE") then	
		
		if arg0 == nil then
			return 
		end		
		local nEventType = tonumber(arg0)	

		if this:IsVisible() 
		and nEventType == UpdateEventType.AddRankListData 
		and g_bHeavenLadderChampionNameAssigned == false 
		then	
			local nRanking, nName, nScore = RankData:GetRankData("CurPageItem", tonumber(0))
			g_MainButton_Main[2]:SetText("")
			g_bHeavenLadderChampionNameAssigned = true
		end
	end
end

--=======================================
--			 �����������¼�
--=======================================
function	MainButton_SportsMatch_Click()
	OpenRequestWaitProgress()	
	PushEvent("HEAVEN_LADDER_MATCH_LOAD")
	-- ��������������
	SendArenaData()	
end

function	MainButton_Shop_Click()

	OpenRequestWaitProgress()	
	
	CloseAllWidget()
	
	--���ʹ��̵���Ϣ
	ClearScript()
	SetFunction("OnDefaultEvent")
	SetScriptID(100000)
	SendScript()	
	
end
function MainButton_Guess_Click()

	PushEvent("GUESS_LOAD")
end

