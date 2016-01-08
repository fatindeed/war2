local g_Resource_Main = {}
local g_PortraitLeft_Main = {}	
local g_Resource_Add_Speed = 0
local g_ExpPos = 0 			-- 当前经验位置
local g_NotifyMsg = 0

local g_PortraitImageName = {"uidenglu_touxiang1.png", "uidenglu_touxiang2.png", "uidenglu_touxiang3.png", "uidenglu_touxiang4.png"}

function UserMainPanel_PreLoad()
	this:RegisterEvent("RESOURCE_BAR_LOAD")
	this:RegisterEvent("RESOURCE_BAR_UPDATE_MONEY")
	this:RegisterEvent("RESOURCE_BAR_UPDATE_DIAMOND")
	this:RegisterEvent("RESOURCE_BAR_UPDATE_IRON")
	this:RegisterEvent("RESOURCE_BAR_UPDATE_OIL")
	this:RegisterEvent("RESOURCE_BAR_UPDATE_PERSON")
	this:RegisterEvent("RESOURCE_BAR_UPDATE_MEDICINE")
	
	this:RegisterEvent("PORTRAIT_LEFT_LOAD")
	this:RegisterEvent("PORTRAIT_LEFT_UPDATE_NAME")
	this:RegisterEvent("PORTRAIT_LEFT_UPDATE_LEVEL")
	this:RegisterEvent("PORTRAIT_LEFT_UPDATE_EXP")
	this:RegisterEvent("PORTRAIT_LEFT_UPDATE_STRENGTH")
	this:RegisterEvent("HUMANID_UPDATA")
end

function UserMainPanel_OnLoad() 
	g_Resource_Main[1] = Resource_Coinamount_Text
	g_Resource_Main[2] = Resource_Moneyamount_Text
	g_Resource_Main[3] = UserPanel_Ironamount_Text			-- 铁
	g_Resource_Main[4] = UserPanel_Oilamount_Text			-- 石油
	g_Resource_Main[5] = Resource_Manamount_Text	
	
	g_PortraitLeft_Main[1] = UserPanel_Class_Text	  		-- 等级
	g_PortraitLeft_Main[2] = UserPanel_UserName_Text		-- 名字
	g_PortraitLeft_Main[3] = UserPanel_ExpBar      			-- 经验进度条
	g_PortraitLeft_Main[4] = UserPanel_Exp_Text				-- 经验值
	g_PortraitLeft_Main[5] = UserPanel_PhyStrBar      		-- 体力进度条
	g_PortraitLeft_Main[6] = UserPanel_PhyStr_Text		    -- 体力值	
	g_PortraitLeft_Main[7] = UserPanel_Ironamount_Bar		-- 铁矿
	g_PortraitLeft_Main[8] = UserPanel_Oilamount_Bar		-- 石油
	g_PortraitLeft_Main[9] = Resource_Money_Time_Mich		-- 金币定时器
	g_PortraitLeft_Main[10] = Resource_Money_Image			-- 金钱图标
	g_PortraitLeft_Main[11] = UserMainPanel_Portrait		-- 头像图标
end

--窗口事件
function UserMainPanel_OnEvent(event)
	if event=="RESOURCE_BAR_LOAD" then
		this:Show()

	elseif event == "RESOURCE_BAR_UPDATE_MONEY" then
		local bool = this:IsVisible()
		if bool == false then
			this:Hide()
		end
		Resource_UpDateMoney()
	elseif event == "RESOURCE_BAR_UPDATE_DIAMOND" then
		local bool = this:IsVisible()
		if bool == false then
			this:Hide()
		end
		Resource_UpdateDiamond()
	elseif event == "RESOURCE_BAR_UPDATE_MEDICINE" then
		local bool = this:IsVisible()
		if bool == false then
			this:Hide()
		end
	elseif event == "RESOURCE_BAR_UPDATE_IRON" then
		local bool = this:IsVisible()
		if bool == false then
			this:Hide()
		end
		Resource_UpdateIron()				
	elseif event == "RESOURCE_BAR_UPDATE_OIL" then
		local bool = this:IsVisible()
		if bool == false then
			this:Hide()
		end
		Resource_UpdateOil()
	elseif event == "RESOURCE_BAR_UPDATE_PERSON" then
		local bool = this:IsVisible()
		if bool == false then
			this:Hide()
		end
		Resource_UpdatePerson()				
	elseif(event=="PORTRAIT_LEFT_LOAD")then
		this:Show()
	elseif (event == "PORTRAIT_LEFT_UPDATE_NAME")then
		local bool = this:IsVisible()
		if bool == false then
			this:Hide()
		end
		UserPanel_UpdateName()
	elseif (event == "PORTRAIT_LEFT_UPDATE_LEVEL")then
		local bool = this:IsVisible()
		if bool == false then
			this:Hide()
		end
		UserPanel_UpdateLevel()
	elseif (event == "PORTRAIT_LEFT_UPDATE_EXP")then
		local bool = this:IsVisible()
		if bool == false then
			this:Hide()
		end
		UserPanel_UpdateExp()
	elseif (event == "PORTRAIT_LEFT_UPDATE_STRENGTH") then
		UserPanel_UpdatePhyStr()
	elseif (event == "HUMANID_UPDATA") then
		UserPanel_UpdatePortrait()
	end	
end

--=================================================
--			    	更新游戏币
--=================================================

function	Resource_UpDateMoney()
	local	pCURMoney = g_Resource_Main[2]:GetString()
	if 	pCURMoney == "" then
		local	pMoney = Player:GetMoney()
		g_Resource_Main[2]:SetText(pMoney)	
		return	
	end
	
	local	pMoney = Player:GetMoney()
	--if pMoney < pCURMoney then
	--	g_Resource_Main[2]:SetText(pMoney)
	--	return
	--end

	g_Resource_Add_Speed =  ( pMoney - tonumber(pCURMoney) ) / 20
	g_Resource_Add_Speed = math.ceil(g_Resource_Add_Speed)

	if g_Resource_Add_Speed < 0 then
		g_Resource_Main[2]:SetText(pMoney)
	else
		g_PortraitLeft_Main[9]:StartTime(20, 0, 1, 0.1)
	end

end

--=================================================
--					 更新平台币
--=================================================

function Resource_UpdateDiamond()
	local pDiamond = Player:GetDiamond()
	g_Resource_Main[1]:SetText(pDiamond)
end

--=================================================
--					   更新铁
--=================================================
function Resource_UpdateIron()
	local pIron = Player:GetIron()
	local MaxIron = Player:GetIronLimit()
	if (math.floor(MaxIron) <= 0) then
		return	
	end	
	if (pIron >= MaxIron) then			
		g_Resource_Main[3]:SetColor("255 0 0")	
	else			
		g_Resource_Main[3]:SetColor("255 255 255")
	end	
	local str = string.format("%s%s%s", pIron, "/", MaxIron)
	g_Resource_Main[3]:SetText(str)
	-- 防止超过最大值
	local nToPercent = pIron < MaxIron and pIron * 100 / MaxIron or 100
	
	local nCurPercent = g_PortraitLeft_Main[7]:GetPercent()
	-- 当前最大百分比等于要设置的百分比 返回
	if nCurPercent == nToPercent then
		return	
	end
	
	g_PortraitLeft_Main[7]:RunFromTo(0, nToPercent, 0)
end

--===========================================
--				更新石油
--===========================================
function Resource_UpdateOil()
	local pOil = Player:GetOil()
	local MaxOil = Player:GetOilLimit()
	if (math.floor(MaxOil) <= 0) then
		return	
	end	
	if (pOil >= MaxOil) then	
		g_Resource_Main[4]:SetColor("255 0 0")
	else 
		g_Resource_Main[4]:SetColor("255 255 255")		
	end
	local str = string.format("%s%s%s", pOil, "/", MaxOil)
	g_Resource_Main[4]:SetText(str)
	-- 防止当前值大于最大值	
	local nToPercent = pOil < MaxOil and pOil * 100 / MaxOil or 100
	-- 防止重复刷新
	local nCurPercent = g_PortraitLeft_Main[8]:GetPercent()	
	if nCurPercent == nToPercent then
		return	
	end
	g_PortraitLeft_Main[8]:RunFromTo(0, nToPercent, 0)
end

--===========================================
--			    更新人口
--===========================================
function Resource_UpdatePerson()
	local pWorkPerson, pMaxPerson= Player:GetPerson()
	local temp = ""
	temp = string.format("%s%s%s",pWorkPerson,"/",pMaxPerson)
	g_Resource_Main[5]:SetText(temp)
	if pWorkPerson == pMaxPerson then
		g_Resource_Main[5]:SetColor("255 0 0")
	else
		g_Resource_Main[5]:SetColor("255 255 255")	
	end
end

--===========================================
--					购买
--===========================================
function	ResourceBar_Buy()
	-- JavaJni:OpenWebConnect("http://www.handgame.cc")
	PushEvent("SHOP_LOAD", 2)
end

--===========================================
--				更新头像
--===========================================
function	UserPanel_UpdatePortrait()
	local pPortraitID = Player:GetPortraitID()
	local n_PortraitCount = #g_PortraitImageName
	if pPortraitID <= 0 or pPortraitID > n_PortraitCount then
		return
	end
	g_PortraitLeft_Main[11]:SetAtlasTexture(g_PortraitImageName[pPortraitID])
end

--===========================================
--				更新名字
--===========================================
function UserPanel_UpdateName()
	local pName = Player:GetName()
	g_PortraitLeft_Main[2]:SetText(pName)
end

--===========================================
--				更新等级
--===========================================
function UserPanel_UpdateLevel()
	local pLevel = Player:GetLevel()
	g_PortraitLeft_Main[1]:SetText(pLevel)
end

--===========================================
--				更新经验
--===========================================
function UserPanel_UpdateExp()
	local pCurExp = Player:GetExp()
	local level   = Player:GetLevel()
	if level > 0 then
		local pLevelUpExp = Player:GetLevelUpExp()
		if (math.floor(pLevelUpExp) <= 0) then
			return		
		end
		local toPercent   = pCurExp * 100 / pLevelUpExp
		local fromPercent = g_ExpPos * 100 / pLevelUpExp 
		local pValue = math.floor(toPercent)
		g_PortraitLeft_Main[4]:SetText(" #{TXSS_1000_082}: ".. pValue .."%")
		g_PortraitLeft_Main[3]:RunFromTo(fromPercent, toPercent, 0)	
		
		g_ExpPos = pCurExp
	end
end

--===========================================
--				更新体力
--===========================================
function UserPanel_UpdatePhyStr()
	local PhyStr = Player:GetVitality()
	local MaxPhyStr = Player:GetVitalityLimit()
	if (math.floor(MaxPhyStr) <= 0) then
		return	
	end

	local str = string.format("%d%s%d", PhyStr, "/", MaxPhyStr)
	g_PortraitLeft_Main[6]:SetText(" #{TXSS_3000_001}: " .. str)
	g_PortraitLeft_Main[5]:RunFromTo(0, 100 * ( PhyStr / MaxPhyStr ), 0)
end

--===========================================
--				定时添加游戏币
--===========================================
function UserMainPanel_UpdateCoin()
	local	pCURMoney = g_Resource_Main[2]:GetString()
	local	pMoney = tonumber(pCURMoney) + g_Resource_Add_Speed
	local	tMoney = Player:GetMoney()
	g_Resource_Main[2]:SetText(pMoney)
	--local i =	math.random(1,2)
	--if i == 1 then
	--	g_PortraitLeft_Main[10]:SetScale(1.1)
	--else
	--	g_PortraitLeft_Main[10]:SetScale(0.9)
	--end
	
	if tonumber(pMoney) >= tMoney then
		--pMoney = tMoney
		--g_PortraitLeft_Main[10]:SetScale(1)	
		g_Resource_Main[2]:SetText(tMoney)
	end
end