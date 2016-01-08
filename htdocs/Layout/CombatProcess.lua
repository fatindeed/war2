local g_CombatProcess_User		= {}
local g_CombatProcess_Foe		= {}
local g_CombatProcess_LiftMenu	= {}
local g_CombatProcess_DownMenu	= {}
local g_CombatProcess_Main 		= {}
local g_CombatProcess_Show		= {}

local g_scriptID 				= -1
local g_functionName			= ""

local g_SolderCount				= 0							-- ���µ�Ԫ��������
				
local g_unit					= 0							-- ����ս���ĵ�Ԫ������
local g_CurJoinCount	 		= 0							-- ��ǰ����ս���ĵ�Ԫ��
local g_RoundCount				= 0							-- �غϴ���

local g_OurMaxHp				= 0							-- �ҷ��������ֵ
local g_EnmyMaxHp				= 0							-- �з��������ֵ

local g_nMatchRemainTime		= 10						-- ����ʱƥ��ʣ��ʱ��  10��
local g_nTakeTurnRemainTime     = 10						-- ����ʱ�ֻ�ʣ��ʱ��  10��
local g_nCurTakeTurnCamp        = -1						-- ��ǰ������Ӫ��  0 �ҷ� 1 �з�

local g_nCombatType	= 										-- ս������
{
	g_PVE_Combat		  		= 1,
	g_PVP_Combat		 		= 2,
	g_PVPE_Combat				= 3
}       

local g_nBattleState			= 1							-- ս��״̬ȱʡΪս����

local BATTLE_STATE 	=
{
	BATTLE_STATE_PROCESSING	    = 1,						-- ս����
	BATTLE_STATE_FINISH			= 2							-- ս�����
}

local g_PortraitImageName = {"uidenglu_touxiang1.png", "uidenglu_touxiang2.png", "uidenglu_touxiang3.png", "uidenglu_touxiang4.png"}

-- �����ӳ��·�����
local g_DelayDataListenning = false

-- ע���¼�
function	CombatProcess_PreLoad()
	this:RegisterEvent("COMBATPROCESS_LOAD")						-- ���봰��
	this:RegisterEvent("UI_COMMAND") 								-- UI�¼�
	this:RegisterEvent("COMBATPROCESS_UPDATE")  					-- ����
	this:RegisterEvent("COMBATPROCESS_SELFBLOOD_LOAD")  			-- �����ҷ���Ѫ��
	this:RegisterEvent("COMBATPROCESS_ENEMYBLOOD_LOAD") 			-- ���µз���Ѫ��
	this:RegisterEvent("COMBATPROCESS_WIN_LOAD") 					-- ս��ʤ��
	this:RegisterEvent("COMBATPROCESS_FAIL_LOAD") 					-- ս��ʧ��
	this:RegisterEvent("COMBATPROCESS_TAKETURN_UPDATE")				-- �����ֻ�
	this:RegisterEvent("COMBATPROCESS_RETREAT_HIDE")				-- ���س���
	this:RegisterEvent("COMBATPROCESS_UNITLIST_VISIBLE")			-- ��Ԫ�б�����
	this:RegisterEvent("COMBATPROCESS_END_DELAY_LISTEN")		    -- ���������·��ӳ�����
end

-- Ԥ���ر�ǩ�ļ�
function	CombatProcess_OnLoad()
	g_CombatProcess_User[1] = CombatProcess_UserHPBar						-- �û�Ѫ��
	g_CombatProcess_User[2] = CombatProcess_UserHead						-- �û�ͷ��
	g_CombatProcess_User[3] = CombatProcess_UserNameText				-- �û�����
	g_CombatProcess_User[4] = CombatProcess_UserClass_Text			-- �û��ȼ�

	g_CombatProcess_Foe[1] = CombatProcess_FoeHPBar							-- ����Ѫ��
	g_CombatProcess_Foe[2] = CombatProcess_FoeHead							-- ����ͷ��
	g_CombatProcess_Foe[3] = CombatProcess_FoeNameText					-- ��������
	g_CombatProcess_Foe[4] = CombatProcess_FoeClass_Text				-- ���˵ȼ�

	g_CombatProcess_LiftMenu[1] = CombatProcess_Kzan_Button			-- ��ս��ť
	g_CombatProcess_LiftMenu[2] = CombatProcess_Handup_Button		-- �йܰ�ť����
	g_CombatProcess_LiftMenu[3] = CombatProcess_Handup_ButtonOne	-- �й�  
	g_CombatProcess_LiftMenu[4] = CombatProcess_Handup_ButtonTwo	-- ȡ��
	g_CombatProcess_LiftMenu[5] = CombatProcess_Retreat_Button		-- ���˰���

	g_CombatProcess_DownMenu[1] = CombatProcess_DownSubMenuWindow	-- ѡ��������
	g_CombatProcess_DownMenu[2] = ComnatProcess_ScrollView			-- ѡ����
	g_CombatProcess_DownMenu[3] = CombatProcess_Cure_Button			-- Ѫƿ��ť
	g_CombatProcess_DownMenu[4] = CombatProcess_Shift_Button		-- �ٶȰ�ť
	g_CombatProcess_DownMenu[5] = ComnatProcess_ArmyButtonOne		-- �û�����
	-- g_CombatProcess_DownMenu[6] = ComnatProcess_ArmyButtonTwo		-- ��Ӷ��
	g_CombatProcess_DownMenu[7] = ComnatProcess_Shift_ButtonTwo		-- �ٶȼӳ�
	
	g_CombatProcess_Main[1] = CombatProcess_NextRound				-- ��һ�غ���ʾ�İ���
	g_CombatProcess_Main[2] = ComnatProcess_Unit_Text				-- ��սʿ����������		
	g_CombatProcess_Main[3] = CombatProcess_ReadyGoTipWindow		-- ׼����ʼս�����
	g_CombatProcess_Main[4] = CombatProcess_PvPArrangeCoord_Text	-- PVP������ʾ�ı�
	g_CombatProcess_Main[5] = CombatProcess_Image_ReadyTip			-- ׼��ͼƬ
	g_CombatProcess_Main[6] = CombatProcess_Image_StartTip			-- ��ʼͼƬ
	g_CombatProcess_Main[7] = CombatProcess_MyHpText				-- �Լ�����Ѫ�� �ı�
	g_CombatProcess_Main[8] = CombatProcess_EnmyHpText				-- �Է�����Ѫ�� �ı�
	g_CombatProcess_Main[9] = CombatProcess_Content_Text            -- �ֵ�	�����ơ�
	g_CombatProcess_Main[11] = CombatProcess_MatchCountDown_Timer	 -- ƥ�䵹��ʱ��ʱ��
	g_CombatProcess_Main[12] = CombatProcess_MatchCountDown_BarBg	-- ƥ�䵹��ʱ����������
	g_CombatProcess_Main[13] = CombatProcess_MatchCountDown_Bar		 -- ƥ�䵹��ʱ������
	g_CombatProcess_Main[14] = CombatProcess_MatchCountDown_Frame	 -- ƥ�䵹��ʱ��������
	g_CombatProcess_Main[15] = CombatProcess_MatchCountDown_Desc	 -- ƥ�䵹��ʱ�ֵ䡾ƥ������У�10Sƥ��һ�ζ���,����Ķ����ǲ���ɣ���
	g_CombatProcess_Main[16] = CombatProcess_MatchCountDown_Text	 -- ƥ�䶨ʱ��ʱ��
	g_CombatProcess_Main[17] = CombatProcess_AttackRamainTimeText	 -- �����ֻ�����ʱ
	g_CombatProcess_Main[18] = CombatProcess_AttackRamainTime_Timer  -- �����ֻ�����ʱ
	g_CombatProcess_Main[19] = CombatProcess_AttackTakeTurnDesc		 -- �ֻ����� �ֵ䡾�з�����˼���������������
	g_CombatProcess_Main[20] = CombatProcess_DelayData_Timer 		 -- �Է������·�������ʱ��
end

-- ��Ӧ�¼�
function	CombatProcess_OnEvent(event)

	if (event == "UI_COMMAND" and tonumber(arg0) == 100001) then		-- PVE��Ϣ
		
		g_functionName	= Get_XParam_STR(1)
		g_unit			= Get_XParam_INT(1)
		g_scriptID		= Get_XParam_INT(2)
		
		-- ��ʾͷ�������
		CombatProcess_Update()
		
		-- ����
		local level = Get_XParam_INT(0)
		local name  = Get_XParam_STR(0)	
		g_CombatProcess_Foe[1]:RunFromTo(0, 100, 0) 
		g_CombatProcess_Foe[3]:SetText(tostring(name))
		g_CombatProcess_Foe[4]:SetText(tostring(level))
		
		-- ��ʾ���˰���
		g_CombatProcess_LiftMenu[5]:Show()	

		-- �����й�	
		g_CombatProcess_LiftMenu[2]:Hide() 	
		
		-- ���ز�����ʾ
		g_CombatProcess_Main[4]:Hide()	

		-- �������ư���	
		g_CombatProcess_DownMenu[3]:Hide()
		
		-- ����ƥ�䶨ʱ��	
		CombatProcess_HideMatchCountDown()
		
		-- �����ֻ���ʱ��
		CombatProcess_HideTakeTurn()
		
		-- ��ʾ����
		CombatProcess_PeopleNum()		
		
		-- ��ʾԭ��
		g_CombatProcess_DownMenu[7]:SetNormal9PatchImg("ms_sudu1.png")
		g_CombatProcess_DownMenu[7]:SetSelect9PatchImg("ms_sudu1.png")
		
	elseif (event == "UI_COMMAND" and tonumber(arg0) == 100002) then -- PVP��Ϣ
		
		g_functionName	= Get_XParam_STR(0)
		g_unit 	  		= Get_XParam_INT(0)
		g_scriptID 	  	= Get_XParam_INT(1)
		
		-- �����ϳ�����
		CombatProcess_PeopleNum()
		
		-- ��ʾͷ�������
		CombatProcess_Update()
		
		-- �Է���Ϣ
		CombatProcess_FoeWindow:Hide()
		
		-- ����Ѫƿ
		g_CombatProcess_DownMenu[3]:Hide()
		CombatProcess_VS:Hide()
		
		-- ��ʾ���˰���
		g_CombatProcess_LiftMenu[5]:Show()	
		
		-- ��ʾ������ʾ
		g_CombatProcess_Main[4]:Show()
		g_CombatProcess_Main[4]:SetText("#{UITT_1000_018}")
		
		-- ����ƥ�䶨ʱ��	
		CombatProcess_HideMatchCountDown()
		
		-- �����ֻ���ʱ��
		CombatProcess_HideTakeTurn()
	elseif (event == "UI_COMMAND" and tonumber(arg0) == 100003) then	-- �Է���Ϣ
		
		local level 	  = Get_XParam_INT(0)
		local loop		  = Get_XParam_INT(1)
		local name 	  	  = Get_XParam_STR(0)
		-- ��ֵ������Ӫ��
		g_nCurTakeTurnCamp = loop
		
		-- �Է���Ϣ
		CombatProcess_FoeWindow:Show()
		g_CombatProcess_Foe[3]:SetText(tostring(name))
		g_CombatProcess_Foe[4]:SetText(tostring(level))
			
		-- ����ƥ�䶨ʱ��	
		CombatProcess_HideMatchCountDown()
		
		-- ˭�ȳ���
		LoopRanking(loop)

		-- ��ʾ�ֻ���ʱ��
		CombatProcess_ShowTakeTurn(loop)
		
		-- ��ʾ�й�	
		g_CombatProcess_LiftMenu[2]:Show() 	
	elseif (event == "UI_COMMAND" and tonumber(arg0) == 100004) then -- �Է�����
		
		-- ������Ϣ
		PushToast("#{UITT_1000_025}")
		
		-- �Է���Ϣ
		CombatProcess_FoeWindow:Hide()
	elseif (event == "UI_COMMAND" and tonumber(arg0) == 100005) then -- PVPE   PVPģʽ�ڹ涨ʱ��û��ƥ�䵽��ң��Զ�ת��PVE
		
		g_functionName	= Get_XParam_STR(0)
		g_unit 	  		= Get_XParam_INT(0)
		g_scriptID 	  	= Get_XParam_INT(1)	
		--
		local name 	  	  = Get_XParam_STR(1)
		-- �Է���Ϣ
		CombatProcess_FoeWindow:Show()
		g_CombatProcess_Foe[3]:SetText(tostring(name))
		--		
		
		SetSceneType(g_nCombatType.g_PVPE_Combat)
		
		-- ��ʾ���˰���
		g_CombatProcess_LiftMenu[5]:Show()	

		-- ���ز�����ʾ
		g_CombatProcess_Main[4]:Hide()	

		-- �������ư���	
		g_CombatProcess_DownMenu[3]:Hide()

		-- �Է���Ϣ
		CombatProcess_FoeWindow:Show()
		
		-- ��ʾ�й�	
		g_CombatProcess_LiftMenu[2]:Show() 	
		
		-- ����ƥ�䶨ʱ��	
		CombatProcess_HideMatchCountDown()
		
		-- �����ֻ���ʱ��
		CombatProcess_HideTakeTurn()
		
		-- ��ʾ����
		CombatProcess_PeopleNum()		
		
		-- ��ʾԭ��
		g_CombatProcess_DownMenu[7]:SetNormal9PatchImg("ms_sudu1.png")
		g_CombatProcess_DownMenu[7]:SetSelect9PatchImg("ms_sudu1.png")				
	elseif (event == "COMBATPROCESS_WIN_LOAD") then

		local nType = GetSceneType()
		if nType == g_nCombatType.g_PVE_Combat then --PVE
			g_RoundCount = g_RoundCount + 1
			if g_RoundCount < 3 then
				-- ��ʾ��һ�ذ�ť
				CombatProcess_ShowNextRound()
				
				g_EnmyMaxHp	= 0				-- �з��������ֵ
			else
				local probability = tonumber(arg0)
				g_OurMaxHp	= 0				-- �ҷ��������ֵ
				g_EnmyMaxHp	= 0				-- �з��������ֵ
				-- ��ʾս��ʤ��
				CombatProcess_Win(probability)	
				g_CombatProcess_Main[7]:SetText("")
			end
		elseif( nType == g_nCombatType.g_PVP_Combat or nType == g_nCombatType.g_PVPE_Combat) then --PVP PVPE
		
			-- ��ʾս��ʤ��
			CombatProcess_Win(0)
			g_CombatProcess_Main[7]:SetText("")
		end
		
	elseif (event == "COMBATPROCESS_FAIL_LOAD") then
	
			-- ��ʾս��ʧ��
			local probability = tonumber(arg0)
						
			CombatProcess_Fail(probability)
	
			g_OurMaxHp	= 0				-- �ҷ��������ֵ
			g_EnmyMaxHp	= 0				-- �з��������ֵ
			
	elseif (event == "COMBATPROCESS_LOAD") then  -- ����ս������
		-- ��ʾ����
		this:Show()
		-- ��ʼ���غ���
		g_RoundCount = 0
		-- ��þ��µ�Ԫ��������
		g_SolderCount = Solider:GetArmyTypeCount()
		-- ������µ�Ԫ�б�
		AskSoliderList()
		-- �����ʼ��
		CombatProcess_Init()
		-- ˢ��ʿ���б�
		CombatProcess_InitArrmyList()
		-- ��ʾ׼��ս������
		CombatProcess_ShowReady()

		g_CombatProcess_Main[9]:SetText("#{TXSS_1000_054}")
	elseif (event == "COMBATPROCESS_UPDATE") then   -- ����ս������
		g_CurJoinCount = DataPool:GetJoinSoliderCount(0)	
		
		if(g_CurJoinCount < 1) then
			g_CombatProcess_LiftMenu[1]:DestoryButton()
		else 		
			g_CombatProcess_LiftMenu[1]:UNDestoryButton()
		end		
		CombatProcess_InitArrmyList()	
		
		CombatProcess_PeopleNum()
	elseif (event == "COMBATPROCESS_SELFBLOOD_LOAD") then -- �����ҷ���Ѫ��
		if arg0 ~= nil then
			arg0 = tonumber(arg0)	 					   -- ʣ��Ѫ��
			local fromPercent = g_CombatProcess_User[1]:GetPercent() 		
			local duration  = math.abs(arg0 - fromPercent) / 14
			
			if fromPercent < arg0 then
				duration = 0
			end

			if g_OurMaxHp == 0 then
				g_OurMaxHp = GetMaxHpArmed()			    -- �ҷ�ʿ������ֵ�ܺ�	
			end

			local endValue = ( arg0 / g_OurMaxHp ) * 100
						
			g_CombatProcess_User[1]:RunFromTo(fromPercent, endValue, duration)

			g_CombatProcess_Main[7]:SetText("#{TXSS_1000_026}: "..arg0)
		end
	elseif (event == "COMBATPROCESS_ENEMYBLOOD_LOAD") then -- ���µз���Ѫ��	
		if arg0 ~= nil then
			arg0 = tonumber(arg0)	 -- Ѫ��ʣ��ٷֱ�
			local fromPercent = g_CombatProcess_Foe[1]:GetPercent() 		
			local duration  = math.abs(arg0 - fromPercent) / 14
			if fromPercent < arg0 then
				duration = 0
			end
			
			if g_EnmyMaxHp == 0 then
				g_EnmyMaxHp =  GetMaxHpHostile()			-- �з�ʿ������ֵ�ܺ�		
			end

			local endValue = ( arg0 / g_EnmyMaxHp ) * 100
			
			g_CombatProcess_Foe[1]:RunFromTo(fromPercent, endValue, duration)	
			g_CombatProcess_Main[8]:SetText("#{TXSS_1000_026}: "..arg0)
		end		
	elseif (event == "COMBATPROCESS_TAKETURN_UPDATE") then  -- �ֻ�����
		-- �ֻ��Է���Ӫ	
		if arg0 ~= nil then
			g_nCurTakeTurnCamp = tonumber(arg0)
			
			if g_nBattleState == BATTLE_STATE.BATTLE_STATE_FINISH then
				return			
			end
			
			CombatProcess_ShowTakeTurn(g_nCurTakeTurnCamp)
		end
	elseif (event == "COMBATPROCESS_RETREAT_HIDE") then		-- ���س���
		g_CombatProcess_LiftMenu[5]:Hide()	
	elseif (event == "COMBATPROCESS_UNITLIST_VISIBLE") then -- ��Ԫ�б���ʾ״̬
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
		
		g_CombatProcess_LiftMenu[2]:Show() 						  -- ��ʾ�й�		
	end
end

-- ��ʾͷ�������
function	CombatProcess_Update()
	-- �û�
	local UserName	= Player:GetName()
	local UserLevel	= Player:GetLevel()
	g_CombatProcess_User[1]:RunFromTo(0,100,0)
	g_CombatProcess_User[3]:SetText(tostring(UserName))
	g_CombatProcess_User[4]:SetText(tostring(UserLevel))
end

--================================
--			�����ʼ��
--================================
function	CombatProcess_Init()
	-- �����йܰ�ť
	g_CombatProcess_LiftMenu[2]:Hide()
	-- ��ʾ��ս��ť
	g_CombatProcess_LiftMenu[1]:Show()
	-- ������һ�ذ�ť
	g_CombatProcess_Main[1]:Hide()
	-- ���ؼ��ٰ���
	g_CombatProcess_DownMenu[4]:Hide()
	-- ��ʾ�й�����
	g_CombatProcess_LiftMenu[3]:Show()
	-- ����ȡ������
	g_CombatProcess_LiftMenu[4]:Hide()
	-- ��ʼ���Լ�ͷ��	
	CombatProcess_UpdatePortrait()
	-- ��ʼ��ս��״̬
	g_nBattleState = BATTLE_STATE.BATTLE_STATE_PROCESSING
end

--===========================================
--				 ����ͷ��
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
--			��ʾ��ս��������
--================================
function	CombatProcess_PeopleNum()

	local unitText = g_CurJoinCount.."/"..g_unit.."#{TXSS_2000_022}"
	g_CombatProcess_Main[2]:SetText(unitText)
			
end

--============================================
--			��ʾ��һ�ذ�ť
--============================================
function	CombatProcess_ShowNextRound()
	g_CombatProcess_Main[1]:SetPosition(433, 205)	
	g_CombatProcess_Main[1]:MoveBy(10, 10, 0.2, true)
	g_CombatProcess_Main[1]:Show()
	
	g_CombatProcess_LiftMenu[2]:Hide() -- �����й�
	CombatProcess_CancelHandUp()
end

--========================================
--			ˢ��ʿ���б�
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
--				 ����ģ��
--========================================
function	CombatProcess_CreateTemp(ID,ICON,MIN,MAX,X,Y)

	local Function = string.format("%s%d%s","CombatProcess_ArrmyOnClick(",ID,")")
	g_CombatProcess_DownMenu[2]:AddItemIcon(15, X, Y)
	g_CombatProcess_DownMenu[2]:AddItemSelect(ICON,ICON,X+32,Y+33,Function)
	g_CombatProcess_DownMenu[2]:AddItemIcon(16, X + 51, Y + 50)	
	g_CombatProcess_DownMenu[2]:AddItemText(MIN, X + 50, Y + 50, 0, 0, "181 251 255", 18)
end

--====================================
--			��ʾƥ�䵹��ʱ
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
	-- ����ƥ��ʱ��	
	g_nMatchRemainTime = 10
end

--====================================
--			����ƥ�䵹��ʱ
--====================================
function	CombatProcess_HideMatchCountDown()
	g_CombatProcess_Main[12]:Hide()
	g_CombatProcess_Main[13]:Hide()
	g_CombatProcess_Main[14]:Hide()
	g_CombatProcess_Main[15]:Hide()
	g_CombatProcess_Main[16]:Hide()
	-- ����
	g_CombatProcess_Main[13]:RunFromTo(0, 0, 0)	
	g_CombatProcess_Main[11]:StopTime()
end

--====================================
--			��ʾ�ֻ�����ʱ
--====================================
function	CombatProcess_ShowTakeTurn(loop)
	-- �����ֻ�ʱ��
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
--			�����ֻ�����ʱ
--====================================
function	CombatProcess_HideTakeTurn()
	g_CombatProcess_Main[17]:Hide()
	g_CombatProcess_Main[18]:StopTime()
	g_CombatProcess_Main[19]:Hide()
end

--====================================
--			�����ֻ�����ʱ
--====================================
function CombatProcess_Update_TakeTurnTime()
	if g_nBattleState == BATTLE_STATE.BATTLE_STATE_FINISH then	-- ��ս��������ʱ��
		g_CombatProcess_Main[18]:StopTime()						-- ֹͣ�ֻ���ʱ�� 
		g_CombatProcess_Main[17]:SetText("0#{TXSS_1000_015}")	-- ����0�� 
		return
	end
	
	g_nTakeTurnRemainTime = g_nTakeTurnRemainTime - 1
	g_CombatProcess_Main[17]:SetText(g_nTakeTurnRemainTime .. "#{TXSS_1000_015}")
end

--====================================
--			�����ֻ�����ʱ
--====================================
function CombatProcess_End_TakeTurnTime()
	g_CombatProcess_Main[18]:StopTime()
	
	local bEntrusting = GetEntrustState() 
	if bEntrusting == false then
		CombatProcess_StartHandUp()
	end
end

--================================================
--				����ƥ�䵹��ʱ
--================================================
function CombatProcess_Update_MatchingTime()
	g_nMatchRemainTime = g_nMatchRemainTime - 1
	g_CombatProcess_Main[16]:SetText(g_nMatchRemainTime .. "#{TXSS_1000_015}")

end

--==============================================
--				��������ƥ�䵹��ʱ
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
--				��ʾ׼��ս��
--====================================
function	CombatProcess_ShowReady()
	g_CombatProcess_Main[3]:Show()
	g_CombatProcess_Main[5]:Show()
	g_CombatProcess_Main[6]:Hide()
	g_CombatProcess_Main[5]:setAnimation("animation",false)
end

--====================================
--				׼��ս����������
--====================================
function CombatProcess_Ready_SkeletonAnimationEnd()
    g_CombatProcess_Main[5]:Hide()
end

--==========================================
--				��ʾ��ʼս��
--==========================================
function	CombatProcess_ShowStartBattle()
	g_CombatProcess_Main[5]:Hide()
	g_CombatProcess_Main[6]:Show()
	g_CombatProcess_Main[6]:setAnimation("animation",false)
end

--==========================================
--				��ʼս����������
--==========================================
function CombatProcess_Start_SkeletonAnimationEnd()
	g_CombatProcess_Main[3]:Hide()
	g_CombatProcess_Main[5]:Hide()
	g_CombatProcess_Main[6]:Hide()
	--PushToast("start combat end")
end

--==========================================
--				����¼�	ѡ��
--==========================================
function	CombatProcess_ArrmyOnClick(index)
	if index < 100 and index > -1 then
	
		local SCENE_TYPE = GetSceneType()

		-- ��òμ�ս���ı�������
		local curSoldierJoinCount = DataPool:GetJoinSoliderCount(0)	
			
		local curSoldierUseCount, MaxSoldierCount = DataPool:GetSoliderList(index)-- ��ñ������͵Ŀ�ʹ������
			
		if(curSoldierUseCount <= 0)then  					-- ��֤��ǰ���ͱ��֣��Ƿ��п��õ�
			PushToast("#{TXSS_2000_024}")		
		elseif (curSoldierJoinCount >= g_unit)then	
			PushToast("#{TXSS_2000_021}"..g_unit.."#{TXSS_2000_022}")	
		else
			CreateSolider(index)
				
			curSoldierUseCount = curSoldierUseCount - 1
			DataPool:UpdateSoliderList(index, curSoldierUseCount, MaxSoldierCount)
				
			PushEvent("COMBATPROCESS_UPDATE")				 -- ����ս���˵�
		end
	end
end

--==========================================
--			�������ս���¼�
--==========================================
function	CombatProcess_StartBattle()

	if g_CurJoinCount == 0 or g_CurJoinCount > g_unit then   -- �����ս����������Ҫ��	
		PushMessageBox("#{TXSS_2000_018}")					  -- ���������ʾ
		
		return
	end
	
	local nType = GetSceneType()
	
	if nType == g_nCombatType.g_PVE_Combat or nType == g_nCombatType.g_PVPE_Combat then
		
		BeginFight("PVE_COMBAT")
		-- ����ƥ�䶨ʱ��	
		CombatProcess_HideMatchCountDown()	
		-- ��ʾ���ư���	
		--g_CombatProcess_DownMenu[3]:Show()
		-- ������ȴ�����
		OpenRequestWaitProgress()
		-- �����ӳټ���
		CombatProcess_Start_ListenDelayTime()
	elseif nType == g_nCombatType.g_PVP_Combat then
	
		BeginFight("PVP_COMBAT")
		
		-- ���س��˰���
		g_CombatProcess_LiftMenu[5]:Show()
			
		-- ���ز�����ʾ	
		g_CombatProcess_Main[4]:Hide()

		-- ��ʾƥ�䶨ʱ��	
		CombatProcess_ShowMatchCountDown()
		
	end
	
	g_CombatProcess_DownMenu[1]:Hide()
	g_CombatProcess_LiftMenu[1]:Hide()

	CombatProcess_ShowStartBattle()	

end

--==========================================
--			 ����¼�	�й�
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
--				 �����й� 
--==========================================
function   CombatProcess_StartHandUp()

	g_CombatProcess_LiftMenu[3]:Hide()	--�����й�����
	g_CombatProcess_LiftMenu[4]:Show()	--��ʾȡ������
	
	local nType = GetSceneType()
	if nType == g_nCombatType.g_PVE_Combat or nType == g_nCombatType.g_PVPE_Combat then
		g_CombatProcess_DownMenu[4]:Show()	--��ʾ���ٰ���
		g_CombatProcess_DownMenu[3]:Hide()	--�������ư���
	end
	
	Entrust(true)
	
end

--==========================================
--				 ȡ���й� 
--==========================================
function   CombatProcess_CancelHandUp()
	g_CombatProcess_LiftMenu[3]:Show()	--��ʾ�й�����
	g_CombatProcess_LiftMenu[4]:Hide()	--����ȡ������
	
		
	local nType = GetSceneType()
	if nType == g_nCombatType.g_PVE_Combat then
		--g_CombatProcess_DownMenu[3]:Show()	--��ʾ���ư���
		g_CombatProcess_DownMenu[4]:Hide()	--���ؼ��ٰ���
	end
	
	Entrust(false)
	
end


--==========================================
--			����¼�	����
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
--			����¼�	��Ѫ
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
--			����¼�	��һ��
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
	--FORCES_ARMED    = 0,	//�Ҿ�
	--FORCES_HOSTILE  = 1,	//�жԾ��� 
	Solider:SetFightTarget(0);
	g_CombatProcess_LiftMenu[2]:Show() -- ��ʾ�й�
	
	OpenRequestWaitProgress()
	
	CombatProcess_Start_ListenDelayTime()
end

--==========================================
--				ս��ʤ��
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
--				ս��ʧ��
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
--				���˰��� �¼�
--==========================================
function CombatProcess_RetreatOnEvent()
	CloseAllWidget()
	
	PushEvent("LOADINGWIDGET_LOAD")
	g_CombatProcess_Main[7]:SetText("")
	-- �����ֻ���ʱ��
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
--		 ��ʼ�Է������·��������¼�
--==========================================
function CombatProcess_Start_ListenDelayTime()
	g_DelayDataListenning = true
	g_CombatProcess_Main[20]:StartTime(10, 0, 1, 1)
end

--==========================================
--		 �����Է������·��������¼�
--==========================================
function CombatProcess_End_ListenDelayTime()
	if g_DelayDataListenning == true then
		
		PushMessageBox("#{CUPY_4000_070}")		
				
		g_CombatProcess_Main[20]:StopTime()
		g_DelayDataListenning = false
	end
end



