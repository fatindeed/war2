-- �ؼ��б�
local g_ChooseCharacter_Window = {}
local NICKNAMELENGTHLIMIT=18

local g_PortraitImageName = {"uidenglu_touxiang1.png", "uidenglu_touxiang2.png", "uidenglu_touxiang3.png", "uidenglu_touxiang4.png"}

function	ChooseCharacter_PreLoad()
	this:RegisterEvent("CHOOSECHARACTER_LOAD")
end

function	ChooseCharacter_OnLoad()
	g_ChooseCharacter_Window[1] = ChooseCharacter_InputNickName_Desc	-- �������ж����� ���ֵ䡿
	g_ChooseCharacter_Window[2] = ChooseCharacter_BackGround			-- ��ɫ����
	g_ChooseCharacter_Window[3] = ChooseCharacter_NickNameHint_Desc		-- �ǳ�ʾ�� �ǳ��6�������ַ� ���ֵ䡿
	g_ChooseCharacter_Window[4] = ChooseCharacter_Continue_Btn_Text		-- ���������ı�  ���ֵ䡿����
	g_ChooseCharacter_Window[5] = ChooseCharacter_PortraitList			-- ͷ���б�
	g_ChooseCharacter_Window[6] = ChooseCharacter_Input_NickName_Text	-- �ǳ������
	g_ChooseCharacter_Window[7] = ChooseCharacter_PortraitDescript1		--
	g_ChooseCharacter_Window[8] = ChooseCharacter_PortraitDescript2		
	g_ChooseCharacter_Window[9] = ChooseCharacter_PortraitDescript3		--
	g_ChooseCharacter_Window[10] = ChooseCharacter_PortraitDescript4	--
	g_ChooseCharacter_Window[11] = ChooseCharacter_PortraitSelect
end

function	ChooseCharacter_OnEvent(event)
	if ( event == "CHOOSECHARACTER_LOAD" ) then
	    ChooseCharacter_Init()
			
		this:Show()
		ChooseCharacter_ShowBG()
		
    end
end

--============================================
--				   ��ʾ��ɫ����
--============================================
function    ChooseCharacter_ShowBG()
	--g_ChooseCharacter_Window[2]:SetScale(40)
end

--============================================
--				   ��ʼ������
--============================================
function	ChooseCharacter_Init()
	g_ChooseCharacter_Window[1]:SetText("#{UIDL_1000_007}") -- �������ж����� ���ֵ䡿
	g_ChooseCharacter_Window[3]:SetText("#{UIDL_1000_009}") -- �ǳ��6�������ַ� ���ֵ䡿
	g_ChooseCharacter_Window[4]:SetText("#{UIDL_1000_008}") -- ���ֵ䡿����
	g_ChooseCharacter_Window[7]:SetText("#{CUPY_5000_197}") -- 
	g_ChooseCharacter_Window[8]:SetText("#{CUPY_5000_198}") -- 
	g_ChooseCharacter_Window[9]:SetText("#{CUPY_5000_199}") -- 
	g_ChooseCharacter_Window[10]:SetText("#{CUPY_5000_200}") --
	g_ChooseCharacter_Window[11]:SetText("#{CUPY_5000_196}")
	-- ��ʼ��ͷ���б� 
	ChooseCharacter_InitPortraitList()
	
	ChooseCharacter_OnPortraitEvent(1)	-- Ĭ��ѡ�е�һ��ͷ��
end

--============================================
--				   ��ʼ��ͷ���б�
--============================================
function	ChooseCharacter_InitPortraitList()
	g_ChooseCharacter_Window[5]:CleanAllElement()
	
	local nPortraitCount = 4
	local nOffset_X, nOffset_Y = 0, 0	
	for i = 1, nPortraitCount do
		ChooseCharacter_AddPortraitListItem(i, nOffset_X, nOffset_Y)	
		nOffset_X = nOffset_X + 180
	end	
	g_ChooseCharacter_Window[5]:Touch(-1)
end

--============================================
--				   ����ͷ���б���
--============================================
function	ChooseCharacter_AddPortraitListItem(uID, pos_x, pos_y)
	
	g_ChooseCharacter_Window[5]:AddImage9Patch("uidenglu_renwubiankuang.png", pos_x, pos_y, 2, 121, 113, true)
	g_ChooseCharacter_Window[5]:AddImage9Patch(g_PortraitImageName[uID], pos_x + 8, pos_y, 2, 105, 105, true)	
	local Function = string.format("%s%d%s", "ChooseCharacter_OnPortraitEvent(", uID, ")")
	g_ChooseCharacter_Window[5]:AddItemSelect9Patch("empty.png", "uidenglu_touxiangxuanzhong.png", pos_x + 61, pos_y + 55, 105, 106, 24, Function)
	
	g_ChooseCharacter_Window[5]:SetSelectItem(0)

end

--============================================
--				  ͷ���б������¼�
--============================================
function    ChooseCharacter_OnPortraitEvent(uID)
	SetSharedUserForKey("user_character", tostring(uID))
end

--============================================
--				   �رմ���
--============================================
function	ChooseCharacter_Close()
	g_ChooseCharacter_Window[5]:CleanAllElement()
		
	this:Hide()
end

--============================================
--				   ��������¼�
--============================================
function	ChooseCharacter_OnContinueEvent()
	local strNickName = g_ChooseCharacter_Window[6]:GetText()
	
	if #strNickName <= 0 or #strNickName > NICKNAMELENGTHLIMIT then
		PushToast("#{TXSS_1000_095}")	
		return	false
	end
	
	-- �ǳƲ����к���
	if HaveCharact(tostring(strNickName)) == true then
		--PushToast("#{TXSS_2000_050}")	
		--return	false
	end
	-- ���зǷ��ַ������硰����"%","@","^"����!"
	if CheckIllegalString(tostring(strNickName)) == true then
		PushToast("#{ITEM_2000_031}")	
		return	false
	end
	
	local nResultCode = FilterKeyWords(strNickName)
	if nResultCode == 0 then
		PushToast("#{UIDL_1000_035}")
		return
	else 
	   SetSharedUserForKey("user_nickname", strNickName)
	   GameLogin:SendCreateCharMsg()
	 --  PushEvent("GUIDENEW_LOAD")
	end
	PushEvent("LOADINGWIDGET_LOAD")
	this:Hide()
end









