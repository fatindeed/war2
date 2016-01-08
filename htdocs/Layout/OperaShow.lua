-- �ؼ��б�
local g_OperaShow_Window    = {}

-- ͼƬ�б�
local g_OperaShow_ImageView = {
	18, -- ����ͼ2
	19, -- ����ͼ3
	20, -- ����ͼ4
	21  -- ����ͼ5
}

-- ������������
local g_OperaShow_Caption = 
{
	"#{UIDL_1000_037}",
	"#{UIDL_1000_038}",
	"#{UIDL_1000_039}",
	"#{UIDL_1000_040}",
	"#{UIDL_1000_041}"
}

local g_OperaImageView_SequenceFrameIndex = 1 -- ������ͼ������֡����

function	OperaShow_PreLoad()
	this:RegisterEvent("OPERA_LOAD")
end

function	OperaShow_OnLoad()
	g_OperaShow_Window[1] = OperaShow_Window		  	-- ������
	g_OperaShow_Window[2] = OperaShow_ImageView 	  	-- ��������ͼƬ
	g_OperaShow_Window[3] = OperaShow_Timer			  	-- ��ʱ��
	g_OperaShow_Window[4] = OperaShow_PromptBg_Image	-- �����ı�����ͼ
	g_OperaShow_Window[5] = OperaShow_PromptBg_TextBox  -- �����ı�
	g_OperaShow_Window[6] = OperaMask_Timer				-- ���ֶ�ʱ�� 
end

function	OperaShow_OnEvent(event)
	if ( event == "OPERA_LOAD" ) then
		--this:Show()
		--OperaShow_InitPrompt()		
		--g_OperaShow_Window[3]:StartTime(1, 0, 4, 1)
		--PushEvent("CHOOSECHARACTER_LOAD")
		PushEvent("OPENINGBATTLE_LOAD")
    end
end

--======================================
--			    ��ʼ����ʾ
--======================================
function	OperaShow_InitPrompt()
	g_OperaShow_Window[4]:SetScaleX(40)
	g_OperaShow_Window[4]:SetScaleY(4)
	g_OperaShow_Window[4]:SetOpacity(200)
	
	g_OperaShow_Window[5]:SetPosition(25, -80)
	g_OperaShow_Window[5]:SetText("#{UIDL_1000_036}")
end

--=====================================
--				������ʾ����֡
--=====================================
function	OperaShow_EndShowOperaFrameEvent()
	if( g_OperaImageView_SequenceFrameIndex == 6) then
		g_OperaShow_Window[6]:StartTime(1, 0, 1, 1)
		g_OperaShow_Window[5]:FadeOut(1)		
	else	
		g_OperaShow_Window[2]:FadeOut(1)
		g_OperaShow_Window[4]:FadeOut(1)
		g_OperaShow_Window[5]:FadeOut(1)
		
		g_OperaShow_Window[6]:StartTime(1, 0, 1, 0.5)
	end
end

--=====================================
--				������ʾ����
--=====================================
function	OperaShow_EndShowMaskEvent()
	if (g_OperaImageView_SequenceFrameIndex < 5) then
		g_OperaShow_Window[2]:SetTexture(g_OperaShow_ImageView[g_OperaImageView_SequenceFrameIndex])
	
		g_OperaShow_Window[2]:FadeIn(0.2)
	elseif (g_OperaImageView_SequenceFrameIndex == 6) then
		PushEvent("OPENINGBATTLE_LOAD")
		OperaShow_Close()
		return
	else
		g_OperaShow_Window[5]:SetPosition(25, 150)			-- �������һ�ξ��е���Ļ
	end
	g_OperaShow_Window[5]:SetText(g_OperaShow_Caption[g_OperaImageView_SequenceFrameIndex])
	g_OperaImageView_SequenceFrameIndex = g_OperaImageView_SequenceFrameIndex + 1

	g_OperaShow_Window[4]:SetOpacity(200)
	g_OperaShow_Window[5]:FadeIn(0.2)	
	
	g_OperaShow_Window[3]:StartTime(1, 0, 7, 1)
end 


--=====================================
--			    ��������
--=====================================
function	OperaShow_OnSkipEvent()
	PushEvent("OPENINGBATTLE_LOAD")
	OperaShow_Close()
end

--=====================================
--			  �رս���
--=====================================
function    OperaShow_Close()
	g_OperaImageView_SequenceFrameIndex = 1
	g_OperaShow_Window[3]:StopTime()
	g_OperaShow_Window[6]:StopTime()
	
	this:Hide()
end


