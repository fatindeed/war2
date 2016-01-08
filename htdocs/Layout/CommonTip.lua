local g_CommonTip_Main = {}	

local g_EventType 	    = ""	    -- 全局事件类型

local g_Buy_Index 	    = -1		-- 购买索引
local g_Buy_Type  	    = -1		-- 消费类型
local g_Ptb		  	    = -1		-- 消耗平台币

local g_Build_Createing = 0			-- 建筑建造中...
local g_Build_Producing = 6			-- 建筑生产中...

local g_Create_Build	= 0			-- 建造建筑
local g_Add_Speed 		= 1 		-- 购买加速
local g_Solider_Buy		= 2			-- 训练收费士兵/坦克
local g_ShopGift_Buy	= 3			-- 商店礼包购买
local g_ShopTopup_Buy   = 4			-- 商店充值购买

local g_Shop_Const		= 0			-- 兑换比率

local g_Need_Resource = -1

local g_FrameInfo = -1;

local g_ResourceIndex = 1		-- 资源对应建筑的index

local FrameInfoList =
{
	zhiyuandian = 1				-- 资源点
}

local g_nShopTopupItemPurchaseInfo =		-- 商店充值物品购买信息		  【根据索引排序】 
{
	{MONEY = 10,   POWER = 100,   GIFT = 5},	-- 平台币  能量币  赠送值
	{MONEY = 50,   POWER = 500,   GIFT = 25},
	{MONEY = 100,  POWER = 1000,  GIFT = 100},
	{MONEY = 500,  POWER = 5000,  GIFT = 750},
	{MONEY = 1000, POWER = 10000, GIFT = 2000},
	{MONEY = 2000, POWER = 20000, GIFT = 5000}
}

function	CommonTip_PreLoad()
	this:RegisterEvent("COMMON_TIP_LOAD")
	this:RegisterEvent("COMMON_TIP_BUY")
	this:RegisterEvent("COMMON_TIP_TOBUY")
	this:RegisterEvent("COMMON_TIP_TOBUILD")
	this:RegisterEvent("COMMON_TIP_RESOURCE")
	this:RegisterEvent("COMMON_TIP_BUYSUCCESS")
	this:RegisterEvent("COMMON_TIP_TOSELL")
end

function	CommonTip_OnLoad()
	g_CommonTip_Main[1] = CommonTip_Content
	g_CommonTip_Main[2] = CommonTip_Mask					-- 灰色半透明蒙板
	g_CommonTip_Main[3] = CommonTip_BG						-- 主窗口
	g_CommonTip_Main[4] = CommonTip_Confirm_Button			-- 确认按键
	g_CommonTip_Main[5] = CommonTip_Confirm_Button_Text		-- 确认按键文本
	g_CommonTip_Main[6] = CommonTip_Cancel_Button			-- 取消按键
	g_CommonTip_Main[7] = CommonTip_Cancel_Button_Text  	-- 取消按键文本	

	g_CommonTip_Main[9] = CommonTip_ToBuild_Button			-- 建造按键
	g_CommonTip_Main[10] = CommonTip_ToBuild_Button_Text	-- 建造按键文本
end

function	CommonTip_OnEvent(event)
		
	CommonTip_SetEventType(event)	
	
	if ( event == "COMMON_TIP_LOAD" or event == "COMMON_TIP_BUYSUCCESS") then
		if g_CommonTip_Main[3]:NumberOfRunningActions() ~= 0 then
			return		
		end
		
		this:Show()
		
		if(arg0 ~= nil) then
			local textID = tostring(arg0)
			
			g_CommonTip_Main[1]:SetText(textID)
			
			CommonTip_ShowMask()
			
			CommonTip_ShowButton_Confirm()		
			
			CommonTip_ShowButton_Cancel()
			
			CommonTip_HideButton_Build()
			
			g_CommonTip_Main[3]:PopUp(0.2)	      		-- 弹出窗口
		end	
	elseif event == "COMMON_TIP_TOSELL" then
		if arg0 ~= nil then
			if g_CommonTip_Main[3]:NumberOfRunningActions() ~= 0 then
				return		
			end		

			this:Show()
			
			g_CommonTip_Main[1]:SetText("#{TXSS_2000_016}" .. " " .. tonumber(arg0))
			CommonTip_ShowMask()
			CommonTip_ShowButton_Confirm()		
			CommonTip_ShowButton_Cancel()
			CommonTip_HideButton_Build()
			g_CommonTip_Main[3]:PopUp(0.2)	      		-- 弹出窗口	
		end	
	elseif event == "COMMON_TIP_BUY" then
		if arg0 ~= nil and arg1 ~= nil then
			if g_CommonTip_Main[3]:NumberOfRunningActions() ~= 0 then
				return		
			end
			
			this:Show()
			
			CommonTip_ShowMask()	
			
			CommonTip_ShowButton_Confirm()
			
			CommonTip_ShowButton_Cancel()
			
			CommonTip_HideButton_Build()
			
			g_Buy_Type  = tonumber( arg0 )	-- 购买类型
			g_Buy_Index = tonumber( arg1 )	-- 购买索引
				
			CommonTip_AnalyzeData(g_Buy_Type,g_Buy_Index)	
			
			g_CommonTip_Main[3]:PopUp(0.2)		-- 弹出窗口
			
			--建筑索引
			if( g_Buy_Index >= 12 and g_Buy_Index <= 19)then
				g_FrameInfo = FrameInfoList.zhiyuandian
			end			
		end		
	elseif event == "COMMON_TIP_TOBUY" then
		if g_CommonTip_Main[3]:NumberOfRunningActions() ~= 0 then
			return		
		end
		this:Show()	

		g_CommonTip_Main[1]:SetText("#{SHOP_2000_025}")
		
		CommonTip_ShowMask()
	
		CommonTip_ShowButton_Confirm()
		
		CommonTip_ShowButton_Cancel()
		
		CommonTip_HideButton_Build()

		g_CommonTip_Main[3]:PopUp(0.2)	--弹出窗口
	elseif event == "COMMON_TIP_TOBUILD" then
		if g_CommonTip_Main[3]:NumberOfRunningActions() ~= 0 then
			return		
		end
		
		this:Show()
		
		CommonTip_ShowMask()			

		CommonTip_HideConfirm()
		
		CommonTip_ShowButton_Cancel()	
		CommonTip_ShowButton_Build()
		
		if(arg0 ~= nil) then
			local Name, _, Info = BuildData:GetResourceDescData(tonumber(arg0))					
			g_ResourceIndex = tonumber(arg0)
			g_CommonTip_Main[1]:SetText(Info)		

			g_CommonTip_Main[9]:Show()
			g_CommonTip_Main[10]:SetText("#{TXSS_1000_040}")
			g_CommonTip_Main[3]:PopUp(0.2)	-- 弹出窗口
		end
	elseif event == "COMMON_TIP_RESOURCE" then
		local index = tonumber( arg0 )
		if index == nil then
			return 	
		end
		g_Need_Resource = 1
		this:Show()
		
		CommonTip_HideButton_Build()		

		CommonTip_ShowMask()			

		CommonTip_ShowButton_Confirm()	
		
		CommonTip_ShowButton_Cancel()
		
		CommonTip_InitCostLackText(index)
	end
end

--========================================
-- 				设置事件类型
--========================================
function	CommonTip_SetEventType(event)
	g_EventType = event
end

--========================================
--		  显示全屏半透明灰色模板
--========================================
function  CommonTip_ShowMask()
	g_CommonTip_Main[2]:Show()
	g_CommonTip_Main[2]:SetScale(40)
	g_CommonTip_Main[2]:SetOpacity(200)	
end

--========================================
--		  显示全屏半透明灰色模板
--========================================
function  CommonTip_HideMask()
	g_CommonTip_Main[2]:Hide()
end

--========================================
-- 			扣费类型分流 -- 类型 索引
--========================================
function	CommonTip_AnalyzeData(tTYPE,tIndex)	
	if tTYPE == g_Create_Build then			-- 创建建筑
		CommonTip_CreateBuild(tIndex)
	elseif tTYPE == g_Add_Speed then		-- 生产加速
		CommonTip_AddSpeed()
	elseif tTYPE == g_Solider_Buy then		-- 训练加速
		CommonTip_TrainSolider(tIndex)
	elseif tTYPE == g_ShopGift_Buy then		-- 商店礼包购买
		CommonTip_PurchaseGiftBoxItem(tIndex)
	elseif tTYPE == g_ShopTopup_Buy then	-- 商店充值购买
		CommonTip_PurchaseTopupItem(tIndex)
	end
end

--========================================
--				购买商店礼包
--========================================
function	CommonTip_PurchaseGiftBoxItem(tIndex)
	g_CommonTip_Main[1]:SetText("#{TXSS_1000_039}".. 100 .."#{TXSS_1000_030}".."?")
end

--========================================
--				购买商店充值物品
--========================================
function	CommonTip_PurchaseTopupItem(tIndex)
	
	g_CommonTip_Main[1]:SetText("#{TIP_1000_045}".. g_nShopTopupItemPurchaseInfo[tIndex].POWER .."#{TXSS_1000_030}".."?")
end

--========================================
--				训练收费士兵
--========================================
function	CommonTip_TrainSolider(tIndex)
	g_Ptb = Solider:GetMilitaryInfo("Use_Money",tIndex)
	g_CommonTip_Main[1]:SetText("#{TXSS_1000_039}"..g_Ptb.."#{TXSS_1000_030}".."!")
end

--========================================
--				创建建筑类型
--========================================
function	CommonTip_CreateBuild(tIndex)
	g_Ptb = BuildData:GetBuildInfo("Use_Money",tIndex)
	g_CommonTip_Main[1]:SetText("#{TXSS_1000_039}".. g_Ptb .."#{TXSS_1000_030}".."!")	
end

--========================================
--				加速类型
--========================================
function	CommonTip_AddSpeed()
	local tState  =	BuildData:GetMainTargetBuildState("MainTargetBuild_State_ID")
	---		获取兑换比率
	if g_Shop_Const == 0 then
			g_Shop_Const = 	600000 --GetExchangeValue()	-- ！！！需要改 --[每个能量球对应的加速时间(单位:秒 600秒一个能量球)]-- 
	end	
	if tState == g_Build_Createing then		------------------------ 创建中 
		local uResTime = BuildData:GetMainTargetBuildState("MainTargetBuild_ConstructTime")
		local uPtb = uResTime / g_Shop_Const

		g_Ptb = math.ceil(uPtb)
		g_CommonTip_Main[1]:SetText("#{TXSS_1000_039}"..g_Ptb.."#{TXSS_1000_030}".."!")	
	elseif tState == g_Build_Producing then	------------------------ 生产中 
		local uResTime = BuildData:GetMainTargetBuildState("MainTargetBuild_ProduceTime")	
		local uPtb = math.floor(uResTime / g_Shop_Const) + 1

		g_Ptb = uPtb
		g_CommonTip_Main[1]:SetText("#{TXSS_1000_039}"..g_Ptb.."#{TXSS_1000_030}".."!")			
	end
end

--===================================================
--					确认事件
--===================================================
function	CommonTip_Confirm_Click()
	if g_EventType == "COMMON_TIP_BUY" then
		if g_Buy_Type == g_Create_Build then		-- 创建建筑
			local mPtb	=	Player:GetDiamond()						
			
			if mPtb >= g_Ptb then
				-- 确定建造				
				Move_OK()		
			else
				-- 弹出平台币不足的提示框
				PushEvent("COMMON_TIP_TOBUY")
			end
		elseif g_Buy_Type == g_Add_Speed then		-- 生产加速
			local mPtb	=	Player:GetDiamond()
					
			if mPtb >= g_Ptb then
				BuildData:ProduceAddSpeed()	
			else
				-- 弹出平台币不足的提示框				
				PushEvent("COMMON_TIP_TOBUY")
			end
		elseif	g_Buy_Type == g_Solider_Buy then	-- 训练加速
			local mPtb = Player:GetDiamond()
			
			if mPtb >= g_Ptb then
				BuildData:TrainSoliderSubmit(g_Buy_Index)	
			else
				-- 弹出平台币不足的提示框				
				PushEvent("COMMON_TIP_TOBUY")
			end
		elseif	g_Buy_Type == g_ShopGift_Buy then		-- 商店礼包购买			

		elseif	g_Buy_Type == g_ShopTopup_Buy then		-- 商店充值购买

			PushToast("#{TIP_1000_042}" .. g_nShopTopupItemPurchaseInfo[g_Buy_Index].POWER)			
		end
	elseif g_EventType == "COMMON_TIP_TOBUY" then

		-- 跳转到充值界面
		PushEvent("SHOP_LOAD", 2)	
	elseif g_EventType == "COMMON_TIP_RESOURCE" then
	
		-- 跳转到充值界面		
		PushEvent("SHOP_LOAD", 2)
	elseif	g_EventType == "COMMON_TIP_BUYSUCCESS" then

	elseif  g_EventType == "COMMON_TIP_TOSELL" then
		Move_Sell()		
		PushEvent("MOVE_MENU_UNLOAD")
	end
	this:Hide()	
end

--==================================================
--					取消事件 
--==================================================
function	CommonTip_Cancel_Click()
	this:Hide()
	
	if g_Buy_Type == g_Create_Build then
		Move_NO()
		CloseAllWidget()
		PushEvent("MAIN_MENU_LOAD")
		PushEvent("RESOURCE_BAR_LOAD")
		PushEvent("PORTRAIT_LEFT_LOAD")
		PushEvent("TASK_LIST_LOAD")
		PushEvent("MAIN_CHAT_LOAD")				
	end
end

--===================================================
--				显示[确认]按键
--===================================================
function	CommonTip_ShowButton_Confirm()

	g_CommonTip_Main[4]:Show()		
	g_CommonTip_Main[5]:SetText("#{TXSS_1000_043}")
end

--===================================================
--				隐藏[确认]按键
--===================================================
function	CommonTip_HideConfirm()
	g_CommonTip_Main[4]:Hide()
end

--===================================================
--				显示[取消]按键
--===================================================
function	CommonTip_ShowButton_Cancel()
	g_CommonTip_Main[6]:Show()
	g_CommonTip_Main[7]:SetText("#{TXSS_1000_041}")
end

--===================================================
--				隐藏[取消]按键
--===================================================
function	CommonTip_HideCancel()
	g_CommonTip_Main[6]:Hide()
end

--===================================================
--				显示[立即建造]按键
--===================================================
function	CommonTip_ShowButton_Build()
	g_CommonTip_Main[9]:Show()
	g_CommonTip_Main[10]:SetText("#{TXSS_1000_040}")
end

--===================================================
--				隐藏[立即建造]按键
--===================================================
function	CommonTip_HideButton_Build()
	g_CommonTip_Main[9]:Hide()
	g_CommonTip_Main[10]:Hide()	
end

--===================================================
--	2013年5月20日
--	by 薛云龙	
--	跳转到建筑建造界面	
--===================================================
function	CommonTip_ToBuildHouse()
	this:Hide()
	PushEvent("BUILD_CHOOSE_TOBUILD", 3, g_ResourceIndex)			
end

--========================================
--				关闭窗口
--========================================
function	CommonTip_Close()
	if g_CommonTip_Main[3]:NumberOfRunningActions() ~= 0 then
		return		
	end
	-- 弹出窗口
	g_CommonTip_Main[3]:PopDown(0.2)			    
		
	if(g_FrameInfo == FrameInfoList.zhiyuandian) then
		return
	end
	
	-- this:Hide()
	local buildID = BuildData:GetMainTargetBuildState("MainTargetBuild_ID")
	-- 当资源类建筑弹出到达存储上限，卸载主目标	
	if (buildID >= 12 and buildID <= 19) then	 
		BuildData:UnMainTarget()
	end
	g_Need_Resource = -1
end

--=========================================
--			  资源不足提示框
--=========================================
function	CommonTip_InitCostLackText(index)
	
	local _, _, _, _, _, BuildCoin, _, Iron, Oil = BuildData:GetBuildInfo("BuildDesc_DetailInfo", index)
	
	local showStr = "#{TXSS_1000_091}" .. ":"
	local t_PlatCoin = 0
	if BuildCoin > 0 then
		showStr = showStr .. BuildCoin .. "#{TXSS_1000_005}"
		t_PlatCoin =  t_PlatCoin + ( BuildCoin / 200 )
	end
	
	if Iron > 0 then
		showStr = showStr .. Iron .."#{TXSS_1000_028}"
		t_PlatCoin = t_PlatCoin + ( Iron/25 )
	end
	
	if Oil > 0 then
		showStr	= showStr .. Oil .. "#{TXSS_1000_029}"
		t_PlatCoin = t_PlatCoin + ( Oil / 25 )
	end
	
	showStr = showStr .. ",#{TXSS_1000_093}!"

	t_PlatCoin = math.ceil(t_PlatCoin)
	
	g_CommonTip_Main[1]:SetText(showStr)

end