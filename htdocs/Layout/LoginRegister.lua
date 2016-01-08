local g_Login_Main = {}

local USERNAME_LENGTH_LIMIT = 11      -- 用户名长度限制 11
local PASSWORD_LENGTH_LIMIT = 15	  -- 密码长度限制   15

g_SetMusicFinishedFirst  = false   	  -- 首次音乐设置  

local g_UserName = ""						  -- 全局用户名
local g_Password = ""						  -- 全局密码

local g_CurRegType = 0				-- 当前注册类型   0 普通注册 1 快速注册

function LoginRegister_PreLoad()
	this:RegisterEvent("LOGINREGISTER_LOAD")
	this:RegisterEvent("LOGINREGISTER_LOAD_UPDATE")
	this:RegisterEvent("LOGINREGISTER_LOAD_ISAUTO")
end

function LoginRegister_OnLoad()
	g_Login_Main[1] = LoginRegister_Title_Image      -- 大标题
	g_Login_Main[2] = LoginRegister_IDarea_Image     -- 输入用户名大背景
	g_Login_Main[3] = LoginRegister_TextBox_User   		-- 输入用户名
	g_Login_Main[4] = LoginRegister_IDarea_Text	   				-- 输入用户名 EditBox
	g_Login_Main[5] = LoginRegister_Passwordarea_Image		-- 输入密码大背景
	g_Login_Main[6] = LoginRegister_TextBox_Password			-- 输入密码文本
	g_Login_Main[7] = LoginRegister_Passwordarea_Text			-- 输入密码 EditBox
	g_Login_Main[8] = LoginRegister_OneKey_Register_Button				-- 一键注册按钮
	g_Login_Main[9] = LoginRegister_OneKey_Register_Text 			-- 一键注册按钮文本
	g_Login_Main[10] = LoginRegister_Login_Button				-- 登录按钮
	g_Login_Main[11] = LoginRegister_Login_Text					-- 登录按钮文本
	g_Login_Main[12] = LoginRegister_IDarea_Register_Image				-- 注册用户名大背景
	g_Login_Main[13] = LoginRegister_TextBox_Register_User				-- 注册用户名文本	
	g_Login_Main[14] = LoginRegister_IDarea_Register_Text				-- 注册用户名EditBox
	g_Login_Main[15] = LoginRegister_Passwordarea_Register_Image			-- 注册密码大背景
	g_Login_Main[16] = LoginRegister_TextBox_Register_Password				-- 注册密码文本
	g_Login_Main[17] = LoginRegister_Passwordarea_Register_Text			-- 注册密码EditBox
	g_Login_Main[18] = 	LoginRegister_Register_Finish_Button		-- 完成注册Button
    g_Login_Main[19] = LoginRegister_Register_Finish_Text      -- 完成注册text
	g_Login_Main[20] = LoginRegister_Register_Login_BG_Image    -- 登录底板
	g_Login_Main[21] = LoginRegister_Register_Login_Close_Image    -- 登录 关闭按钮
    g_Login_Main[22] = LoginRegister_Register_Register_Close_Image    -- 注册中的关闭按钮
	g_Login_Main[23] = LoginRegister_TextBox_Login_Title    -- 登录 中 “账号登录”
	g_Login_Main[24] = LoginRegister_TextBox_Register_Title    -- 注册中的“账户注册”
	g_Login_Main[25] = LoginRegister_Passwordarea_Register_Confirm_Image    -- 确认密码大背景
	g_Login_Main[26] = LoginRegister_TextBox_Register_Confirm_Password    -- 确认密码文本
	g_Login_Main[27] = LoginRegister_Passwordarea_Confirm_Register_Text    -- 确认密码EditBox
	g_Login_Main[28] = LoginRegister_UserAgreement_Btn						-- 用户协议按键
	g_Login_Main[29] = LoginRegister_UserAgreementConfirm_Desc				-- 同意此协议 【字典】
	g_Login_Main[30] = LoginRegister_UserAgreement_BG						-- 用户协议背景图
	g_Login_Main[31] = LoginRegister_UserAgreementTitle_Desc				-- 用户协议标题文本 【字典】
	g_Login_Main[32] = LoginRegister_UserAgreementInfo						-- 用户协议列表信息  
	g_Login_Main[33] = LoginRegister_AtOnce_Button							-- 快速注册按键
	g_Login_Main[34] = LoginRegister_AtOnce_Text							-- 快速注册按键文本
end

function LoginRegister_OnEvent(event)
	if ( event == "LOGINREGISTER_LOAD" ) then
		HideLoading()
		this:Show()
        LoginRegister_Init()
	    LoginRegister_OnClick_Register_Close()		

		LoginRegister_HideUserAgreemetnWindow()

		HideLoading()

		LoginRegister_Init_AtOnceRegBtn()		
	elseif (event == "LOGINREGISTER_LOAD_ISAUTO") then
		if arg0 ~= nil and arg1 ~= nil then
			g_UserName = tostring(arg0)			
			g_Password = tostring(arg1)
		end
	elseif (event == "LOGINREGISTER_LOAD_UPDATE") then  
	    this:Show()
		
	    if arg0 == nil then
			return
		end
		local resultTag = tonumber(arg0)
	    if resultTag == 0 then --注册成功
			 if g_CurRegType == 0 then
				LoginRegister_OnClick_Register_Close()
				LoginRegister_SaveLogin(1)	
				g_Login_Main[33]:Show()
				g_Login_Main[34]:SetText("#{UIDL_1000_019}")
			 elseif g_CurRegType == 1 then 
				 CloseRequestWaitProgress()				
				 SetSharedUserForKey("user_name", g_UserName)
				 SetSharedUserForKey("user_paswod", g_Password)				 		 
				 g_CurRegType = 0	
				 LoginRegister_OnClick_Register_Close()			 
			 end
	    elseif resultTag == 1 then --注册失败
		     
			 LoginRegister_ShowRegisterWindow()
	         LoginRegister_HideLoginWindow()
		end		    
	    PushEvent("LOADINGWIDGET_UNLOAD")
		LoginRegister_HideUserAgreemetnWindow()
		LoginRegister_Init()
	end
end

--====================================
--			初始化快速注册按键
--====================================
function LoginRegister_Init_AtOnceRegBtn()
	local n_ChannelID = JavaJni:GetChannelID()
	-- if n_ChannelID == "U001" then    -- 联通渠道
		--g_Login_Main[33]:Hide()		
	-- else
		g_Login_Main[33]:Show()
		g_Login_Main[34]:SetText("#{UIDL_1000_019}")			
	-- end
	
end

-- 显示 登录界面
function LoginRegister_OnClick_Login_Close()
	this:Hide()
	PushEvent("LOGIN_LOAD")
end
-- 显示 登录输入界面
function LoginRegister_OnClick_Register_Close() 	
	 LoginRegister_HideRegisterWindow()
	 LoginRegister_ShowLoginWindow()
end


-- 初始化
function  LoginRegister_Init()
        
		g_Login_Main[3]:SetText("#{TXSS_1000_079}"..":")  --“用户名：”
		g_Login_Main[6]:SetText("#{TXSS_1000_080}"..":")  --“密码：”
		g_Login_Main[9]:SetText("#{TXSS_1000_062}") 	   --“注册账号”
		g_Login_Main[11]:SetText("#{UI_1000_001}") 		   --“立即登录”
		
		g_Login_Main[13]:SetText("#{TXSS_1000_079}"..":") --“用户名：”
		g_Login_Main[16]:SetText("#{TXSS_1000_080}"..":")  --“密码：”
		g_Login_Main[19]:SetText("#{TXSS_1000_062}")       --“注册账号”

        g_Login_Main[23]:SetText("#{UIDL_1000_006}")       -- "账户登录"
		g_Login_Main[24]:SetText("#{UIDL_1000_014}")       --账户注册
        
		g_Login_Main[26]:SetText("#{UIDL_1000_017}"..":")  --“确认密码：”
		g_Login_Main[29]:SetText("#{UIDL_1000_034}")		-- 同意此协议
		g_Login_Main[31]:SetText("#{UIDL_1000_033}")		-- 协议  【字典】
		local u_Name = GetSharedUserForKey("user_name", "-1")
		local u_Pwd = GetSharedUserForKey("user_paswod", "-1")
		
		if u_Name == "-1" or u_Pwd == "-1" then
			return
		end
		
		g_Login_Main[4]:SetInputText(u_Name)
		g_Login_Main[7]:SetInputText(u_Pwd)
end
-- 判断是否有老用户  true 是有老用户，false 是新用户
function LoginRegister_IsOldUser()
	local u_Name = GetSharedUserForKey("user_name", "-1")
	local u_Pwd = GetSharedUserForKey("user_paswod", "-1")
	
	if u_Name == "-1" or u_Pwd == "-1" then
		return false
	end
	
	return true
end



-- 显示注册窗口
function  LoginRegister_ShowRegisterWindow()
	g_Login_Main[12]:Show()
	g_Login_Main[13]:Show()
	g_Login_Main[14]:Show()
	g_Login_Main[15]:Show()
	g_Login_Main[16]:Show()
	g_Login_Main[17]:Show()
	g_Login_Main[18]:Show()
	g_Login_Main[22]:Show()
    g_Login_Main[24]:Show()
	g_Login_Main[25]:Show()
	g_Login_Main[26]:Show()
	g_Login_Main[27]:Show()
	g_Login_Main[28]:Show()
	g_Login_Main[33]:Hide()
end

-- 隐藏注册窗口
function   LoginRegister_HideRegisterWindow()
    g_Login_Main[12]:Hide()
	g_Login_Main[13]:Hide()
	g_Login_Main[14]:Hide()
	g_Login_Main[15]:Hide()
	g_Login_Main[16]:Hide()
	g_Login_Main[17]:Hide()
	g_Login_Main[18]:Hide()
	g_Login_Main[22]:Hide()
	g_Login_Main[24]:Hide()
	g_Login_Main[25]:Hide()
	g_Login_Main[26]:Hide()
	g_Login_Main[27]:Hide()
	g_Login_Main[28]:Hide()
end

-- 显示登录窗口
function   LoginRegister_ShowLoginWindow()
    g_Login_Main[2]:Show()
	g_Login_Main[3]:Show()
	g_Login_Main[4]:Show()
	g_Login_Main[5]:Show()
	g_Login_Main[6]:Show()
	g_Login_Main[7]:Show()
	g_Login_Main[8]:Show()
    g_Login_Main[9]:Show()    
	g_Login_Main[10]:Show()
	g_Login_Main[11]:Show()
    g_Login_Main[21]:Show()
	g_Login_Main[23]:Show()
end

-- 隐藏登录窗口
function   LoginRegister_HideLoginWindow()
    g_Login_Main[2]:Hide()
	g_Login_Main[3]:Hide()
	g_Login_Main[4]:Hide()
	g_Login_Main[5]:Hide()
	g_Login_Main[6]:Hide()
	g_Login_Main[7]:Hide()
	g_Login_Main[8]:Hide()
    g_Login_Main[9]:Hide()    
	g_Login_Main[10]:Hide()
	g_Login_Main[11]:Hide()
	g_Login_Main[21]:Hide()
	g_Login_Main[23]:Hide()
end

--==============================================
-- 				显示用户协议窗口
--==============================================
function   LoginRegister_ShowUserAgreemetnWindow()
		g_Login_Main[30]:Show()
end

--==============================================
-- 				隐藏用户协议窗口
--==============================================
function   LoginRegister_HideUserAgreemetnWindow()
		g_Login_Main[30]:Hide()
end

--==============================================
-- 			  关闭用户协议 点击事件 
--==============================================
function LoginRegister_OnCloseUserAgreementEvent()
	LoginRegister_HideUserAgreemetnWindow()
	LoginRegister_ShowRegisterWindow()
	g_Login_Main[20]:Show()
	g_Login_Main[1]:Show()
end

--一键注册
function LoginRegister_OnClick_OneKey_Register()
	LoginRegister_HideLoginWindow()
	LoginRegister_ShowRegisterWindow()	
--useName = g_Login_Main[4]:GetText()
--local name=FilterKeyWordsStar(useName)
--g_Login_Main[4]:SetInputText(tostring(name))
end

--============================================
--			用户协议 点击事件
--============================================
function LoginRegister_OnClick_UserAgreement()
	LoginRegister_HideRegisterWindow()
	g_Login_Main[20]:Hide()
	g_Login_Main[1]:Hide()	
	LoginRegister_ShowUserAgreemetnWindow()
	
	LoginRegister_InitAgreementInfo()
end

--登录按钮
function LoginRegister_OnClick_Login()
    if( LoginRegister_SaveLogin(0)==false) then
		return 	
	end
	PushEvent("LOGIN_LOAD")
	 this:Hide()
end

--注册完成
function LoginRegister_OnClick_FinishRegister()
   local passWord =   g_Login_Main[17]:GetText()    
   local rePassWord = g_Login_Main[27]:GetText()  
   
   if (LoginRegister_IsValidStr("nothing",passWord)==false) then  --数字正常
	     return 
    end   
   
    if	(LoginRegister_IsValidStr("nothing",rePassWord)==false) then  --数字正常
	     return 
    end   
	
	if passWord~=rePassWord then
			PushToast("#{UIDL_1000_031}")	
			return 
	end

    LoginRegister_LinkToNet()
	 
	g_CurRegType = 0
end

-- 保存用户名密码
-- Index 标识注册和登录输入中的值，0标识记录 登记 中的用户名密码，1标识记录 注册 中的用户名密码

function LoginRegister_SaveLogin(Index)

	local useName 
	local usePwd  
	if Index==0 then
		useName = g_Login_Main[4]:GetText()
	    usePwd  = g_Login_Main[7]:GetText()
	else
	    useName = g_Login_Main[14]:GetText()
	    usePwd  = g_Login_Main[17]:GetText()
	end
	
    if	(LoginRegister_IsValidStr(useName, usePwd)==false) then  --数字正常
	     return false
    end
	
	--存储选择的服务器索引

	SetSharedUserForKey("user_name", useName)
	SetSharedUserForKey("user_paswod", usePwd)
    
	
    return true
end

--判断是否是合理的用户名或密码
function LoginRegister_IsValidStr(useName, usePwd)

    -- 含有非法字符，比如“”，"%","@","^"，“!"
	if CheckIllegalString(tostring(strNickName)) == true then
		PushToast("#{ITEM_2000_031}")	
		return	false
	end
    
	---账号不能为空	
	if  useName=="" then
		--PushMessageBox("#{TXSS_2000_048}")
		PushToast("#{TXSS_2000_048}")
		return	false
	end
	
	-- 密码不能为空
	if usePwd =="" then
		--PushMessageBox("#{TXSS_2000_049}")	
		PushToast("#{TXSS_2000_049}")
		return false
	end
	
	--- 用户名不能有汉字
	if HaveCharact(tostring(useName)) == true then
		PushToast("#{TXSS_2000_050}")	
		return	false
	end
	
	-- 用户名长度上限11个字符
	if #useName > USERNAME_LENGTH_LIMIT then
		PushToast("#{UIDL_1000_043}")	
		return	false			
	end
	
	-- 密码不能有汉字
	if HaveCharact(tostring(usePwd))== true then
		PushToast("#{TXSS_2000_051}")	
		return	false
	end
	
	-- 密码长度上限15个字符
	if #usePwd > PASSWORD_LENGTH_LIMIT then
		PushToast("#{UIDL_1000_044}")	
		return	false			
	end
		
	return true
end

-- 连接网络去注册
function LoginRegister_LinkToNet()
	--注册代码--------------------------------
	local useName = g_Login_Main[14]:GetText()
	local usePwd  = g_Login_Main[17]:GetText()
	
	useName = LoginRegister_Trim(useName)
	g_Login_Main[14]:SetInputText(useName)	
	
	if	(LoginRegister_IsValidStr(useName, usePwd)==false) then  --数字正常
	     return false
    end
	PushEvent("LOADINGWIDGET_LOAD")

	GameLogin:RegisterAccount(useName, usePwd, 0)
end

--======================================
--				加载用户协议详情
--======================================
function	LoginRegister_InitAgreementInfo()
	g_Login_Main[32]:AddItemIcon(5, 0, 0)
	g_Login_Main[32]:SetContentOffset(0, -1560)	
	g_Login_Main[32]:SetContentSize(340, 1850)
end

--======================================
--				字符串去掉空格 
--======================================
function 	LoginRegister_Trim(str)
	return (string.gsub(str, "(.-)%s*$", "%1"))
end

--======================================
--				快速注册
--======================================
function    LoginRegister_AtOnceReg()
	g_CurRegType = 1		
	GameLogin:RegisterAccount("-1", "-1", 1)			
	OpenRequestWaitProgress()	
end