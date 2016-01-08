local 	g_Settings_Windows = {}

local g_bOpenMusic  = "true"  							-- �Ƿ�������
	
local g_bOpenEffect = "true"							-- �Ƿ�����Ч

local g_bBgMusicName="bg_music_setting"                 -- �������ֱ�����

local g_bEffectMusicName="effect_music_setting"         -- ��Ч���ֱ�����

function	Settings_PreLoad()
	this:RegisterEvent("SETTINGS_LOAD")					-- ���봰��
end

function	Settings_OnLoad()
	g_Settings_Windows[1] = Settings_Mask
	g_Settings_Windows[2] = Settings_LeftBG
	g_Settings_Windows[3] = Settings_Title_Text
	g_Settings_Windows[4] = Settings_Music_Text
	g_Settings_Windows[5] = Settings_Effect_Text
	g_Settings_Windows[6] = Settings_Button_Music
	g_Settings_Windows[7] = Settings_Button_Effect
	g_Settings_Windows[8] = Settings_Music_Img
	g_Settings_Windows[9] = Settings_Effect_Img
end

function	Settings_OnEvent(event)
	if event == "SETTINGS_LOAD" then
		this:Show()
		
		Settings_ShowMask()	
		
		g_Settings_Windows[3]:SetText("#{UISZ_1000_001}")
		g_Settings_Windows[4]:SetText("#{UISZ_1000_002}") 
		g_Settings_Windows[5]:SetText("#{UISZ_1000_003}")
		
		g_bOpenMusic=GetSharedUserForKey(g_bBgMusicName, "true")
		
		if g_bOpenMusic == "true" then
			g_Settings_Windows[8]:Show()
		else
			g_Settings_Windows[8]:Hide()
		end
		
		g_bOpenEffect=GetSharedUserForKey(g_bEffectMusicName, "true")
		
		if g_bOpenEffect == "true" then
			g_Settings_Windows[9]:Show()
		else 
			g_Settings_Windows[9]:Hide()
		end
	end
end

--========================================
--		   ��ʾȫ����͸����ɫģ��
--========================================
function  Settings_ShowMask()
	g_Settings_Windows[1]:Show()
	g_Settings_Windows[1]:SetScale(40)
	g_Settings_Windows[1]:SetOpacity(200)	
end

--========================================
--		   		���ֿ����¼�
--========================================
function Settings_OnMusicSwitchEvent()
	if g_bOpenMusic	== "false" then
		g_Settings_Windows[8]:Show()
		g_bOpenMusic ="true"
	else
		g_Settings_Windows[8]:Hide()
		g_bOpenMusic = "false"
	end
	SetSharedUserForKey(g_bBgMusicName, g_bOpenMusic)
	SetBgMusic()
end

--========================================
--		   		��Ч�����¼�
--========================================
function Settings_OnEffectSwitchEvent()
	if g_bOpenEffect == "false" then	
		g_Settings_Windows[9]:Show()
		g_bOpenEffect ="true"
	else
		g_Settings_Windows[9]:Hide()
		g_bOpenEffect = "false"
	end
	SetSharedUserForKey(g_bEffectMusicName, g_bOpenEffect)
	SetEffectMusic()
end

--========================================
--		   		�رս����¼�
--========================================
function Settings_OnCloseEvent()
	this:Hide()
end
