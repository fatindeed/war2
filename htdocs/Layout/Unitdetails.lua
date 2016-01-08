local	g_unitdetails_List = {}
local	g_unitdetails_Skill = {}

local 	g_UnitIndex = -1						-- ��Ԫ����
function	Unitdetails_PreLoad()
	this:RegisterEvent("UNITDETAILS_LOAD")    	-- ��ʾ���µ�Ԫ
	this:RegisterEvent("UNITDETAILS_UPDATE")	-- ���µ�Ԫ����
end

function	Unitdetails_OnLoad()	
	g_unitdetails_List[1]	=	Unitdetails_OneScrollView		--������
	g_unitdetails_List[2]	=	Unitdetails_TwoScrollView		--����ͼ��
	g_unitdetails_List[7]	=	Unitdetails_Title_Text			--����
	g_unitdetails_List[8]	=	Unitdetails_ArrmyIcon_Image		--ͷ��ͼ��
	g_unitdetails_List[9]	=	Unitdetails_SkillDesc_Name
	g_unitdetails_List[10]	=	Unitdetails_SkillDesc_Type
	g_unitdetails_List[11]	=	Unitdetails_SkillDesc_Content
	g_unitdetails_List[12] = Unitdetails_JNDesc_Text
end

function	Unitdetails_OnEvent(event)
	if ( event == "UNITDETAILS_LOAD" ) then
		if arg0 ~= nil then
			this:Show()	--->>>��ʾUI			
			unitdetails_ReadData(arg0)
			g_UnitIndex = arg0
		end
	elseif ( event == "UNITDETAILS_UPDATE") then
		unitdetails_ReadData(g_UnitIndex)
	end
end

-------------------��ȡ����>>>>>>>>>>>>>>>>>>
function	unitdetails_ReadData(tIndex)
	tIndex = tonumber(tIndex)
	
	local	ID,			--ID
			ICONID,		--ͼ��
			NAME,		--����
			LEVEL,		--�ȼ�
			TYPE		--����
			= Solider:GetMilitaryInfo("Military_BaseInfo", tIndex)
			
	local	ATTACK, 			--����
			DEFENSE, 			--����
			HP, 				--����
			HIT, 				--����
			DODGE, 				--����
			CRITICAL, 			--����
			CRITICAL_MUTIPLE, 	--��������
			SKILL_ONE_ID,		--����1
			SKILL_TWO,			--����2
			SKILL_THREE,		--����3
			SKILL_FOUR 			--����4
			= Solider:GetUnitDesc("SoldierAttr_DetailInfo", tIndex)
				
	local	tLevel = Solider:GetMilitaryInfo("Military__Level", tIndex)
	-- ����ʿ������
	g_unitdetails_List[7]:SetText(NAME)												-- ����
--	g_unitdetails_List[8]:SetTexture(ICONID)										-- ��ʾ���µ�Ԫͼ��

    local jsonFile,textureFile = Solider:GetMilitaryInfoBySkeleton("GetMilitaryInfoBySkeleton", tIndex)
	g_unitdetails_List[8]:setSkeletonDataFile(jsonFile)
	g_unitdetails_List[8]:setAtlasFile(textureFile)
	g_unitdetails_List[8]:updataSkeletonState()
    g_unitdetails_List[8]:setAnimation("attack",true)-- ��ʾ����ʿ��



	-- ��ʼ�����еĻ�����
	unitdetails_Init()
	-- ������ߵ�ʿ������
	local xPos,yPos = 10, 145
	
	if (ATTACK ~= nil and DEFENSE ~= nil and HP ~= nil and HIT ~= nil and DODGE ~= nil and CRITICAL ~= nil) then
		unitdetails_CreateLeftText("#{TXSS_1000_057}",ATTACK,xPos,yPos,18)			-- ����
		yPos = yPos - 29
		unitdetails_CreateLeftText("#{DYXX_1000_023}",DEFENSE,xPos,yPos,18)			-- ����
		yPos = yPos - 29
		unitdetails_CreateLeftText("#{DYXX_1000_002}",HP,xPos,yPos,18)				-- ����
		yPos = yPos - 29
		unitdetails_CreateLeftText("#{DYXX_1000_008}",HIT,xPos,yPos,18)				-- ����
		yPos = yPos - 29
		unitdetails_CreateLeftText("#{DYXX_1000_019}",DODGE,xPos,yPos,18)		    -- ����
		yPos = yPos - 29
		unitdetails_CreateLeftText("#{DYXX_1000_009}",CRITICAL.."%",xPos,yPos,18)	-- ����
		yPos = yPos - 29
		
		g_unitdetails_List[1]:SetContentSize(300, 170)
		g_unitdetails_List[1]:Touch(-1)
		
		--- ����ͼ��
		local x,y = 37, 30		
		-- ���ܶ�����û���ṩ ÿ�εķ���ֵ���� 0 	-->>	log: Ѧ���� by 2013��5��17��
		-- ����ͼ��
		local ICON = Solider:GetSkillInfo("Skill_ICON", SKILL_ONE_ID)		
		unitdetails_CreateTechnicalIcon(1, ICON, ICON, x,y)		
		--unitdetails_CreateTechnicalIcon(1, 336, 336, x + 60,y)
		--unitdetails_CreateTechnicalIcon(1, 336, 336, x + 120,y)
		--unitdetails_CreateTechnicalIcon(1, 336, 336, x + 180,y)
		
		local Name,Desc = Solider:GetSkillInfo("Skill_DetailInfo",tIndex)
		g_unitdetails_List[9]:SetText(Name)

		-- g_unitdetails_List[10]:SetText(Type) -- ��������

		g_unitdetails_List[11]:SetText(Desc)
		
		local _,_,_,_,_,_,_,_,_,strDesc = Solider:GetMilitaryInfo("Military_TrainInfo", tIndex)
		g_unitdetails_List[12]:SetText(strDesc)
	end
end

-------------------��UI�����ֶ�>>>>>>>>>>>>>>>>>>
function	unitdetails_CreateLeftText(tText,tValue,X,Y,Size)
	
	g_unitdetails_List[1]:AddImage9Patch("di_shadow.png", X - 5, Y - 2, 2, 220, 24, true) --�б���
	g_unitdetails_List[1]:AddItemText(tText, X, Y, 0, 0, "0 250 255", Size)	
	g_unitdetails_List[1]:AddItemText(tValue, X + 140, Y, 0, 0, "0 255 0", Size)
end

-------------------����ͼ�괴��>>>>>>>>>>>>>>>>>>
function	unitdetails_CreateTechnicalIcon(tIndex,tImg, tSecImg, X,Y)
	local Function = string.format("%s%d%s","Unitdetails_Skill(",tIndex,")")
	g_unitdetails_List[2]:AddItemSelect(tImg, tSecImg, X, Y, Function)	
end

-------------------��ʼ��������>>>>>>>>>>>>>>
function	unitdetails_Init()
	g_unitdetails_List[1]:CleanAllElement()
	g_unitdetails_List[2]:CleanAllElement()
end

-------------------�رշ���>>>>>>>>>>>>>>>>>>
function	unitdetails_Close()
	this:Hide()
	unitdetails_Init()
end

-------------------����>>>>>>>>>>>>>>>>>>>>>
function	Unitdetails_Skill(arg)
	local	tIndex = tonumber(arg)
end