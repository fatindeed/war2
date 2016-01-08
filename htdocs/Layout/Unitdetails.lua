local	g_unitdetails_List = {}
local	g_unitdetails_Skill = {}

local 	g_UnitIndex = -1						-- 单元索引
function	Unitdetails_PreLoad()
	this:RegisterEvent("UNITDETAILS_LOAD")    	-- 显示军事单元
	this:RegisterEvent("UNITDETAILS_UPDATE")	-- 军事单元更新
end

function	Unitdetails_OnLoad()	
	g_unitdetails_List[1]	=	Unitdetails_OneScrollView		--技能左
	g_unitdetails_List[2]	=	Unitdetails_TwoScrollView		--技能图标
	g_unitdetails_List[7]	=	Unitdetails_Title_Text			--标题
	g_unitdetails_List[8]	=	Unitdetails_ArrmyIcon_Image		--头像图标
	g_unitdetails_List[9]	=	Unitdetails_SkillDesc_Name
	g_unitdetails_List[10]	=	Unitdetails_SkillDesc_Type
	g_unitdetails_List[11]	=	Unitdetails_SkillDesc_Content
	g_unitdetails_List[12] = Unitdetails_JNDesc_Text
end

function	Unitdetails_OnEvent(event)
	if ( event == "UNITDETAILS_LOAD" ) then
		if arg0 ~= nil then
			this:Show()	--->>>显示UI			
			unitdetails_ReadData(arg0)
			g_UnitIndex = arg0
		end
	elseif ( event == "UNITDETAILS_UPDATE") then
		unitdetails_ReadData(g_UnitIndex)
	end
end

-------------------读取数据>>>>>>>>>>>>>>>>>>
function	unitdetails_ReadData(tIndex)
	tIndex = tonumber(tIndex)
	
	local	ID,			--ID
			ICONID,		--图标
			NAME,		--名字
			LEVEL,		--等级
			TYPE		--类型
			= Solider:GetMilitaryInfo("Military_BaseInfo", tIndex)
			
	local	ATTACK, 			--攻击
			DEFENSE, 			--防御
			HP, 				--生命
			HIT, 				--命中
			DODGE, 				--闪避
			CRITICAL, 			--暴击
			CRITICAL_MUTIPLE, 	--暴击倍数
			SKILL_ONE_ID,		--技能1
			SKILL_TWO,			--技能2
			SKILL_THREE,		--技能3
			SKILL_FOUR 			--技能4
			= Solider:GetUnitDesc("SoldierAttr_DetailInfo", tIndex)
				
	local	tLevel = Solider:GetMilitaryInfo("Military__Level", tIndex)
	-- 载入士兵数据
	g_unitdetails_List[7]:SetText(NAME)												-- 标题
--	g_unitdetails_List[8]:SetTexture(ICONID)										-- 显示军事单元图标

    local jsonFile,textureFile = Solider:GetMilitaryInfoBySkeleton("GetMilitaryInfoBySkeleton", tIndex)
	g_unitdetails_List[8]:setSkeletonDataFile(jsonFile)
	g_unitdetails_List[8]:setAtlasFile(textureFile)
	g_unitdetails_List[8]:updataSkeletonState()
    g_unitdetails_List[8]:setAnimation("attack",true)-- 显示动画士兵



	-- 初始化所有的滑动框
	unitdetails_Init()
	-- 创建左边的士兵数据
	local xPos,yPos = 10, 145
	
	if (ATTACK ~= nil and DEFENSE ~= nil and HP ~= nil and HIT ~= nil and DODGE ~= nil and CRITICAL ~= nil) then
		unitdetails_CreateLeftText("#{TXSS_1000_057}",ATTACK,xPos,yPos,18)			-- 攻击
		yPos = yPos - 29
		unitdetails_CreateLeftText("#{DYXX_1000_023}",DEFENSE,xPos,yPos,18)			-- 防御
		yPos = yPos - 29
		unitdetails_CreateLeftText("#{DYXX_1000_002}",HP,xPos,yPos,18)				-- 生命
		yPos = yPos - 29
		unitdetails_CreateLeftText("#{DYXX_1000_008}",HIT,xPos,yPos,18)				-- 命中
		yPos = yPos - 29
		unitdetails_CreateLeftText("#{DYXX_1000_019}",DODGE,xPos,yPos,18)		    -- 闪避
		yPos = yPos - 29
		unitdetails_CreateLeftText("#{DYXX_1000_009}",CRITICAL.."%",xPos,yPos,18)	-- 暴击
		yPos = yPos - 29
		
		g_unitdetails_List[1]:SetContentSize(300, 170)
		g_unitdetails_List[1]:Touch(-1)
		
		--- 技能图标
		local x,y = 37, 30		
		-- 技能读表方法没有提供 每次的返回值都是 0 	-->>	log: 薛云龙 by 2013年5月17日
		-- 技能图标
		local ICON = Solider:GetSkillInfo("Skill_ICON", SKILL_ONE_ID)		
		unitdetails_CreateTechnicalIcon(1, ICON, ICON, x,y)		
		--unitdetails_CreateTechnicalIcon(1, 336, 336, x + 60,y)
		--unitdetails_CreateTechnicalIcon(1, 336, 336, x + 120,y)
		--unitdetails_CreateTechnicalIcon(1, 336, 336, x + 180,y)
		
		local Name,Desc = Solider:GetSkillInfo("Skill_DetailInfo",tIndex)
		g_unitdetails_List[9]:SetText(Name)

		-- g_unitdetails_List[10]:SetText(Type) -- 技能类型

		g_unitdetails_List[11]:SetText(Desc)
		
		local _,_,_,_,_,_,_,_,_,strDesc = Solider:GetMilitaryInfo("Military_TrainInfo", tIndex)
		g_unitdetails_List[12]:SetText(strDesc)
	end
end

-------------------左UI创建字段>>>>>>>>>>>>>>>>>>
function	unitdetails_CreateLeftText(tText,tValue,X,Y,Size)
	
	g_unitdetails_List[1]:AddImage9Patch("di_shadow.png", X - 5, Y - 2, 2, 220, 24, true) --列表背景
	g_unitdetails_List[1]:AddItemText(tText, X, Y, 0, 0, "0 250 255", Size)	
	g_unitdetails_List[1]:AddItemText(tValue, X + 140, Y, 0, 0, "0 255 0", Size)
end

-------------------技能图标创建>>>>>>>>>>>>>>>>>>
function	unitdetails_CreateTechnicalIcon(tIndex,tImg, tSecImg, X,Y)
	local Function = string.format("%s%d%s","Unitdetails_Skill(",tIndex,")")
	g_unitdetails_List[2]:AddItemSelect(tImg, tSecImg, X, Y, Function)	
end

-------------------初始化滑动框>>>>>>>>>>>>>>
function	unitdetails_Init()
	g_unitdetails_List[1]:CleanAllElement()
	g_unitdetails_List[2]:CleanAllElement()
end

-------------------关闭方法>>>>>>>>>>>>>>>>>>
function	unitdetails_Close()
	this:Hide()
	unitdetails_Init()
end

-------------------技能>>>>>>>>>>>>>>>>>>>>>
function	Unitdetails_Skill(arg)
	local	tIndex = tonumber(arg)
end