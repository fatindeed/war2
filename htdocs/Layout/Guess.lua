--主键
local g_Guess_Main = {}					
-- 分类按键	
local g_Guess_BtnType =  0	
local g_Guess_BtnText = {} 
local g_Guess_Pic = {}

local g_Guess_curPic = 0

function	Guess_PreLoad()

	this:RegisterEvent("GUESS_LOAD")
end

function	Guess_OnLoad()	
	
	g_Guess_Main[1] = Guess_GoodsDesc_Mask
	g_Guess_Main[2] = Guess_GoodsDescBg_Img
	g_Guess_Main[3] = Guess_Confirm_Button_Text
	g_Guess_Main[4] = Guess_GoodsDesc_Text
	g_Guess_Main[5] = Guess_TitleBackground
	g_Guess_Main[6] = Guess_SmallBg_Img
	g_Guess_Main[7] = Guess_Title_Text
	
	g_Guess_Pic[1] = Guess_SmallBg1
	g_Guess_Pic[2] = Guess_SmallBg2
	g_Guess_Pic[3] = Guess_SmallBg3
	g_Guess_Pic[4] = Guess_SmallBg4
	g_Guess_Pic[5] = Guess_SmallBg5
	g_Guess_Pic[6] = Guess_SmallBg6
	
	
end


--窗口事件
function	Guess_OnEvent(event)
	if event=="GUESS_LOAD" then
		math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)) )
		g_Guess_BtnType = 0
		g_Guess_curPic = 0
		
		this:Show()
		Guess_Init()
		
		Guess_HideGoodsDetail()		
	end
end

--===============================================
--					初始化
--===============================================
function	Guess_Init()
	g_Guess_Main[3]:SetText("#{TXSS_1000_043}")			-- 确定文本
	
	g_Guess_Main[7]:SetText("#{GUSS_1000_009}")
	--g_Guess_Main[6]:SetAtlasTexture("Logo/touxiang_xuanze.png")
	--g_Guess_Main[6]:SetScaleX(0.9)
	--g_Guess_Main[6]:SetScaleY(0.6)
end


--===============================================
-- 					
--===============================================
function	Guess_ShowOK()

	g_Guess_Main[1]:Show()
	g_Guess_Main[2]:Show()	
	g_Guess_Main[1]:SetOpacity(100)	
	g_Guess_Main[4]:SetText("#{GUSS_1000_007}")
end

--===============================================
-- 					
--===============================================
function	Guess_HideGoodsDetail()
	g_Guess_Main[1]:Hide()
    g_Guess_Main[2]:Hide()
	
end

--===============================================
--- 			关闭当前界面 回到主界面
--===============================================
function	Guess_Close()
	g_Guess_BtnType = 0
	CloseAllWidget()
	PushEvent("MAIN_MENU_LOAD")
	PushEvent("RESOURCE_BAR_LOAD")
	PushEvent("PORTRAIT_LEFT_LOAD")
	PushEvent("TASK_LIST_LOAD")
	PushEvent("MAIN_CHAT_LOAD")	
	
	PushEvent("RESOURCE_BAR_UPDATE_MONEY")
	PushEvent("RESOURCE_BAR_UPDATE_DIAMOND")
	PushEvent("RESOURCE_BAR_UPDATE_IRON")
	PushEvent("RESOURCE_BAR_UPDATE_OIL")	
	PushEvent("PORTRAIT_LEFT_UPDATE_STRENGTH")	
	
	
end




--===============================================
--		 		 
--===============================================
function	Guess_OnDescCloseEvent()

		Guess_HideGoodsDetail()
end



--===============================================
--		 		    
--===============================================
function	Guess_OnConfirmEvent()
	
	
	---向服务器发送扣金币请求
	local money = Player:GetMoney()
	if money < 10000 then
		PushToast("#{GUSS_1000_005}")
		return
	end
	SendCostMoney(0,0,10000)--参数1为货币种类，参数2为操作类型0标识减少1标识增加，参数3为数量 
	
	OpenRequestWaitProgress()	

	Guess_HideGoodsDetail()
	IsWin()
	
end
function MainButton_Shears_Click()
	if g_Guess_curPic == 6 then
		PushToast("#{GUSS_1000_006}")
		return
	end
	g_Guess_BtnType = 1
	
	Guess_ShowOK()
end
function  MainButton_Stone_Click()
	if g_Guess_curPic == 6 then
		PushToast("#{GUSS_1000_006}")
		return
	end
	
	g_Guess_BtnType = 2
	Guess_ShowOK()
end
function MainButton_Cloth_Click()
	if g_Guess_curPic == 6 then
		PushToast("#{GUSS_1000_006}")
		return
	end
	
	g_Guess_BtnType = 3
	Guess_ShowOK()
end

--判断输赢	
function IsWin()
	--math.randomseed(tostring(os.time()))
	local index = math.random(3)
	index = math.random(3)
	
	local op = -1
	
	if index > 3 or index < 1 then
		PushToast("errer!!!")
		return
	elseif index == 1 then
		if g_Guess_BtnType == 1 then
			PushToast("#{GUSS_1000_004}")
			op = 0
		elseif g_Guess_BtnType == 2 then
			PushToast("#{GUSS_1000_003}")
		elseif g_Guess_BtnType == 3 then
			--PushToast("#{GUSS_1000_002}")
			Guess_OnWin()
			op = 1
		end
	elseif index == 2 then
		if g_Guess_BtnType == 1 then
			--PushToast("#{GUSS_1000_002}")
			Guess_OnWin()
			op = 1
		elseif g_Guess_BtnType == 2 then
			PushToast("#{GUSS_1000_004}")
			op = 0
		elseif g_Guess_BtnType == 3 then
			PushToast("#{GUSS_1000_003}")
		end
	elseif index == 3 then
		if g_Guess_BtnType == 1 then
			PushToast("#{GUSS_1000_003}")
		elseif g_Guess_BtnType == 2 then
			--PushToast("#{GUSS_1000_002}")
			Guess_OnWin()
			op = 1
		elseif g_Guess_BtnType == 3 then
			PushToast("#{GUSS_1000_004}")
			op = 0
		end
	
	end
	Guess_OperatePic(op)
end

function  Guess_OperatePic(op)
	if op == 1 then
		g_Guess_curPic = g_Guess_curPic + 1
		g_Guess_Pic[g_Guess_curPic]:Hide()
	elseif op == -1 then
		g_Guess_Pic[g_Guess_curPic]:Show()
		g_Guess_curPic = g_Guess_curPic - 1
		if g_Guess_curPic < 0 then
			g_Guess_curPic = 0
		end
	else
		 
	end
end

----判断是不是全部显示出来
function Guess_OnWin()
	if g_Guess_curPic == 5 then
		PushToast("#{GUSS_1000_008}")
		
		SendCostMoney(1,1,50)--参数1为货币种类，参数2为操作类型0标识减少1标识增加，参数3为数量 
		OpenRequestWaitProgress()
	else
		PushToast("#{GUSS_1000_002}")
	end
end
