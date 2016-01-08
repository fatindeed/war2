-- 控件列表
local g_WorldPlayer_Window = {}
local g_Count = 0

-- 是否可以请求服务器搜索玩家  每隔10S请求一次服务器
local g_bSearchPlayerEnable = true    

function	WorldPlayer_PreLoad()
	this:RegisterEvent("WORLDPLAYER_LOAD")
	this:RegisterEvent("WORLDPLAYER_LOAD_UPDATA")
end

function	WorldPlayer_OnLoad()
	g_WorldPlayer_Window[1]=WorldPlayer_Planet1_TextBox
    g_WorldPlayer_Window[2]=WorldPlayer_Planet2_TextBox
	g_WorldPlayer_Window[3]=WorldPlayer_Planet3_TextBox
	g_WorldPlayer_Window[4]=WorldPlayer_Planet4_TextBox
	g_WorldPlayer_Window[5]=WorldPlayer_Planet5_TextBox
	g_WorldPlayer_Window[6]=WorldPlayer_Planet6_TextBox
	g_WorldPlayer_Window[7]=WorldPlayer_Planet7_TextBox
	g_WorldPlayer_Window[8]=WorldPlayer_Planet8_TextBox
	g_WorldPlayer_Window[9]=WorldPlayer_PlanetCount
	g_WorldPlayer_Window[10]=WorldPlayer_Search_Timer		 -- 触发搜索玩家按键的定时器
	-----
	g_WorldPlayer_Window[11]=WorldPlayer_Player1
	g_WorldPlayer_Window[12]=WorldPlayer_Player2
	g_WorldPlayer_Window[13]=WorldPlayer_Player3
	g_WorldPlayer_Window[14]=WorldPlayer_Player4
	g_WorldPlayer_Window[15]=WorldPlayer_GoHome
	
	---
	g_WorldPlayer_Window[16]=WorldPlayer_Planet1
	g_WorldPlayer_Window[17]=WorldPlayer_Planet2
	g_WorldPlayer_Window[18]=WorldPlayer_Planet3
	g_WorldPlayer_Window[19]=WorldPlayer_Planet4
	g_WorldPlayer_Window[20]=WorldPlayer_Planet5
	g_WorldPlayer_Window[21]=WorldPlayer_Planet6
	g_WorldPlayer_Window[22]=WorldPlayer_Planet7
	g_WorldPlayer_Window[23]=WorldPlayer_Planet8
	
	g_WorldPlayer_Window[24]=WorldPlayer_Search
	
	
end

function	WorldPlayer_OnEvent(event)

   
	if ( event == "WORLDPLAYER_LOAD" ) then
		this:Show()
		--HideLoading()  --非测试需要注释
	    WorldPlayer_Init()
		--g_WorldPlayer_Window[1]:SetText("1000")	
      -- WorldPlayer_ShowPlayer()
    elseif ( event == "WORLDPLAYER_LOAD_UPDATA" )  then
        --PushEvent("SCENESWITCH_OPEN")
        WorldPlayer_ShowPlayer()
  
  
    end
end

--============================================
--				   初始化窗口
--============================================
function WorldPlayer_Init()
	DataPool:AskWorldPlayer()
	g_WorldPlayer_Window[11]:Hide()
	g_WorldPlayer_Window[12]:Hide()
	g_WorldPlayer_Window[13]:Hide()
	g_WorldPlayer_Window[14]:Hide()
	g_WorldPlayer_Window[15]:Hide()
end

--============================================
--				   关闭窗口
--============================================
function WorldPlayer_Close()
	this:Hide()
end
--============================================
--				   点击搜索按钮
--============================================
function WorldPlayer_Search_Click()
	-- 如果在10S之内请求过服务器 返回  
	if g_bSearchPlayerEnable == false then
		-- 弹出提示 PushToast 
		PushToast("#{UISJ_1000_003}")
		-- 开启禁用搜索玩家的按键定时器
	else
	  -- DataPool:AskWorldPlayer()
	   PushEvent("SCENESWITCH_CLOSE")
	   -- 禁止请求服务器
	   g_bSearchPlayerEnable = false
	   g_WorldPlayer_Window[10]:StartTime(3, 0, 1, 1)
	end	
end

--============================================
--				   展示获取到的玩家
--============================================
function WorldPlayer_ShowPlayer()

g_Count=0
local params
--g_WorldPlayer_Window[1]:AddMarqueeMessage("2312312313232132313213313")
for i=1,8,1 do 
    
	params=DataPool:GetWorldPlayer(tonumber(i)-1)	

	if(params~=nil) then
       
		 g_WorldPlayer_Window[i]:SetText(tostring(params))--显示名字
		 g_Count=g_Count+1
    else
	     g_WorldPlayer_Window[i]:SetText("#{UISJ_1000_002}") --没有名字
	end

end

g_WorldPlayer_Window[9]:SetText("#{UISJ_1000_001}:" .. tostring(g_Count));   

end

--==============================================
--			解锁搜索玩家按键事件  回调接口
--==============================================
function WorldPlayer_Search_EndTimeEvent()
	-- 开启请求服务器 允许搜索玩家	
	g_bSearchPlayerEnable = true
	-- 停止禁用搜索玩家的定时器
	g_WorldPlayer_Window[10]:StopTime()
end

--===============================================
--			    查看星球 事件
--===============================================
function WorldPlayer_OnPlanetDetailEvent()
	math.randomseed(tostring(os.time()))
	local index = math.random(4)
	index = math.random(4)
	if index < 10 then
		return
	end
	g_WorldPlayer_Window[16]:Hide()
	g_WorldPlayer_Window[17]:Hide()
	g_WorldPlayer_Window[18]:Hide()
	g_WorldPlayer_Window[19]:Hide()
	g_WorldPlayer_Window[20]:Hide()
	g_WorldPlayer_Window[21]:Hide()
	g_WorldPlayer_Window[22]:Hide()
	g_WorldPlayer_Window[23]:Hide()
	g_WorldPlayer_Window[24]:Hide()
	if index == 1 then
		g_WorldPlayer_Window[11]:Show()
		--g_WorldPlayer_Window[11]:SetScale(3)
		--g_WorldPlayer_Window[11]:SetOpacity(100)

		--PushToast("1111111")
		g_WorldPlayer_Window[12]:Hide()
		g_WorldPlayer_Window[13]:Hide()
		g_WorldPlayer_Window[14]:Hide()
	elseif index == 2 then
		g_WorldPlayer_Window[12]:Show()
		--g_WorldPlayer_Window[12]:SetScale(30)
		--g_WorldPlayer_Window[12]:SetOpacity(100)
		--PushToast("222222222222222")
		g_WorldPlayer_Window[11]:Hide()
		g_WorldPlayer_Window[13]:Hide()
		g_WorldPlayer_Window[14]:Hide()
	elseif index == 3 then
		g_WorldPlayer_Window[13]:Show()
		--g_WorldPlayer_Window[13]:SetScale(10)
		--g_WorldPlayer_Window[13]:SetOpacity(100)
		
		--PushToast("333333333333333333")
		g_WorldPlayer_Window[12]:Hide()
		g_WorldPlayer_Window[11]:Hide()
		g_WorldPlayer_Window[14]:Hide()
	elseif index == 4 then
		g_WorldPlayer_Window[14]:Show()
		--g_WorldPlayer_Window[14]:SetScale(20)
		--g_WorldPlayer_Window[14]:SetOpacity(100)
		--PushToast("4444444444444444444")
		g_WorldPlayer_Window[12]:Hide()
		g_WorldPlayer_Window[13]:Hide()
		g_WorldPlayer_Window[11]:Hide()
	else
		--PushToast("#{TIP_1000_023}")
	end
	
end












