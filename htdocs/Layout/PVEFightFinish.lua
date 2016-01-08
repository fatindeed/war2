local g_FightFinish_ImageBox = {}
local g_FightFinish_TextBox = {}
local g_FightFinish_Main = {}

local TRUE  = 1
local FALSE = 0

local g_nCombatType	= 										-- 战斗类型
{
	g_PVE_Combat		  		= 1,
	g_PVP_Combat		 		= 2
}   

-- 升级剩余经验
local g_nLevelup_RemainExp = 0

-- 等级经验表
local g_nTableLevelExpInfo = 
{
	100, 
	700, 
	1600,
	2800,
	4300,
	6100,
	8200,
	10600,
	13300,
	16300,
	19600,
	23200,
	27100,
	31300,
	35800,
	40600,
	45700,
	51100,
	56800,
	62800,
	69100,
	75700,
	82600,
	89800,
	97300,
	105100,
	113200,
	121600,
	130300,
	139300
}

function	PVEFightFinish_PreLoad()
	this:RegisterEvent("PVE_FIGHT_FINISH_LOAD")
end

function	PVEFightFinish_OnLoad()
	g_FightFinish_TextBox[1]   = PVEFightFinish_Coin_Text  			  -- 金币文本
	g_FightFinish_TextBox[2]   = PVEFightFinish_PTCoin_Text   		  -- 平台币文本
	g_FightFinish_TextBox[3]   = PVEFightFinish_Exp_Text			  -- 经验值文本
	g_FightFinish_TextBox[4]   = PVEFightFinish_Class_Text			  -- 等级文本
	g_FightFinish_TextBox[5]   = PVEFightFinish_Tip_Label			  --【点击任意位置退出】文本	
	
	g_FightFinish_ImageBox[1]  = PVEFightFinish_ImageBox_grey		  -- 灰色背景
	g_FightFinish_ImageBox[2]  = PVEFightFinish_Light				  -- 闪光背景
	g_FightFinish_ImageBox[3]  = PVEFightFinish_Title_ImgOne		  -- 标题第一个字图片
	g_FightFinish_ImageBox[4]  = PVEFightFinish_Title_ImgTwo		  -- 标题第二个字图片
	g_FightFinish_ImageBox[5]  = PVEFightFinish_ImageBox_StarBg1	  -- 第一颗星星背景
	g_FightFinish_ImageBox[6]  = PVEFightFinish_ImageBox_StarBg2	  -- 第二颗星星背景
	g_FightFinish_ImageBox[7]  = PVEFightFinish_ImageBox_StarBg3	  -- 第三颗星星背景
	g_FightFinish_ImageBox[8]  = PVEFightFinish_ImageBox_Star1		  -- 第一颗星星
	g_FightFinish_ImageBox[9]  = PVEFightFinish_ImageBox_Star2		  -- 第二颗星星
	g_FightFinish_ImageBox[10] = PVEFightFinish_ImageBox_Star3		  -- 第三颗星星	
	
	g_FightFinish_Main[1] 	   = PVEFightFinish_ExpBar				  -- 经验条
	g_FightFinish_Main[2]	   = PVEFightFinish_Kill_Number_Image
	g_FightFinish_Main[3]	   = PVEFightFinish_Kill_Image
	
end

--窗口事件
function	PVEFightFinish_OnEvent(event)
	if(event=="PVE_FIGHT_FINISH_LOAD")then		
		this:Show()
		--bSuccess == false 失败
		--nFlag : 1=小败 1颗星 2 = 大败 两颗星 3 = 完败
		
		--bSuccess == true 胜利
		--nFlag : 1=小胜 1颗星 2 = 大胜 两颗星 3 = 完胜
		local bSuccess, nFlag = DataPool:GetFightSuccess()		
		
		PVEFightFinish_ShowFlashLight(bSuccess)		
		
		PVEFightFinish_Init()		
		
		PVEFightFinish_InitTitle(bSuccess, nFlag)
		
		PVEFightFinish_ShowRewardList()
		
	end	
end

function PVEFightFinish_Init()
	g_nLevelup_RemainExp = 0	
	
	g_FightFinish_TextBox[5]:SetText("#{TXSS_1000_081}")	--点击任意位置退出	
end

--初始化标题
function  PVEFightFinish_InitTitle(bSuccess, nFlag)
	if (bSuccess == TRUE) then
		if 	nFlag == 3 then
			g_FightFinish_ImageBox[3]:SetAtlasTexture("ms_wanw.png")
			g_FightFinish_ImageBox[4]:SetAtlasTexture("ms_sheng.png")
			g_FightFinish_ImageBox[8]:Show()		
			g_FightFinish_ImageBox[9]:Show()		
			g_FightFinish_ImageBox[10]:Show()				
		elseif nFlag == 2 then
			g_FightFinish_ImageBox[3]:SetAtlasTexture("ms_xiaow.png")
			g_FightFinish_ImageBox[4]:SetAtlasTexture("ms_sheng.png")	
			g_FightFinish_ImageBox[8]:Show()		
			g_FightFinish_ImageBox[9]:Show()		
			g_FightFinish_ImageBox[10]:Hide()	
		elseif nFlag == 1 then
			g_FightFinish_ImageBox[3]:SetAtlasTexture("ms_xian.png")
			g_FightFinish_ImageBox[4]:SetAtlasTexture("ms_sheng.png")	
			g_FightFinish_ImageBox[8]:Show()		
			g_FightFinish_ImageBox[9]:Hide()		
			g_FightFinish_ImageBox[10]:Hide()		
		end
	elseif (bSuccess == FALSE)then
		g_FightFinish_ImageBox[8]:Hide()		
		g_FightFinish_ImageBox[9]:Hide()		
		g_FightFinish_ImageBox[10]:Hide()		
		if 	nFlag == 3 then
			g_FightFinish_ImageBox[3]:SetAtlasTexture("ms_wanl.png")
			g_FightFinish_ImageBox[4]:SetAtlasTexture("ms_bai.png")
		elseif nFlag == 2 then
			g_FightFinish_ImageBox[3]:SetAtlasTexture("ms_xiaol.png")
			g_FightFinish_ImageBox[4]:SetAtlasTexture("ms_bai.png")		
		elseif nFlag == 1 then
			g_FightFinish_ImageBox[3]:SetAtlasTexture("ms_xil.png")
			g_FightFinish_ImageBox[4]:SetAtlasTexture("ms_bai.png")		
		end	
	end
end

--显示闪光背景
function PVEFightFinish_ShowFlashLight(bSuccess)
	if (bSuccess == TRUE) then
		g_FightFinish_ImageBox[2]:Show()
		--g_FightFinish_ImageBox[2]:SetScale(10)	
		g_FightFinish_ImageBox[2]:StartRotation(1, 180, true)
		--g_FightFinish_ImageBox[2]:SetPosition(-100, -300)
	else 
		g_FightFinish_ImageBox[2]:Hide()
	end
end

--***************************************************
--				显示奖励物品列表	
--***************************************************
function PVEFightFinish_ShowRewardList()	
	local bonusNum = DataPool:GetFightBonusNum()
	for i = 0, bonusNum - 1, 1 do
		local strIcon, count = 0, 0
		strIcon, count = DataPool:GetFightBonus(i)
		if (tostring(strIcon) == "money") then
			g_FightFinish_TextBox[1]:SetText(count)
		elseif(tostring(strIcon) == "Glod") then	
			g_FightFinish_TextBox[2]:SetText(count)
		elseif (tostring(strIcon) == "exp") then
			local level = Player:GetLevel()	
			local levelupExp = Player:GetLevelUpExp()
			local curExp = Player:GetExp()
				
			if (math.floor(levelupExp) <= 0) then
				return
			end
			
			local FinalExp = 0
			
			if curExp > levelupExp then
				FinalExp = 100
				g_nLevelup_RemainExp = curExp - levelupExp
			else
				FinalExp = 100 * curExp / levelupExp			
			end
				
			g_FightFinish_Main[1]:RunFromTo(0, FinalExp, 1)
			g_FightFinish_TextBox[3]:SetText(math.floor(FinalExp).."%")
			g_FightFinish_TextBox[4]:SetText(level)
		end
	end
	g_FightFinish_Main[3]:SetPosition(360,84)
	local g_KillNumber = GetMaxKillNumber()
	if g_KillNumber == 1 then
		g_FightFinish_Main[2]:SetAtlasTexture("ms_fa1.png")
	elseif g_KillNumber == 2 then
		g_FightFinish_Main[2]:SetAtlasTexture("ms_fa2.png")
	elseif g_KillNumber == 3 then
		g_FightFinish_Main[2]:SetAtlasTexture("ms_fa3.png")
	elseif g_KillNumber > 3 then
		g_FightFinish_Main[2]:SetAtlasTexture("ms_fagod.png")
		g_FightFinish_Main[3]:SetPosition(410,110)
	else
		g_FightFinish_Main[2]:Hide()
		g_FightFinish_Main[3]:Hide()
	end
end

--===================================================
--  			进度条播放完成回调事件
--===================================================
function PVEFightFinish_OnProgressEventEnd()
	if (g_nLevelup_RemainExp <= 0) then
		g_nLevelup_RemainExp = 0
		return	
	end
	local level = Player:GetLevel()	 + 1
	local FinalExp = 100 * g_nLevelup_RemainExp / g_nTableLevelExpInfo[level]
	g_FightFinish_Main[1]:RunFromTo(0, FinalExp, 1)
    g_FightFinish_TextBox[3]:SetText(math.floor(FinalExp).."%")
	g_FightFinish_TextBox[4]:SetText(level)	
	
	g_nLevelup_RemainExp = g_nLevelup_RemainExp - g_nTableLevelExpInfo[level]		
end

--***************************************************
--				确定按键事件
--***************************************************
function PVEFightFinish_OnClick()
	
	CloseAllWidget()
	
	PushEvent("LOADINGWIDGET_LOAD")
	--PushEvent("SCENESWITCH_OPEN")
	local scriptID = DataPool:GetFightScript()
	if scriptID ~= -1 then
		ClearScript()
		SetFunction("OnGoHome")
		SetScriptID(scriptID)
		SendScript()
	end

	SendCombatBalance()	
end

