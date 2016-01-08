local g_Login_Main = {}

local USERNAME_LENGTH_LIMIT = 11      -- �û����������� 11
local PASSWORD_LENGTH_LIMIT = 15	  -- ���볤������   15

g_SetMusicFinishedFirst  = false   	  -- �״���������  

local g_UserName = ""						  -- ȫ���û���
local g_Password = ""						  -- ȫ������

local g_CurRegType = 0				-- ��ǰע������   0 ��ͨע�� 1 ����ע��

function LoginRegister_PreLoad()
	this:RegisterEvent("LOGINREGISTER_LOAD")
	this:RegisterEvent("LOGINREGISTER_LOAD_UPDATE")
	this:RegisterEvent("LOGINREGISTER_LOAD_ISAUTO")
end

function LoginRegister_OnLoad()
	g_Login_Main[1] = LoginRegister_Title_Image      -- �����
	g_Login_Main[2] = LoginRegister_IDarea_Image     -- �����û����󱳾�
	g_Login_Main[3] = LoginRegister_TextBox_User   		-- �����û���
	g_Login_Main[4] = LoginRegister_IDarea_Text	   				-- �����û��� EditBox
	g_Login_Main[5] = LoginRegister_Passwordarea_Image		-- ��������󱳾�
	g_Login_Main[6] = LoginRegister_TextBox_Password			-- ���������ı�
	g_Login_Main[7] = LoginRegister_Passwordarea_Text			-- �������� EditBox
	g_Login_Main[8] = LoginRegister_OneKey_Register_Button				-- һ��ע�ᰴť
	g_Login_Main[9] = LoginRegister_OneKey_Register_Text 			-- һ��ע�ᰴť�ı�
	g_Login_Main[10] = LoginRegister_Login_Button				-- ��¼��ť
	g_Login_Main[11] = LoginRegister_Login_Text					-- ��¼��ť�ı�
	g_Login_Main[12] = LoginRegister_IDarea_Register_Image				-- ע���û����󱳾�
	g_Login_Main[13] = LoginRegister_TextBox_Register_User				-- ע���û����ı�	
	g_Login_Main[14] = LoginRegister_IDarea_Register_Text				-- ע���û���EditBox
	g_Login_Main[15] = LoginRegister_Passwordarea_Register_Image			-- ע������󱳾�
	g_Login_Main[16] = LoginRegister_TextBox_Register_Password				-- ע�������ı�
	g_Login_Main[17] = LoginRegister_Passwordarea_Register_Text			-- ע������EditBox
	g_Login_Main[18] = 	LoginRegister_Register_Finish_Button		-- ���ע��Button
    g_Login_Main[19] = LoginRegister_Register_Finish_Text      -- ���ע��text
	g_Login_Main[20] = LoginRegister_Register_Login_BG_Image    -- ��¼�װ�
	g_Login_Main[21] = LoginRegister_Register_Login_Close_Image    -- ��¼ �رհ�ť
    g_Login_Main[22] = LoginRegister_Register_Register_Close_Image    -- ע���еĹرհ�ť
	g_Login_Main[23] = LoginRegister_TextBox_Login_Title    -- ��¼ �� ���˺ŵ�¼��
	g_Login_Main[24] = LoginRegister_TextBox_Register_Title    -- ע���еġ��˻�ע�ᡱ
	g_Login_Main[25] = LoginRegister_Passwordarea_Register_Confirm_Image    -- ȷ������󱳾�
	g_Login_Main[26] = LoginRegister_TextBox_Register_Confirm_Password    -- ȷ�������ı�
	g_Login_Main[27] = LoginRegister_Passwordarea_Confirm_Register_Text    -- ȷ������EditBox
	g_Login_Main[28] = LoginRegister_UserAgreement_Btn						-- �û�Э�鰴��
	g_Login_Main[29] = LoginRegister_UserAgreementConfirm_Desc				-- ͬ���Э�� ���ֵ䡿
	g_Login_Main[30] = LoginRegister_UserAgreement_BG						-- �û�Э�鱳��ͼ
	g_Login_Main[31] = LoginRegister_UserAgreementTitle_Desc				-- �û�Э������ı� ���ֵ䡿
	g_Login_Main[32] = LoginRegister_UserAgreementInfo						-- �û�Э���б���Ϣ  
	g_Login_Main[33] = LoginRegister_AtOnce_Button							-- ����ע�ᰴ��
	g_Login_Main[34] = LoginRegister_AtOnce_Text							-- ����ע�ᰴ���ı�
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
	    if resultTag == 0 then --ע��ɹ�
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
	    elseif resultTag == 1 then --ע��ʧ��
		     
			 LoginRegister_ShowRegisterWindow()
	         LoginRegister_HideLoginWindow()
		end		    
	    PushEvent("LOADINGWIDGET_UNLOAD")
		LoginRegister_HideUserAgreemetnWindow()
		LoginRegister_Init()
	end
end

--====================================
--			��ʼ������ע�ᰴ��
--====================================
function LoginRegister_Init_AtOnceRegBtn()
	local n_ChannelID = JavaJni:GetChannelID()
	-- if n_ChannelID == "U001" then    -- ��ͨ����
		--g_Login_Main[33]:Hide()		
	-- else
		g_Login_Main[33]:Show()
		g_Login_Main[34]:SetText("#{UIDL_1000_019}")			
	-- end
	
end

-- ��ʾ ��¼����
function LoginRegister_OnClick_Login_Close()
	this:Hide()
	PushEvent("LOGIN_LOAD")
end
-- ��ʾ ��¼�������
function LoginRegister_OnClick_Register_Close() 	
	 LoginRegister_HideRegisterWindow()
	 LoginRegister_ShowLoginWindow()
end


-- ��ʼ��
function  LoginRegister_Init()
        
		g_Login_Main[3]:SetText("#{TXSS_1000_079}"..":")  --���û�������
		g_Login_Main[6]:SetText("#{TXSS_1000_080}"..":")  --�����룺��
		g_Login_Main[9]:SetText("#{TXSS_1000_062}") 	   --��ע���˺š�
		g_Login_Main[11]:SetText("#{UI_1000_001}") 		   --��������¼��
		
		g_Login_Main[13]:SetText("#{TXSS_1000_079}"..":") --���û�������
		g_Login_Main[16]:SetText("#{TXSS_1000_080}"..":")  --�����룺��
		g_Login_Main[19]:SetText("#{TXSS_1000_062}")       --��ע���˺š�

        g_Login_Main[23]:SetText("#{UIDL_1000_006}")       -- "�˻���¼"
		g_Login_Main[24]:SetText("#{UIDL_1000_014}")       --�˻�ע��
        
		g_Login_Main[26]:SetText("#{UIDL_1000_017}"..":")  --��ȷ�����룺��
		g_Login_Main[29]:SetText("#{UIDL_1000_034}")		-- ͬ���Э��
		g_Login_Main[31]:SetText("#{UIDL_1000_033}")		-- Э��  ���ֵ䡿
		local u_Name = GetSharedUserForKey("user_name", "-1")
		local u_Pwd = GetSharedUserForKey("user_paswod", "-1")
		
		if u_Name == "-1" or u_Pwd == "-1" then
			return
		end
		
		g_Login_Main[4]:SetInputText(u_Name)
		g_Login_Main[7]:SetInputText(u_Pwd)
end
-- �ж��Ƿ������û�  true �������û���false �����û�
function LoginRegister_IsOldUser()
	local u_Name = GetSharedUserForKey("user_name", "-1")
	local u_Pwd = GetSharedUserForKey("user_paswod", "-1")
	
	if u_Name == "-1" or u_Pwd == "-1" then
		return false
	end
	
	return true
end



-- ��ʾע�ᴰ��
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

-- ����ע�ᴰ��
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

-- ��ʾ��¼����
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

-- ���ص�¼����
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
-- 				��ʾ�û�Э�鴰��
--==============================================
function   LoginRegister_ShowUserAgreemetnWindow()
		g_Login_Main[30]:Show()
end

--==============================================
-- 				�����û�Э�鴰��
--==============================================
function   LoginRegister_HideUserAgreemetnWindow()
		g_Login_Main[30]:Hide()
end

--==============================================
-- 			  �ر��û�Э�� ����¼� 
--==============================================
function LoginRegister_OnCloseUserAgreementEvent()
	LoginRegister_HideUserAgreemetnWindow()
	LoginRegister_ShowRegisterWindow()
	g_Login_Main[20]:Show()
	g_Login_Main[1]:Show()
end

--һ��ע��
function LoginRegister_OnClick_OneKey_Register()
	LoginRegister_HideLoginWindow()
	LoginRegister_ShowRegisterWindow()	
--useName = g_Login_Main[4]:GetText()
--local name=FilterKeyWordsStar(useName)
--g_Login_Main[4]:SetInputText(tostring(name))
end

--============================================
--			�û�Э�� ����¼�
--============================================
function LoginRegister_OnClick_UserAgreement()
	LoginRegister_HideRegisterWindow()
	g_Login_Main[20]:Hide()
	g_Login_Main[1]:Hide()	
	LoginRegister_ShowUserAgreemetnWindow()
	
	LoginRegister_InitAgreementInfo()
end

--��¼��ť
function LoginRegister_OnClick_Login()
    if( LoginRegister_SaveLogin(0)==false) then
		return 	
	end
	PushEvent("LOGIN_LOAD")
	 this:Hide()
end

--ע�����
function LoginRegister_OnClick_FinishRegister()
   local passWord =   g_Login_Main[17]:GetText()    
   local rePassWord = g_Login_Main[27]:GetText()  
   
   if (LoginRegister_IsValidStr("nothing",passWord)==false) then  --��������
	     return 
    end   
   
    if	(LoginRegister_IsValidStr("nothing",rePassWord)==false) then  --��������
	     return 
    end   
	
	if passWord~=rePassWord then
			PushToast("#{UIDL_1000_031}")	
			return 
	end

    LoginRegister_LinkToNet()
	 
	g_CurRegType = 0
end

-- �����û�������
-- Index ��ʶע��͵�¼�����е�ֵ��0��ʶ��¼ �Ǽ� �е��û������룬1��ʶ��¼ ע�� �е��û�������

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
	
    if	(LoginRegister_IsValidStr(useName, usePwd)==false) then  --��������
	     return false
    end
	
	--�洢ѡ��ķ���������

	SetSharedUserForKey("user_name", useName)
	SetSharedUserForKey("user_paswod", usePwd)
    
	
    return true
end

--�ж��Ƿ��Ǻ�����û���������
function LoginRegister_IsValidStr(useName, usePwd)

    -- ���зǷ��ַ������硰����"%","@","^"����!"
	if CheckIllegalString(tostring(strNickName)) == true then
		PushToast("#{ITEM_2000_031}")	
		return	false
	end
    
	---�˺Ų���Ϊ��	
	if  useName=="" then
		--PushMessageBox("#{TXSS_2000_048}")
		PushToast("#{TXSS_2000_048}")
		return	false
	end
	
	-- ���벻��Ϊ��
	if usePwd =="" then
		--PushMessageBox("#{TXSS_2000_049}")	
		PushToast("#{TXSS_2000_049}")
		return false
	end
	
	--- �û��������к���
	if HaveCharact(tostring(useName)) == true then
		PushToast("#{TXSS_2000_050}")	
		return	false
	end
	
	-- �û�����������11���ַ�
	if #useName > USERNAME_LENGTH_LIMIT then
		PushToast("#{UIDL_1000_043}")	
		return	false			
	end
	
	-- ���벻���к���
	if HaveCharact(tostring(usePwd))== true then
		PushToast("#{TXSS_2000_051}")	
		return	false
	end
	
	-- ���볤������15���ַ�
	if #usePwd > PASSWORD_LENGTH_LIMIT then
		PushToast("#{UIDL_1000_044}")	
		return	false			
	end
		
	return true
end

-- ��������ȥע��
function LoginRegister_LinkToNet()
	--ע�����--------------------------------
	local useName = g_Login_Main[14]:GetText()
	local usePwd  = g_Login_Main[17]:GetText()
	
	useName = LoginRegister_Trim(useName)
	g_Login_Main[14]:SetInputText(useName)	
	
	if	(LoginRegister_IsValidStr(useName, usePwd)==false) then  --��������
	     return false
    end
	PushEvent("LOADINGWIDGET_LOAD")

	GameLogin:RegisterAccount(useName, usePwd, 0)
end

--======================================
--				�����û�Э������
--======================================
function	LoginRegister_InitAgreementInfo()
	g_Login_Main[32]:AddItemIcon(5, 0, 0)
	g_Login_Main[32]:SetContentOffset(0, -1560)	
	g_Login_Main[32]:SetContentSize(340, 1850)
end

--======================================
--				�ַ���ȥ���ո� 
--======================================
function 	LoginRegister_Trim(str)
	return (string.gsub(str, "(.-)%s*$", "%1"))
end

--======================================
--				����ע��
--======================================
function    LoginRegister_AtOnceReg()
	g_CurRegType = 1		
	GameLogin:RegisterAccount("-1", "-1", 1)			
	OpenRequestWaitProgress()	
end