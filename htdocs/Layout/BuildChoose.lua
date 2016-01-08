local g_BuildChoose_Main = {}	
local g_BuildChoose_Text = {}
local HOUSE_TYPE 		 = 0
local ARRMY_TYPE 		 = 1
local RESOURCE_TYPE		 = 2
local PRODUCE_TYPE 		 = 3
local STORE_TYPE 		 = 4

local HOUSE_COUNT 		 = 15
local index  			 = -1 

function	BuildChoose_PreLoad()
	this:RegisterEvent("BUILD_CHOOSE_LOAD")					
	this:RegisterEvent("BUILD_CHOOSE_TOBUILD")
end

function	BuildChoose_OnLoad()
	
	g_BuildChoose_Main[1] = BuildChoose_Title_Image
	g_BuildChoose_Main[2] = BuildChoose_ScrollView
	g_BuildChoose_Main[3] = BuildChoose_FrontWindow				--�������鵯��
	g_BuildChoose_Main[4] = BuildChoose_House_Button
	g_BuildChoose_Main[5] = BuildChoose_Arrmy_Button
	g_BuildChoose_Main[6] = BuildChoose_Produce_Button
	g_BuildChoose_Main[7] = BuildChoose_Resource_Button
	g_BuildChoose_Main[8] = BuildChoose_Button_ComingSoon		
	g_BuildChoose_Main[9] = BuildChoose_ImageBox_Mask			-- ��ɫ��͸���ɰ�
	g_BuildChoose_Main[10] = BuildChoose_ImageBox_CostGold		-- ���ѽ��ͼ��
	g_BuildChoose_Main[11] = BuildChoose_ImageBox_CostIron		-- ������ͼ��
	g_BuildChoose_Main[12] = BuildChoose_ImageBox_CostOil		-- ����ʯ��ͼ��
	g_BuildChoose_Main[13] = BuildChoose_ImageBox_CostPlatMoney -- ����ƽ̨��ͼ��
	
	g_BuildChoose_Text[1] = BuildChoose_Manamount_Text			-- �˿�
	g_BuildChoose_Text[2] = BuildChoose_Coinamount_Text			-- ƽ̨��
	g_BuildChoose_Text[3] = BuildChoose_Moneyamount_Text		-- ���

	g_BuildChoose_Text[5] = BuildChoose_Button_Construct_Text	-- ���찴���ı�
	g_BuildChoose_Text[6] = BuildChoose_TextBox_CostPlatMoney	-- ���ѵ�ƽ̨���ı�
	g_BuildChoose_Text[7] = BuildChoose_Ironamount_Text			-- ����	
	g_BuildChoose_Text[8] = BuildChoose_Oilamount_Text			-- ʯ��
	
	g_BuildChoose_Text[9] = BuildChoose_Title_huafei
	g_BuildChoose_Text[10] = BuildChoose_Title_renkou
	g_BuildChoose_Text[11] = BuildChoose_Title_shijian
	
	g_BuildChoose_Text[12] = BuildChoose_TextBox_CostIron		--���ѵ����ı�
	g_BuildChoose_Text[13] = BuildChoose_TextBox_CostOil		--���ѵ�ʯ���ı�
	g_BuildChoose_Text[14] = BuildChoose_TextBox_CostGold		--���ѵĽ���ı�
	g_BuildChoose_Text[15] = BuildChoose_Title_ren
	g_BuildChoose_Text[16] = BuildChoose_Title_shi
	g_BuildChoose_Text[17] = BuildChoose_xiadiTitle
	g_BuildChoose_Text[18] = BuildChoose_Ironamount_Bar			--��
	g_BuildChoose_Text[19] = BuildChoose_Oilamount_Bar			--ʯ��
end

function	BuildChoose_OnEvent(event)
	if ( event == "BUILD_CHOOSE_LOAD" ) then
		this:Show()
		BuildChoose_HideMask()	-- �����ɰ�	
		BuildChoose_Init()
	elseif event == "BUILD_CHOOSE_TOBUILD" then
		if arg0 ~= nil and arg1 ~= nil then				
			local Type = tonumber(arg0)
			local Index = tonumber(arg1)
			if this:IsVisible() == false then
				this:Show()
				BuildChoose_UpData()
			end
			BuildChoose_ShowMask()	-- ��ʾ�ɰ�		
			for i = 4, 8, 1 do 			-- ��ʾ�������5����ť һ��ͼ��
				g_BuildChoose_Main[i]:Hide()		
			end	
			
			g_BuildChoose_Main[2]:SetContentOffset(0, 0)
			--��ʾ���ذ���
			g_BuildChoose_Main[3]:Show()
			
			--������Ӧ�������͵�ѡ�
			if( Type == 0) then			-- ס������
				g_BuildChoose_Main[1]:SetText("#{JZCD_1000_005}")
				BuildChoose_CreateWindowForHouse(Index)
				g_BuildChoose_Text[10]:SetText("#{TXSS_1000_089}")
			elseif ( Type == 1) then	-- �����ཨ��
				g_BuildChoose_Main[1]:SetText("#{JZCD_2000_026}")
				BuildChoose_CreateWindowWithType(ARRMY_TYPE, Index)
			elseif ( Type == 2) then	-- �����ཨ��
				g_BuildChoose_Main[1]:SetText("#{JZCD_2000_027}")
				BuildChoose_CreateWindowWithType(PRODUCE_TYPE, Index)	
			elseif ( Type == 3) then	-- ��Դ�ཨ��	
				g_BuildChoose_Main[1]:SetText("#{JZCD_2000_028}")
				BuildChoose_CreateWindowWithTypeTow(RESOURCE_TYPE,STORE_TYPE, Index)
			end	
		end
	end
end

--��ʾȫ����͸����ɫģ��
function  BuildChoose_ShowMask()
	g_BuildChoose_Main[9]:Show()
	g_BuildChoose_Main[9]:SetScale(40)
	g_BuildChoose_Main[9]:SetOpacity(200)	
end

--========================================
--		  ��ʾȫ����͸����ɫģ��
--========================================
function  BuildChoose_HideMask()
	g_BuildChoose_Main[9]:Hide()
end

--******************************************************
--						�رմ��� 
--******************************************************
function	BuildChoose_Close()
	if (g_BuildChoose_Main[9]:IsVisible() == true) then
		return	
	end
	CloseAllWidget()
	g_BuildChoose_Main[2]:Hide()
	g_BuildChoose_Main[3]:Hide()
	g_BuildChoose_Main[2]:CleanAllElement()
	g_BuildChoose_Main[2]:SetContentSize(800, 285)
	PushEvent("MAIN_MENU_LOAD")
	PushEvent("RESOURCE_BAR_LOAD")
	PushEvent("PORTRAIT_LEFT_LOAD")
	PushEvent("TASK_LIST_LOAD")
	PushEvent("MAIN_CHAT_LOAD")	
end

--******************************************************
--				��ʼ��
--******************************************************
function	BuildChoose_Init()
	g_BuildChoose_Main[3]:Hide()

	BuildChoose_UpData()
	g_BuildChoose_Text[9]:SetText("#{JZCD_1000_002}")
	g_BuildChoose_Text[10]:SetText("#{TXSS_1000_086}")
	g_BuildChoose_Text[11]:SetText("#{TXSS_1000_087}")
	local x, y = 20, 180
	
	--��������ѡ�˳�� 
	--ס�� ���� ���� ��Դ ����
	--����������������
	local namelist = {"#{JZCD_2000_025}", "#{JZCD_2000_026}","#{JZCD_2000_027}","#{JZCD_2000_028}","#{JZCD_2000_029}"}
	--����ͼ������
	local buildImgList = {35, 43, 37, 53, 55}
	--�������� 
	local posX = {56, 261, 465, 56, 261}
	local posY = {178,178, 178, 2,  2}
			
	BuildChoose_CreateBuildType()
end

--******************************************************
--				����һ������ѡ�
--******************************************************
function BuildChoose_CreateBuildType()
	for i = 4, 7, 1 do 	-- ��ʾ�������5����ť һ��ͼ��
		g_BuildChoose_Main[i]:Show()		
	end
end

--******************************************************
--			�������������ѡ�
--******************************************************
function	BuildChoose_CreateWindowWithType(CUR_TYPE, Index)
	for i = 4, 8, 1 do 
		g_BuildChoose_Main[i]:Hide()	-- �����������5����ť һ��ͼ��		
	end

	g_BuildChoose_Main[2]:CleanAllElement()
		
	local x,y = 0, 0
	local Width, Height = 701, 182
	local nNum = 0				 		-- ѡ�������	

	for i = 0 , HOUSE_COUNT-1 ,1 do
	
		local uID, uTYPE, uNAME, uIcon = BuildData:GetBuildInfo("BuildChoose_CreateOptions", i)		
		if (CUR_TYPE == uTYPE) then
			
			local Function = string.format("BuildChoose_OnClick(%d%s",uID,")")							
			g_BuildChoose_Main[2]:AddImage9Patch("j_put.png",x + 10, y + 10, 2, 146, 174, true)
			
			g_BuildChoose_Main[2]:AddItemSelect9Patch("empty.png", "c_ckuang.png", x + 83, y + 80, 146, 140, 0, Function)
			g_BuildChoose_Main[2]:AddItemIcon(uIcon, x + 30, y + 45)	
			g_BuildChoose_Main[2]:AddItemText(uNAME, x + 11, y + 155, 146, 25,"0 255 246", 18, "Center")
			g_BuildChoose_Main[2]:AddItemText(uNAME, x + 55, y + 20, 0, 0, "0 255 246", 14)		-- ����ͼ��2
			
			local Level = BuildData:GetBuildInfo("BuildDesc_BuildLevel",i)
			local pLevel	=	Player:GetLevel()
			if pLevel < Level then
				g_BuildChoose_Main[2]:AddItemIcon(413, x + 10, y + 35 )
				g_BuildChoose_Main[2]:AddItemText("LV"..Level, x + 34, y + 50,100,50,"255 255 255",20 , "Center")					
			end
			if  nNum == 0 then			
				BuildChoose_OnClick(uID)
			end
			if (uID == Index) then
				g_BuildChoose_Main[2]:SetSelectItem(nNum)			
			end
			nNum = nNum + 1
			x= x + 153
			if x > Width then
				Width = Width + 153
			end	
		end
	end
	if (nNum > 3)then
		g_BuildChoose_Main[2]:Touch(0)
	else
		g_BuildChoose_Main[2]:Touch(-1)
	end
	g_BuildChoose_Main[2]:SetContentSize(Width - 66, 285)
end

--******************************************************
--			�������������ѡ�
--******************************************************
function	BuildChoose_CreateWindowWithTypeTow(CUR_TYPEA , CUR_TYPEB, Index)

	--	�ȽϷ���
	local sortFunc = function(a,b)
		
		if a[2] == b[2] then
			return a[1] < b[1];		
		elseif a[2] < b[2] then
			return a[2] < b[2]
		end
		
	end
	
	g_BuildChoose_Main[2]:CleanAllElement()
		
	local x, y = 0, 0
	local Width, Height = 701, 182
	local _nNum = 0			-- ѡ�������	
	
	local g_Build = {}	--�����ŵı�
	local g_Count = 1
	
	for i = 0, HOUSE_COUNT-1, 1 do
		local uID,uTYPE,uNAME,uIcon = BuildData:GetBuildInfo("BuildChoose_CreateOptions", i)
		if (CUR_TYPEA == uTYPE or CUR_TYPEB == uTYPE) then		
			local Level = BuildData:GetBuildInfo("BuildDesc_BuildLevel",i)
			g_Build[g_Count] = {uID,Level}
			g_Count = g_Count + 1
		end
	end
	
	table.sort(g_Build , sortFunc)

	for index,g_Table in pairs(g_Build) do
		local uID,uTYPE,uNAME,uIcon = BuildData:GetBuildInfo("BuildChoose_CreateOptions", g_Table[1])
		local Function = string.format("BuildChoose_OnClick(%d%s",g_Table[1],")")							
		g_BuildChoose_Main[2]:AddImage9Patch("j_put.png",x + 10, y + 10, 2, 146, 174, true)

		g_BuildChoose_Main[2]:AddItemSelect9Patch("empty.png", "c_ckuang.png", x + 83, y + 80, 146, 140, 0, Function)
		g_BuildChoose_Main[2]:AddItemIcon(uIcon, x + 30 ,y + 45)	
		g_BuildChoose_Main[2]:AddItemText(uNAME, x + 11, y + 155, 146, 25, "0 255 246", 18, "Center")
		g_BuildChoose_Main[2]:AddItemText(uNAME, x + 55, y + 20, 0, 0, "0 255 246", 14)	--����˵��
		local Level = BuildData:GetBuildInfo("BuildDesc_BuildLevel",g_Table[1])
		local pLevel	=	Player:GetLevel()
		if pLevel < Level then
			g_BuildChoose_Main[2]:AddItemIcon(413, x + 10, y + 35 )
			g_BuildChoose_Main[2]:AddItemText("LV"..Level, x + 34, y + 50,100,50,"255 255 255",20 , "Center")					
		end
		if (_nNum == 0) then			
			BuildChoose_OnClick(g_Table[1])
		end
		if ( Index == g_Table[1] ) then
			g_BuildChoose_Main[2]:SetSelectItem(_nNum)							
		end
		_nNum = _nNum + 1
		x= x + 153
		if x > Width then
			Width = Width + 153
		end	
	end
	
	if (_nNum > 3)then
		g_BuildChoose_Main[2]:Touch(0)
	else
		g_BuildChoose_Main[2]:Touch(-1)
	end
	g_BuildChoose_Main[2]:SetContentSize(Width, 285)

end

--********************************************************
--					2��������ѡ��¼�
--********************************************************
function BuildChoose_OnClick(arg)
	local BuildIndex = tonumber(arg)
	if BuildIndex >= 0 and BuildIndex < 50  then

		index = BuildIndex
		local ID, nType, _, strDesc, nBuildTime, nGold, nPlatMoney, nIron, nOil, _, nWorkPerson = BuildData:GetBuildInfo("BuildDesc_DetailInfo", BuildIndex)
		if (nPlatMoney > 0) then
			g_BuildChoose_Main[13]:Show()	
			g_BuildChoose_Text[6]:Show()		
			g_BuildChoose_Text[6]:SetText("-" .. nPlatMoney)
			g_BuildChoose_Main[10]:Hide()				
			g_BuildChoose_Main[11]:Hide()	
			g_BuildChoose_Main[12]:Hide()	
			g_BuildChoose_Text[12]:Hide()			
			g_BuildChoose_Text[13]:Hide()					
			g_BuildChoose_Text[14]:Hide()
		else
			g_BuildChoose_Main[13]:Hide()			
			g_BuildChoose_Text[6]:Hide()	
			if (nGold > 0) then
				g_BuildChoose_Main[10]:Show()			
				g_BuildChoose_Text[14]:Show()				
				g_BuildChoose_Text[14]:SetText("-" .. nGold)	
			else 
				g_BuildChoose_Main[10]:Hide()	
				g_BuildChoose_Text[14]:Hide()		
			end
			if (nIron > 0) then
				g_BuildChoose_Main[11]:Show()	
				g_BuildChoose_Text[12]:Show()	
				g_BuildChoose_Text[12]:SetText("-" .. nIron)
			else
				g_BuildChoose_Main[11]:Hide()	
				g_BuildChoose_Text[12]:Hide()
			end
			if (nOil > 0) then
				g_BuildChoose_Main[12]:Show()	
				g_BuildChoose_Text[13]:Show()
				g_BuildChoose_Text[13]:SetText("-" .. nOil)					
			else			
				g_BuildChoose_Main[12]:Hide()
				g_BuildChoose_Text[13]:Hide()
			end
		end
		if nType == 0 then		--���ཨ�������˿�
			local _,_,nPeople,_,_,_,_,_ =  BuildData:GetHouseInfo(ID)
			g_BuildChoose_Text[15]:SetText((nPeople > 0 and "+" .. nPeople) or nPeople)
		else 
			g_BuildChoose_Text[15]:SetText((nWorkPerson > 0 and "-" .. nWorkPerson) or nWorkPerson)			
		end

		g_BuildChoose_Text[16]:SetText(Main_GetTimeS(nBuildTime / 1000))
		g_BuildChoose_Text[17]:SetText(strDesc)
	end
end

function  Main_GetTimeS(sec)
	local mins = sec / 60
	local secs = math.modf(sec % 60)
	
	local strTime = string.format("%d%s%s%s", mins, "#{TXSS_1000_014}", secs, "#{TXSS_1000_015}")

	return strTime
end

--*********************************************************
--		1��������ѡ��¼�
--*********************************************************
function	BuildChoose_TypeOnClick(arg)
	local _nType = tonumber(arg)
	local _nBuildID = 0
	if (_nType == 0) then
		_nBuildID = 0
	elseif (_nType == 1) then
		_nBuildID = 8
	elseif (_nType == 2) then
		_nBuildID = 3	
	elseif (_nType == 3) then
		_nBuildID = 10	
	end
	PushEvent("BUILD_CHOOSE_TOBUILD", _nType, _nBuildID)
end

--********************************************************
--		��ת�ص�������
--********************************************************
function	BuildChoose_GoBack()
	g_BuildChoose_Main[2]:CleanAllElement()
		
	BuildChoose_HideMask()	-- �����ɰ�
	
	PushEvent("BUILD_CHOOSE_LOAD")
end

--******************************************************
--			�������������ѡ� ס������
--******************************************************
function	BuildChoose_CreateWindowForHouse(Index)
	for i = 4, 8, 1 do 
		g_BuildChoose_Main[i]:Hide()	-- �����������5����ť һ��ͼ��		
	end
	g_BuildChoose_Main[2]:CleanAllElement()
		
	local x, y = 0, 0
	local _nWidth, _nHeight = 701, 182
	local nNum = 0	-- ѡ�������	
	
	for i = 0 , HOUSE_COUNT-1 ,1 do
	
		local uID, uTYPE, uNAME, uIcon = BuildData:GetBuildInfo("BuildChoose_CreateOptions", i)
				
		if (HOUSE_TYPE == uTYPE) then
			local _,_,People,_,_,_,_,_ =  BuildData:GetHouseInfo(i)
			local Function = string.format("BuildChoose_OnClick(%d%s",uID,")")							
			
			g_BuildChoose_Main[2]:AddImage9Patch("j_put.png",x + 10, y + 10, 2, 146, 174, true)
			g_BuildChoose_Main[2]:AddItemSelect9Patch("empty.png", "c_ckuang.png", x + 83, y + 80, 146, 140, 0, Function)
			g_BuildChoose_Main[2]:AddItemIcon(uIcon, x + 30 ,y + 45)	
			g_BuildChoose_Main[2]:AddItemText(uNAME, x + 11, y + 155, 146, 25, "0 255 246", 18, "Center")	      			 -- ����ͼ��1
			g_BuildChoose_Main[2]:AddItemText("+" .. People .. "#{JZCD_1000_006}", x + 55, y + 20, 0, 0, "0 255 246", 14)  -- ����ͼ��2	
			
			local Level = BuildData:GetBuildInfo("BuildDesc_BuildLevel",i)
			local pLevel = Player:GetLevel()
			if pLevel < Level then
				g_BuildChoose_Main[2]:AddItemIcon(413, x + 10, y + 35)	
				g_BuildChoose_Main[2]:AddItemText("LV"..Level, x + 34, y + 50,100,50,"255 255 255",20, "Center" )			
			end		
			
			if (uID == Index) then
				BuildChoose_OnClick(uID)					
				g_BuildChoose_Main[2]:SetSelectItem(nNum)	
			end
			nNum = nNum + 1
			
			x = x + 153
			if x > _nWidth then
				_nWidth = _nWidth + 153
			end	
		end
	end
	if (nNum > 3)then
		g_BuildChoose_Main[2]:Touch(0)
	else
		g_BuildChoose_Main[2]:Touch(-1)
	end
	g_BuildChoose_Main[2]:SetContentSize(_nWidth - 66, 285)
end

--======================================
--				������Դ����Ϣ
--======================================
function	BuildChoose_UpData()
	local	p_WorkPerson, p_MaxPerson = Player:GetPerson()
	local 	p_Person 	= string.format("%d%s%d",p_WorkPerson,"/",p_MaxPerson)
	local	pDMoney 	= Player:GetDiamond()					
	local	pMoney 		= Player:GetMoney()	
	
	if p_WorkPerson == p_MaxPerson then
		g_BuildChoose_Text[1]:SetColor("255 0 0")
	else
		g_BuildChoose_Text[1]:SetColor("255 255 255")
	end
	
	g_BuildChoose_Text[1]:SetText(p_Person)	
	g_BuildChoose_Text[2]:SetText(pDMoney)
	g_BuildChoose_Text[3]:SetText(pMoney)
	
	local	pSteel 		= Player:GetIron()
	local	pOil		= Player:GetOil()
	local	MaxSteel	= Player:GetIronLimit()
	local	MaxOil		= Player:GetOilLimit()
	
	if (math.floor(MaxSteel) <= 0 or math.floor(MaxOil) <= 0) then
		return
	end	
	if (p_WorkPerson >= p_MaxPerson) then
		g_BuildChoose_Text[1]:SetColor("255 0 0")	
	else			
		g_BuildChoose_Text[1]:SetColor("255 255 255")			
	end
	if (pSteel >= MaxSteel) then			
		g_BuildChoose_Text[7]:SetColor("255 0 0")	
	else			
		g_BuildChoose_Text[7]:SetColor("255 255 255")
	end		
	if (pOil >= MaxOil) then	
		g_BuildChoose_Text[8]:SetColor("255 0 0")
	else 
		g_BuildChoose_Text[8]:SetColor("255 255 255")		
	end
	g_BuildChoose_Text[7]:SetText(string.format("%s%s%s", pSteel, "/", MaxSteel))	
	g_BuildChoose_Text[8]:SetText(string.format("%s%s%s", pOil, "/", MaxOil))	
	
	local steel = pSteel / MaxSteel
	local oil = pOil / MaxOil
	if pSteel > MaxSteel then
		steel = 1
	end

	if pOil > MaxOil then
		oil = 1	
	end
	--g_BuildChoose_Text[18]:RunFromTo(0, 100 * pSteel / MaxSteel, 0)
	--g_BuildChoose_Text[19]:RunFromTo(0, 100 * pOil / MaxOil, 0)
	g_BuildChoose_Text[18]:RunFromTo(0, 100 * steel , 0)
	g_BuildChoose_Text[19]:RunFromTo(0, 100 * oil , 0)
	
	g_BuildChoose_Text[5]:SetText("#{TXSS_1000_040}")
end

function	BuildChoose_jianzao()
	local g_Build_index = index
	
	if g_Build_index >= 0 and g_Build_index < 50 then
		local BuildLevel = BuildData:GetBuildInfo("BuildDesc_BuildLevel",g_Build_index)		
		local playerLevel = Player:GetLevel()

		if (playerLevel >= BuildLevel) then			
			CloseAllWidget()
			BuildData:CreateNewBuild(g_Build_index)
		else
			PushToast("#{TXSS_2000_010}")
		end
		g_Build_index = -1
	end
end

function	BuildChoose_AddButton()
	
end

--********************************************************
--					Coming soon ����¼�
--********************************************************
function	BuildChoose_ComingSoonClick()
	PushToast("#{TIP_1000_027}")
end
