
local g_Login_Main = {}
local g_ServerListIndex = -1 	-- �������б������
local g_selectServerIndex = -1	-- ��ǰѡ�����������

local g_helpKickCount = -1
local g_aboutKickCount = -1

local LOGIN_SERVER_FULL	  = 0 	-- ����
local LOGIN_SERVER_BUSY   = 1 	-- ӵ��
local LOGIN_SERVER_NORMAL = 2	-- ����
local LOGIN_SERVER_NEW    = 3	-- �·�
local LOGIN_SERVER_STOP   = 4	-- ά��

local g_CurServerInfo = 		-- ��ǰ��������Ϣ
{
	g_CurServerID,				-- ������ID
    g_CurServerName,			-- ����������
	g_CurServerColor,			-- ��������ɫ
	g_CurServerState			-- ������״̬
}

function Login_PreLoad()
	this:RegisterEvent("LOGIN_LOAD")
end

function Login_OnLoad()
	g_Login_Main[1] = Login_Register_Btn				-- ����ע�� ����
	g_Login_Main[2] = Login_Register_Btn_Text			-- ����ע�� �ı����ֵ䡿
	g_Login_Main[3] = Login_TextBox_Version   			-- �汾��
	g_Login_Main[4] = Login_ServerList_Desc				-- �������б�  �ı����ֵ䡿
	g_Login_Main[5] = Login_Confirm_ServerNameState		-- ���������ֺ�״̬���ı��� {ѡ����}
	g_Login_Main[6] = Login_ServerList_CurServerDesc	-- �����¼������ �ı� ���ֵ䡿
	g_Login_Main[7] = Login_Scroll_ServerList			-- �������б�����Ӵ�
	g_Login_Main[8] = Login_ServerList_CurServerText	-- �������б� ��ǰ��������
	g_Login_Main[9] = Login_Logo						-- ����ͼ��
	g_Login_Main[10] = Login_ServerList_BG				-- �������б���
	g_Login_Main[11] = Login_Login_Text					-- ��½�����ı�  ���ֵ䡿
	g_Login_Main[12] = Login_SwitchServer				-- �л�����������
	g_Login_Main[13] = Login_Login_Button				-- ��¼����������	
	g_Login_Main[14] = Login_About_Button				-- ���ڰ���			
	g_Login_Main[15] = Login_About_Text					-- ���ڰ����ı�
	g_Login_Main[16] = Login_More_Button				-- ���ఴ��
	g_Login_Main[17] = Login_More_Text					-- ���ఴ���ı�
	
	g_Login_Main[18] = Login_Help_Button				-- ��������
	g_Login_Main[19] = Login_Help_Text
	g_Login_Main[20] = Login_Set_Button					--���ð���
	g_Login_Main[21] = Login_Set_Text
	
	g_Login_Main[22] = Login_Luntan_Button					--��̳����
	g_Login_Main[23] = Login_Luntan_Text
	
	g_Login_Main[24] = Login_Help_BG                       --������Ϣ
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
		
		
		g_Login_Main[1]:Hide()			-- ����ע�� ����
		
		g_selectServerIndex = tonumber(GetSharedUserForKey("server_index", "-1"))				

		--�����Ϸ�汾��
		local version = GetVersion()
		g_Login_Main[3]:SetText(tostring(version))
		
		-- ���Ĭ�Ϸ�����
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
			g_Login_Main[2]:SetText(u_Name) -- ��¼���������ʾ��¼��
		else
		    g_Login_Main[2]:SetText("") -- �˻���¼        �ı����ֵ䡿
		end
		--g_Login_Main[2]:SetText("#{UIDL_1000_006}") -- �˻���¼        �ı����ֵ䡿
		g_Login_Main[4]:SetText("#{UIDL_1000_013}") -- �������б�      �ı����ֵ䡿
		g_Login_Main[6]:SetText("#{UIDL_1000_010}")	 -- �����¼������  �ı����ֵ䡿	
		g_Login_Main[11]:SetText("#{UIDL_1000_020}")  -- ��¼�����ı�    �ı����ֵ䡿

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
--			��ʼ�����ڰ���
--====================================
function Login_Init_AboutBtn()
	local n_ChannelID = JavaJni:GetChannelID()
	-- if n_ChannelID == "U002" then    -- ��ͨ����
	--	g_Login_Main[14]:Show()
	--	g_Login_Main[15]:SetText("#{TXSS_2000_003}")		
	-- else
		g_Login_Main[14]:Hide()
		--if n_ChannelID == "U002" then -- �ƶ�����
		--g_Login_Main[14]:Show()
		--g_Login_Main[15]:SetText("#{TXSS_2000_003}")			
	-- end
end

--====================================
--			��ʼ������������ ��̳
--====================================
function Login_Init_SetHelpBtn()
	-- local n_ChannelID = JavaJni:GetChannelID()
	-- if n_ChannelID == "U003" then    -- ��ͨ����
		g_Login_Main[18]:Hide()
		g_Login_Main[20]:Hide()
		g_Login_Main[22]:Hide()
	-- elseif n_ChannelID == "U002" then -- �ƶ�����
		-- g_Login_Main[18]:Show()--����
		-- g_Login_Main[19]:SetText("#{CUPY_4000_071}")
		-- g_Login_Main[20]:Show()--����
		-- g_Login_Main[21]:SetText("#{UISZ_1000_001}")
		-- g_Login_Main[22]:Show()--��̳
		-- g_Login_Main[23]:SetText("#{CUPY_4000_073}")
	-- end
end
--====================================
--		��ʼ�����ఴ��
--====================================
function Login_Init_MoreBtn()
	local n_ChannelID = JavaJni:GetChannelID()
	-- if n_ChannelID == "U002" then    -- ��ͨ����
		--g_Login_Main[16]:Show()
		--g_Login_Main[17]:SetText("#{CUPY_5000_194}")		
	-- else
		g_Login_Main[16]:Hide()
		--if n_ChannelID == "U002" then -- �ƶ�����
		--g_Login_Main[14]:Show()
		--g_Login_Main[15]:SetText("#{TXSS_2000_003}")			
	-- end
end

--====================================
--			���浱ǰ��������Ϣ
--====================================
function Login_SaveCurServerInfo(_serverID, _serverName, _serverColor, _serverState)
	g_CurServerInfo.g_CurServerID    = _serverID
	g_CurServerInfo.g_CurServerName  = _serverName
	g_CurServerInfo.g_CurServerColor = _serverColor
	g_CurServerInfo.g_CurServerState = _serverState
end

--====================================
--				��¼����¼�
--====================================
function Login_Login()
	
	--- ��ѡ�������
	if 	g_selectServerIndex == -1 then
		--PushMessageBox("#{TXSS_3000_003}")
		PushToast("#{TXSS_3000_003}")	
		return		
	end
	
	local useName = GetSharedUserForKey("user_name", "-1")
	local usePwd = GetSharedUserForKey("user_paswod", "-1")
	---�˺Ų���Ϊ��	
	-- if  useName=="-1" then
		-- PushToast("#{TXSS_2000_048}")
		-- return	false
	-- end
	-- -- ���벻��Ϊ��
	-- if usePwd =="-1" then
		-- PushToast("#{TXSS_2000_049}")
		-- return false
	-- end
	
	--׼����½
	GameLogin:LoginAccount(useName, usePwd)
	
	PushEvent("LOADINGWIDGET_LOAD")
	
	Guide_Init()--����������ʼ��
	
	--�洢ѡ��ķ���������
	SetSharedUserForKey("server_index", g_selectServerIndex)

	this:Hide()
end

--===================================
--			 ����ע���¼�
--===================================
function	Login_OnRegisterEvent()
--	this:Hide()	
	
--	PushEvent("LOGINREGISTER_LOAD")
end


--��ӷ������б�ѡ�� 
function    Login_AddServerListItem(ServerID, ServerIndex, ServerName, ServerState, x, y)

	local Function = string.format("%s%d%s","Login_OnClickServerList(",ServerIndex,")")
	g_Login_Main[7]:AddItemSelect9Patch("uidenglu_fuwuqibiankuang.png", "uidenglu_fuwuqibiankuangxia.png", x + 138, y + 29, 276, 34, 4, Function)
	
	local ServerStateName = Login_GetServerStateName(ServerState)
	local ServerColor = Login_GetServerStateColor(ServerState)
	g_Login_Main[7]:AddItemText(ServerID.."#{TXSS_1000_072}".."  "..ServerName.."  "..ServerStateName, x, y + 15, 276, 34, ServerColor, 20, "Center")
	
end

--��ʾ����������
function Login_ReadServerList()
	local offsetX = 0
	local offsetY = 0
	local ContentHeight = 184
	local count = GameLogin:GetServerAreaCount()
	-- ���÷������б������
	g_ServerListIndex = -1
	
	-- ����б�����
	g_Login_Main[7]:CleanAllElement()	
		
	for i = count - 1, 0, -1 do
		local ServerID, ServerName, ServerState = GameLogin:GetAreaLoginServerInfo(i)
		Login_AddServerListItem(ServerID, i, ServerName, ServerState, offsetX, offsetY)
		
		offsetY = offsetY + 46
	end
	
	if offsetY > ContentHeight then
		ContentHeight = offsetY	
	end
	g_Login_Main[7]:SetContentSize(278, ContentHeight) --�������ݳ���
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
--          ��ʾ������
--=================================
function    Login_ShowMainWindow()
--	g_Login_Main[1]:Show()			-- ����ע�� ����
	g_Login_Main[9]:Show()			-- ����ͼ��
	g_Login_Main[13]:Show()			-- ��¼������ ����
	g_Login_Main[12]:Show()			-- �л������� ����	
end

--=================================
--          ����������
--=================================
function    Login_HideMainWindow()
	g_Login_Main[1]:Hide()			-- ����ע�� ����
	g_Login_Main[9]:Hide()			-- ����ͼ��
	g_Login_Main[13]:Hide()			-- ��¼������ ����
	g_Login_Main[12]:Hide()			-- �л������� ����	
end

-- ��ʾ�������б�
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

-- ���ط������б�
function    Login_HideServerList()
	g_Login_Main[7]:Hide()
	g_Login_Main[10]:Hide()
end

-- ���ѡ�����������
function 	Login_OnClickSwitchServer()
	Login_HideMainWindow()
	
	Login_ReadServerList()
	
	Login_ShowServerList()
end

-- ��÷�����״̬����
function   Login_GetServerStateName(StateIndex)
	if StateIndex == LOGIN_SERVER_FULL then   		-- ����
		return "#{TXSS_1000_074}"
	elseif StateIndex == LOGIN_SERVER_BUSY then		-- ӵ��
		return "#{TXSS_1000_075}"
	elseif StateIndex == LOGIN_SERVER_NORMAL then	-- ����
		return "#{TXSS_1000_076}"
	elseif StateIndex == LOGIN_SERVER_NEW then		-- �·�
		return "#{TXSS_1000_077}"
	elseif StateIndex == LOGIN_SERVER_STOP then		-- ά��
		return "#{TXSS_1000_078}"
	end
end

function Login_GetServerStateColor(StateIndex)
	if StateIndex == LOGIN_SERVER_FULL then   		-- ����
		return "255 0 0"
	elseif StateIndex == LOGIN_SERVER_BUSY then		-- ӵ��
		return "255 255 0"
	elseif StateIndex == LOGIN_SERVER_NORMAL then	-- ����
		return "0 255 0"
	elseif StateIndex == LOGIN_SERVER_NEW then		-- �·�
		return "0 255 255"
	elseif StateIndex == LOGIN_SERVER_STOP then		-- ά��
		return "180 180 180"
	end
end

-- ���ѡ��������б���
function Login_OnClickServerList(_ServerIndex)		
	g_ServerListIndex = _ServerIndex

	local ServerID, ServerName, StateIndex = GameLogin:GetAreaLoginServerInfo(g_ServerListIndex)
	-- ������ά��״̬����ѡ��	
	if  StateIndex ~= LOGIN_SERVER_STOP then 	
		-- ���浱ǰ����������
		g_selectServerIndex = g_ServerListIndex 

		GameLogin:SelectLoginServer(g_ServerListIndex)
		
		--������״̬����
		local ServerStateName = Login_GetServerStateName(StateIndex)
		g_Login_Main[5]:SetText(ServerID.."#{TXSS_1000_072}".." "..ServerName.."  "..ServerStateName)
		
		--������״̬��ɫ
		local ServerColor = Login_GetServerStateColor(StateIndex)
		g_Login_Main[5]:SetColor(ServerColor)
	
	end	
	Login_HideServerList()
	Login_ShowMainWindow()
end

--=============================================
-- 				����رշ������б�
--=============================================
function Login_OnCloseServerListEvent()	
	if g_selectServerIndex == -1 and g_ServerListIndex < 0 then
		g_ServerListIndex = 0  -- ��ֵѡ�з������б�����Ĭ����		
	end

	Login_HideServerList()
	Login_ShowMainWindow()
end

--=============================================
-- 				�������ڰ����¼� g_helpKickCount = -1  g_aboutKickCount = -1
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
-- 				�������ఴ���¼�
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

--ʱ����ƹ��ڰ�ť����Ӧ һ��ʱ���ڲ�����Ӧ
function Login_AboutShowEvent()
	g_aboutKickCount = -1
end

