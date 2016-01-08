local g_WareHouse_TextBox = {}	
local g_WareHouse_ImageBox = {}
local g_WareHouse_ProgressBar = {}

function	WareHouse_PreLoad()
	this:RegisterEvent("WAREHOUSE_LOAD")
end

function	WareHouse_OnLoad()
	g_WareHouse_TextBox[1] = WareHouse_Title_Text  				 --标题
	g_WareHouse_TextBox[2] = WareHouse_Population_Value			 --人口
	g_WareHouse_TextBox[3] = WareHouse_Construct_Button_Text	 --创建按键文本
	g_WareHouse_TextBox[4] = Home_Iron_Text					 	 --铁的数量文本
	g_WareHouse_TextBox[5] = Home_Oil_Text					     --石油的数量文本
	g_WareHouse_TextBox[6] = WareHouse_Construct_Button 		 -- 创建按键		
		
	g_WareHouse_ProgressBar[1] = Home_Name_IronBar				 --铁数量进度条
	g_WareHouse_ProgressBar[2] = Home_Name_OilBar				 --石油数量进度条
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
--					载入资源数据 
--********************************************
function	WareHouse_ReadData(arg)
	local ironCount = Player:GetIron()
	local ironMaxCount = Player:GetIronLimit()		
	local oilCount = Player:GetOil()
	local oilMaxCount = Player:GetOilLimit()
	
	if (math.floor(ironMaxCount) <= 0 or math.floor(oilMaxCount) <= 0) then
		return
	end
	
	g_WareHouse_TextBox[6]:Hide()  -- 隐藏建造按键
	
	local NAME, WORKPERSON = BuildData:GetBuildInfo("WareHouse_Title", arg)
	g_WareHouse_TextBox[1]:SetText(NAME)
	g_WareHouse_TextBox[2]:SetText("-" .. WORKPERSON)
	g_WareHouse_TextBox[3]:SetText("#{TXSS_1000_040}")

	-- 防止铁资源上限小于等于零
	if ironMaxCount <= 0 then
		return	
	end
	-- 防止铁资源当前值大于上限
	local toPercent = ironCount <= ironMaxCount and ironCount * 100 / ironMaxCount or 100 
	g_WareHouse_ProgressBar[1]:RunFromTo(0, toPercent, 1)
	g_WareHouse_TextBox[4]:SetText("#{TXSS_1000_028}:" .. " " .. ironCount.. "/" .. ironMaxCount)
	
	-- 防止石油资源上限小于等于零
	if oilMaxCount <= 0 then
		return	
	end
	-- 防止石油资源当前值大于上限
    toPercent = oilCount <= oilMaxCount and oilCount * 100 / oilMaxCount or 100 
	g_WareHouse_ProgressBar[2]:RunFromTo(0, toPercent, 1)
	g_WareHouse_TextBox[5]:SetText("#{TXSS_1000_029}:" .. " " .. oilCount.. "/" .. oilMaxCount)
end


--********************************************
--				 关闭窗口
--********************************************
function WareHouse_Close()
	g_WareHouse_ProgressBar[1]:RunFromTo(100,0,0)
	g_WareHouse_ProgressBar[2]:RunFromTo(100,0,0)	
	this:Hide()

	BuildData:UnMainTarget()		
end