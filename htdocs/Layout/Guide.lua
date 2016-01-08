local g_Guide_Main = {}
-----------------------------------------------------
--����ָ������
--����
--���� 1: NPC�������� 2: ��ͷ����
-----------------------------------------------------
local g_GuideTable =
{	
-- ���콺�����		
	{Type = 2, PosX = 80,  PosY = 330, OffsetX = -70,  OffsetY = -10,  Width = 60,  Height = 60,  FlipX = false},-- ����ͼ�꡾��ʾ��ͷ��	  
	{Type = 2, PosX = 667, PosY = 401, OffsetX = -70,  OffsetY = -20,  Width = 42,  Height = 42,  FlipX = false},-- ���������б� �رս��水��
	{Type = 2, PosX = 615, PosY = 86,  OffsetX = 125,  OffsetY = -15,  Width = 68,  Height = 60,  FlipX = true },-- ���˵���������	
	{Type = 2, PosX = 230, PosY = 275, OffsetX = -106, OffsetY = 19,   Width = 148, Height = 148, FlipX = false},-- ����ѡ��һ������										 													 		
	{Type = 2, PosX = 520, PosY = 40,  OffsetX = 125,  OffsetY = -12,  Width = 120, Height = 40,  FlipX = true },-- ����ѡ���������
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_074}"},	 -- NPC�����޷��ƶ����� ��NPC��ʾ�����ؼ�ͷ��	
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -76,  OffsetY = -26,  Width = 55,  Height = 55,  FlipX = false},-- ����ѡ��λ��
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -70,  OffsetY = -45,  Width = 65,  Height = 140, FlipX = false},-- ������Ӽ���
-- ������ũԷ 
	{Type = 2, PosX = 80,  PosY = 330, OffsetX = -70,  OffsetY = -10,  Width = 60,  Height = 60,  FlipX = false},-- ����ͼ�꡾��ʾ��ͷ��	  	
	{Type = 2, PosX = 667, PosY = 401, OffsetX = -70,  OffsetY = -20,  Width = 42,  Height = 42,  FlipX = false},-- ���������б� �رս��水��
	{Type = 2, PosX = 615, PosY = 86,  OffsetX = 125,  OffsetY = -15,  Width = 68,  Height = 60,  FlipX = true },-- ���˵���������
	{Type = 2, PosX = 475, PosY = 275, OffsetX = 135,  OffsetY = 19,   Width = 148, Height = 148, FlipX = true },-- ����ѡ��һ������																				
	{Type = 2, PosX = 520, PosY = 40,  OffsetX = 125,  OffsetY = -12,  Width = 120, Height = 40,  FlipX = true },-- ����ѡ���������
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_074}"},	 -- NPC�����޷��ƶ����� ��NPC��ʾ�����ؼ�ͷ��		
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -76,  OffsetY = -26,  Width = 55,  Height = 55,  FlipX = false},-- ����ѡ��λ��
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -70,  OffsetY = -45,  Width = 65,  Height = 140, FlipX = false},-- ���ũԷ����
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -70,  OffsetY = -45,  Width = 65,  Height = 140, FlipX = false},-- ���ũԷ�ȴ�״̬
	{Type = 2, PosX = 596, PosY = 70,  OffsetX = -100, OffsetY = -25,  Width = 116, Height = 42,  FlipX = false},-- ���ũԷ�ȴ�����
	{Type = 2, PosX = 596, PosY = 70,  OffsetX = -100, OffsetY = -25,  Width = 116, Height = 42,  FlipX = false},-- ���ũԷ�ռ�
	{Type = 2, PosX = 552, PosY = 391, OffsetX = 98,   OffsetY = -17,  Width = 38,  Height = 38,  FlipX = true },-- ���ũԷ�ر�	
-- ������Դ������
	{Type = 2, PosX = 80,  PosY = 330, OffsetX = -70,  OffsetY = -10,  Width = 60,  Height = 60,  FlipX = false},-- ����ͼ�꡾��ʾ��ͷ��	  
	{Type = 2, PosX = 667, PosY = 401, OffsetX = -70,  OffsetY = -20,  Width = 42,  Height = 42,  FlipX = false},-- ���������б� �رս��水��
	{Type = 2, PosX = 615, PosY = 86,  OffsetX = 125,  OffsetY = -15,  Width = 68,  Height = 60,  FlipX = true },-- ���˵���������
	{Type = 2, PosX = 230, PosY = 129, OffsetX = -106, OffsetY = -30,  Width = 148, Height = 148, FlipX = false},-- ����ѡ��һ������							 													 		
	{Type = 2, PosX = 520, PosY = 40,  OffsetX = 125,  OffsetY = -12,  Width = 120, Height = 40,  FlipX = true },-- ����ѡ���������
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_074}"},	 -- NPC�����޷��ƶ����� ��NPC��ʾ�����ؼ�ͷ��		
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -76,  OffsetY = -26,  Width = 55,  Height = 55,  FlipX = false},-- ����ѡ��λ��
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -70,  OffsetY = -45,  Width = 65,  Height = 140, FlipX = false},-- ��Դ���������	
-- ����ʿ��ѵ��Ӫ
	{Type = 2, PosX = 80,  PosY = 330, OffsetX = -70,  OffsetY = -10,  Width = 60,  Height = 60,  FlipX = false},-- ����ͼ�꡾��ʾ��ͷ��
	{Type = 2, PosX = 667, PosY = 401, OffsetX = -70,  OffsetY = -20,  Width = 42,  Height = 42,  FlipX = false},-- ���������б� �رս��水��
	{Type = 2, PosX = 615, PosY = 86,  OffsetX = 125,  OffsetY = -15,  Width = 68,  Height = 60,  FlipX = true },-- ���˵���������	
	{Type = 2, PosX = 475, PosY = 275, OffsetX = -106, OffsetY = 19,   Width = 148, Height = 148, FlipX = false},-- ����ѡ��һ������							
	{Type = 2, PosX = 520, PosY = 40,  OffsetX = 125,  OffsetY = -12,  Width = 120, Height = 40,  FlipX = true },-- ����ѡ���������
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_074}"},	 -- NPC�����޷��ƶ����� ��NPC��ʾ�����ؼ�ͷ��			
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -76,  OffsetY = -26,  Width = 55,  Height = 55,  FlipX = false},-- ����ѡ��λ��
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -70,  OffsetY = -45,  Width = 65,  Height = 140, FlipX = false},-- ʿ��ѵ��Ӫ����
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -70,  OffsetY = -45,  Width = 65,  Height = 140, FlipX = false},-- ʿ��ѵ��Ӫ�ȴ�״̬
	{Type = 2, PosX = 580, PosY = 70,  OffsetX = -100, OffsetY = -25,  Width = 116, Height = 42,  FlipX = false},-- ʿ��ѵ��Ӫ�ȴ�����	
	{Type = 2, PosX = 580, PosY = 70,  OffsetX = -100, OffsetY = -25,  Width = 116, Height = 42,  FlipX = false},-- ʿ��ѵ��Ӫ�ռ�
	{Type = 2, PosX = 627, PosY = 421, OffsetX = 91,   OffsetY = -20,  Width = 38,  Height = 38,  FlipX = true },-- ʿ��ѵ��Ӫ�ر�	
-- ������ʽ���(һ)
	{Type = 2, PosX = 80,  PosY = 330, OffsetX = -70,  OffsetY = -10,  Width = 60,  Height = 60,  FlipX = false}, -- ����ͼ�꡾��ʾ��ͷ��
	{Type = 2, PosX = 667, PosY = 401, OffsetX = -70,  OffsetY = -20,  Width = 42,  Height = 42,  FlipX = false}, -- ���������б� �رս��水��
	{Type = 2, PosX = 615, PosY = 86,  OffsetX = 125,  OffsetY = -15,  Width = 68,  Height = 60,  FlipX = true }, -- ���˵���������	
	{Type = 2, PosX = 230, PosY = 275, OffsetX = -106, OffsetY = 19,   Width = 148, Height = 148, FlipX = false}, -- ����ѡ��һ������										 													 		
	{Type = 2, PosX = 373, PosY = 269, OffsetX = -115, OffsetY = 0,    Width = 146, Height = 172, FlipX = false}, -- ����ѡ���������ѡ�
	{Type = 2, PosX = 520, PosY = 40,  OffsetX = 125,  OffsetY = -12,  Width = 120, Height = 40,  FlipX = true }, -- ����ѡ��������潨�찴��	
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_074}"},	 -- NPC�����޷��ƶ����� ��NPC��ʾ�����ؼ�ͷ��				
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -76,  OffsetY = -26,  Width = 55,  Height = 55,  FlipX = false}, -- ����ѡ��λ��
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -70,  OffsetY = -45,  Width = 65,  Height = 140, FlipX = false}, -- ��ʽ��Ӽ���		
-- ������ʽ���(��)
	{Type = 2, PosX = 615, PosY = 86,  OffsetX = 125,  OffsetY = -15,  Width = 68,  Height = 60,  FlipX = true }, -- ���˵���������	
	{Type = 2, PosX = 230, PosY = 275, OffsetX = -106, OffsetY = 19,   Width = 148, Height = 148, FlipX = false}, -- ����ѡ��һ������										 													 		
	{Type = 2, PosX = 373, PosY = 269, OffsetX = -115, OffsetY = 0,    Width = 146, Height = 172, FlipX = false}, -- ����ѡ���������ѡ�
	{Type = 2, PosX = 520, PosY = 40,  OffsetX = 125,  OffsetY = -12,  Width = 120, Height = 40,  FlipX = true }, -- ����ѡ��������潨�찴��	
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_074}"},	 -- NPC�����޷��ƶ����� ��NPC��ʾ�����ؼ�ͷ��					
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -76,  OffsetY = -26,  Width = 55,  Height = 55,  FlipX = false}, -- ����ѡ��λ��
	{Type = 2, PosX = 0,   PosY = 0,   OffsetX = -70,  OffsetY = -45,  Width = 65,  Height = 140, FlipX = false}, -- ��ʽ��Ӽ���		
-- PVE �ؿ�
	{Type = 2, PosX = 380, PosY = 25,  OffsetX = 105,  OffsetY = -25,  Width = 68,  Height = 60, FlipX = true},  -- ���˵��ؿ�����
	{Type = 2, PosX = 185, PosY = 335,  OffsetX = -95,  OffsetY = -25,  Width = 118, Height = 166,FlipX = false}, -- �ؿ�һ������	ѡ�
	{Type = 2, PosX = 438, PosY = 81,   OffsetX = 139,  OffsetY = -25,  Width = 116, Height = 44, FlipX = true},  -- �ؿ���������	��������	 			
-- PVE ս��
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_058}"},	 -- NPC���� ��NPC��ʾ�����ؼ�ͷ��
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_059}"},	 -- NPC���� ��NPC��ʾ�����ؼ�ͷ��
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_060}"},	 -- NPC���� ��NPC��ʾ�����ؼ�ͷ��
	{Type = 2, PosX = 105, PosY = 33,  OffsetX = -71,  OffsetY = -25,  Width = 74,  Height = 70,  FlipX = false},							     -- ս����Ԫ�б� ѡ�����	 				
	{Type = 2, PosX = 101, PosY = 295, OffsetX = -81,  OffsetY = -25,  Width = 100,  Height = 38,  FlipX = false},							 -- ս���˵� ��ս����	 				
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_061}"},	 -- NPC����
	{Type = 1, PosX = 0,   PosY = 0,   OffsetX = 0,    OffsetY = 0,    Width = 0,   Height = 0,	FlipX = true, Intro = "#{TXSS_2000_062}"},	 -- NPC����
}

-- �����������������
local g_nMaxStep = 66

-- ��ǰ��������
local g_nCurStep = 1

-- NPCָ������
local TYPE_NPC = 1

-- ��ͷָ������
local TYPE_ARROW = 2

-- ����״̬
local g_Produce_State = {STATE_WORK_WAIT=3, STATE_COLSE=5, STATE_PRODUCE_TING=6, STATE_HARVEST=7}

-- ��������
local POINT =
{
	POS_X = 0,
	POS_Y = 0
}

local EVENT = 
{
	LEVELUP_LOAD = 1,
	TASK_COMPLETE_LOAD = 2,
	GUIDE_UI_UPDATE = 3,
}

-- �ȴ���������
local bWaitLoadData = false 

function	Guide_PreLoad()
	this:RegisterEvent("GUIDE_LOAD")			  		-- ������������
	this:RegisterEvent("GUIDE_UI_UPDATE")		  		-- UI������������
	this:RegisterEvent("GUIDE_ENTITY_UPDATE")			-- ʵ�������������	
	this:RegisterEvent("GUIDE_HIDE")					-- ������������	
	
	this:RegisterEvent("TASK_LIST_LOAD")				-- ����ͼ���б�����
	this:RegisterEvent("TASK_LIST_UPDATE")				-- ����ͼ���б����
	this:RegisterEvent("TASK_DESCRIBLE_LOAD")			-- ���������б�
	this:RegisterEvent("BUILD_CHOOSE_LOAD")				-- ����ѡ��������
	this:RegisterEvent("BUILD_CHOOSE_TOBUILD")			-- ����ѡ���ӽ���
	this:RegisterEvent("MOVE_MENU_LOAD")				-- �ƶ��˵� 
	this:RegisterEvent("MOVE_MENU_UPDATE")				-- �ƶ��˵����� 
	this:RegisterEvent("MOVE_MENU_UNLOAD")				-- �ƶ��˵����� 
	this:RegisterEvent("TASK_COMPLETE_LOAD")			-- ������ɽ��� 
	this:RegisterEvent("NPC_Dialog_LOAD")				-- NPC�Ի� 
	this:RegisterEvent("PRODUCE_LOAD")					-- ��ʼ���������� 
	this:RegisterEvent("PRODUCE_UPDATE")				-- ������������
	this:RegisterEvent("TRAIN_SOLIDER_LOAD")			-- ��ʼ��ʿ��ѵ��Ӫ���� 
	this:RegisterEvent("TRAIN_SOLIDER_UPDATE")			-- ����ʿ��ѵ��Ӫ����	
	this:RegisterEvent("MISSION_MONSTER_LOAD")			-- ���¹ؿ�����
	this:RegisterEvent("COMBATPROCESS_LOAD")			-- ս������
	this:RegisterEvent("LOADINGWIDGET_UNLOAD")			-- �����������
end

function	Guide_OnLoad()
	g_Guide_Main[1] = Guide_ImageBox_arrow				-- ��ͷ 	
	g_Guide_Main[2] = Guide_ImageBox_GreyBG				-- ��͸���ɰ�
	g_Guide_Main[3] = Guide_NpcPanel					-- NPC
	g_Guide_Main[4] = Guide_Button_NextStep				-- ��һ������
	g_Guide_Main[5] = Guide_DetailPanel					-- �������
	g_Guide_Main[6] = Guide_TextDetail					-- �������˵��
end

function	Guide_OnEvent(event)	
	if (event ~= "LOADINGWIDGET_UNLOAD") then -- LOADINGWIDGET_UNLOAD ����¼��ڵ�¼ʱ�������Ϣ��û�л��
		local bNewPlayer = Player:GetIsNewPlayer()
		if tonumber(bNewPlayer) == 0 then
			this:Hide()	
			return 
		end
	end
	if g_nCurStep > g_nMaxStep then
		return	
	end
	if ( event == "GUIDE_LOAD" ) then			
		--��ʼ������
		Guide_Init()
	elseif (event == "GUIDE_HIDE") then
		this:Hide()
	elseif (event == "GUIDE_ENTITY_UPDATE") then
		if (arg0 ~= nil) then
			local PosX, PosY = BuildData:GetBuildInfoFromID("BuildInfoFromID_ScreenPos", tonumber(arg0)) 
			local IndexID = BuildData:GetBuildInfoFromID("BuildInfoFromID_IndexID", tonumber(arg0))
 
			if g_nCurStep == 8 						 					   -- ������Ӽ���
			or ((g_nCurStep == 16 or g_nCurStep == 17) and IndexID == 3)  -- ���ũԷ����	  --���ũԷ�ȴ�
			or (g_nCurStep == 28 and IndexID == 10) 					   -- ��Դ���������
			or ((g_nCurStep == 36 or g_nCurStep == 37) and IndexID == 8)  -- ʿ��ѵ��Ӫ���� --ʿ��ѵ��Ӫ�ȴ�
			or (g_nCurStep == 49 or g_nCurStep == 56) 					   -- ��ʽ��Ӽ���
			then	
				this:Show()	
				local Type, _, _, OffsetX, OffsetY, Width, Height, bFlipX = Guide_GetCurStepData()	
				POINT.POS_X = PosX
				POINT.POS_Y = PosY + 110						
				Guide_ShowGuide(Type, PosX + 40, PosY + 110, OffsetX, OffsetY, Width, Height, bFlipX)	
			end	
		end	
	elseif (event == "GUIDE_UI_UPDATE") then
		if arg0 == nil then
			return		
		end	
		arg0 = tonumber(arg0)
		if (g_nCurStep == 3  and arg0 == EVENT.GUIDE_UI_UPDATE)
		or (g_nCurStep == 6  and arg0 == EVENT.GUIDE_UI_UPDATE)
		or (g_nCurStep == 9  and arg0 == EVENT.LEVELUP_LOAD) 
		or (g_nCurStep == 11 and arg0 == EVENT.GUIDE_UI_UPDATE)
		or (g_nCurStep == 14  and arg0 == EVENT.GUIDE_UI_UPDATE)		
		or (g_nCurStep == 20 and arg0 == EVENT.LEVELUP_LOAD)
		or (g_nCurStep == 21 and arg0 == EVENT.GUIDE_UI_UPDATE)
		or (g_nCurStep == 23 and arg0 == EVENT.GUIDE_UI_UPDATE)
		or (g_nCurStep == 26  and arg0 == EVENT.GUIDE_UI_UPDATE)
		or (g_nCurStep == 29 and arg0 == EVENT.LEVELUP_LOAD)	
		or (g_nCurStep == 31 and arg0 == EVENT.GUIDE_UI_UPDATE)
		or (g_nCurStep == 34 and arg0 == EVENT.GUIDE_UI_UPDATE)						
		or (g_nCurStep == 40 and arg0 == EVENT.LEVELUP_LOAD)
		or (g_nCurStep == 43 and arg0 == EVENT.GUIDE_UI_UPDATE)	
		or (g_nCurStep == 47 and arg0 == EVENT.GUIDE_UI_UPDATE)				
		or (g_nCurStep == 50 and arg0 == EVENT.GUIDE_UI_UPDATE)
		or (g_nCurStep == 54 and arg0 == EVENT.GUIDE_UI_UPDATE)		
		or (g_nCurStep == 57 and arg0 == EVENT.TASK_COMPLETE_LOAD)		
		or (g_nCurStep == 59 and arg0 == EVENT.GUIDE_UI_UPDATE)	
		or (g_nCurStep == 64 and arg0 == EVENT.GUIDE_UI_UPDATE)			
		then
			this:Show()	
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX = Guide_GetCurStepData()	
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX)	
		end
	elseif (event == "PRODUCE_LOAD" or event == "PRODUCE_UPDATE") then 
		if g_nCurStep == 18 or g_nCurStep == 19 then	
			this:Show()					
			local pState = BuildData:GetMainTargetBuildState("MainTargetBuild_State_ID")
			if g_Produce_State.STATE_PRODUCE_TING == pState then
				Guide_HideGuide()		
				return	
			end	
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX  = Guide_GetCurStepData()
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX )	
		end		
	elseif (event == "TRAIN_SOLIDER_LOAD" or event == "TRAIN_SOLIDER_UPDATE") then
		if g_nCurStep == 38 or 	g_nCurStep == 39 then
			this:Show()			
			local pState = BuildData:GetMainTargetBuildState("MainTargetBuild_State_ID")
			if g_Produce_State.STATE_PRODUCE_TING == pState then
				Guide_HideGuide()		
				return	
			end	
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX  = Guide_GetCurStepData()
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX )				
		end	
	elseif (event == "TASK_COMPLETE_LOAD") then 
		if g_nCurStep == 9 or g_nCurStep == 20 or g_nCurStep == 29 or g_nCurStep == 40 then	
			this:Hide()				
		end
	elseif (event == "MOVE_MENU_LOAD" or event == "MOVE_MENU_UPDATE") then
		if arg0 ~= nil and arg1 ~= nil then			
			arg0 = tonumber(arg0)
			arg1 = tonumber(arg1)			
			if g_nCurStep == 7 or g_nCurStep == 15 or g_nCurStep == 27 or g_nCurStep == 35 or g_nCurStep == 48 or g_nCurStep == 55 then
				this:Show()	
				local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX = Guide_GetCurStepData()			
				Guide_ShowGuide(Type, arg0 + 100, arg1 - 40, OffsetX, OffsetY, Width, Height, bFlipX)	
			end
		end 
	elseif (event == "MOVE_MENU_UNLOAD" ) then
		if g_nCurStep == 8 or g_nCurStep == 16 or g_nCurStep == 28 or g_nCurStep == 36 or g_nCurStep == 49 or g_nCurStep == 56 then --����ʼ���콨��ʱ
			Guide_HideGuide()			
		end
	elseif (event == "BUILD_CHOOSE_LOAD") then		
		if g_nCurStep == 4 or g_nCurStep == 12 or g_nCurStep == 24 or g_nCurStep == 32 or g_nCurStep == 44 or g_nCurStep == 51 then
			this:Show()					
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX  = Guide_GetCurStepData()
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX )
		end
	elseif event == "BUILD_CHOOSE_TOBUILD" then
		if g_nCurStep == 5 or g_nCurStep == 13 or g_nCurStep == 25 or g_nCurStep == 33 or g_nCurStep == 45 or g_nCurStep == 46 or g_nCurStep == 52 or g_nCurStep == 53 then					
			this:Show()			
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX = Guide_GetCurStepData()
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX)
		end	
	elseif (event == "TASK_LIST_LOAD") then
		if g_nCurStep == 1 or g_nCurStep == 9 or g_nCurStep == 10 or g_nCurStep == 21 or g_nCurStep == 22 or g_nCurStep == 29 or g_nCurStep == 30 or g_nCurStep == 41 then
			this:Show()				
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX = Guide_GetCurStepData()	
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX)
		end
	elseif (event == "TASK_LIST_UPDATE") then
		if g_nCurStep == 1 or g_nCurStep == 2 or g_nCurStep == 10 or g_nCurStep == 22 or g_nCurStep == 30 or g_nCurStep == 41 then
			this:Show()				
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX = Guide_GetCurStepData()	
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX)
		end	
	elseif (event == "TASK_DESCRIBLE_LOAD") then
		if g_nCurStep == 2 or g_nCurStep == 11 or g_nCurStep == 23 or g_nCurStep == 30 or g_nCurStep == 42 then
			this:Show()				
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX  = Guide_GetCurStepData()
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX)		
		end
	elseif (event == "NPC_Dialog_LOAD") then
		this:Hide()
				
	elseif (event == "MISSION_MONSTER_LOAD") then
		if g_nCurStep == 58 then
			this:Show()				
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX  = Guide_GetCurStepData()
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX)						
		end
	elseif (event == "COMBATPROCESS_LOAD") then
		if g_nCurStep == 60 then
			this:Show()				
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX  = Guide_GetCurStepData()
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX)	
			PushEvent("COMBATPROCESS_RETREAT_HIDE")		
			PushEvent("COMBATPROCESS_UNITLIST_VISIBLE", 0)			
		end 
	elseif (event == "LOADINGWIDGET_UNLOAD") then
		if g_nCurStep == 65 then
			this:Show()		
			local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX  = Guide_GetCurStepData()
			Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, bFlipX)	
		end
	end
end

--===================================
--			��ʼ������
--===================================
function    Guide_Init()
	g_nCurStep = 1
end

--===================================
--			��õ�ǰ��������
--===================================
function   Guide_GetCurStepData()
	return g_GuideTable[g_nCurStep]["Type"], g_GuideTable[g_nCurStep]["PosX"], g_GuideTable[g_nCurStep]["PosY"]
	, g_GuideTable[g_nCurStep]["OffsetX"], g_GuideTable[g_nCurStep]["OffsetY"], g_GuideTable[g_nCurStep]["Width"]
	, g_GuideTable[g_nCurStep]["Height"], g_GuideTable[g_nCurStep]["FlipX"]
end

--===================================
--		��ʾȫ����͸����ɫ�ɰ�
--===================================
function   Guide_ShowGreyMask()
	g_Guide_Main[2]:Show()
	g_Guide_Main[2]:SetScale(40)
	g_Guide_Main[2]:SetOpacity(100)	
end

--===================================
--		����ȫ����͸����ɫ�ɰ�
--===================================
function   Guide_HideMask()
	g_Guide_Main[2]:Hide()
end

--===================================
--			��ʾ��������
--===================================
function Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, FlipX)
	if Type == TYPE_NPC then			
		Guide_ShowGreyMask()	
		Guide_ShowNpc()
		Guide_HideArrow()
		Guide_HideNextStep()
		
		bWaitLoadData = false
	elseif Type == TYPE_ARROW then
		Guide_HideMask()	
		Guide_ShowArrow(PosX, PosY, FlipX)
		Guide_ShowNextStep(PosX + OffsetX, PosY + OffsetY, Width, Height)
		Guide_HideNpc()
		
		bWaitLoadData = false
	end
end

--===================================
--				������������
--===================================
function Guide_HideGuide()
	Guide_HideArrow()
	Guide_HideNextStep()
	Guide_HideMask()	
	Guide_HideNpc()
end

--===================================
--				��ʾNPCָ��
--===================================
function Guide_ShowNpc()
	g_Guide_Main[3]:Show()
	g_Guide_Main[5]:Show()
	g_Guide_Main[6]:SetText(tostring(g_GuideTable[g_nCurStep].Intro))
end

--===================================
--				����NPCָ��
--===================================
function Guide_HideNpc()
	g_Guide_Main[3]:Hide()
	g_Guide_Main[5]:Hide()
end

--===================================
--			��ʾ��һ������
--===================================
function Guide_ShowNextStep(PosX, PosY, Width, Height)
	g_Guide_Main[4]:Show()
	g_Guide_Main[4]:SetPosition(PosX, PosY)
	g_Guide_Main[4]:SetButton9PatchContentSize(Width, Height)	
end

--===================================
--			������һ������
--===================================
function Guide_HideNextStep()
	g_Guide_Main[4]:Hide()
end

--===================================
--			��ʾ��ͷָ��
--===================================
function Guide_ShowArrow(PosX, PosY, FlipX)		
	g_Guide_Main[1]:Show()	
	g_Guide_Main[1]:SetPosition(PosX, PosY)
	g_Guide_Main[1]:SetFlipX(FlipX)
	g_Guide_Main[1]:StartMoveAction(-10, 0, 0.3, true)
end

--===================================
--			���ؼ�ͷָ��
--===================================
function Guide_HideArrow()
	g_Guide_Main[1]:Hide()
	g_Guide_Main[1]:StopAnimation()
end

--===================================
--			���ò������� 
--	��ĳһ����ر� ��Ҫ���ص�ָ������
--===================================
function Guide_ResetStep(backStep)
	g_nCurStep = backStep	
end

--===================================
--			�����һ��
--===================================
function Guide_AddNextStep()
	g_nCurStep = g_nCurStep + 1		
end

--===================================
--			�����ͷָ����
--===================================
function Guide_ClickOK()
	if(bWaitLoadData) then
		return 
	end
	bWaitLoadData = true
	
	if g_nCurStep == 1 then 		-- ������콺����ӵ�����ͼ��
		ClearScript()
		SetFunction("OnDefaultEvent")
		SetScriptID(2)
		SendScript()
	elseif g_nCurStep == 2 then	 	-- ���������б� �رս��水��
		PushEvent("TASK_DESCRIBLE_HIDE")
	elseif g_nCurStep == 3 then  	-- ���˵���������
		PushEvent("BUILD_CHOOSE_LOAD")
	elseif g_nCurStep == 4 then		-- ��������ѡ�����
		PushEvent("BUILD_CHOOSE_TOBUILD", 0, 0)		
	elseif g_nCurStep == 5 then	 	-- ������찴����������ӡ� 
		CloseAllWidget()		
	elseif g_nCurStep == 7 then	 	-- ����ƶ��˵�ȷ����
		PushEvent("MOVE_MENU_UNLOAD")
		Move_OK()	
	elseif g_nCurStep == 8 then	 	-- ������Ӽ���
		TouchesEnd(POINT.POS_X, POINT.POS_Y)
	elseif g_nCurStep == 9 then	 	-- ���������ũԷ������ͼ��
		ClearScript()
		SetFunction("OnDefaultEvent")
		SetScriptID(3)
		SendScript()	
	elseif g_nCurStep == 10 then	 	-- ���������б� �رս��水��
		PushEvent("TASK_DESCRIBLE_HIDE")		
	elseif g_nCurStep == 11 then 	-- ���˵���������
		PushEvent("BUILD_CHOOSE_LOAD")	
	elseif g_nCurStep == 12 then	-- ��������ѡ�����
		PushEvent("BUILD_CHOOSE_TOBUILD", 2, 3)	
	elseif g_nCurStep == 13 then	-- ������찴�������ũԷ�� 
		CloseAllWidget()		
	elseif g_nCurStep == 15 then	-- ����ƶ��˵�ȷ����
		PushEvent("MOVE_MENU_UNLOAD")
		Move_OK()	
	elseif g_nCurStep == 16 then	-- ���ũԷ����
		Guide_HideNextStep()		
		TouchesEnd(POINT.POS_X, POINT.POS_Y)	
	elseif g_nCurStep == 17 then	-- �򿪹��ũԷ��Ϣ���
		TouchesEnd(POINT.POS_X, POINT.POS_Y)
	elseif g_nCurStep == 18 then	-- ����������������ܲ���
		BuildData:ProduceIndex(5)
		Guide_HideGuide()
	elseif g_nCurStep == 19 then	-- ����ռ����������ܲ���
		BuildData:RecviedBuildProduct()	
	elseif g_nCurStep == 20 then	-- �ر��������� 
		CloseAllWidget()
		PushEvent("MAIN_MENU_LOAD")
		PushEvent("RESOURCE_BAR_LOAD")
		PushEvent("PORTRAIT_LEFT_LOAD")
		PushEvent("TASK_LIST_LOAD")
		PushEvent("MAIN_CHAT_LOAD")	
		PushEvent("GUIDE_UI_UPDATE", 3)			
	elseif g_nCurStep == 21 then	-- ���������Դ�����������ͼ��
		ClearScript()
		SetFunction("OnDefaultEvent")
		SetScriptID(4)
		SendScript()
	elseif g_nCurStep == 22 then 	-- ���������б� �رս��水��
		PushEvent("TASK_DESCRIBLE_HIDE")
	elseif g_nCurStep == 23 then  	-- ���˵���������	
		PushEvent("BUILD_CHOOSE_LOAD")		
	elseif g_nCurStep == 24 then	-- ��������ѡ�����
		PushEvent("BUILD_CHOOSE_TOBUILD", 3, 10)	
	elseif g_nCurStep == 25 then	-- ������찴������Դ�����⡿ 
		CloseAllWidget()		
	elseif g_nCurStep == 27 then	-- ����ƶ��˵�ȷ����
		PushEvent("MOVE_MENU_UNLOAD")
		Move_OK()	
	elseif g_nCurStep == 28 then	-- ��Դ���������
		TouchesEnd(POINT.POS_X, POINT.POS_Y)	
	elseif g_nCurStep == 29 then    -- �������ʿ��ѵ��Ӫ������ͼ��
		ClearScript()
		SetFunction("OnDefaultEvent")
		SetScriptID(5)
		SendScript()	 
	elseif g_nCurStep == 30 then	 -- ���������б� ��ת������ѡ�����İ���
		PushEvent("TASK_DESCRIBLE_HIDE")
	elseif g_nCurStep == 31 then  	 -- ���˵���������	
		PushEvent("BUILD_CHOOSE_LOAD")
	elseif g_nCurStep == 32 then     -- ��������ѡ�����
		PushEvent("BUILD_CHOOSE_TOBUILD", 1, 8)		
	elseif g_nCurStep == 33 then	 -- ������찴����ʿ��ѵ��Ӫ�� 
		CloseAllWidget()		
	elseif g_nCurStep == 35 then	 -- ����ƶ��˵�ȷ����
		PushEvent("MOVE_MENU_UNLOAD")
		Move_OK()	
	elseif g_nCurStep == 36 then	 -- ʿ��ѵ��Ӫ����
		Guide_HideNextStep()	
		TouchesEnd(POINT.POS_X, POINT.POS_Y)	
	elseif g_nCurStep == 37 then	 -- ��ʿ��ѵ��Ӫ��Ϣ���
		TouchesEnd(POINT.POS_X, POINT.POS_Y)
	elseif g_nCurStep == 38 then	 -- ���ѵ��������������
		BuildData:TrainSoliderSubmit(0)
		Guide_HideGuide()
	elseif g_nCurStep == 39 then	 -- ����ռ�������������
		BuildData:RecviedBuildProduct()	
	elseif g_nCurStep == 40 then	 -- �ر�ѵ������ 
		-- ж����Ŀ�� ��ʿ��ѵ��Ӫ��
		BuildData:UnMainTarget() 		
		CloseAllWidget()
		PushEvent("MAIN_MENU_LOAD")
		PushEvent("RESOURCE_BAR_LOAD")
		PushEvent("PORTRAIT_LEFT_LOAD")
		PushEvent("TASK_LIST_LOAD")
		PushEvent("MAIN_CHAT_LOAD")			
		PushEvent("GUIDE_UI_UPDATE", 3)		
	elseif g_nCurStep == 41 then	 -- ���������ʽ��ӵ�����ͼ��
		ClearScript()
		SetFunction("OnDefaultEvent")
		SetScriptID(6)
		SendScript()	
	elseif g_nCurStep == 42 then	 -- ���������б� �رս��水��
		PushEvent("TASK_DESCRIBLE_HIDE")
	elseif g_nCurStep == 43 then  	-- ���˵���������
		PushEvent("BUILD_CHOOSE_LOAD")
	elseif g_nCurStep == 44 then	-- ��������ѡ�����
		PushEvent("BUILD_CHOOSE_TOBUILD", 0, 0)		
	elseif g_nCurStep == 45 then	-- ��������ѡ�����
		PushEvent("BUILD_CHOOSE_TOBUILD", 0, 1)			
	elseif g_nCurStep == 46 then	 -- ������찴������ʽ���(һ)�� 
		CloseAllWidget()		
	elseif g_nCurStep == 48 then	 -- ����ƶ��˵�ȷ����
		PushEvent("MOVE_MENU_UNLOAD")
		Move_OK()	
	elseif g_nCurStep == 49 then	 -- ��ʽ���(һ)����
		TouchesEnd(POINT.POS_X, POINT.POS_Y)		
	elseif g_nCurStep == 50 then  	 -- ���˵���������
		PushEvent("BUILD_CHOOSE_LOAD")
	elseif g_nCurStep == 51 then	 -- ��������ѡ�����
		PushEvent("BUILD_CHOOSE_TOBUILD", 0, 0)		
	elseif g_nCurStep == 52 then	 -- ��������ѡ�����
		PushEvent("BUILD_CHOOSE_TOBUILD", 0, 1)			
	elseif g_nCurStep == 53 then	 -- ������찴������ʽ���(��)�� 
		CloseAllWidget()		
	elseif g_nCurStep == 55 then	 -- ����ƶ��˵�ȷ����
		PushEvent("MOVE_MENU_UNLOAD")
		Move_OK()	
	elseif g_nCurStep == 56 then	 -- ��ʽ���(��)����
		TouchesEnd(POINT.POS_X, POINT.POS_Y)	
	elseif g_nCurStep == 57 then	 -- ���˵��ؿ�����
		OpenRequestWaitProgress()		
		CloseAllWidget()
		--���ʹ򿪸���������Ϣ
		ClearScript()
		SetFunction("OnDefaultEvent")
		SetScriptID(100501)
		SendScript()	
		AskSoliderList()					
	elseif g_nCurStep == 58 then	 -- �ؿ�һ������	ѡ�
		Instance_TaskClick(1)	
	elseif g_nCurStep == 59 then	 -- �ؿ���������	��������
		local scriptId = DataPool:GetBossEventItem(0, "desc")
		-- �ر����н���
		CloseAllWidget()	
		-- ��ʾ������
		PushEvent("LOADINGWIDGET_LOAD")
		ClearScript()
		SetFunction("OnDefaultEvent")
		SetScriptID(scriptId)
		SetParameter(0, 1)
		SetParamCount(1)
		SendScript()		
	elseif g_nCurStep == 63 then		-- ս����Ԫ�б� ѡ�����		
		CombatProcess_ArrmyOnClick(0)
	elseif g_nCurStep == 64 then		-- ս���˵� ��ս����
		CombatProcess_StartBattle()
		
		this:Hide()
	end
	
	Guide_AddNextStep()			 	 -- ��ǰ����ı��λ����
	
	
	if (g_nCurStep == 6) then			 -- NPC�����޷��ƶ����� ��NPC��ʾ�����ؼ�ͷ��
		PushEvent("GUIDE_UI_UPDATE", 3)	
	elseif (g_nCurStep == 14) then		 -- NPC�����޷��ƶ����� ��NPC��ʾ�����ؼ�ͷ��
		PushEvent("GUIDE_UI_UPDATE", 3)		
	elseif (g_nCurStep == 26) then		 -- NPC�����޷��ƶ����� ��NPC��ʾ�����ؼ�ͷ��
		PushEvent("GUIDE_UI_UPDATE", 3)					
	elseif (g_nCurStep == 34) then		 -- NPC�����޷��ƶ����� ��NPC��ʾ�����ؼ�ͷ��
		PushEvent("GUIDE_UI_UPDATE", 3)		
	elseif (g_nCurStep == 47) then		 -- NPC�����޷��ƶ����� ��NPC��ʾ�����ؼ�ͷ��
		PushEvent("GUIDE_UI_UPDATE", 3)			
	elseif (g_nCurStep == 50)  then		 -- ����ʽ���(һ)��������ת ���˵���������
		PushEvent("GUIDE_UI_UPDATE", 3)	
	elseif (g_nCurStep == 54)  then		 -- ����ʽ���(һ)��������ת ���˵���������
		PushEvent("GUIDE_UI_UPDATE", 3)			
	elseif (g_nCurStep == 59) then  	 -- �ؿ���������	��������
		PushEvent("GUIDE_UI_UPDATE", 3)			
	elseif (g_nCurStep == 64) then	 	 -- ս����Ԫ�б� ѡ�����	
		PushEvent("GUIDE_UI_UPDATE", 3)
	end
	
end

--===================================
-- 				�ر�NPC����
--===================================
function Guide_OnClickNPC()
	Guide_AddNextStep()			
	-- ��֤�Ƿ������һ��
	if g_nCurStep <= g_nMaxStep then	
		local Type, PosX, PosY, OffsetX, OffsetY, Width, Height, FlipX = Guide_GetCurStepData()
		Guide_ShowGuide(Type, PosX, PosY, OffsetX, OffsetY, Width, Height, FlipX)		
		if (g_nCurStep == 7) then
			BuildData:CreateNewBuild(0)
		elseif (g_nCurStep == 15) then
			BuildData:CreateNewBuild(3)		
		elseif (g_nCurStep == 27) then			
			BuildData:CreateNewBuild(10)
		elseif (g_nCurStep == 35) then					
			BuildData:CreateNewBuild(8)	
		elseif (g_nCurStep == 48) then	
			BuildData:CreateNewBuild(1)	
		elseif (g_nCurStep == 55) then				
			BuildData:CreateNewBuild(1)							
		elseif (g_nCurStep == 62) then
			PushEvent("COMBATPROCESS_UNITLIST_VISIBLE", 1)		
		end	
	else	
		-- �ر�������������	
		this:Hide()
		SendNewPlayerDone()
		PushToast("#{CUPY_5000_195}")
	end
end
