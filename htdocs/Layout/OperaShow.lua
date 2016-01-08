-- 控件列表
local g_OperaShow_Window    = {}

-- 图片列表
local g_OperaShow_ImageView = {
	18, -- 引导图2
	19, -- 引导图3
	20, -- 引导图4
	21  -- 引导图5
}

-- 剧情文字序列
local g_OperaShow_Caption = 
{
	"#{UIDL_1000_037}",
	"#{UIDL_1000_038}",
	"#{UIDL_1000_039}",
	"#{UIDL_1000_040}",
	"#{UIDL_1000_041}"
}

local g_OperaImageView_SequenceFrameIndex = 1 -- 剧情视图的序列帧索引

function	OperaShow_PreLoad()
	this:RegisterEvent("OPERA_LOAD")
end

function	OperaShow_OnLoad()
	g_OperaShow_Window[1] = OperaShow_Window		  	-- 主窗口
	g_OperaShow_Window[2] = OperaShow_ImageView 	  	-- 开场动画图片
	g_OperaShow_Window[3] = OperaShow_Timer			  	-- 定时器
	g_OperaShow_Window[4] = OperaShow_PromptBg_Image	-- 剧情文本背景图
	g_OperaShow_Window[5] = OperaShow_PromptBg_TextBox  -- 剧情文本
	g_OperaShow_Window[6] = OperaMask_Timer				-- 遮罩定时器 
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
--			    初始化提示
--======================================
function	OperaShow_InitPrompt()
	g_OperaShow_Window[4]:SetScaleX(40)
	g_OperaShow_Window[4]:SetScaleY(4)
	g_OperaShow_Window[4]:SetOpacity(200)
	
	g_OperaShow_Window[5]:SetPosition(25, -80)
	g_OperaShow_Window[5]:SetText("#{UIDL_1000_036}")
end

--=====================================
--				结束显示剧情帧
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
--				结束显示遮罩
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
		g_OperaShow_Window[5]:SetPosition(25, 150)			-- 设置最后一次居中的字幕
	end
	g_OperaShow_Window[5]:SetText(g_OperaShow_Caption[g_OperaImageView_SequenceFrameIndex])
	g_OperaImageView_SequenceFrameIndex = g_OperaImageView_SequenceFrameIndex + 1

	g_OperaShow_Window[4]:SetOpacity(200)
	g_OperaShow_Window[5]:FadeIn(0.2)	
	
	g_OperaShow_Window[3]:StartTime(1, 0, 7, 1)
end 


--=====================================
--			    跳过界面
--=====================================
function	OperaShow_OnSkipEvent()
	PushEvent("OPENINGBATTLE_LOAD")
	OperaShow_Close()
end

--=====================================
--			  关闭界面
--=====================================
function    OperaShow_Close()
	g_OperaImageView_SequenceFrameIndex = 1
	g_OperaShow_Window[3]:StopTime()
	g_OperaShow_Window[6]:StopTime()
	
	this:Hide()
end


