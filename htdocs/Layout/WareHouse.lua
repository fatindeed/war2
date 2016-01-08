local g_WareHouse_TextBox = {}	
local g_WareHouse_ImageBox = {}
local g_WareHouse_ProgressBar = {}

function	WareHouse_PreLoad()
	this:RegisterEvent("WAREHOUSE_LOAD")
end

function	WareHouse_OnLoad()
	g_WareHouse_TextBox[1] = WareHouse_Title_Text  				 --����
	g_WareHouse_TextBox[2] = WareHouse_Population_Value			 --�˿�
	g_WareHouse_TextBox[3] = WareHouse_Construct_Button_Text	 --���������ı�
	g_WareHouse_TextBox[4] = Home_Iron_Text					 	 --���������ı�
	g_WareHouse_TextBox[5] = Home_Oil_Text					     --ʯ�͵������ı�
	g_WareHouse_TextBox[6] = WareHouse_Construct_Button 		 -- ��������		
		
	g_WareHouse_ProgressBar[1] = Home_Name_IronBar				 --������������
	g_WareHouse_ProgressBar[2] = Home_Name_OilBar				 --ʯ������������
end

function	WareHouse_OnEvent(event)
	if ( event == "WAREHOUSE_LOAD" ) then
		this:Show()
		if(arg0 ~= nil)then
			WareHouse_ReadData(tonumber(arg0))
		end
	end
end

--********************************************
--					������Դ���� 
--********************************************
function	WareHouse_ReadData(arg)
	local ironCount = Player:GetIron()
	local ironMaxCount = Player:GetIronLimit()		
	local oilCount = Player:GetOil()
	local oilMaxCount = Player:GetOilLimit()
	
	if (math.floor(ironMaxCount) <= 0 or math.floor(oilMaxCount) <= 0) then
		return
	end
	
	g_WareHouse_TextBox[6]:Hide()  -- ���ؽ��찴��
	
	local NAME, WORKPERSON = BuildData:GetBuildInfo("WareHouse_Title", arg)
	g_WareHouse_TextBox[1]:SetText(NAME)
	g_WareHouse_TextBox[2]:SetText("-" .. WORKPERSON)
	g_WareHouse_TextBox[3]:SetText("#{TXSS_1000_040}")

	-- ��ֹ����Դ����С�ڵ�����
	if ironMaxCount <= 0 then
		return	
	end
	-- ��ֹ����Դ��ǰֵ��������
	local toPercent = ironCount <= ironMaxCount and ironCount * 100 / ironMaxCount or 100 
	g_WareHouse_ProgressBar[1]:RunFromTo(0, toPercent, 1)
	g_WareHouse_TextBox[4]:SetText("#{TXSS_1000_028}:" .. " " .. ironCount.. "/" .. ironMaxCount)
	
	-- ��ֹʯ����Դ����С�ڵ�����
	if oilMaxCount <= 0 then
		return	
	end
	-- ��ֹʯ����Դ��ǰֵ��������
    toPercent = oilCount <= oilMaxCount and oilCount * 100 / oilMaxCount or 100 
	g_WareHouse_ProgressBar[2]:RunFromTo(0, toPercent, 1)
	g_WareHouse_TextBox[5]:SetText("#{TXSS_1000_029}:" .. " " .. oilCount.. "/" .. oilMaxCount)
end


--********************************************
--				 �رմ���
--********************************************
function WareHouse_Close()
	g_WareHouse_ProgressBar[1]:RunFromTo(100,0,0)
	g_WareHouse_ProgressBar[2]:RunFromTo(100,0,0)	
	this:Hide()

	BuildData:UnMainTarget()		
end