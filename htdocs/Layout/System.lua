local 	g_System_Windows = {}

local 	g_metaListItemNameTable = {"#{UISZ_1000_001}", "#{SYST_1000_001}", "#{TXSS_2000_003}"}

function	System_PreLoad()
	this:RegisterEvent("SYSTEM_LOAD")					-- 载入窗口
end

function	System_OnLoad()
	g_System_Windows[1] = System_Mask					-- 蒙板
	g_System_Windows[2] = System_Title					-- 标题
	g_System_Windows[3] = System_List					-- 选项列表
end

function	System_OnEvent(event)
	if event == "SYSTEM_LOAD" then	
		System_Init()		
		System_LoadList()
		this:Show()
		System_ShowMask()	
	end
end

--========================================
--		   显示全屏半透明灰色模板
--========================================
function	System_ShowMask()
	g_System_Windows[1]:Show()
	g_System_Windows[1]:SetScale(40)
	g_System_Windows[1]:SetOpacity(200)	
end

--=========================================
--				初始化
--=========================================
function 	System_Init()
	g_System_Windows[2]:SetText("#{CHAT_1000_004}")
end

--=========================================
--				载入列表
--=========================================
function	System_LoadList()
	local offsetX 		= 0
	local offsetY 		= 0
	local ContentHeight = 184
	local nItemCount 	= 0
	local n_ChannelID = JavaJni:GetChannelID()
		
	if n_ChannelID == "U003"  or n_ChannelID == "U005" then
		nItemCount = 2
	elseif n_ChannelID == "U002" then	
		nItemCount = 3
	end
	
	-- 重置服务器列表的索引
	g_ServerListIndex 	= -1
	-- 清空列表数据
	g_System_Windows[3]:CleanAllElement()	
	
	for i = nItemCount, 1, -1 do
		System_AddListItem(i, offsetX, offsetY)
		offsetY = offsetY + 46
	end
	if offsetY > ContentHeight then
		ContentHeight = offsetY	
	end
	g_System_Windows[3]:SetContentSize(278, ContentHeight) -- 设置内容长度
	if offsetY > 230 then
		g_System_Windows[3]:SetContentOffset(0, -(offsetY - 184))	
	else
		g_System_Windows[3]:SetContentOffset(0, ContentHeight - offsetY)
		g_System_Windows[3]:Touch(-1)
	end
	-- g_System_Windows[3]:SetSelectItem(1)	
end

--=======================================
--				添加列表项
--=======================================
function	System_AddListItem(index, pos_x, pos_y)

	local Function = string.format("%s%d%s","System_OnListItemEvent(",index,")")
	g_System_Windows[3]:AddItemSelect9Patch("uidenglu_fuwuqibiankuang.png", "uidenglu_fuwuqibiankuangxia.png", pos_x + 138, pos_y + 29, 276, 34, 4, Function)
	
	g_System_Windows[3]:AddItemText(g_metaListItemNameTable[index], pos_x, pos_y + 15, 276, 34, "255 255 255", 20, "Center")	
end

--=======================================
--				点击列表项事件
--=======================================
function	System_OnListItemEvent(cell_index)
	if cell_index == 1 then
		PushEvent("SETTINGS_LOAD")
	elseif cell_index == 2 then
		GoBackLoginWindow()
    elseif cell_index == 3 then
		local n_ChannelID = JavaJni:GetChannelID()
		if n_ChannelID == "U001" then
			--JavaJni:ShowAboutWindow("#{TXSS_2000_075}")	
		elseif n_ChannelID == "U002" then
			JavaJni:ShowAboutWindow("#{TXSS_2000_004}")	
		end	
	end
	System_CloseWindow()	
end

--========================================
--		   		关闭界面事件
--========================================
function System_OnCloseEvent()
	System_CloseWindow()
end


function System_CloseWindow()
	this:Hide()
end