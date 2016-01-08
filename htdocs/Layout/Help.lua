-- 控件列表
local g_Help_Window={}

-- 图片列表
local g_Help_ImageView={
429,--引导图1
430,--引导图2
431,--引导图3
432,--引导图4
433,--下一个文字
434 --完成文字
}

--当前列表步骤
local currentStep=1



local MAX_IMAGE_COUNT=4

function	Help_PreLoad()
	this:RegisterEvent("HELP_LOAD")
end

function	Help_OnLoad()
g_Help_Window[1] = Help_ImageView
g_Help_Window[2] = Help_Next 		-- "下一步"按钮
g_Help_Window[3] = Help_Mask		-- 蒙版
g_Help_Window[4]=  Help_Next_Text	-- "下一步"按钮文字
g_Help_Window[5]=  Help_OK			-- "确定"按钮
g_Help_Window[6]=  Help_OK_Text		--"确定" 按钮文字
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
--		  显示全屏半透明灰色模板
--========================================
function  Help_ShowMask()
	g_Help_Window[3]:Show()
	g_Help_Window[3]:SetScale(40)
	g_Help_Window[3]:SetOpacity(200)	
end

--============================================
--		 点击“下一个”按钮事件
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
--		 点击“确定”按钮事件
--============================================
function Help_OK_Click()
	this:Hide()	
end












