local g_CostLack_Main = {}	

local g_EventType = ""				--ȫ���¼�����


function	CostLack_PreLoad()
	this:RegisterEvent("COST_LACK_LOAD")
end

function	CostLack_OnLoad()
	g_CostLack_Main[1] = CostLack_Title
	g_CostLack_Main[2] = CostLack_Gold_Img
	g_CostLack_Main[3] = CostLack_Gold_Text
	g_CostLack_Main[4] = CostLack_Iron_Img
	g_CostLack_Main[5] = CostLack_Iron_Text
	g_CostLack_Main[6] = CostLack_Oil_Img
	g_CostLack_Main[7] = CostLack_Oil_Text	
	g_CostLack_Main[8] = CostLack_Content	--����ȱ�ٵ���Դ���ı�
	g_CostLack_Main[9] = CostLack_Pay_Button_Text	--��ֵ�����ı�
	g_CostLack_Main[10] = CostLack_PayButtonTip_Text	--��ʾ��ֵ�ı�	
end

function	CostLack_OnEvent(event)
	if event == "COST_LACK_LOAD" then
		if arg0 == nil then
			return			
		end	
		this:Show()		
		g_CostLack_Main[1]:SetText("#{TXSS_2000_046}")  --��Դ����
		g_CostLack_Main[10]:SetText("#{TXSS_2000_057}") --����ȫ����Դ�����Ͽ�ʼ����
		local ItemID = tonumber(arg0)
		local _, _, _, _, _, BuildCoin, _, Iron, Oil, _, _= BuildData:GetBuildInfo("BuildDesc_DetailInfo", ItemID)				
		local TotalCost = 0--�ܵĻ��� 
		if BuildCoin > 0 then
			g_CostLack_Main[2]:Show()			
			g_CostLack_Main[3]:SetText(BuildCoin)
			TotalCost = TotalCost + BuildCoin
		else
			g_CostLack_Main[2]:Hide()
			g_CostLack_Main[3]:Hide()
		end
		if Iron > 0 then
			g_CostLack_Main[4]:Show()
			g_CostLack_Main[5]:SetText(Iron)	
			TotalCost = TotalCost + Iron			
		else
			g_CostLack_Main[4]:Hide()
			g_CostLack_Main[5]:Hide()			
		end
		if Oil > 0 then
			g_CostLack_Main[6]:Show()
			g_CostLack_Main[7]:SetText(Oil)	
			TotalCost = TotalCost + Oil				
		else
			g_CostLack_Main[6]:Hide()
			g_CostLack_Main[7]:Hide()							
		end
		g_CostLack_Main[9]:SetText(TotalCost)
	end
end

-- �����¼�����
function	CostLack_SetEventType(event)
	g_EventType = event
end

--******************************
--					�رմ���
--******************************
function	CostLack_Close()
	this:Hide()
end
