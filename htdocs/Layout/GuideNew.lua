-- 控件列表
local g_GuideNew_Window={}

-- 图片列表
local g_GuideNew_ImageView={
429,--引导图1
430,--引导图2
431,--引导图3
432,--引导图4
433,--下一个文字
434 --完成文字
}
--<Property key="bTextureSet" value="true"/> 
--当前列表步骤
local currentStep=1

--判断新手引导是否完成
local isGuideCompleted="false"

local MAX_IMAGE_COUNT=4

function	GuideNew_PreLoad()
	this:RegisterEvent("GUIDENEW_LOAD")
end

function	GuideNew_OnLoad()
g_GuideNew_Window[1] = GuideNew_ImageView
g_GuideNew_Window[2] = GuideNew_Next -- "下一步"按钮
g_GuideNew_Window[3] = GuideNew_Mask		-- 蒙版
g_GuideNew_Window[4]=  GuideNew_Next_Text     -- "下一步"按钮文字
g_GuideNew_Window[5]=  GuideNew_OK     -- "确定"按钮
g_GuideNew_Window[6]=  GuideNew_OK_Text     --"确定" 按钮文字
end

function	GuideNew_OnEvent(event)
	if ( event == "GUIDENEW_LOAD" ) then
	  --  HideLoading() -- 非测试需要注释
	  
	   
	    isGuideCompleted = GetSharedUserForKey("GuideNew", "false")
		-- 新手引导完成 返回	
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
--		  显示全屏半透明灰色模板
--========================================
function  GuideNew_ShowMask()
	g_GuideNew_Window[3]:Show()
	g_GuideNew_Window[3]:SetScale(40)
	g_GuideNew_Window[3]:SetOpacity(200)	
end

--============================================
--		 点击“下一个”按钮事件
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
		--g_GuideNew_Window[4]:SetTexture(g_GuideNew_ImageView[6]) --完成文字
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
--		 点击“确定”按钮事件
--============================================
function GuideNew_OK_Click()
		GuideNew_GoToMain()
end


function GuideNew_GoToMain() 
	this:Hide()		
    SetSharedUserForKey("GuideNew", "true")
	--PushEvent("LOGIN_LOAD")
end










