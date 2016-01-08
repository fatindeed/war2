local g_CommonTip_Main = {}	

local g_EventType 	    = ""	    -- ȫ���¼�����

local g_Buy_Index 	    = -1		-- ��������
local g_Buy_Type  	    = -1		-- ��������
local g_Ptb		  	    = -1		-- ����ƽ̨��

local g_Build_Createing = 0			-- ����������...
local g_Build_Producing = 6			-- ����������...

local g_Create_Build	= 0			-- ���콨��
local g_Add_Speed 		= 1 		-- �������
local g_Solider_Buy		= 2			-- ѵ���շ�ʿ��/̹��
local g_ShopGift_Buy	= 3			-- �̵��������
local g_ShopTopup_Buy   = 4			-- �̵��ֵ����

local g_Shop_Const		= 0			-- �һ�����

local g_Need_Resource = -1

local g_FrameInfo = -1;

local g_ResourceIndex = 1		-- ��Դ��Ӧ������index

local FrameInfoList =
{
	zhiyuandian = 1				-- ��Դ��
}

local g_nShopTopupItemPurchaseInfo =		-- �̵��ֵ��Ʒ������Ϣ		  �������������� 
{
	{MONEY = 10,   POWER = 100,   GIFT = 5},	-- ƽ̨��  ������  ����ֵ
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
	g_CommonTip_Main[2] = CommonTip_Mask					-- ��ɫ��͸���ɰ�
	g_CommonTip_Main[3] = CommonTip_BG						-- ������
	g_CommonTip_Main[4] = CommonTip_Confirm_Button			-- ȷ�ϰ���
	g_CommonTip_Main[5] = CommonTip_Confirm_Button_Text		-- ȷ�ϰ����ı�
	g_CommonTip_Main[6] = CommonTip_Cancel_Button			-- ȡ������
	g_CommonTip_Main[7] = CommonTip_Cancel_Button_Text  	-- ȡ�������ı�	

	g_CommonTip_Main[9] = CommonTip_ToBuild_Button			-- ���찴��
	g_CommonTip_Main[10] = CommonTip_ToBuild_Button_Text	-- ���찴���ı�
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
			
			g_CommonTip_Main[3]:PopUp(0.2)	      		-- ��������
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
			g_CommonTip_Main[3]:PopUp(0.2)	      		-- ��������	
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
			
			g_Buy_Type  = tonumber( arg0 )	-- ��������
			g_Buy_Index = tonumber( arg1 )	-- ��������
				
			CommonTip_AnalyzeData(g_Buy_Type,g_Buy_Index)	
			
			g_CommonTip_Main[3]:PopUp(0.2)		-- ��������
			
			--��������
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

		g_CommonTip_Main[3]:PopUp(0.2)	--��������
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
			g_CommonTip_Main[3]:PopUp(0.2)	-- ��������
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
-- 				�����¼�����
--========================================
function	CommonTip_SetEventType(event)
	g_EventType = event
end

--========================================
--		  ��ʾȫ����͸����ɫģ��
--========================================
function  CommonTip_ShowMask()
	g_CommonTip_Main[2]:Show()
	g_CommonTip_Main[2]:SetScale(40)
	g_CommonTip_Main[2]:SetOpacity(200)	
end

--========================================
--		  ��ʾȫ����͸����ɫģ��
--========================================
function  CommonTip_HideMask()
	g_CommonTip_Main[2]:Hide()
end

--========================================
-- 			�۷����ͷ��� -- ���� ����
--========================================
function	CommonTip_AnalyzeData(tTYPE,tIndex)	
	if tTYPE == g_Create_Build then			-- ��������
		CommonTip_CreateBuild(tIndex)
	elseif tTYPE == g_Add_Speed then		-- ��������
		CommonTip_AddSpeed()
	elseif tTYPE == g_Solider_Buy then		-- ѵ������
		CommonTip_TrainSolider(tIndex)
	elseif tTYPE == g_ShopGift_Buy then		-- �̵��������
		CommonTip_PurchaseGiftBoxItem(tIndex)
	elseif tTYPE == g_ShopTopup_Buy then	-- �̵��ֵ����
		CommonTip_PurchaseTopupItem(tIndex)
	end
end

--========================================
--				�����̵����
--========================================
function	CommonTip_PurchaseGiftBoxItem(tIndex)
	g_CommonTip_Main[1]:SetText("#{TXSS_1000_039}".. 100 .."#{TXSS_1000_030}".."?")
end

--========================================
--				�����̵��ֵ��Ʒ
--========================================
function	CommonTip_PurchaseTopupItem(tIndex)
	
	g_CommonTip_Main[1]:SetText("#{TIP_1000_045}".. g_nShopTopupItemPurchaseInfo[tIndex].POWER .."#{TXSS_1000_030}".."?")
end

--========================================
--				ѵ���շ�ʿ��
--========================================
function	CommonTip_TrainSolider(tIndex)
	g_Ptb = Solider:GetMilitaryInfo("Use_Money",tIndex)
	g_CommonTip_Main[1]:SetText("#{TXSS_1000_039}"..g_Ptb.."#{TXSS_1000_030}".."!")
end

--========================================
--				������������
--========================================
function	CommonTip_CreateBuild(tIndex)
	g_Ptb = BuildData:GetBuildInfo("Use_Money",tIndex)
	g_CommonTip_Main[1]:SetText("#{TXSS_1000_039}".. g_Ptb .."#{TXSS_1000_030}".."!")	
end

--========================================
--				��������
--========================================
function	CommonTip_AddSpeed()
	local tState  =	BuildData:GetMainTargetBuildState("MainTargetBuild_State_ID")
	---		��ȡ�һ�����
	if g_Shop_Const == 0 then
			g_Shop_Const = 	600000 --GetExchangeValue()	-- ��������Ҫ�� --[ÿ���������Ӧ�ļ���ʱ��(��λ:�� 600��һ��������)]-- 
	end	
	if tState == g_Build_Createing then		------------------------ ������ 
		local uResTime = BuildData:GetMainTargetBuildState("MainTargetBuild_ConstructTime")
		local uPtb = uResTime / g_Shop_Const

		g_Ptb = math.ceil(uPtb)
		g_CommonTip_Main[1]:SetText("#{TXSS_1000_039}"..g_Ptb.."#{TXSS_1000_030}".."!")	
	elseif tState == g_Build_Producing then	------------------------ ������ 
		local uResTime = BuildData:GetMainTargetBuildState("MainTargetBuild_ProduceTime")	
		local uPtb = math.floor(uResTime / g_Shop_Const) + 1

		g_Ptb = uPtb
		g_CommonTip_Main[1]:SetText("#{TXSS_1000_039}"..g_Ptb.."#{TXSS_1000_030}".."!")			
	end
end

--===================================================
--					ȷ���¼�
--===================================================
function	CommonTip_Confirm_Click()
	if g_EventType == "COMMON_TIP_BUY" then
		if g_Buy_Type == g_Create_Build then		-- ��������
			local mPtb	=	Player:GetDiamond()						
			
			if mPtb >= g_Ptb then
				-- ȷ������				
				Move_OK()		
			else
				-- ����ƽ̨�Ҳ������ʾ��
				PushEvent("COMMON_TIP_TOBUY")
			end
		elseif g_Buy_Type == g_Add_Speed then		-- ��������
			local mPtb	=	Player:GetDiamond()
					
			if mPtb >= g_Ptb then
				BuildData:ProduceAddSpeed()	
			else
				-- ����ƽ̨�Ҳ������ʾ��				
				PushEvent("COMMON_TIP_TOBUY")
			end
		elseif	g_Buy_Type == g_Solider_Buy then	-- ѵ������
			local mPtb = Player:GetDiamond()
			
			if mPtb >= g_Ptb then
				BuildData:TrainSoliderSubmit(g_Buy_Index)	
			else
				-- ����ƽ̨�Ҳ������ʾ��				
				PushEvent("COMMON_TIP_TOBUY")
			end
		elseif	g_Buy_Type == g_ShopGift_Buy then		-- �̵��������			

		elseif	g_Buy_Type == g_ShopTopup_Buy then		-- �̵��ֵ����

			PushToast("#{TIP_1000_042}" .. g_nShopTopupItemPurchaseInfo[g_Buy_Index].POWER)			
		end
	elseif g_EventType == "COMMON_TIP_TOBUY" then

		-- ��ת����ֵ����
		PushEvent("SHOP_LOAD", 2)	
	elseif g_EventType == "COMMON_TIP_RESOURCE" then
	
		-- ��ת����ֵ����		
		PushEvent("SHOP_LOAD", 2)
	elseif	g_EventType == "COMMON_TIP_BUYSUCCESS" then

	elseif  g_EventType == "COMMON_TIP_TOSELL" then
		Move_Sell()		
		PushEvent("MOVE_MENU_UNLOAD")
	end
	this:Hide()	
end

--==================================================
--					ȡ���¼� 
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
--				��ʾ[ȷ��]����
--===================================================
function	CommonTip_ShowButton_Confirm()

	g_CommonTip_Main[4]:Show()		
	g_CommonTip_Main[5]:SetText("#{TXSS_1000_043}")
end

--===================================================
--				����[ȷ��]����
--===================================================
function	CommonTip_HideConfirm()
	g_CommonTip_Main[4]:Hide()
end

--===================================================
--				��ʾ[ȡ��]����
--===================================================
function	CommonTip_ShowButton_Cancel()
	g_CommonTip_Main[6]:Show()
	g_CommonTip_Main[7]:SetText("#{TXSS_1000_041}")
end

--===================================================
--				����[ȡ��]����
--===================================================
function	CommonTip_HideCancel()
	g_CommonTip_Main[6]:Hide()
end

--===================================================
--				��ʾ[��������]����
--===================================================
function	CommonTip_ShowButton_Build()
	g_CommonTip_Main[9]:Show()
	g_CommonTip_Main[10]:SetText("#{TXSS_1000_040}")
end

--===================================================
--				����[��������]����
--===================================================
function	CommonTip_HideButton_Build()
	g_CommonTip_Main[9]:Hide()
	g_CommonTip_Main[10]:Hide()	
end

--===================================================
--	2013��5��20��
--	by Ѧ����	
--	��ת�������������	
--===================================================
function	CommonTip_ToBuildHouse()
	this:Hide()
	PushEvent("BUILD_CHOOSE_TOBUILD", 3, g_ResourceIndex)			
end

--========================================
--				�رմ���
--========================================
function	CommonTip_Close()
	if g_CommonTip_Main[3]:NumberOfRunningActions() ~= 0 then
		return		
	end
	-- ��������
	g_CommonTip_Main[3]:PopDown(0.2)			    
		
	if(g_FrameInfo == FrameInfoList.zhiyuandian) then
		return
	end
	
	-- this:Hide()
	local buildID = BuildData:GetMainTargetBuildState("MainTargetBuild_ID")
	-- ����Դ�ཨ����������洢���ޣ�ж����Ŀ��	
	if (buildID >= 12 and buildID <= 19) then	 
		BuildData:UnMainTarget()
	end
	g_Need_Resource = -1
end

--=========================================
--			  ��Դ������ʾ��
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