local g_NPCDialog_Main = {}

local g_NPCDialog_Time = 0	-- �Ի�����



-------------Ԥ����----------------
function	NPCDialog_PreLoad()
	this:RegisterEvent("NPC_Dialog_LOAD")
end

------------�������---------------
function	NPCDialog_OnLoad()
	g_NPCDialog_Main[1]  = NPCDialog_Background				-- ����ͼ
	g_NPCDialog_Main[2]  = NPCDialog_Left_Img				-- ͷ��(��)
	g_NPCDialog_Main[3]  = NPCDialog_Left_Chat				-- ���ݱ���(��)
	g_NPCDialog_Main[4]  = NPCDialog_Text_Left				-- ��������(��)
	g_NPCDialog_Main[5]  = NPCDialog_Name_Left				-- ����(��)
	g_NPCDialog_Main[6]  = NPCDialog_Right_Img				-- ͷ��(��)
	g_NPCDialog_Main[7]  = NPCDialog_Right_Chat				-- ���ݱ���(��)
	g_NPCDialog_Main[8]	 = NPCDialog_Text_Right				-- ��������(��)
	g_NPCDialog_Main[9]  = NPCDialog_Name_Right				-- ����(��)
end

-----------��Ӧ�¼�----------------
function	NPCDialog_OnEvent(event)
	if ( event == "NPC_Dialog_LOAD" ) then
		
		g_NPCDialog_Main[1]:SetScale(40)
		g_NPCDialog_Main[1]:SetOpacity(200)
		this:Show()

		-- NPCͷ��ͼƬ�� λ�� ��1�� 2��)������
		local tNPC,tPosition,tContent = DataPool:GetNpcDialogItem(0)
		local tName = DataPool:GetNpcDialogText(0)
		-- ��������
		NPCDialog_LoadData(tNPC,tPosition,tName,tContent)
		
		CloseRequestWaitProgress()	
	end
end

---------ˢ�����ݵķ���------------
function	NPCDialog_LoadData(tIMG,tPosition,tName,tContent)
	if tPosition == 1 then  -- NPC���������

		for i = 2,4,1 do	-- ��ʾ������ߵ�UI
			g_NPCDialog_Main[i]:Show()		
		end
		for j = 5,9,1 do 	-- ���������ұߵ�UI
			g_NPCDialog_Main[j]:Hide()		
		end
		-- ͷ��(��)
		g_NPCDialog_Main[2]:SetTexture(tIMG) 		
		-- ��������(��)
		local tSize = g_NPCDialog_Main[4]:SetText(tContent)		
		-- ����(��)		
		g_NPCDialog_Main[5]:SetText(tName)						
		
	elseif tPosition == 2 then -- NPC�������ұ�
		-- ����������ߵ�UI	
		for i = 2,5,1 do	
			g_NPCDialog_Main[i]:Hide()		
		end
		-- ��ʾ�����ұߵ�UI
		for j = 6,8,1 do 	
			g_NPCDialog_Main[j]:Show()		
		end
		-- ͷ��(��)
		g_NPCDialog_Main[6]:SetTexture(tIMG) 
		g_NPCDialog_Main[6]:SetFlipX(true)		
		-- ��������(��)
		local tSize = g_NPCDialog_Main[8]:SetText(tContent)		
		-- ����(��)		
		g_NPCDialog_Main[9]:SetText(tName)			
	end
end

---------�رմ���------------------
function	NPCDialog_Close()
	
	g_NPCDialog_Time = g_NPCDialog_Time + 1
	
	-- ���ָ���	�Ի�����
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
	
	-- ��������
	NPCDialog_LoadData(tNPC,tPosition,tName,tContent)
	
end