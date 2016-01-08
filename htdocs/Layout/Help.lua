-- �ؼ��б�
local g_Help_Window={}

-- ͼƬ�б�
local g_Help_ImageView={
429,--����ͼ1
430,--����ͼ2
431,--����ͼ3
432,--����ͼ4
433,--��һ������
434 --�������
}

--��ǰ�б���
local currentStep=1



local MAX_IMAGE_COUNT=4

function	Help_PreLoad()
	this:RegisterEvent("HELP_LOAD")
end

function	Help_OnLoad()
g_Help_Window[1] = Help_ImageView
g_Help_Window[2] = Help_Next 		-- "��һ��"��ť
g_Help_Window[3] = Help_Mask		-- �ɰ�
g_Help_Window[4]=  Help_Next_Text	-- "��һ��"��ť����
g_Help_Window[5]=  Help_OK			-- "ȷ��"��ť
g_Help_Window[6]=  Help_OK_Text		--"ȷ��" ��ť����
end

function	Help_OnEvent(event)
	if ( event == "HELP_LOAD" ) then
	  
		Help_ShowMask()
		
		this:Show()	
		
		currentStep=1	
		g_Help_Window[1]:SetTexture(g_Help_ImageView[currentStep])
		g_Help_Window[1]:Show()
		g_Help_Window[2]:Show()
		g_Help_Window[4]:Show()
		g_Help_Window[5]:Hide()
		g_Help_Window[6]:Hide()
		     
    end
end

--========================================
--		  ��ʾȫ����͸����ɫģ��
--========================================
function  Help_ShowMask()
	g_Help_Window[3]:Show()
	g_Help_Window[3]:SetScale(40)
	g_Help_Window[3]:SetOpacity(200)	
end

--============================================
--		 �������һ������ť�¼�
--============================================
function Help_Next_Click()
	 currentStep=currentStep+1
	 if(currentStep<=MAX_IMAGE_COUNT) then
	 	 	g_Help_Window[1]:SetTexture(g_Help_ImageView[currentStep])
	 end
	 if(currentStep==MAX_IMAGE_COUNT) then
		 g_Help_Window[2]:Hide()
		 g_Help_Window[4]:Hide()
		 g_Help_Window[5]:Show()
		 g_Help_Window[6]:Show()
	 end
end

--============================================
--		 �����ȷ������ť�¼�
--============================================
function Help_OK_Click()
	this:Hide()	
end












