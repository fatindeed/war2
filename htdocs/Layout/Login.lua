
local g_Login_Main = {}
local g_ServerListIndex = -1 	-- 服务器列表的索引
local g_selectServerIndex = -1	-- 当前选择服务器索引

local g_helpKickCount = -1
local g_aboutKickCount = -1

local LOGIN_SERVER_FULL	  = 0 	-- 爆满
local LOGIN_SERVER_BUSY   = 1 	-- 拥挤
local LOGIN_SERVER_NORMAL = 2	-- 流畅
local LOGIN_SERVER_NEW    = 3	-- 新服
local LOGIN_SERVER_STOP   = 4	-- 维护

local g_CurServerInfo = 		-- 当前服务器信息
{
	g_CurServerID,				-- 服务器ID
    g_CurServerName,			-- 服务器名字
	g_CurServerColor,			-- 服务器颜色
	g_CurServerState			-- 服务器状态
}

function Login_PreLoad()
	this:RegisterEvent("LOGIN_LOAD")
end

function Login_OnLoad()
	g_Login_Main[1] = Login_Register_Btn				-- 快速注册 按键
	g_Login_Main[2] = Login_Register_Btn_Text			-- 快速注册 文本【字典】
	g_Login_Main[3] = Login_TextBox_Version   			-- 版本号
	g_Login_Main[4] = Login_ServerList_Desc				-- 服务器列表  文本【字典】
	g_Login_Main[5] = Login_Confirm_ServerNameState		-- 服务器名字和状态的文本框 {选中区}
	g_Login_Main[6] = Login_ServerList_CurServerDesc	-- 最近登录服务器 文本 【字典】
	g_Login_Main[7] = Login_Scroll_ServerList			-- 服务器列表滚动视窗
	g_Login_Main[8] = Login_ServerList_CurServerText	-- 服务器列表 当前服务器名
	g_Login_Main[9] = Login_Logo						-- 标题图标
	g_Login_Main[10] = Login_ServerList_BG				-- 服务器列表背景
	g_Login_Main[11] = Login_Login_Text					-- 登陆按键文本  【字典】
	g_Login_Main[12] = Login_SwitchServer				-- 切换服务器按键
	g_Login_Main[13] = Login_Login_Button				-- 登录服务器按键	
	g_Login_Main[14] = Login_About_Button				-- 关于按键			
	g_Login_Main[15] = Login_About_Text					-- 关于按键文本
	g_Login_Main[16] = Login_More_Button				-- 更多按键
	g_Login_Main[17] = Login_More_Text					-- 更多按键文本
	
	g_Login_Main[18] = Login_Help_Button				-- 帮助按键
	g_Login_Main[19] = Login_Help_Text
	g_Login_Main[20] = Login_Set_Button					--设置按键
	g_Login_Main[21] = Login_Set_Text
	
	g_Login_Main[22] = Login_Luntan_Button					--论坛按键
	g_Login_Main[23] = Login_Luntan_Text
	
	g_Login_Main[24] = Login_Help_BG                       --帮助信息
	g_Login_Main[25] = Login_Help_Tile
	g_Login_Main[26] = Login_Help_Detil
	g_Login_Main[27] = Login_Help_Info
	g_Login_Main[28] = Login_AboutShow_Timer
	--g_Login_Main[28] = Login_Help_Tile
	
end

function Login_OnEvent(event)
	if ( event == "LOGIN_LOAD" ) then
		this:Show()
		HideLoading()
		g_helpKickCount = -1
		g_aboutKickCount = -1
		
		
		g_Login_Main[1]:Hide()			-- 快速注册 按键
		
		g_selectServerIndex = tonumber(GetSharedUserForKey("server_index", "-1"))				

		--获得游戏版本号
		local version = GetVersion()
		g_Login_Main[3]:SetText(tostring(version))
		
		-- 获得默认服务器
		if g_selectServerIndex < 0 then
			g_selectServerIndex = 0		
		end
		 
		if g_selectServerIndex >= 0 then
			local ServerID, ServerName, ServerState = GameLogin:GetAreaLoginServerInfo(g_selectServerIndex)	
			local ServerStateName = Login_GetServerStateName(ServerState)
			local ServerColor = Login_GetServerStateColor(ServerState)
			g_Login_Main[5]:SetColor(ServerColor)			
			g_Login_Main[5]:SetText(ServerID.."#{TXSS_1000_072}".." "..ServerName.."  "..ServerStateName)
			GameLogin:SelectLoginServer(g_selectServerIndex)
			
			Login_SaveCurServerInfo(ServerID, ServerName, ServerColor, ServerStateName)
		end
		
		local u_Name = GetSharedUserForKey("user_name", "-1")
		local u_Pwd = GetSharedUserForKey("user_paswod", "-1")
		
		if u_Name ~= "-1" and u_Pwd ~= "-1" then
			g_Login_Main[2]:SetText(u_Name) -- 登录过的玩家显示登录名
		else
		    g_Login_Main[2]:SetText("") -- 账户登录        文本【字典】
		end
		--g_Login_Main[2]:SetText("#{UIDL_1000_006}") -- 账户登录        文本【字典】
		g_Login_Main[4]:SetText("#{UIDL_1000_013}") -- 服务器列表      文本【字典】
		g_Login_Main[6]:SetText("#{UIDL_1000_010}")	 -- 最近登录服务器  文本【字典】	
		g_Login_Main[11]:SetText("#{UIDL_1000_020}")  -- 登录按键文本    文本【字典】

		Login_HideServerList()

		Login_Init_AboutBtn()
		
		Login_Init_MoreBtn()
		
		Login_Init_SetHelpBtn()
		
		HideLoading()
		Help_Hide()
--		local u_Name = GetSharedUserForKey("user_name", "-1")
--		local u_Pwd = GetSharedUserForKey("user_paswod", "-1")
		
		if u_Name == "-1" or u_Pwd == "-1" then
			return
		end
	end
end

--====================================
--			初始化关于按键
--====================================
function Login_Init_AboutBtn()
	local n_ChannelID = JavaJni:GetChannelID()
	-- if n_ChannelID == "U002" then    -- 联通渠道
	--	g_Login_Main[14]:Show()
	--	g_Login_Main[15]:SetText("#{TXSS_2000_003}")		
	-- else
		g_Login_Main[14]:Hide()
		--if n_ChannelID == "U002" then -- 移动渠道
		--g_Login_Main[14]:Show()
		--g_Login_Main[15]:SetText("#{TXSS_2000_003}")			
	-- end
end

--====================================
--			初始化帮助和设置 论坛
--====================================
function Login_Init_SetHelpBtn()
	-- local n_ChannelID = JavaJni:GetChannelID()
	-- if n_ChannelID == "U003" then    -- 联通渠道
		g_Login_Main[18]:Hide()
		g_Login_Main[20]:Hide()
		g_Login_Main[22]:Hide()
	-- elseif n_ChannelID == "U002" then -- 移动渠道
		-- g_Login_Main[18]:Show()--帮助
		-- g_Login_Main[19]:SetText("#{CUPY_4000_071}")
		-- g_Login_Main[20]:Show()--设置
		-- g_Login_Main[21]:SetText("#{UISZ_1000_001}")
		-- g_Login_Main[22]:Show()--论坛
		-- g_Login_Main[23]:SetText("#{CUPY_4000_073}")
	-- end
end
--====================================
--		初始化更多按键
--====================================
function Login_Init_MoreBtn()
	local n_ChannelID = JavaJni:GetChannelID()
	-- if n_ChannelID == "U002" then    -- 联通渠道
		--g_Login_Main[16]:Show()
		--g_Login_Main[17]:SetText("#{CUPY_5000_194}")		
	-- else
		g_Login_Main[16]:Hide()
		--if n_ChannelID == "U002" then -- 移动渠道
		--g_Login_Main[14]:Show()
		--g_Login_Main[15]:SetText("#{TXSS_2000_003}")			
	-- end
end

--====================================
--			保存当前服务器信息
--====================================
function Login_SaveCurServerInfo(_serverID, _serverName, _serverColor, _serverState)
	g_CurServerInfo.g_CurServerID    = _serverID
	g_CurServerInfo.g_CurServerName  = _serverName
	g_CurServerInfo.g_CurServerColor = _serverColor
	g_CurServerInfo.g_CurServerState = _serverState
end

--====================================
--				登录点击事件
--====================================
function Login_Login()
	
	--- 请选择服务器
	if 	g_selectServerIndex == -1 then
		--PushMessageBox("#{TXSS_3000_003}")
		PushToast("#{TXSS_3000_003}")	
		return		
	end
	
	local useName = GetSharedUserForKey("user_name", "-1")
	local usePwd = GetSharedUserForKey("user_paswod", "-1")
	---账号不能为空	
	-- if  useName=="-1" then
		-- PushToast("#{TXSS_2000_048}")
		-- return	false
	-- end
	-- -- 密码不能为空
	-- if usePwd =="-1" then
		-- PushToast("#{TXSS_2000_049}")
		-- return false
	-- end
	
	--准备登陆
	GameLogin:LoginAccount(useName, usePwd)
	
	PushEvent("LOADINGWIDGET_LOAD")
	
	Guide_Init()--新手引导初始化
	
	--存储选择的服务器索引
	SetSharedUserForKey("server_index", g_selectServerIndex)

	this:Hide()
end

--===================================
--			 快速注册事件
--===================================
function	Login_OnRegisterEvent()
--	this:Hide()	
	
--	PushEvent("LOGINREGISTER_LOAD")
end


--添加服务器列表选项 
function    Login_AddServerListItem(ServerID, ServerIndex, ServerName, ServerState, x, y)

	local Function = string.format("%s%d%s","Login_OnClickServerList(",ServerIndex,")")
	g_Login_Main[7]:AddItemSelect9Patch("uidenglu_fuwuqibiankuang.png", "uidenglu_fuwuqibiankuangxia.png", x + 138, y + 29, 276, 34, 4, Function)
	
	local ServerStateName = Login_GetServerStateName(ServerState)
	local ServerColor = Login_GetServerStateColor(ServerState)
	g_Login_Main[7]:AddItemText(ServerID.."#{TXSS_1000_072}".."  "..ServerName.."  "..ServerStateName, x, y + 15, 276, 34, ServerColor, 20, "Center")
	
end

--显示服务器个数
function Login_ReadServerList()
	local offsetX = 0
	local offsetY = 0
	local ContentHeight = 184
	local count = GameLogin:GetServerAreaCount()
	-- 重置服务器列表的索引
	g_ServerListIndex = -1
	
	-- 清空列表数据
	g_Login_Main[7]:CleanAllElement()	
		
	for i = count - 1, 0, -1 do
		local ServerID, ServerName, ServerState = GameLogin:GetAreaLoginServerInfo(i)
		Login_AddServerListItem(ServerID, i, ServerName, ServerState, offsetX, offsetY)
		
		offsetY = offsetY + 46
	end
	
	if offsetY > ContentHeight then
		ContentHeight = offsetY	
	end
	g_Login_Main[7]:SetContentSize(278, ContentHeight) --设置内容长度
	if offsetY > 230 then
		g_Login_Main[7]:SetContentOffset(0, -(offsetY - 184))
		g_Login_Main[7]:Touch(1)	
	else
		g_Login_Main[7]:SetContentOffset(0, ContentHeight - offsetY)
		g_Login_Main[7]:Touch(-1)	
	end

	g_Login_Main[7]:SetSelectItem(count - ((g_selectServerIndex == -1 and 1) or g_selectServerIndex + 1))
end

--=================================
--          显示主界面
--=================================
function    Login_ShowMainWindow()
--	g_Login_Main[1]:Show()			-- 快速注册 按键
	g_Login_Main[9]:Show()			-- 标题图标
	g_Login_Main[13]:Show()			-- 登录服务器 按键
	g_Login_Main[12]:Show()			-- 切换服务器 按键	
end

--=================================
--          隐藏主界面
--=================================
function    Login_HideMainWindow()
	g_Login_Main[1]:Hide()			-- 快速注册 按键
	g_Login_Main[9]:Hide()			-- 标题图标
	g_Login_Main[13]:Hide()			-- 登录服务器 按键
	g_Login_Main[12]:Hide()			-- 切换服务器 按键	
end

-- 显示服务器列表
function    Login_ShowServerList()
	g_Login_Main[7]:Show()
	g_Login_Main[10]:Show()
	g_Login_Main[8]:Show()
	if g_CurServerInfo.g_CurServerID == nil then
		return	
	end
	g_Login_Main[8]:SetColor(tostring(g_CurServerInfo.g_CurServerColor))			
	
	g_Login_Main[8]:SetText(g_CurServerInfo.g_CurServerID.."#{TXSS_1000_072}".." "..g_CurServerInfo.g_CurServerName.."  "..g_CurServerInfo.g_CurServerState)
end

-- 隐藏服务器列表
function    Login_HideServerList()
	g_Login_Main[7]:Hide()
	g_Login_Main[10]:Hide()
end

-- 点击选择服务器开关
function 	Login_OnClickSwitchServer()
	Login_HideMainWindow()
	
	Login_ReadServerList()
	
	Login_ShowServerList()
end

-- 获得服务器状态名称
function   Login_GetServerStateName(StateIndex)
	if StateIndex == LOGIN_SERVER_FULL then   		-- 爆满
		return "#{TXSS_1000_074}"
	elseif StateIndex == LOGIN_SERVER_BUSY then		-- 拥挤
		return "#{TXSS_1000_075}"
	elseif StateIndex == LOGIN_SERVER_NORMAL then	-- 流畅
		return "#{TXSS_1000_076}"
	elseif StateIndex == LOGIN_SERVER_NEW then		-- 新服
		return "#{TXSS_1000_077}"
	elseif StateIndex == LOGIN_SERVER_STOP then		-- 维护
		return "#{TXSS_1000_078}"
	end
end

function Login_GetServerStateColor(StateIndex)
	if StateIndex == LOGIN_SERVER_FULL then   		-- 爆满
		return "255 0 0"
	elseif StateIndex == LOGIN_SERVER_BUSY then		-- 拥挤
		return "255 255 0"
	elseif StateIndex == LOGIN_SERVER_NORMAL then	-- 流畅
		return "0 255 0"
	elseif StateIndex == LOGIN_SERVER_NEW then		-- 新服
		return "0 255 255"
	elseif StateIndex == LOGIN_SERVER_STOP then		-- 维护
		return "180 180 180"
	end
end

-- 点击选择服务器列表项
function Login_OnClickServerList(_ServerIndex)		
	g_ServerListIndex = _ServerIndex

	local ServerID, ServerName, StateIndex = GameLogin:GetAreaLoginServerInfo(g_ServerListIndex)
	-- 服务器维护状态不能选中	
	if  StateIndex ~= LOGIN_SERVER_STOP then 	
		-- 保存当前服务器索引
		g_selectServerIndex = g_ServerListIndex 

		GameLogin:SelectLoginServer(g_ServerListIndex)
		
		--服务器状态名字
		local ServerStateName = Login_GetServerStateName(StateIndex)
		g_Login_Main[5]:SetText(ServerID.."#{TXSS_1000_072}".." "..ServerName.."  "..ServerStateName)
		
		--服务器状态颜色
		local ServerColor = Login_GetServerStateColor(StateIndex)
		g_Login_Main[5]:SetColor(ServerColor)
	
	end	
	Login_HideServerList()
	Login_ShowMainWindow()
end

--=============================================
-- 				点击关闭服务器列表
--=============================================
function Login_OnCloseServerListEvent()	
	if g_selectServerIndex == -1 and g_ServerListIndex < 0 then
		g_ServerListIndex = 0  -- 赋值选中服务器列表索引默认项		
	end

	Login_HideServerList()
	Login_ShowMainWindow()
end

--=============================================
-- 				触发关于按键事件 g_helpKickCount = -1  g_aboutKickCount = -1
--=============================================
function Login_About()
	if g_aboutKickCount == -1 then
		--PushToast("1212")
		g_Login_Main[28]:StartTime(1, 0, 3, 1)
		g_aboutKickCount = 0
		JavaJni:ShowAboutWindow("#{TXSS_2000_004}")
	end
	
end
function Login_Help()
	-- if g_helpKickCount == -1 then
		-- g_helpKickCount = 0
		-- JavaJni:ShowAboutWindow("#{CUPY_4000_072}")
	-- end
	-- g_helpKickCount = -1
	
	Help_Show()
	g_Login_Main[25]:SetText("#{CUPY_4000_071}")
	g_Login_Main[27]:SetContentOffset(0, -400)	
	g_Login_Main[27]:SetContentSize(340, 700)
	g_Login_Main[26]:SetText("#{CUPY_4000_072}")
end
--=============================================
-- 				触发更多按键事件
--=============================================
function Login_More()
	JavaJni:OpenWebConnect("http://game.10086.cn/a/")	
end

function Login_Set()
	PushEvent("SETTINGS_LOAD")
end

function Login_Luntan()
	JavaJni:OpenWebConnect("http://www.baidu.com")
end
function Help_Show()
	g_Login_Main[24]:Show()
	Main_Hide()
end
function Help_Hide()
	g_Login_Main[24]:Hide()
	Main_Show()
end
function Login_OnCloseHelptEvent()
	Help_Hide()
end

function Main_Show()

--	g_Login_Main[1]:Show()
	g_Login_Main[12]:Show()
	g_Login_Main[13]:Show()
	--g_Login_Main[14]:Show()
	--g_Login_Main[16]:Show()
	--g_Login_Main[18]:Show()
	--g_Login_Main[20]:Show()
	--g_Login_Main[22]:Show()

end
function Main_Hide()

	g_Login_Main[1]:Hide()
	g_Login_Main[12]:Hide()
	g_Login_Main[13]:Hide()
	g_Login_Main[14]:Hide()
	g_Login_Main[16]:Hide()
	g_Login_Main[18]:Hide()
	g_Login_Main[20]:Hide()
	g_Login_Main[22]:Hide()

end

--时间控制关于按钮的响应 一定时间内不会响应
function Login_AboutShowEvent()
	g_aboutKickCount = -1
end

