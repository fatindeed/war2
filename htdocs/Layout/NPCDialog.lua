local g_NPCDialog_Main = {}

local g_NPCDialog_Time = 0	-- 对话个数



-------------预加载----------------
function	NPCDialog_PreLoad()
	this:RegisterEvent("NPC_Dialog_LOAD")
end

------------载入界面---------------
function	NPCDialog_OnLoad()
	g_NPCDialog_Main[1]  = NPCDialog_Background				-- 背景图
	g_NPCDialog_Main[2]  = NPCDialog_Left_Img				-- 头像(左)
	g_NPCDialog_Main[3]  = NPCDialog_Left_Chat				-- 气泡背景(左)
	g_NPCDialog_Main[4]  = NPCDialog_Text_Left				-- 气泡内容(左)
	g_NPCDialog_Main[5]  = NPCDialog_Name_Left				-- 名字(左)
	g_NPCDialog_Main[6]  = NPCDialog_Right_Img				-- 头像(右)
	g_NPCDialog_Main[7]  = NPCDialog_Right_Chat				-- 气泡背景(右)
	g_NPCDialog_Main[8]	 = NPCDialog_Text_Right				-- 气泡内容(右)
	g_NPCDialog_Main[9]  = NPCDialog_Name_Right				-- 名字(右)
end

-----------响应事件----------------
function	NPCDialog_OnEvent(event)
	if ( event == "NPC_Dialog_LOAD" ) then
		
		g_NPCDialog_Main[1]:SetScale(40)
		g_NPCDialog_Main[1]:SetOpacity(200)
		this:Show()

		-- NPC头像图片、 位置 （1左 2右)、内容
		local tNPC,tPosition,tContent = DataPool:GetNpcDialogItem(0)
		local tName = DataPool:GetNpcDialogText(0)
		-- 加载数据
		NPCDialog_LoadData(tNPC,tPosition,tName,tContent)
		
		CloseRequestWaitProgress()	
	end
end

---------刷新数据的方法------------
function	NPCDialog_LoadData(tIMG,tPosition,tName,tContent)
	if tPosition == 1 then  -- NPC出现在左边

		for i = 2,4,1 do	-- 显示所有左边的UI
			g_NPCDialog_Main[i]:Show()		
		end
		for j = 5,9,1 do 	-- 隐藏所有右边的UI
			g_NPCDialog_Main[j]:Hide()		
		end
		-- 头像(左)
		g_NPCDialog_Main[2]:SetTexture(tIMG) 		
		-- 气泡内容(左)
		local tSize = g_NPCDialog_Main[4]:SetText(tContent)		
		-- 名字(左)		
		g_NPCDialog_Main[5]:SetText(tName)						
		
	elseif tPosition == 2 then -- NPC出现在右边
		-- 隐藏所有左边的UI	
		for i = 2,5,1 do	
			g_NPCDialog_Main[i]:Hide()		
		end
		-- 显示所有右边的UI
		for j = 6,8,1 do 	
			g_NPCDialog_Main[j]:Show()		
		end
		-- 头像(右)
		g_NPCDialog_Main[6]:SetTexture(tIMG) 
		g_NPCDialog_Main[6]:SetFlipX(true)		
		-- 气泡内容(右)
		local tSize = g_NPCDialog_Main[8]:SetText(tContent)		
		-- 名字(左)		
		g_NPCDialog_Main[9]:SetText(tName)			
	end
end

---------关闭窗口------------------
function	NPCDialog_Close()
	
	g_NPCDialog_Time = g_NPCDialog_Time + 1
	
	-- 名字个数	对话个数
	local NameNum,ItemNum =DataPool:GetNpcDialogNum()
	
	if g_NPCDialog_Time >= ItemNum then
		local scriptId = DataPool:GetNpcDialogScript()
			ClearScript()
			SetFunction("OnNpcDialogComplete")
			SetScriptID(scriptId)
			SendScript()
			this:Hide()
			g_NPCDialog_Time = 0
		return	
	end
	
	local tNPC,tPosition,tContent = DataPool:GetNpcDialogItem(g_NPCDialog_Time)
	local tName = DataPool:GetNpcDialogText(g_NPCDialog_Time)
	
	-- 加载数据
	NPCDialog_LoadData(tNPC,tPosition,tName,tContent)
	
end