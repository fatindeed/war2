
local g_MoveMenu_Main = {}	

local g_nBuildingSellPrice = {90, 150, 240, 60, 150, 300, 150, 6000, 150, 1500, 30, 15000, 6000, 30000, 6000}

function	MoveMenu_PreLoad()
	this:RegisterEvent("MOVE_MENU_LOAD")			  -- 加载(显示)
	this:RegisterEvent("MOVE_MENU_UNLOAD")			  -- 反向加载(隐藏)
	this:RegisterEvent("MOVE_MENU_DESTORY_OK")		  -- 禁用OK按钮
	this:RegisterEvent("MOVE_MENU_DESTORY_SELL")	  -- 禁用出售按钮
	this:RegisterEvent("MOVE_MENU_USE_OK")			  -- 取消OK按钮的禁用
	this:RegisterEvent("MOVE_MENU_USE_SELL")		  -- 取消售卖按钮的禁用
	this:RegisterEvent("MOVE_MENU_TO_MAIN")			  -- 回到主界面
	this:RegisterEvent("MOVE_MENU_MOVE_BUILD")		  -- 移动建筑
	this:RegisterEvent("MOVE_MENU_UPDATE")			  -- 移动菜单坐标更新
end

function	MoveMenu_OnLoad()
	g_MoveMenu_Main[1] = MoveMenu_Background		  -- 背景图
	g_MoveMenu_Main[2] = MoveMenu_OnCancel			  -- 取消按钮
	g_MoveMenu_Main[3] = MoveMenu_OnSell			  -- 出售按钮
	g_MoveMenu_Main[4] = MoveMenu_OnOk				  -- 确认按钮
end

function	MoveMenu_OnEvent(event)
	if  event == "MOVE_MENU_LOAD"  then
		if arg0 ~= nil and arg1 ~= nil then
--=========================================
--				建造建筑的时候
--=========================================
			this:Show()
			arg0 = tonumber(arg0)
			arg1 = tonumber(arg1)
			this:SetPosition(arg0 - 93, arg1 - 75)
		end
	elseif event == "MOVE_MENU_MOVE_BUILD" then
		if arg0 ~= nil and arg1 ~= nil then
--=========================================
--				移动建筑的时候
--				2013年5月21日	修改:不能出售兵营
--				log:修改建筑信息表的时候一定要修改这个方法
--=========================================
			this:Show()
			--g_MoveMenu_Main[2]:SetPosition(5,0)
			g_MoveMenu_Main[3]:Show()
			--g_MoveMenu_Main[4]:SetPosition(115,0)
			arg0 = tonumber(arg0)
			arg1 = tonumber(arg1)
			this:SetPosition(arg0 - 93, arg1 - 75)
			
			--local buildID = BuildData:GetMainTargetBuildState("MainTargetBuild_ID")
			--if( buildID == 10 ) then	-- {医院、资源储备库} 禁止售卖			
			--	PushEvent("MOVE_MENU_DESTORY_SELL")			
			--end
		end	
	elseif event == "MOVE_MENU_UNLOAD" then 		
--=========================================
--				隐藏菜单的时候
--=========================================
			--CloseAllWidget()
			this:Hide()
	elseif event == "MOVE_MENU_DESTORY_OK" then
--=========================================
--				禁用提交按钮
--=========================================
			g_MoveMenu_Main[4]:DestoryButton()
	elseif event == "MOVE_MENU_DESTORY_SELL" then
--=========================================
--				禁用出售按钮
--=========================================
			g_MoveMenu_Main[3]:DestoryButton()
	elseif event == "MOVE_MENU_USE_OK" then
--=========================================
--				取消确定禁用
--=========================================
			g_MoveMenu_Main[4]:UNDestoryButton()
	elseif event == "MOVE_MENU_USE_SELL" then
--=========================================
--				取消售卖禁用
--=========================================
			g_MoveMenu_Main[3]:UNDestoryButton()			
	elseif event == "MOVE_MENU_TO_MAIN" then
--=========================================
--				回到主场景
--=========================================
			--CloseAllWidget()
			PushEvent("MAIN_MENU_LOAD")
			PushEvent("RESOURCE_BAR_LOAD")
			PushEvent("PORTRAIT_LEFT_LOAD")
			PushEvent("TASK_LIST_LOAD")
			PushEvent("MAIN_CHAT_LOAD")	
	elseif event == "MOVE_MENU_UNLOAD" then 		
	
--=========================================
--				隐藏菜单的时候
--=========================================
		--CloseAllWidget()
		this:Hide()
	elseif event == "MOVE_MENU_UPDATE" then
	
--=========================================
--				移动菜单坐标更新
--=========================================
		if arg0 ~= nil and arg1 ~= nil then
			local x = tonumber(arg0)
			local y = tonumber(arg1)
			MoveMenu_ResetPos(x, y)
		end
	end
end

--=========================================
--				移动确定
--=========================================
function	MoveMenu_YES()
	local Index	= BuildData:GetMainTargetBuildState("MainTargetBuild_ID")
	local TYPE  = BuildData:GetMainTargetBuildState("MainTargetBuild_State_ID")
	if TYPE == -1 then
		local g_Ptb = BuildData:GetBuildInfo("Use_Money", Index)
		local mPtb	=	Player:GetDiamond()
		if g_Ptb > 0 then
			if mPtb >= g_Ptb then
				PushEvent("COMMON_TIP_BUY",0,Index)	
			else
				--[[弹出平台币不足--]]	
			end
		else
			PushEvent("MOVE_MENU_UNLOAD")
			Move_OK()	
		end
	else	
		PushEvent("MOVE_MENU_UNLOAD")
		Move_OK()	
	end

end

--=========================================
--				移动取消
--=========================================
function	MoveMenu_NO()
	this:Hide()
	Move_NO()
end

--=========================================
--					出售
--=========================================
function	MoveMenu_Sell()
	--如果卖掉的建筑类型为住房，
	--验证卖掉住房之后的总人口是否 < 当前工作人口
	local BuildType, BuildIndexID = BuildData:GetMainTargetBuildState("MainTargetBuild_TYPE_ID")
	
	if (BuildType == 0) then -- 验证建筑类型为住房
		local _,_,personCount,_,_,_ = BuildData:GetHouseInfo(BuildIndexID)	--住房增加的人口
		-- 当前工作人口和最大人口
		local curPerson, maxPerson = Player:GetPerson()
		
		if (maxPerson - personCount < curPerson) then
			PushMessageBox("#{TXSS_2000_018}")
			Move_OK()	
			PushEvent("MOVE_LOAD")
			return 
		end	
	end	
	
	PushEvent("COMMON_TIP_TOSELL", g_nBuildingSellPrice[BuildIndexID + 1])
	
	-- this:Hide()	
end

--=========================================
--				  重置位置
--=========================================
function  MoveMenu_ResetPos(x, y)
	x = x - 93
	y = y - 75
	this:SetPosition(x, y)
end