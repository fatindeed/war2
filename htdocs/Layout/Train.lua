local g_Train_Element = {}							-- ����Ԫ��
local g_Train_Type = {BARRACK = 8, FACTORY = 9}	-- ��������
local g_nBuildTypeID 		= -1				    -- ��������ID
local g_Arrmy_Type = {SOLIDER = 0, TANK = 1}		-- ��������
local g_Train_MilitaryNum 	= 0					-- ���µ�Ԫ���͸���
local g_Train_Cur_Index		= -1
local g_Train_Index			= -1
local g_Train_State			= -1
local g_Train_State = {STATE_NORMAL = 2, STATE_WORK_WAIT=3, STATE_COLSE=5, STATE_PRODUCE_TING=6, STATE_HARVEST=7}
local g_Train_CurTrainIndex = -1 					-- ѵ���Ŷ����

local COSTMONEY = 0									-- ������Ϸ��
local COSTPLATFORMMONEY = 0							-- ����ƽ̨��
local COSTIRON = 0									-- ������
local COSTOIL = 0									-- ����ʯ��
local g_surplusTime = 0
function	Train_PreLoad()
	this:RegisterEvent("TRAIN_SOLIDER_LOAD")
	this:RegisterEvent("TRAIN_SOLIDER_UPDATE") 
	this:RegisterEvent("TRAIN_SOLIDER_DETAIL_UPDATE") 
end

function	Train_OnLoad()
	g_Train_Element[1] = Train_Untrain_ScrollView	-- û��ѵ�����б�
	g_Train_Element[2] = Train_UnitAtk_Text			-- ʿ��������
	g_Train_Element[3] = Train_UnitHp_Text			-- ʿ������ֵ
	g_Train_Element[4] = Train_UnitDef_Text			-- ʿ��������
	g_Train_Element[5] = Train_Unitpic_Image		-- ʿ��ͼ��
	g_Train_Element[6] = Train_ScrollView2			-- ������Դ
	g_Train_Element[7] = Train_Costdetail_Text		-- "ѵ��ʣ��ʱ��"
	g_Train_Element[8] = Train_Train_Button			-- ѵ����ť
	g_Train_Element[9] = Train_BuildingName_Text	-- ��������
	g_Train_Element[10] = Train_UnitInfo_Button_Text-- �ֵ�[�鿴����]
	g_Train_Element[11] = Train_ManReduce_Text		-- �����˿�����
	g_Train_Element[12] = Train_List_Image			-- ѵ���б���ͼ
	g_Train_Element[13] = Train_Unithead_Image		-- ѵ���е�ʿ��ͼ��
	g_Train_Element[14] = Train_ListName_Text		-- ѵ���е�ʿ������
	g_Train_Element[15] = Train_Quicken_Button_Text -- ���ٰ�ť�ı�
	g_Train_Element[16] = Train_Training_ScrollView	-- ѵ���еĻ�����
	g_Train_Element[17] = Train_Quicken_Button		-- ���ٰ�ť
	g_Train_Element[18] = Train_Time_Text			-- ʣ��ʱ��
	g_Train_Element[19] = Train_Exp_Background_Img	-- ����������ͼ
	g_Train_Element[20] = Train_CreateExp			-- ������
	g_Train_Element[21] = Train_Exp_Light_Img		-- ��������Ч
	g_Train_Element[22] = Train_Collect_Button		-- �ռ���ť
	g_Train_Element[23] = Train_Unithead_Level		-- ѵ���е�ʿ���ȼ�
	g_Train_Element[24] = Train_Unithead_Training	-- ��ǰѵ����Ԫ����ı� �ֵ䡾ѵ���С�
	g_Train_Element[25] = Train_Time_Timer			-- ��ʱ��
	g_Train_Element[26] = Train_Train_Text			-- ѵ��������ȷ���ı�
	g_Train_Element[27] = Train_Collect_Button_Text -- �ռ�������ȷ���ı�
	g_Train_Element[28] = Train_SkillLock1_Button	-- ����ͼ��1
	g_Train_Element[29]	= Train_Desc_Content		-- ��Ԫ��ϸ����
	g_Train_Element[30] = Train_UnitAtk_Mark_Text	-- ʿ��������
	g_Train_Element[31] = Train_UnitHp_Mark_Text	-- ʿ������ֵ
	g_Train_Element[32] = Train_UnitDef_Mark_Text	-- ʿ��������
	
	g_Train_Element[33] = Train_ScrollView3
end


--�����¼�
function	Train_OnEvent(event)
	if event == "TRAIN_SOLIDER_LOAD" then
		-- ������������µ�Ԫ����
		Solider:AskUnitDesc(0) 					   
		-- �����Ŀ�꽨��ID
		local Index = BuildData:GetMainTargetBuildState("MainTargetBuild_ID")
		-- ��þ��µ�Ԫ��������	
		g_Train_MilitaryNum = Solider:GetArmyTypeCount()		
		-- ��ʾ����	
		this:Show()	
		-- ��ʾ����
		Train_ShowTitleInfo(Index)
		-- ��ʼ������
		Train_InitWindow()
			
		g_Train_Element[6]:Touch(-1)
		-- ���浱ǰ���½�������
		g_nBuildTypeID = Index

		if Index == g_Train_Type.BARRACK then				-- ��Ӫ
			
			Train_ToWork(g_Arrmy_Type.SOLIDER)
			Train_ReadDataForType(g_Arrmy_Type.SOLIDER)				
		elseif Index == g_Train_Type.FACTORY then
			
			Train_ToWork(g_Arrmy_Type.TANK)				
			Train_ReadDataForType(g_Arrmy_Type.TANK)		-- ̹�˹���
		else												-- ������ ����
			this:Hide()
		end		
	elseif event == "TRAIN_SOLIDER_UPDATE" then	
		if g_nBuildTypeID == g_Train_Type.BARRACK then		-- ��Ӫ
			Train_ToWork(g_Arrmy_Type.SOLIDER)
		elseif g_nBuildTypeID == g_Train_Type.FACTORY then	-- ս������
			Train_ToWork(g_Arrmy_Type.TANK)
		else												-- ������ ����
			this:Hide()
		end	
		CloseRequestWaitProgress()			
	elseif event == "TRAIN_SOLIDER_DETAIL_UPDATE" then	
		if g_nBuildTypeID == g_Train_Type.BARRACK then		-- ��Ӫ
			Train_LoadMilitaryDetailInfo(g_Train_Cur_Index)	
		elseif g_nBuildTypeID == g_Train_Type.FACTORY then	-- ս������
			Train_LoadMilitaryDetailInfo(g_Train_Cur_Index)	
		else												-- ������ ����
			this:Hide()
		end		
		CloseRequestWaitProgress()						
	end
end

--***************************************************
--				 ��ʾ������Ϣ
--				 ����ID
--***************************************************
function 	Train_ShowTitleInfo(ID)
	local uNAME, _, WorkPerson = BuildData:GetBuildInfo("Train_Title", ID)		
	g_Train_Element[9]:SetText(uNAME)
	g_Train_Element[11]:SetText("-"..WorkPerson)
end

--***************************************************
--				��ʼ���ȴ�״̬��UI
--				
--***************************************************
function	Train_InitWindow()
	g_Train_Element[7]:Hide()	
	g_Train_Element[12]:Hide()
	g_Train_Element[13]:Hide()
	g_Train_Element[14]:Hide()
	g_Train_Element[23]:Hide()
	g_Train_Element[24]:Hide()
	for i = 16,22,1 do
		g_Train_Element[i]:Hide()
	end 
	g_Train_Element[15]:SetText("#{TXSS_1000_085}")
	g_Train_Element[10]:SetText("#{TXSS_1000_088}")
end

--***************************************************
--				��ȡʿ����Ϣ
--				���ڡ�����
--***************************************************
function	Train_ReadDataForType(curType)
	g_Train_Element[1]:CleanAllElement()
	g_Train_Element[1]:UnSelectItem()			-- ж�ظ���ѡ�п�
	local curTypeUnitCount = 0
	local contentHeight = 366
	local X, Y = 0, 0
	local ShowIndex = 0
	local tableUnitLevelSort = {}
	local nTableUnitLevelOffsetIndex = 1
	-- ��ȡ��Ϣ�����������
	for i = g_Train_MilitaryNum - 1, 0, -1 do 
		local ID, ICON, NAME, LEVEL, TYPE = Solider:GetMilitaryInfo("Military_BaseInfo", i)
		if (curType == TYPE) then
			tableUnitLevelSort[nTableUnitLevelOffsetIndex] = {ID, ICON, NAME, LEVEL}	
			-- ��߼���
			nTableUnitLevelOffsetIndex = nTableUnitLevelOffsetIndex + 1		
		end
	end		
	-- �ȼ�����
	local UnitLevelSort = function (a, b) 
		return a[4] < b[4]
	end
	table.sort(tableUnitLevelSort, UnitLevelSort)
	-- ��������������
	for i = #tableUnitLevelSort, 1, -1 do 	-- �������µ�Ԫ��Ϣ��(�����ȴ�״̬)		
		Train_CreateArrmyItem(tableUnitLevelSort[i][1], tableUnitLevelSort[i][2], tableUnitLevelSort[i][3], X, Y, tableUnitLevelSort[i][4])
		local pLevel	=	Player:GetLevel()
		if pLevel < tableUnitLevelSort[i][4] then
			g_Train_Element[1]:AddItemScaleIcon(412 , X + 9, Y + 6, "1")
		end
		Y = Y + 87
		curTypeUnitCount = curTypeUnitCount + 1
		if Y > 366 then	
			contentHeight = contentHeight + ((Y - 366 >= 87 and 87) or Y - 366)		
		end
		ShowIndex = tableUnitLevelSort[i][1]
		g_Train_Cur_Index = tableUnitLevelSort[i][1]
	end
	g_Train_Element[1]:SetSelectItem(curTypeUnitCount - 1)
	g_Train_Element[1]:SetContentSize(218, contentHeight) 						--�������ݳ���		
	if contentHeight > 366 then	
		g_Train_Element[1]:SetContentOffset(0, -(contentHeight - 366))			--��������ƫ�� (��Ϊ�Ǵ������ϻ���)
	end	
	Train_LoadMilitaryDetailInfo(ShowIndex)	
end

--***************************************************
--				��������ѡ�
--				���ڡ�ID��ͼ�ꡢ���֡�x��y���ȼ�
--***************************************************
function	Train_CreateArrmyItem(ID, ICON, NAME, X, Y, Level)
	local Function = string.format("%s%d%s","Train_OnClick(",ID,")")
	-- �б�ѡ���	
	g_Train_Element[1]:AddImage9Patch("arrmy_commond.png", X, Y, 2, 202, 86, true) 			
	-- �б�ѡ���		
	g_Train_Element[1]:AddItemSelect9Patch("empty.png", "c_ckuang.png",X + 101, Y + 42, 198, 76, 24, Function)
	-- ���µ�Ԫͼ��			
	g_Train_Element[1]:AddItemScaleIcon(ICON , X + 10, Y + 10, "1")
	-- ���µ�Ԫ����				
	g_Train_Element[1]:AddItemText(NAME, X + 90, Y + 35, 180, 34, "0 255 255", 18)	
	-- ���µ�Ԫ�ȼ�
	g_Train_Element[1]:AddItemText("LV." .. Level, X + 5, Y + 50, 180, 34, "0 255 255", 15)	
end

--***************************************************
--					��������ѡ�
--***************************************************
function	Train_CreateWorkItem(ID, NAME, ICON, X, Y, Level)
		local Function = string.format("%s%d%s","Train_OnClick(",ID,")")
		-- �б�ѡ���	
		g_Train_Element[16]:AddImage9Patch("arrmy_commond.png", X, Y, 2, 202, 86, true) 
		--�б�ѡ���
		g_Train_Element[16]:AddItemSelect9Patch("empty.png", "c_ckuang.png",X + 101, Y + 42, 198, 76, 24, Function)
		
		g_Train_Element[16]:AddItemScaleIcon(ICON , X + 10, Y + 10, "1")

		g_Train_Element[16]:AddItemText(NAME, X + 90, Y + 35, 180, 34, "0 255 255", 18)
		-- ���µ�Ԫ�ȼ�
		g_Train_Element[16]:AddItemText("LV." .. Level, X + 5, Y + 50, 180, 34, "0 255 255", 15)			
end

--***************************************************
--			 ������µ�Ԫ�б��¼�
--***************************************************
function	Train_OnClick(arg)
	if arg == nil then
		return	
	end
	local index = tonumber(arg)
	
	if index >= 0 and index < g_Train_MilitaryNum then
		-- ��ǰ���ѡ����ڵ�ǰ���� ����	
		if g_Train_Cur_Index == index then
			return		
		end
		-- ���õ�ǰ��Ԫ������	
		g_Train_Cur_Index = index	
		-- ������������µ�Ԫ����
		Solider:AskUnitDesc(index) 		
		
		Train_LoadMilitaryDetailInfo(index)
		local pState = BuildData:GetMainTargetBuildState("MainTargetBuild_State_ID")
		g_Train_Element[6]:Show()
		g_Train_Element[7]:Hide()
		if pState ==g_Train_State.STATE_PRODUCE_TING then
			for i = 17 ,21,1 do 
				g_Train_Element[i]:Hide()			
			end
			g_Train_Element[22]:Hide()
			g_Train_Element[8]:Show()
			g_Train_Element[26]:SetText("#{TXSS_1000_044}")
		elseif pState == g_Train_State.STATE_HARVEST then
			for i = 17,21,1 do 
				g_Train_Element[i]:Hide()
			end
			g_Train_Element[22]:Hide()
			g_Train_Element[8]:Show()
			g_Train_Element[26]:SetText("#{TXSS_1000_044}")			
		else		
			for i = 17,22,1 do 
				g_Train_Element[i]:Hide()			
			end
			g_Train_Element[8]:Show()
			g_Train_Element[26]:SetText("#{TXSS_1000_044}")			
		end
		
	end
end

--***************************************************
--				��ǰ����ѵ����ʿ��
--				
--***************************************************
function	Train_SelectUnitInfoOnClick()
	local pState = BuildData:GetMainTargetBuildState("MainTargetBuild_State_ID")
	g_Train_Element[6]:Hide()
	g_Train_Element[8]:Hide()	
	g_Train_Element[7]:Show()
	g_Train_Element[16]:UnSelectItem()		--ж�ظ���ѡ�п�
	local _, _, Index = BuildData:GetMainTargetBuildState("MainTargetBuild_ProduceTime")
	Train_OnTrainData(Index)		
	if pState ==g_Train_State.STATE_PRODUCE_TING then
		g_Train_Element[17]:Show()
		for i = 18,21,1 do 
			g_Train_Element[i]:Show()		
		end
		g_Train_Element[7]:SetText("#{JZCD_3000_001}")
	elseif pState == g_Train_State.STATE_HARVEST then
		for i = 17,21,1 do 
			g_Train_Element[i]:Hide()
		end
		g_Train_Element[22]:Show()
		g_Train_Element[7]:SetText("#{JZCD_3000_001}")
		g_Train_Element[27]:SetText("#{TXSS_1000_042}")
	end	
	g_Train_Element[28]:Hide()
end

--***************************************************
--				������µ�Ԫ��ϸ��Ϣ
--				index 		��ǰѡ�о��µ�Ԫ����
--				
--***************************************************
function  Train_LoadMilitaryDetailInfo(index)
	local ATK, DEF, HP = Solider:GetUnitDesc("SoldierAttr_BaseInfo", index)		
	--local _, Icon = Solider:GetMilitaryInfo("Military_BaseInfo", index)
	--g_Train_Element[5]:SetTexture(Icon,1)
	
    local jsonFile,textureFile = Solider:GetMilitaryInfoBySkeleton("GetMilitaryInfoBySkeleton", index)
	
  --  PushToast(tostring(jsonFile))
	--PushToast(tostring(textureFile))
	g_Train_Element[5]:setSkeletonDataFile(jsonFile)
	g_Train_Element[5]:setAtlasFile(textureFile)
	g_Train_Element[5]:updataSkeletonState()
    g_Train_Element[5]:setAnimation("attack",true)-- ��ʾ����ʿ��
	
	
	g_Train_Element[2]:SetText("#{TXSS_1000_057}")		-- ʿ��������
	g_Train_Element[3]:SetText("#{DYXX_1000_002}")		-- ʿ������ֵ
	g_Train_Element[4]:SetText("#{DYXX_1000_023}") 	    -- ʿ��������
	if(ATK ~= nil and DEF ~= nil and HP ~= nil) then
		g_Train_Element[30]:SetText(ATK)
		g_Train_Element[31]:SetText(HP)
		g_Train_Element[32]:SetText(DEF)
	end
	
	local nSkill_ID_Fir, _, _, _ = Solider:GetUnitDesc("SoldierAttr_SkillID", index)
	if (nSkill_ID_Fir ~= nil) then
		local strFileICON = Solider:GetSkillInfo("Skill_ICON", nSkill_ID_Fir)	
		g_Train_Element[28]:SetNormalImg(strFileICON)
		g_Train_Element[28]:SetSelectImg(strFileICON)	
	end
	
	local res = {}
	local tIndex = 1
	local ID,_,_,TYPE,HUAFEIJINBI,HUAFEIPINGTAIBI,HUAFEITILE,HUAFEISHIYOU,TIME,strDesc = Solider:GetMilitaryInfo("Military_TrainInfo", index)
	local _,t_DESC = Solider:GetSkillInfo("Skill_DetailInfo",index)
	g_Train_Element[29]:SetText(t_DESC)
	
	COSTMONEY = HUAFEIJINBI			   -- ������Ϸ��
	COSTPLATFORMMONEY = HUAFEIPINGTAIBI-- ����ƽ̨��
	COSTIRON = HUAFEITILE			   -- ������
	COSTOIL = HUAFEISHIYOU			   -- ����ʯ��
		
	if HUAFEIJINBI > 0 then
		local state = {84,"-"..HUAFEIJINBI}	
		res[tIndex] = state
		tIndex = tIndex + 1
	end	
	if HUAFEIPINGTAIBI > 0 then
		local state = {89,"-"..HUAFEIPINGTAIBI}	
		res[tIndex] = state
		tIndex = tIndex + 1
	end
	if HUAFEITILE > 0 then
		local state = {87,"-"..HUAFEITILE}	
		res[tIndex] = state
		tIndex = tIndex + 1
	end
	if HUAFEISHIYOU > 0 then
		local state = {88,"-"..HUAFEISHIYOU}	
		res[tIndex] = state
		tIndex = tIndex + 1
	end
	if TIME > 0 then
		local state = {92,Train_GetTime(TIME/1000)}	
		res[tIndex] = state
		tIndex = tIndex + 1
	end	
	Train_LoadNeedResource(res)
end

--***************************************************
--					������Ҫ��ʾ
--					����һ���� 
--***************************************************
function	Train_LoadNeedResource(pTable)
	local size = table.getn(pTable)
	if size == 0 then
		return
	end
	if size > 4 then
		g_Train_Element[33]:Show()
	else
		g_Train_Element[33]:Hide()
	end
	g_Train_Element[6]:CleanAllElement()
	local x, y = 30, 10
	--local x1,y1 = 30,10
	for i = 1, size,1 do 
	
		local d1 = pTable[i]
		if i <= 4 then
			g_Train_Element[6]:AddItemIcon(d1[1], x + (i - 1) * 110, y)
			g_Train_Element[6]:AddItemText(tostring(d1[2]),x + (i - 1) * 110 + 50, y, 140, 30, "255 255 255", 18)
		else
			g_Train_Element[33]:AddItemIcon(d1[1], x + (i - 5) * 110, y)
			g_Train_Element[33]:AddItemText(tostring(d1[2]),x + (i - 5) * 110 + 50, y, 140, 30, "255 255 255", 18)
		end
	end
end
--***************************************************
--					���ڹر�
--***************************************************
function	Train_Exit()
	this:Hide()
	--for i = 1, 3, 1 do
	--	g_Train_ScrollView[i]:CleanAllElement()
	--	g_Train_ScrollView[i]:UnSelectItem()		--ж�ظ���ѡ�п�
	--end
	BuildData:UnMainTarget()	
	g_Train_index = -1
	g_Train_CurTrainIndex = -1    --��ǰѵ���ľ��µ�Ԫ������
	g_surplusTime = 0
	g_Train_Element[25]:StopTime()
end

--***************************************************
--			 �����Ԫ���鰴���¼�
--***************************************************
function Train_UnitInfo()
	--this:Hide()
	PushEvent("UNITDETAILS_LOAD", tonumber(g_Train_Cur_Index))

end

--***************************************************
--				ѵ����������
--***************************************************
function	Train_Train()
	
	if g_Train_Cur_Index >= 0 and g_Train_Cur_Index < g_Train_MilitaryNum then
		g_Train_Index = g_Train_Cur_Index
		local LEVEL	= Solider:GetMilitaryInfo("Military__Level", g_Train_Cur_Index)
		local pLevel = Player:GetLevel()
		if pLevel < LEVEL then
			--PushMessageBox("#{TXSS_2000_010}")
			PushToast("#{TIP_1000_038}")	
			return
		end
		
		if(g_Train_CurTrainIndex ~= -1) then	--��ǰ������ѵ���ĵ�Ԫ 			
			PushToast("#{JZCD_3000_001}")
		elseif (COSTMONEY > Player:GetMoney() 
		or COSTPLATFORMMONEY > Player:GetDiamond() 
		or COSTIRON > Player:GetIron() 
		or COSTOIL > Player:GetOil()) then
			PushToast("#{TXSS_2000_046}")	
		else 
			BuildData:TrainSoliderSubmit(g_Train_Cur_Index)
			OpenRequestWaitProgress()
		end
	end
end

--****************************************************
--				��ʾ����������ʱ������Ϣ
--****************************************************
function	Train_ShowProgressInfo()
	local surplusTime, totalTime, produceIndex = BuildData:GetMainTargetBuildState("MainTargetBuild_ProduceTime")
	surplusTime = surplusTime + 1000
	g_surplusTime = surplusTime
	
	g_Train_Element[18]:SetText(Train_GetTime(surplusTime/1000))
	g_Train_Element[25]:StartTime(surplusTime/1000, 0, 1, 1)
	
	if (math.floor(totalTime) <= 0) then
		return
	end		
	local fromPercent = ((totalTime - surplusTime)/totalTime) * 100
	g_Train_Element[20]:RunFromTo(fromPercent, 100, surplusTime / 1000)
end

--****************************************************
--				��ʾ���µ�Ԫ�б�ѵ����Ԫ��ͼ����Ϣ
--****************************************************
function   Train_ShowWorkUnitInfoForList(textureIndex, nameID)
	g_Train_ImageBox[2]:SetTexture(textureIndex)	
	--g_Train_ImageBox[2]:SetScale(0.6)
	g_Train_TextBox[5]:SetText(nameID)
end

--***************************************************
--				���ٷ���
--***************************************************
function	Train_Quicken()
	local Index =	BuildData:GetMainTargetBuildState("MainTargetBuild_ProduceTime")
	PushEvent( "COMMON_TIP_BUY",1,Index )
end

--**************************************************
--				�ջ񷽷�
--**************************************************
function	Train_OnRecv()

	if g_Train_Index ~= -1 then
		local _, _, NAME = Solider:GetMilitaryInfo("Military_BaseInfo", g_Train_Index)
		PushToast( "#{TIP_1000_030} "..NAME )
	end
	
	BuildData:ProduceRecvie()--�ջ���µ�Ԫ���������
	g_Train_index = -1 					 --���þ��µ�Ԫ�б�ѡ��������
	g_Train_CurTrainIndex = -1			 --���õ�ǰѵ���ľ��µ�Ԫ������
	g_Train_Element[25]:StopTime()	
	--g_Train_Element[7]:SetText("#{JZCD_1000_002}")
	g_Train_Element[20]:RunFromTo(0, 0, 0)
	Solider:ReLoadTreatSolider()
end

--***************************************************
--				����״̬�л�����
--				�������ȴ����ռ�
--***************************************************
function	Train_ToWork(Type)
	local pState = BuildData:GetMainTargetBuildState("MainTargetBuild_State_ID")
	if pState == g_Train_State.STATE_WORK_WAIT then				-- �ȴ�״̬		
		g_Train_Element[1]:Show()
		g_Train_Element[12]:Hide()
		g_Train_Element[13]:Hide()
		g_Train_Element[14]:Hide()
		g_Train_Element[23]:Hide()
		g_Train_Element[24]:Hide()		
		for i = 16, 22, 1 do 
			g_Train_Element[i]:Hide()
		end
		g_Train_Element[17]:Hide()
		g_Train_Element[22]:Hide()			
		g_Train_Element[6]:Show()
		g_Train_Element[26]:SetText("#{TXSS_1000_044}")			-- �ֵ䡾ѵ����
		
		g_Train_CurTrainIndex = -1
		
	elseif pState == g_Train_State.STATE_PRODUCE_TING then		-- ������
		local _, _, Index = BuildData:GetMainTargetBuildState("MainTargetBuild_ProduceTime")
		g_Train_Element[1]:Hide()
		g_Train_Element[12]:Show()
		g_Train_Element[13]:Show()
		g_Train_Element[14]:Show()	
		g_Train_Element[23]:Show()
		g_Train_Element[24]:Show()		
		for i = 16,22,1 do 
			g_Train_Element[i]:Show()
		end
		--g_Train_Element[15]:Hide()
		g_Train_Element[22]:Hide()
			
		Train_AddWorkType(Type,Index)
		Train_OnTrainData(Index)
		Train_ShowProgressInfo()
		g_Train_Element[6]:Hide()
		g_Train_Element[8]:Hide()
		g_Train_CurTrainIndex = Index
		g_Train_Element[7]:SetText("#{JZCD_3000_001}")
	elseif pState == g_Train_State.STATE_HARVEST then			--- �ջ���
		g_Train_Element[1]:Hide()
		g_Train_Element[12]:Show()		
		g_Train_Element[13]:Show()
		g_Train_Element[14]:Show()	
		g_Train_Element[23]:Show()
		g_Train_Element[24]:Show()
		for i = 16,22,1 do 
			g_Train_Element[i]:Show()
		end
		g_Train_Element[6]:Hide()			
		g_Train_Element[8]:Hide()
		g_Train_Element[17]:Hide()
		g_Train_Element[19]:Hide()	-- ����������ͼ
		g_Train_Element[20]:Hide() 	-- ������
		g_Train_Element[21]:Hide()	-- ��������Ч
		g_Train_Element[7]:SetText("#{JZCD_3000_001}")
		g_Train_Element[18]:Hide()
		g_Train_Element[25]:StopTime()	
		local _, _, Index = BuildData:GetMainTargetBuildState("MainTargetBuild_ProduceTime")			
		Train_OnTrainData(Index)
		g_Train_Element[16]:UnSelectItem()
		g_Train_Element[27]:SetText("#{TXSS_1000_042}")
				
	end
end

--***************************************************
--			�����������͵�ѡ�
--			���� ��������
--***************************************************
function	Train_AddWorkType(pTYPE, Index)
	g_Train_Element[16]:CleanAllElement()	
	local X, Y = 0, 0
	local contentHeight = 272	
	for i = g_Train_MilitaryNum - 1, 0, -1 do --�������µ�Ԫ��Ϣ��(�����ȴ�״̬)
		local ID, ICON, NAME, LEVEL, TYPE = Solider:GetMilitaryInfo("Military_BaseInfo", i)

		if (pTYPE == TYPE and i~=Index) then
			Train_CreateWorkItem(ID, NAME, ICON, X, Y, LEVEL)
			local pLevel	=	Player:GetLevel()
			if pLevel < LEVEL then
				g_Train_Element[16]:AddItemScaleIcon(412 , X + 15, Y + 10, "1")
			end
			Y = Y + 87		
			if Y > 272 then
				contentHeight = contentHeight + ((Y - 272 >= 87 and 87) or Y - 272)		
			end
		end
	end
	Train_LoadMilitaryDetailInfo(Index)	
--	g_Train_Element[16]:SetSelectItem(curTypeUnitCount - 1)
	g_Train_Element[16]:SetContentSize(202, contentHeight) 					--�������ݳ���
	g_Train_Element[16]:SetContentOffset(0, -(contentHeight - 272))				--��������ƫ�� (��Ϊ�Ǵ������ϻ���)	
	
	
end

--***************************************************
--			ˢ�¹����е�ʿ����Ϣ
--			����ID
--***************************************************
function		Train_OnTrainData(Index)
	local ID, ICONID, NAME, nLevel, _ = Solider:GetMilitaryInfo("Military_BaseInfo", Index)
	
	g_Train_Element[13]:SetTexture(ICONID)			-- ѵ���е�ʿ��ͼ��
	g_Train_Element[14]:SetText(NAME)				-- ѵ���е�ʿ������
	g_Train_Element[23]:SetText("Lv." .. nLevel)	-- ѵ���е�ʿ���ȼ�
	g_Train_Element[24]:SetText("#{JZCD_3000_001}")	-- ѵ���е�ʿ�� �ֵ䡾ѵ���С�	
end

--***************************************************
--				����ʱ�� 
--***************************************************
function Train_UpdateTime()
	g_surplusTime = g_surplusTime - 1000	

	g_Train_Element[18]:SetText(Train_GetTime(g_surplusTime/1000))
end

function Train_GetTime(sec)
	local TimeFormat = os.date("*t", tonumber(sec))
	local strTime = ""
	if TimeFormat.day - 1 > 0 then
		strTime = string.format("%d%s",TimeFormat.day - 1, "#{TXSS_1000_040}")
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