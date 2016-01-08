local g_Produce_Main = {}		  --�洢�ֿ�
local g_Produce_Img = {Coin = 58,Exp = 65,Time = 64}
local g_Produce_Num = 14	-- ����������
local g_Produce_Time = 0
local g_CurChooseIndex = 0	-- ��ǰѡ����������������
local g_Produce_State = {STATE_WORK_WAIT=3,STATE_COLSE=5,STATE_PRODUCE_TING=6,STATE_HARVEST=7}
function	Produce_PreLoad()
	this:RegisterEvent("PRODUCE_LOAD")
	this:RegisterEvent("PRODUCE_UPDATE")
end

function	Produce_OnLoad()
	--g_Produce_Main[1]=Produce_Icon
	g_Produce_Main[2]=Produce_Name
	--g_Produce_Main[3]=Produce_Level_Text
	g_Produce_Main[4]=Produce_People
	--g_Produce_Main[5]=Produce_Switch
	g_Produce_Main[6] = Produce_ScrollView
	--g_Produce_Main[7] = Produce_Light_Img
	--g_Produce_Main[8] = Produce_Recv_Img
	--g_Produce_Main[9] = Produce_pIcon_Img
	g_Produce_Main[10] = Produce_Work_Name
	g_Produce_Main[11] = Produce_Time_Text
	--g_Produce_Main[12] = Produce_Exp_Bg
	--g_Produce_Main[13] = Produce_Exp_Bar
	--g_Produce_Main[14] = Produce_Light_Img
	g_Produce_Main[15] = Produce_Button_AddSpeed	 --���ٰ��� 
	g_Produce_Main[16] = Produce_Recv_Button
	g_Produce_Main[17] = Produce_Time_Mich
	g_Produce_Main[18] = Produce_Recv_Button_Text  	 --�ռ�������ȷ�����ı�
	g_Produce_Main[19] = Produce_Button_Produce		 --��������
	g_Produce_Main[20] = Produce_Button_Produce_Text --���������ı�
	g_Produce_Main[21] = Produce_Cost_Text 			 --�ֵ���[����]�ı�
	g_Produce_Main[22] = Produce_CostGold_Text 		 --���ѽ���ı�
	g_Produce_Main[23] = Produce_CostTime_Text 		 --����ʱ���ı�
	g_Produce_Main[24] = Produce_Harvest_Text		 --�ֵ���[����]�ı�
	g_Produce_Main[25] = Produce_HarvestGold_Text	 --�������ı�
	g_Produce_Main[26] = Produce_HarvestExp_Text	 --���澭���ı�
	g_Produce_Main[27] = Produce_Button_AddSpeed_Text--���ٰ����ı�
	g_Produce_Main[28] = Produce_CostGoldIcon_Img	 --��������л��ѽ��ͼ�� 
	g_Produce_Main[29] = Produce_CostTimeIcon_Img	 --��������л��Ѿ���ͼ�� 
	g_Produce_Main[30] = Produce_Exp_Bg				 --��������������
	g_Produce_Main[31] = Produce_Exp_Bar			 --����������
	g_Produce_Main[32] = Produce_ExpBar_Frame		 --�����������߿� 
end


--�����¼�
function	Produce_OnEvent(event)
	if event=="PRODUCE_LOAD" then
		if arg0 == nil then
			this:Hide()
			return ;		
		end	
		local tIndex = tonumber(arg0)
		this:Show()
		Produce_LoadData(tIndex)
	elseif event == "PRODUCE_UPDATE" then
		if arg0 == nil then
			return ;		
		end	
		
		local tIndex = tonumber(arg0)	
		if this:IsVisible() == true then			-->��ʾ״̬ 
			Produce_LoadData(tIndex)		
		end	
	end
end

function	Produce_HideWork()
	--g_Produce_Main[7]:Hide()

	g_Produce_Main[10]:Hide()
	g_Produce_Main[11]:Hide()

	--g_Produce_Main[14]:Hide()
	g_Produce_Main[15]:Hide()
	g_Produce_Main[16]:Hide()	
	g_Produce_Main[19]:Show()						--��������
	g_Produce_Main[21]:Show()						--�����ı�
	g_Produce_Main[22]:Show()						--���ѽ���ı�
	g_Produce_Main[23]:Show()						--����ʱ���ı�
	g_Produce_Main[28]:Show()	 					--��������л��ѽ��ͼ�� 
	g_Produce_Main[29]:Show()						--��������л��Ѿ���ͼ�� 	
	g_Produce_Main[30]:Hide()						--��������������
	g_Produce_Main[31]:Hide()						--����������
	g_Produce_Main[32]:Hide()						--�����������߿�
		
	g_Produce_Main[20]:SetText("#{JZCD_2000_027}")	--����
	--g_Produce_Main[21]:SetText("#{JZCD_1000_002}")	--�����ı�
	--g_Produce_Main[24]:SetText("#{JZCD_1000_003}")	--����

end

function	Produce_ShowWork()
	--g_Produce_Main[7]:Show()
	g_Produce_Main[10]:Show()
	g_Produce_Main[11]:Show()
	--g_Produce_Main[12]:Show()
	--g_Produce_Main[13]:Show()
	--g_Produce_Main[14]:Show()
	g_Produce_Main[15]:Show()	 					--���ٰ��� 
	
	g_Produce_Main[19]:Hide()						--��������
	g_Produce_Main[21]:Hide()						--�����ı�
	g_Produce_Main[22]:Hide()						--���ѽ���ı�
	g_Produce_Main[23]:Hide()						--����ʱ���ı�
	g_Produce_Main[28]:Hide()						--��������л��ѽ��ͼ�� 
	g_Produce_Main[29]:Hide()						--��������л��Ѿ���ͼ�� 
	g_Produce_Main[10]:SetText("#{TXSS_2000_056}")	--�ֵ䡾�����С��ı�
	g_Produce_Main[27]:SetText("#{TXSS_1000_085}")	--���ٰ����ı�
	g_Produce_Main[30]:Show()						--��������������
	g_Produce_Main[31]:Show()						--����������
	g_Produce_Main[32]:Show()						--�����������߿�	
end

function	Produce_Close()
	this:Hide()
	g_Produce_Main[17]:StopTime()
	BuildData:UnMainTarget()
end

function	Produce_Recv_Click()
	local _,_,Index =	BuildData:GetMainTargetBuildState("MainTargetBuild_ProduceTime")

	local _,_,uNAME = BuildData:GetWorkInfo("Produce_DetailInfo",Index)

	PushToast( "#{TIP_1000_030}"..uNAME )
	
	BuildData:RecviedBuildProduct()	---> �����ռ�����
	g_Produce_Main[15]:Hide()
	g_Produce_Main[16]:Hide()
	
	
end

function	Produce_AddSpeedClick()
	local Index =	BuildData:GetMainTargetBuildState("MainTargetBuild_ProduceTime")
	PushEvent( "COMMON_TIP_BUY",1,Index )
end

--===========================================
----		���� ͼ�� ���ѽ�� ʱ�� �ջ� ��� ����
--===========================================
function	Produce_CreatItem(id,x,y,uNAME,uIcon,uCoin,uTime,rCoin,rExp)
	local Function = string.format("%s%d%s","Produce_OnClick(",id,")")
	g_Produce_Main[6]:AddImage9Patch("arrmy_commond.png", x ,y, 2, 226, 86, true) --�б�ѡ���	
	g_Produce_Main[6]:AddItemSelect9Patch("empty.png", "c_ckuang.png",x + 113, y + 42, 220, 76, 24, Function) --�б�ѡ���	
	g_Produce_Main[6]:AddImage9Patch("di_vblue.png", x + 11, y + 11, 0, 64, 64, true) --ѡ��ͼ���
	g_Produce_Main[6]:AddItemIcon(uIcon, x + 17, y + 17)								

	--g_Produce_Main[6]:AddItemIcon(g_Produce_Img.Coin,x + 110,y + 54)
	g_Produce_Main[6]:AddItemText(uNAME ,x + 110 ,y + 44 ,0,0,"125	250	255",16)	
		
	g_Produce_Main[6]:AddItemIcon(g_Produce_Img.Coin,x + 110,y + 11)	
	g_Produce_Main[6]:AddItemText("-"..uCoin ,x + 145 ,y + 11 ,0,0,"125 250 255",16)	
end

--===========================================
--				   ����¼�		
--===========================================
function	Produce_OnClick(Index)
	local index = tonumber(Index)
	if index >= 0 and index <= g_Produce_Num then
		g_CurChooseIndex = Index
		local uCOIN = BuildData:GetWorkInfo("Produce_CostCoin", index)
		local _,_,_,CostCoin,CostTime,HarvestCoin,HarvestExp,_,DESC = BuildData:GetWorkInfo("Produce_DetailInfo", index)			
		Produce_SetDetailInfo(CostCoin, CostTime, HarvestCoin, HarvestExp,DESC)			
	end
end

--===========================================
-- 			  ������������¼�
--===========================================
function 	Produce_ClickProduce()
	BuildData:ProduceIndex(g_CurChooseIndex)
end

--===========================================
--			���õ�ǰѡ������ϸ��Ϣ
--===========================================
function	Produce_SetDetailInfo(CostCoin, CostTime, HarvestCoin, HarvestExp,DESC)
	g_Produce_Main[22]:SetText(CostCoin)
	g_Produce_Main[23]:SetText(Produce_GetTime(CostTime/1000))
	g_Produce_Main[25]:SetText("+"..HarvestCoin)
	g_Produce_Main[26]:SetText(HarvestExp)
	g_Produce_Main[21]:SetText(DESC)
end

--===========================================
-- 				��ȡ��Ϣ 
--===========================================
function	Produce_LoadData(Index)
	local tTYPE, tNAME, tLEVEL, rTYPE, tIMG, uPopulation, unPopulation = BuildData:GetBuildInfo("Unmilitary_Title", Index)
	
	g_Produce_Main[2]:SetText(tNAME)
	
	g_Produce_Main[4]:SetText("-"..uPopulation)

	local pState = BuildData:GetMainTargetBuildState("MainTargetBuild_State_ID")
	
	if pState == g_Produce_State.STATE_WORK_WAIT then			-- �ȴ�״̬
		Produce_WaitState(rTYPE)
	elseif pState == g_Produce_State.STATE_PRODUCE_TING then	-- ������
		Produce_ReLoad(rTYPE)
		Produce_WorkState(rTYPE)
	elseif pState == g_Produce_State.STATE_HARVEST then			-- �ջ�
		Produce_RecvState(rTYPE)	
	end		
end

--============================================
-- 					�ȴ�״̬ 
--============================================
function	Produce_WaitState(TYPE)
	Produce_HideWork()
	g_Produce_Main[6]:Show()
	g_Produce_Main[6]:CleanAllElement()
	
	g_Produce_Main[31]:RunFromTo(0,0,0)
	
	local curTypeAddCount = 0		
	local width, height = 241, 324	
	local x, y = 7, 0
	
	for i = g_Produce_Num, 0, -1 do 	
		local uID,uTYPE,uNAME,uCOIN,uTIME,uADDCOIN,uEXP,uICON,uDESC = BuildData:GetWorkInfo("Produce_DetailInfo", i)
		if TYPE == uTYPE then	
			Produce_CreatItem(uID,x,y,uNAME,uICON,uCOIN,uTIME,uADDCOIN,uEXP)	
			y = y + 87
			curTypeAddCount	= curTypeAddCount + 1
			if y > 324 then
				height = height + ((y - 324 >= 87 and 87) or y - 324)			
			end
			Produce_SetDetailInfo(uCOIN, uTIME, uADDCOIN, uEXP,uDESC)
			g_CurChooseIndex = i
		end
	end
	if curTypeAddCount > 0 then
		g_Produce_Main[6]:SetSelectItem(curTypeAddCount - 1)		
		g_Produce_Main[6]:SetContentSize(width, height)
		if height > 324 then	
			g_Produce_Main[6]:SetContentOffset(0, -(height - 324))
		end
	end
end

--===========================================
-- 					�������� 
--===========================================
function	Produce_ReLoad(TYPE)
	Produce_HideWork()
		
	local _,_,Index =	BuildData:GetMainTargetBuildState("MainTargetBuild_ProduceTime")
	g_Produce_Main[6]:Show()
	g_Produce_Main[6]:CleanAllElement()
	
	g_Produce_Main[31]:RunFromTo(0,0,0)
	
	local curTypeAddCount = 0		
	local width, height = 241, 324	
	local x, y = 7, 0
	
	for i = g_Produce_Num, 0, -1 do 	
		local uID,uTYPE,uNAME,uCOIN,uTIME,uADDCOIN,uEXP,uICON,uDESC = BuildData:GetWorkInfo("Produce_DetailInfo", i)
		
		if TYPE == uTYPE then	
			if Index ~= i then
				Produce_CreatItem(uID,x,y,uNAME,uICON,uCOIN,uTIME,uADDCOIN,uEXP)	
				y = y + 87
				curTypeAddCount	= curTypeAddCount + 1
				if y > 324 then
					height = height + ((y - 324 >= 87 and 87) or y - 324)			
				end
			end
		end
	end
	local uID,uTYPE,uNAME,uCOIN,uTIME,uADDCOIN,uEXP,uICON,uDESC = BuildData:GetWorkInfo("Produce_DetailInfo", Index)
	Produce_CreatItem(uID,x,y,uNAME,uICON,uCOIN,uTIME,uADDCOIN,uEXP)	

	y = y + 87
	curTypeAddCount	= curTypeAddCount + 1
	if y > 324 then
		height = height + ((y - 324 >= 87 and 87) or y - 324)			
	end
	
	Produce_SetDetailInfo(uCOIN, uTIME, uADDCOIN, uEXP,uDESC)					
		
	if curTypeAddCount > 0 then
		g_Produce_Main[6]:SetSelectItem(curTypeAddCount - 1)		
		g_Produce_Main[6]:SetContentSize(width, height)
		if height > 324 then	
			g_Produce_Main[6]:SetContentOffset(0, -(height - 324))
		end
	end
end

--==========================================
-- 				 ����״̬  
--==========================================
function	Produce_WorkState(TYPE)
	local resTime, tolTime, Index =	BuildData:GetMainTargetBuildState("MainTargetBuild_ProduceTime")
	if Index >= 0 and Index <= g_Produce_Num then 

		local uID,uTYPE,uNAME,uCOIN,uTIME,uADDCOIN,uEXP,uICON = BuildData:GetWorkInfo("Produce_DetailInfo", Index)
		
		resTime = resTime + 1000
		g_Produce_Time = resTime
		
		if (math.floor(tolTime) <= 0) then
			return
		end			
		local tBegin = 100 - (100 *(resTime / tolTime))	-- ����������
		
		g_Produce_Main[11]:SetText(Produce_GetTime(resTime/1000))	
	
		g_Produce_Main[31]:RunFromTo(tBegin,100,resTime/1000)

		g_Produce_Main[17]:StartTime(resTime/1000, 0, 1, 1)	
		
	end
	g_Produce_Main[15]:Show()
	g_Produce_Main[16]:Hide()
	
	Produce_ShowWork()
end

--=====================================
--				�ջ�״̬		 	
--=====================================						
function	Produce_RecvState()
	g_Produce_Main[11]:Hide()	
	g_Produce_Main[15]:Hide()
	g_Produce_Main[16]:Show()
	g_Produce_Main[18]:SetText("#{TXSS_1000_042}")		-- �ռ������ı�
	g_Produce_Main[17]:StopTime()
	local fromPercent = g_Produce_Main[31]:GetPercent() 		
	local duration  = math.abs(100 - fromPercent) / 100
	g_Produce_Main[31]:RunFromTo(fromPercent, 100, duration)
	
	local _,_,_,CostCoin,CostTime,HarvestCoin,HarvestExp,_ ,DESC= BuildData:GetWorkInfo("Produce_DetailInfo", g_CurChooseIndex)			
	Produce_SetDetailInfo(CostCoin, CostTime, HarvestCoin, HarvestExp,DESC)		
end

--===========================================
--				  	 ��ʱ�� 			
--===========================================
function	Produce_Time()	
	g_Produce_Time = g_Produce_Time - 1000
	g_Produce_Main[11]:SetText(Produce_GetTime(g_Produce_Time/1000))
end

--===========================================
----				ת����ʱ��		
--===========================================
function Produce_GetTime(sec)
	local TimeFormat = os.date("*t", tonumber(sec))
	local strTime = ""
	if TimeFormat.hour > 0 then
		TimeFormat.min = (TimeFormat.hour - 8) * 60 + TimeFormat.min
	end
	if TimeFormat.min > 0 then
		strTime = string.format("%s%d%s",strTime, TimeFormat.min, "#{TXSS_1000_014}")
	end
	if TimeFormat.sec > 0 then
		strTime = string.format("%s%d%s",strTime, TimeFormat.sec, "#{TXSS_1000_015}")
	end	
	
	return strTime
end