-- �ؼ��б�
local g_GuideNew_Window={}

-- ͼƬ�б�
local g_GuideNew_ImageView={
429,--����ͼ1
430,--����ͼ2
431,--����ͼ3
432,--����ͼ4
433,--��һ������
434 --�������
}
--<Property key="bTextureSet" value="true"/> 
--��ǰ�б���
local currentStep=1

--�ж����������Ƿ����
local isGuideCompleted="false"

local MAX_IMAGE_COUNT=4

function	GuideNew_PreLoad()
	this:RegisterEvent("GUIDENEW_LOAD")
end

function	GuideNew_OnLoad()
g_GuideNew_Window[1] = GuideNew_ImageView
g_GuideNew_Window[2] = GuideNew_Next -- "��һ��"��ť
g_GuideNew_Window[3] = GuideNew_Mask		-- �ɰ�
g_GuideNew_Window[4]=  GuideNew_Next_Text     -- "��һ��"��ť����
g_GuideNew_Window[5]=  GuideNew_OK     -- "ȷ��"��ť
g_GuideNew_Window[6]=  GuideNew_OK_Text     --"ȷ��" ��ť����
end

function	GuideNew_OnEvent(event)
	if ( event == "GUIDENEW_LOAD" ) then
	  --  HideLoading() -- �ǲ�����Ҫע��
	  
	   
	    isGuideCompleted = GetSharedUserForKey("GuideNew", "false")
		-- ����������� ����	
		if 	isGuideCompleted == "true" then
			return		
		end
		
		--isGuideCompleted = "false"
		
		
		GuideNew_ShowMask()
		
		if (isGuideCompleted=="false") then
				this:Show()	
				
				currentStep=1	
				g_GuideNew_Window[1]:SetTexture(g_GuideNew_ImageView[currentStep])
				g_GuideNew_Window[1]:Show()
				g_GuideNew_Window[2]:Show()
				g_GuideNew_Window[4]:Show()
				g_GuideNew_Window[5]:Hide()
				g_GuideNew_Window[6]:Hide()
		        
		elseif (isGuideCompleted=="true")	then
			    this:Hide()		
		end
    end
end

--========================================
--		  ��ʾȫ����͸����ɫģ��
--========================================
function  GuideNew_ShowMask()
	g_GuideNew_Window[3]:Show()
	g_GuideNew_Window[3]:SetScale(40)
	g_GuideNew_Window[3]:SetOpacity(200)	
end

--============================================
--		 �������һ������ť�¼�
--============================================
function GuideNew_Next_Click()
	 currentStep=currentStep+1
	 if(currentStep<=MAX_IMAGE_COUNT) then
	 	 	g_GuideNew_Window[1]:SetTexture(g_GuideNew_ImageView[currentStep])
			
	 end
	 
	 
	 if(currentStep==MAX_IMAGE_COUNT) then
	 	--g_GuideNew_Window[2]:SetNormal9PatchImg("uishijie_anniuchangtai.png")
		--g_GuideNew_Window[2]:SetSelect9PatchImg("uishijie_anxiaanniu.png")
		--g_GuideNew_Window[2]:SetPosition(319, 300)	
		--g_GuideNew_Window[4]:SetPosition(319, 300)
		--g_GuideNew_Window[4]:SetTexture(g_GuideNew_ImageView[6]) --�������
			    g_GuideNew_Window[2]:Hide()
				g_GuideNew_Window[4]:Hide()
				g_GuideNew_Window[5]:Show()
				g_GuideNew_Window[6]:Show()
		
	 end
	 --[[
	 if(currentStep>MAX_IMAGE_COUNT) then
	 
		--PushToast("#{TXSS_2000_049}")
		GuideNew_GoToMain()
	 end
     --]]
	 
end

--============================================
--		 �����ȷ������ť�¼�
--============================================
function GuideNew_OK_Click()
		GuideNew_GoToMain()
end


function GuideNew_GoToMain() 
	this:Hide()		
    SetSharedUserForKey("GuideNew", "true")
	--PushEvent("LOGIN_LOAD")
end










