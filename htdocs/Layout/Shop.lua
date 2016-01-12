-- 主键
local g_Shop_Main 		= {}   					
-- 分类按键	
local g_Shop_Button 	= {}  	
-- 分类按键文本									
local g_Shop_ButtonText = {}   							 		
-- 页面类型
local g_nTypePage       =      							 		
{
	  TYPEPAGE_GIFTBOX  = 1,	-- 礼包页面						 		
	  TYPEPAGE_TOPUP    = 2  	-- 充值页面					 	 		
}
-- 第一次加载页ID
local g_nLoadedFirstPageID = 0				
-- 当前载入的界面ID					
local g_nCurLoadedPageID   = 0									
-- 当前礼包物品索引
local g_nGiftItemIndex	   = 0
-- 当前充值物品索引
local g_nTopupItemIndex    = 0

local g_tableGiftItem_cmgame      =  								    -- 礼包物品
{
	{ICON_ID = "sc_zdz.png",        NAME = "#{NAME_4000_028}", PRICE = 8, GOODS_SUB_ID = "30000765967701", DESC = "#{SHOP_1000_001}"},-- 鼠式坦克	
	{ICON_ID = "sc_tjzc.png",       NAME = "#{NAME_4000_030}", PRICE = 8, GOODS_SUB_ID = "30000765967702", DESC = "#{SHOP_1000_002}"},--  猎虎歼敌机
	{ICON_ID = "sc_lfbbc.png",      NAME = "#{NAME_4000_027}", PRICE = 8, GOODS_SUB_ID = "30000765967703", DESC = "#{SHOP_1000_003}"},-- 野蜂榴弹炮   
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_018}", PRICE = 5, GOODS_SUB_ID = "30000765967709", DESC = "#{ITEM_2000_018}"},-- 5000木材
	{ICON_ID = "sc_qikuang.png",    NAME = "#{ITEM_2000_019}", PRICE = 5, GOODS_SUB_ID = "30000765967708", DESC = "#{ITEM_2000_019}"},-- 5000矿石
	{ICON_ID = "sc_ys.png",         NAME = "#{NAME_4000_018}", PRICE = 10, GOODS_SUB_ID = "30000765967704", DESC = "#{SHOP_1000_004}"},-- 黄鼠狼坦克炮
	{ICON_ID = "sc_hsbd2.png",      NAME = "#{NAME_4000_021}", PRICE = 5, GOODS_SUB_ID = "30000765967705", DESC = "#{SHOP_1000_005}"},-- 生化特种兵
	{ICON_ID = "sc_qxtk.png",       NAME = "#{NAME_4000_022}", PRICE = 10, GOODS_SUB_ID = "30000765967706", DESC = "#{SHOP_1000_006}"},-- 斐迪南战车
	{ICON_ID = "sc_bbc.png",        NAME = "#{NAME_4000_024}", PRICE = 10, GOODS_SUB_ID = "30000765967707", DESC = "#{SHOP_1000_007}"},-- 虎式坦克
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_010}", PRICE = 0.1, GOODS_SUB_ID = "30000765967713", DESC = "#{ITEM_2000_010}"},-- 50木材	
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_011}", PRICE = 0.5, GOODS_SUB_ID = "30000765967714", DESC = "#{ITEM_2000_011}"},-- 300木材
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_014}", PRICE = 2, GOODS_SUB_ID = "30000765967717", DESC = "#{ITEM_2000_014}"},--  500木材  
	{ICON_ID = "sc_qikuang.png",  	NAME = "#{ITEM_2000_015}", PRICE = 2, GOODS_SUB_ID = "30000765967718", DESC = "#{ITEM_2000_015}"},--500矿石
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_017}", PRICE = 4, GOODS_SUB_ID = "30000765967720", DESC = "#{ITEM_2000_017}"},-- 800木材
	{ICON_ID = "sc_qikuang.png",    NAME = "#{ITEM_2000_021}", PRICE = 4, GOODS_SUB_ID = "30000765967721", DESC = "#{ITEM_2000_021}"},--800矿石	
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_022}", PRICE = 6, GOODS_SUB_ID = "30000765967722", DESC = "#{ITEM_2000_022}"},-- 1000木材		
	{ICON_ID = "sc_qikuang.png",    NAME = "#{ITEM_2000_023}", PRICE = 6, GOODS_SUB_ID = "30000765967723", DESC = "#{ITEM_2000_023}"},-- 1000矿石
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_026}", PRICE = 14, GOODS_SUB_ID = "30000765967726", DESC = "#{ITEM_2000_026}"},-- 15000木材
	{ICON_ID = "sc_qikuang.png",    NAME = "#{ITEM_2000_027}", PRICE = 14, GOODS_SUB_ID = "30000765967727", DESC = "#{ITEM_2000_027}"}-- 15000矿石		
}

local g_tableGiftItem_mm      =  								    -- 礼包物品
{
	{ICON_ID = "sc_zdz.png",        NAME = "#{NAME_4000_028}", PRICE = 8, GOODS_SUB_ID = "30000765967701", DESC = "#{SHOP_1000_001}"},-- 鼠式坦克	
	{ICON_ID = "sc_tjzc.png",       NAME = "#{NAME_4000_030}", PRICE = 8, GOODS_SUB_ID = "30000765967702", DESC = "#{SHOP_1000_002}"},--  猎虎歼敌机
	{ICON_ID = "sc_lfbbc.png",      NAME = "#{NAME_4000_027}", PRICE = 8, GOODS_SUB_ID = "30000765967703", DESC = "#{SHOP_1000_003}"},-- 野蜂榴弹炮   
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_018}", PRICE = 5, GOODS_SUB_ID = "30000765967709", DESC = "#{ITEM_2000_018}"},-- 5000木材
	{ICON_ID = "sc_qikuang.png",    NAME = "#{ITEM_2000_019}", PRICE = 5, GOODS_SUB_ID = "30000765967708", DESC = "#{ITEM_2000_019}"},-- 5000矿石
	{ICON_ID = "sc_ys.png",         NAME = "#{NAME_4000_018}", PRICE = 10, GOODS_SUB_ID = "30000765967704", DESC = "#{SHOP_1000_004}"},-- 黄鼠狼坦克炮
	{ICON_ID = "sc_hsbd2.png",      NAME = "#{NAME_4000_021}", PRICE = 5, GOODS_SUB_ID = "30000765967705", DESC = "#{SHOP_1000_005}"},-- 生化特种兵
	{ICON_ID = "sc_qxtk.png",       NAME = "#{NAME_4000_022}", PRICE = 10, GOODS_SUB_ID = "30000765967706", DESC = "#{SHOP_1000_006}"},-- 斐迪南战车
	{ICON_ID = "sc_bbc.png",        NAME = "#{NAME_4000_024}", PRICE = 10, GOODS_SUB_ID = "30000765967707", DESC = "#{SHOP_1000_007}"},-- 虎式坦克
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_010}", PRICE = 0.1, GOODS_SUB_ID = "30000765967713", DESC = "#{ITEM_2000_010}"},-- 50木材	
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_011}", PRICE = 0.5, GOODS_SUB_ID = "30000765967714", DESC = "#{ITEM_2000_011}"},-- 300木材
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_014}", PRICE = 2, GOODS_SUB_ID = "30000765967717", DESC = "#{ITEM_2000_014}"},--  500木材  
	{ICON_ID = "sc_qikuang.png",  	NAME = "#{ITEM_2000_015}", PRICE = 2, GOODS_SUB_ID = "30000765967718", DESC = "#{ITEM_2000_015}"},--500矿石
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_017}", PRICE = 4, GOODS_SUB_ID = "30000765967720", DESC = "#{ITEM_2000_017}"},-- 800木材
	{ICON_ID = "sc_qikuang.png",    NAME = "#{ITEM_2000_021}", PRICE = 4, GOODS_SUB_ID = "30000765967721", DESC = "#{ITEM_2000_021}"},--800矿石	
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_022}", PRICE = 6, GOODS_SUB_ID = "30000765967722", DESC = "#{ITEM_2000_022}"},-- 1000木材		
	{ICON_ID = "sc_qikuang.png",    NAME = "#{ITEM_2000_023}", PRICE = 6, GOODS_SUB_ID = "30000765967723", DESC = "#{ITEM_2000_023}"},-- 1000矿石
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_026}", PRICE = 14, GOODS_SUB_ID = "30000765967726", DESC = "#{ITEM_2000_026}"},-- 15000木材
	{ICON_ID = "sc_qikuang.png",    NAME = "#{ITEM_2000_027}", PRICE = 14, GOODS_SUB_ID = "30000765967727", DESC = "#{ITEM_2000_027}"}-- 15000矿石		
}

local g_tableGiftItem_EgameFee      =  								    -- 礼包物品
{
	{ICON_ID = "sc_zdz.png",        NAME = "#{NAME_4000_001}", PRICE = 5, GOODS_SUB_ID = "30000765967701", DESC = "#{SHOP_1000_001}"},-- 震地者			
	{ICON_ID = "sc_tjzc.png",       NAME = "#{NAME_4000_002}", PRICE = 5, GOODS_SUB_ID = "30000765967702", DESC = "#{SHOP_1000_002}"},-- 突击战车 		
	{ICON_ID = "sc_lfbbc.png",      NAME = "#{NAME_4000_003}", PRICE = 8, GOODS_SUB_ID = "30000765967703", DESC = "#{SHOP_1000_003}"},-- 连发步兵车	    
	{ICON_ID = "sc_ys.png",         NAME = "#{NAME_4000_004}", PRICE = 8, GOODS_SUB_ID = "30000765967704", DESC = "#{SHOP_1000_004}"},-- 鹰隼			
	{ICON_ID = "sc_hsbd2.png",      NAME = "#{NAME_4000_005}", PRICE = 10, GOODS_SUB_ID = "30000765967705", DESC = "#{SHOP_1000_005}"},-- 火山部队		
	{ICON_ID = "sc_qxtk.png",       NAME = "#{NAME_4000_006}", PRICE = 12, GOODS_SUB_ID = "30000765967706", DESC = "#{SHOP_1000_006}"},-- 轻型坦克	
	{ICON_ID = "sc_bbc.png",        NAME = "#{NAME_4000_007}", PRICE = 14, GOODS_SUB_ID = "30000765967707", DESC = "#{SHOP_1000_007}"},-- 步兵车		
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_008}", PRICE = 1, GOODS_SUB_ID = "30000765967708", DESC = "#{SHOP_1000_008}"},-- 500木材
	{ICON_ID = "sc_qikuang.png",  	NAME = "#{ITEM_2000_009}", PRICE = 1, GOODS_SUB_ID = "30000765967709", DESC = "#{SHOP_1000_009}"},-- 500矿石
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_010}", PRICE = 2, GOODS_SUB_ID = "30000765967710", DESC = "#{SHOP_1000_008}"},-- 1000木材
	{ICON_ID = "sc_qikuang.png",    NAME = "#{ITEM_2000_011}", PRICE = 2, GOODS_SUB_ID = "30000765967711", DESC = "#{SHOP_1000_009}"},-- 1000矿石
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_012}", PRICE = 3, GOODS_SUB_ID = "30000765967712", DESC = "#{SHOP_1000_008}"},-- 1500木材
	{ICON_ID = "sc_qikuang.png",    NAME = "#{ITEM_2000_013}", PRICE = 3, GOODS_SUB_ID = "30000765967713", DESC = "#{SHOP_1000_009}"},-- 1500矿石
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_014}", PRICE = 4, GOODS_SUB_ID = "30000765967714", DESC = "#{SHOP_1000_008}"},-- 2000木材
	{ICON_ID = "sc_qikuang.png",    NAME = "#{ITEM_2000_015}", PRICE = 4, GOODS_SUB_ID = "30000765967715", DESC = "#{SHOP_1000_009}"},-- 2000矿石
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_016}", PRICE = 6, GOODS_SUB_ID = "30000765967716", DESC = "#{SHOP_1000_008}"},-- 3000木材
	{ICON_ID = "sc_qikuang.png",    NAME = "#{ITEM_2000_017}", PRICE = 6, GOODS_SUB_ID = "30000765967717", DESC = "#{SHOP_1000_009}"},-- 3000矿石
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_018}", PRICE = 20, GOODS_SUB_ID = "30000765967718", DESC = "#{SHOP_1000_008}"},-- 10000木材
	{ICON_ID = "sc_qikuang.png",    NAME = "#{ITEM_2000_019}", PRICE = 20, GOODS_SUB_ID = "30000765967719", DESC = "#{SHOP_1000_009}"},-- 10000矿石
	{ICON_ID = "sc_jingkuang.png",  NAME = "#{ITEM_2000_020}", PRICE = 30, GOODS_SUB_ID = "30000765967720", DESC = "#{SHOP_1000_008}"},-- 15000木材
	{ICON_ID = "sc_qikuang.png",    NAME = "#{ITEM_2000_021}", PRICE = 30, GOODS_SUB_ID = "30000765967721", DESC = "#{SHOP_1000_009}"}-- 15000矿石
}

local g_nGiftCount 	 = 0									-- 礼包数量

local g_nShopTopupItemPurchaseInfo_cmgame =			-- 商店充值物品购买信息		  【根据索引排序】 
{	-- 平台币       能量币  	赠送值
	{MONEY = 15,  POWER = 300,  GIFT = 30, GOODS_SUB_ID = "30000765967710", DESC = "#{TXSS_2000_063}"},
	-- {MONEY = 0.01,  POWER = 1,  GIFT = 0, GOODS_SUB_ID = "30000765967711", DESC = "#{TXSS_2000_063}"},
	{MONEY = 0.1,  POWER = 10,  GIFT = 0, GOODS_SUB_ID = "30000765967712", DESC = "#{TXSS_2000_063}"},
	{MONEY = 1,  POWER = 16,  GIFT = 0, GOODS_SUB_ID = "30000765967715", DESC = "#{TXSS_2000_063}"},
	{MONEY = 2,  POWER = 30,  GIFT = 0, GOODS_SUB_ID = "30000765967716", DESC = "#{TXSS_2000_063}"},
	{MONEY = 4,  POWER = 50,  GIFT = 0, GOODS_SUB_ID = "30000765967719", DESC = "#{TXSS_2000_063}"},
	{MONEY = 12,  POWER = 150,  GIFT = 0, GOODS_SUB_ID = "30000765967724", DESC = "#{TXSS_2000_063}"},
	{MONEY = 14,  POWER = 200,  GIFT = 0, GOODS_SUB_ID = "30000765967725", DESC = "#{TXSS_2000_063}"},
	{MONEY = 15,  POWER = 400,  GIFT = 0, GOODS_SUB_ID = "30000765967728", DESC = "#{TXSS_2000_063}"},
	{MONEY = 20,  POWER = 600,  GIFT = 0, GOODS_SUB_ID = "30000765967729", DESC = "#{TXSS_2000_063}"},
	{MONEY = 25,  POWER = 900,  GIFT = 0, GOODS_SUB_ID = "30000765967730", DESC = "#{TXSS_2000_063}"}
}

local g_nShopTopupItemPurchaseInfo_mm =			-- 商店充值物品购买信息		  【根据索引排序】 
{	-- 平台币       能量币  	赠送值
	{MONEY = 15,  POWER = 300,  GIFT = 30, GOODS_SUB_ID = "30000765967710", DESC = "#{TXSS_2000_063}"},
	-- {MONEY = 0.01,  POWER = 1,  GIFT = 0, GOODS_SUB_ID = "30000765967711", DESC = "#{TXSS_2000_063}"},
	{MONEY = 0.1,  POWER = 10,  GIFT = 0, GOODS_SUB_ID = "30000765967712", DESC = "#{TXSS_2000_063}"},
	{MONEY = 1,  POWER = 16,  GIFT = 0, GOODS_SUB_ID = "30000765967715", DESC = "#{TXSS_2000_063}"},
	{MONEY = 2,  POWER = 30,  GIFT = 0, GOODS_SUB_ID = "30000765967716", DESC = "#{TXSS_2000_063}"},
	{MONEY = 4,  POWER = 50,  GIFT = 0, GOODS_SUB_ID = "30000765967719", DESC = "#{TXSS_2000_063}"},
	{MONEY = 12,  POWER = 150,  GIFT = 0, GOODS_SUB_ID = "30000765967724", DESC = "#{TXSS_2000_063}"},
	{MONEY = 14,  POWER = 200,  GIFT = 0, GOODS_SUB_ID = "30000765967725", DESC = "#{TXSS_2000_063}"},
	{MONEY = 15,  POWER = 400,  GIFT = 0, GOODS_SUB_ID = "30000765967728", DESC = "#{TXSS_2000_063}"},
	{MONEY = 20,  POWER = 600,  GIFT = 0, GOODS_SUB_ID = "30000765967729", DESC = "#{TXSS_2000_063}"},
	{MONEY = 25,  POWER = 900,  GIFT = 0, GOODS_SUB_ID = "30000765967730", DESC = "#{TXSS_2000_063}"}
}

local g_nShopTopupItemPurchaseInfo_EgameFee =			-- 商店充值物品购买信息		  【根据索引排序】 
{	-- 平台币       能量币  	赠送值
	{MONEY = 0.1,  POWER = 1,  GIFT = 0, GOODS_SUB_ID = "30000765967722", DESC = "#{SHOP_1000_010}"},
	{MONEY = 0.5,  POWER = 5,  GIFT = 0, GOODS_SUB_ID = "30000765967723", DESC = "#{SHOP_1000_010}"},
	{MONEY = 1,  POWER = 10,  GIFT = 1, GOODS_SUB_ID = "30000765967724", DESC = "#{SHOP_1000_010}"},
	{MONEY = 5,  POWER = 50,  GIFT = 5, GOODS_SUB_ID = "30000765967725", DESC = "#{SHOP_1000_010}"},
	{MONEY = 10,  POWER = 100,  GIFT = 20, GOODS_SUB_ID = "30000765967726", DESC = "#{SHOP_1000_010}"},
	{MONEY = 15,  POWER = 150,  GIFT = 30, GOODS_SUB_ID = "30000765967727", DESC = "#{SHOP_1000_010}"},
	{MONEY = 20,  POWER = 200,  GIFT = 60, GOODS_SUB_ID = "30000765967728", DESC = "#{SHOP_1000_010}"},
	{MONEY = 25,  POWER = 250,  GIFT = 100, GOODS_SUB_ID = "30000765967729", DESC = "#{SHOP_1000_010}"},
	{MONEY = 30,  POWER = 300,  GIFT = 150, GOODS_SUB_ID = "30000765967730", DESC = "#{SHOP_1000_010}"}
}

function	Shop_PreLoad()
	this:RegisterEvent("SHOP_LOAD")
end

function	Shop_OnLoad()	
	g_Shop_Main[1] = Shop_PlatMoney_Text				  -- 平台币文本
	g_Shop_Main[2] = Shop_Time_Mich						  -- 商品第一次加载定时器 
	g_Shop_Main[3] = Shop_GoodsDesc_Mask				  -- 物品详情蒙板
	g_Shop_Main[4] = Shop_GoodsDescBg_Img				  -- 物品详情主面板
	g_Shop_Main[5] = Shop_GoodsDescIcon					  -- 物品详情面板图标
	g_Shop_Main[6] = Shop_Confirm_Button_Text			  -- 确认按键文本
	g_Shop_Main[7] = Shop_GoodsDesc_Text				  -- 详细物品说明文本
	g_Shop_Main[8] = Shop_Item_ScrollView    			  -- 物品列表
	g_Shop_Main[9] = Shop_Title_Text					  -- 标题文字 	
	g_Shop_Main[10] = Shop_GoodsDesc_ItemName			  -- 物品详情的名字
	
	g_Shop_Button[1] = Shop_SmallBg_Img
	g_Shop_Button[2] = Shop_GiftBox_Button 
	g_Shop_Button[3] = Shop_TopUp_Button

	g_Shop_ButtonText[1] = Shop_GiftBox_Button_Text

end


--窗口事件
function	Shop_OnEvent(event)
	if event=="SHOP_LOAD" then
		if arg0 == nil then
			return		
		end
		Shop_Init()
		
		PushEvent("RESOURCE_BAR_LOAD")
		
		this:Show()		
		
		Shop_HideGoodsDetail()
		
		g_nLoadedFirstPageID = tonumber(arg0)
		
		if g_nCurLoadedPageID ~= g_nLoadedFirstPageID then
	
			g_Shop_Main[2]:StopTime()
			g_Shop_Main[2]:StartTime(0, 0, 0, 0)
			g_Shop_Main[8]:CleanAllElement()
			g_Shop_Main[8]:SetContentOffset(0, 0)
		end
		CloseRequestWaitProgress()
	end
end

--===============================================
--					初始化
--===============================================
function	Shop_Init()
	g_Shop_Button[1]:ResetZOrder(6)

	g_Shop_ButtonText[1]:SetText("#{TXSS_1000_051}")	-- 礼包文本
	g_Shop_Main[9]:SetText("#{SHOP_2000_001}")			-- 在线商城
	
	-- 获取玩家平台币
	local nPlatMoney = Player:GetDiamond()	
	g_Shop_Main[1]:SetText(tostring(nPlatMoney))
	
	g_Shop_Main[6]:SetText("#{SYST_1000_002}")			-- 确定文本
end

--===============================================
-- 				显示当前分类页
--===============================================
function 	Shop_ShowCurTypePage(_TypePage)
	if  _TypePage == g_nTypePage.TYPEPAGE_GIFTBOX then
		Shop_GiftBoxLabel_Click()
	elseif _TypePage == g_nTypePage.TYPEPAGE_TOPUP then
		Shop_TopUpLabel_Click()	
	end		
end

--===============================================
-- 					显示物品详情
--===============================================
function	Shop_ShowGoodsDetail()
	g_Shop_Main[3]:Show()
	g_Shop_Main[4]:Show()	
	g_Shop_Main[3]:SetOpacity(100)		
end

--===============================================
-- 					隐藏物品详情
--===============================================
function	Shop_HideGoodsDetail()
	g_Shop_Main[3]:Hide()
    g_Shop_Main[4]:Hide()
	
end

--===============================================
-- 					显示礼包列表
--===============================================
function 	Shop_ShowGiftBoxList()
	local pos_x, pos_y = 15, 0	
	local display_width = 713
	local content_width, content_height = 0, 318
	local offset_x, offset_y = 0, 0
	
	local g_tableGiftItem = {}
	local strChannelID = JavaJni:GetChannelID()
	if strChannelID == "U004" then
		g_nGiftCount = #g_tableGiftItem_cmgame
		g_tableGiftItem = g_tableGiftItem_cmgame
	elseif strChannelID == "U003" then	
		g_nGiftCount = #g_tableGiftItem_mm
		g_tableGiftItem = g_tableGiftItem_mm
	elseif strChannelID == "U005" then	
		g_nGiftCount = #g_tableGiftItem_EgameFee
		g_tableGiftItem = g_tableGiftItem_EgameFee
	end
	
	
	
	for i = 1, g_nGiftCount, 1 do	
		offset_x = math.floor(i % 2 ~= 0 and i / 2 or i / 2 - 1) * 200	
		offset_y = (i % 2 == 0 and 4 or 164)
		
		local Function = string.format("%s%d%s","Click_PurchaseGiftBoxItem(", i,")")		
		
		g_Shop_Main[8]:AddItemSelect9Patch("uishangcheng_libaodikuang.png", "uishangcheng_libaodikuang.png", pos_x + offset_x + 76, pos_y + offset_y + 70, 152, 140, 2, Function)	
		g_Shop_Main[8]:AddImage9Patch(g_tableGiftItem[i].ICON_ID, pos_x + offset_x + 42, pos_y + offset_y + 44, 2, 66, 72, false)
		g_Shop_Main[8]:AddItemText(g_tableGiftItem[i].NAME, pos_x + offset_x, pos_y + offset_y + 110, 152, 25,"241 255 85", 18, "Center")
		-- g_Shop_Main[8]:AddImage9Patch(g_tableGiftItem[i].SALES_PROMOTION, pos_x + offset_x + 5, pos_y + offset_y + 82, 2, 52, 54)		
		g_Shop_Main[8]:AddImage9Patch("uishangcheng_libaomemgban.png", pos_x + offset_x, pos_y + offset_y, 2, 152, 44, true)			
		g_Shop_Main[8]:AddImage9Patch("uishangcheng_huobi.png", pos_x + offset_x + 46, pos_y + offset_y + 10, 2, 12, 17, true)					
		g_Shop_Main[8]:AddItemBMFont(g_tableGiftItem[i].PRICE, pos_x + offset_x + 30, pos_y + offset_y + 5, 100, 30, "fonts/ui_shangchengshuzi.fnt", "1.5")			
		if i % 2 ~= 0 then
			content_width = content_width + 200
		end
	end 
	if content_width < display_width then
		content_width = display_width	
	end
	g_Shop_Main[8]:SetContentSize(content_width, content_height)	
end 

--===============================================
-- 					购买礼包物品
--===============================================
function Click_PurchaseGiftBoxItem(_index)

	--PushToast("#{GUSS_1000_010}")
	Shop_ShowGoodsDetail()
	
	local g_tableGiftItem = {}
	local strChannelID = JavaJni:GetChannelID()
	if strChannelID == "U004" then
		g_tableGiftItem = g_tableGiftItem_cmgame
	elseif strChannelID == "U003" then
		g_tableGiftItem	 = g_tableGiftItem_mm
	elseif strChannelID == "U005" then
		g_tableGiftItem	 = g_tableGiftItem_EgameFee
	end
	
	g_Shop_Main[5]:SetAtlasTexture(g_tableGiftItem[_index].ICON_ID)
	g_Shop_Main[7]:SetText(g_tableGiftItem[_index].DESC)
	g_Shop_Main[10]:SetText(g_tableGiftItem[_index].NAME)
	
	g_nGiftItemIndex = _index
end

--===============================================
-- 				购买充值物品 【能量球】
--===============================================
function Click_PurchaseTopupItem(_index)
	
	Shop_ShowGoodsDetail()
	
	
	local g_nShopTopupItemPurchaseInfo = {}
	local strChannelID = JavaJni:GetChannelID()
	if strChannelID == "U004" then
		g_nShopTopupItemPurchaseInfo = g_nShopTopupItemPurchaseInfo_cmgame
	elseif strChannelID == "U003" then
		g_nShopTopupItemPurchaseInfo	 = g_nShopTopupItemPurchaseInfo_mm
	elseif strChannelID == "U005" then
		g_nShopTopupItemPurchaseInfo	 = g_nShopTopupItemPurchaseInfo_EgameFee
	end
	
	
	g_Shop_Main[5]:SetAtlasTexture("t_zymbptb.png")
	g_Shop_Main[7]:SetText(g_nShopTopupItemPurchaseInfo[_index].DESC)
	g_Shop_Main[10]:SetText("")	
	
	g_nTopupItemIndex = _index
end

--===============================================
-- 					显示充值列表
--===============================================
function	Shop_ShowTopUpList()
	local X, Y = 0, 155
	local display_width = 713
	local content_width, content_height = 0, 318
	
	local g_nShopTopupItemPurchaseInfo = {}
	local tableCount = 0
	
	local strChannelID = JavaJni:GetChannelID()
	if strChannelID == "U004" then
		tableCount = #g_nShopTopupItemPurchaseInfo_cmgame
		g_nShopTopupItemPurchaseInfo = g_nShopTopupItemPurchaseInfo_cmgame
	elseif strChannelID == "U003" then
		tableCount = #g_nShopTopupItemPurchaseInfo_mm
		g_nShopTopupItemPurchaseInfo	 = g_nShopTopupItemPurchaseInfo_mm
	elseif strChannelID == "U005" then
		tableCount = #g_nShopTopupItemPurchaseInfo_EgameFee
		g_nShopTopupItemPurchaseInfo	 = g_nShopTopupItemPurchaseInfo_EgameFee
	end
	
	
	
	for i = 1, tableCount, 1 do
		local Function = string.format("%s%d%s","Click_PurchaseTopupItem(", i,")")		
		--g_Shop_Main[8]:AddButton9Patch("shop_paydi.png", "shop_paydi.png", X + (((i > 6 and i - 6) or i) - 1) * 240, Y - ((i > 6 and 1) or 0) * 157, Function, 234, 152, 2)			
		
		g_Shop_Main[8]:AddItemSelect9Patch("shop_paydi.png", "shop_paydi.png", X + 112+(((i > 6 and i - 6) or i) - 1) * 240, Y+80 - ((i > 6 and 1) or 0) * 157, 234, 152, 2, Function)
		g_Shop_Main[8]:AddItemBMFont(g_nShopTopupItemPurchaseInfo[i].POWER, X + 110 + (((i > 6 and i - 6) or i) - 1) * 240, Y + 100 - ((i > 6 and 1) or 0) * 157, 100, 30, "fonts/font_gree_topup.fnt", "0.6")	
		g_Shop_Main[8]:AddItemBMFont(g_nShopTopupItemPurchaseInfo[i].GIFT, X + 100 + (((i > 6 and i - 6) or i) - 1) * 240, Y + 55 - ((i > 6 and 1) or 0) * 157, 100, 30, "fonts/font_yellow_topup.fnt", "0.6")	

		g_Shop_Main[8]:AddImage9Patch("uishangcheng_huobi.png", X + 90 + (((i > 6 and i -6) or i) - 1) * 240, Y + 20 - ((i > 6 and 1) or 0) * 157, 2, 12, 17, true)					
		g_Shop_Main[8]:AddItemBMFont(g_nShopTopupItemPurchaseInfo[i].MONEY, X + 75 + (((i > 6 and i - 6) or i) - 1) * 240, Y + 15 - ((i > 6 and 1) or 0) * 157, 100, 30, "fonts/ui_shangchengshuzi.fnt", "1.5")			
	end	
	if i % 2 ~= 0 then
		content_width = content_width + 280
	end
	if content_width < display_width then
		content_width = display_width	
	end
	g_Shop_Main[8]:SetContentSize(content_width, 318)	
	g_Shop_Main[8]:SetContentOffset(0, 0)

end

--===============================================
-- 			平台币不足 跳转到充值界面
--===============================================
function	Shop_Buy_Money()
	Shop_TopUpLabel_Click()
end

--===============================================
--- 			关闭当前界面 回到主界面
--===============================================
function	Shop_Close()
	g_Shop_Main[2]:StopTime()
	
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
	
	g_Shop_Main[8]:SetContentOffset(0, 0)

	g_nGiftItemIndex  = 0
	g_nTopupItemIndex = 0
end

--===============================================
-- 			 	点击礼包标签
--===============================================
function	Shop_GiftBoxLabel_Click()
	g_nCurLoadedPageID = g_nTypePage.TYPEPAGE_GIFTBOX
	
	g_Shop_Button[2]:ResetZOrder(7)
	g_Shop_Button[3]:ResetZOrder(5)	
	
	g_Shop_Main[8]:CleanAllElement()
	Shop_ShowGiftBoxList()
end

--===============================================
--		 		点击充值标签
--===============================================
function	Shop_TopUpLabel_Click()
	g_nCurLoadedPageID = g_nTypePage.TYPEPAGE_TOPUP	
	
	g_Shop_Button[2]:ResetZOrder(5)
	g_Shop_Button[3]:ResetZOrder(7)	

	g_Shop_Main[8]:CleanAllElement()
	
	Shop_ShowTopUpList()
end

--===============================================
--		 		 隐藏物品详情事件
--===============================================
function	Shop_OnGoodsDescCloseEvent()
		Shop_HideGoodsDetail()
end

--===============================================
--		 		   第一次加载数据
--===============================================
function	Shop_OnLoadFirstEvent()
	Shop_ShowCurTypePage(g_nLoadedFirstPageID)
end

--===============================================
--		 		   详情面板的确定购买事件 
--===============================================
function	Shop_OnConfirmEvent()
	local strChannelID = JavaJni:GetChannelID() 						    		-- 获得渠道ID
	local nServerID = tonumber(GetSharedUserForKey("server_index", "-1")) 		-- 服务器ID
	
	local g_tableGiftItem = {}
	local g_nShopTopupItemPurchaseInfo = {}
	
	local strChannelID = JavaJni:GetChannelID()
	if strChannelID == "U004" then
		g_nShopTopupItemPurchaseInfo = g_nShopTopupItemPurchaseInfo_cmgame
		g_tableGiftItem = g_tableGiftItem_cmgame
	elseif strChannelID == "U003" then
		g_nShopTopupItemPurchaseInfo	 = g_nShopTopupItemPurchaseInfo_mm
		g_tableGiftItem	 = g_tableGiftItem_mm
	elseif strChannelID == "U005" then
		g_nShopTopupItemPurchaseInfo	 = g_nShopTopupItemPurchaseInfo_EgameFee
		g_tableGiftItem	 = g_tableGiftItem_EgameFee
		return
	else
		return
	end
	
	
	
	----请求支付购买物品
	if g_nCurLoadedPageID == g_nTypePage.TYPEPAGE_GIFTBOX then
		SuperTooltips:SendPayItem(strChannelID, tostring(g_tableGiftItem[g_nGiftItemIndex].GOODS_SUB_ID), nServerID)
	elseif g_nCurLoadedPageID == g_nTypePage.TYPEPAGE_TOPUP then
		SuperTooltips:SendPayItem(strChannelID, tostring(g_nShopTopupItemPurchaseInfo[g_nTopupItemIndex].GOODS_SUB_ID), nServerID)		
	end
	
	OpenRequestWaitProgress()	

	Shop_HideGoodsDetail()
	
end

	



