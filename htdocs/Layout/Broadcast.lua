local g_Broadcast_Main = {}	

function	Broadcast_PreLoad()
	this:RegisterEvent("BROADCAST_LOAD")
end

function	Broadcast_OnLoad()
	g_Broadcast_Main[1] = Broadcast_Marquee_Text  				-- �����ı�����
end

function	Broadcast_OnEvent(event)
	if ( event == "BROADCAST_LOAD" ) then
		if (arg0 ~= nil) then
			if this:IsVisible() == false then
			    this:Show()
			end
			g_Broadcast_Main[1]:AddMarqueeMessage(tostring(arg0))
		end
	end
end

--============================================
--				   �رմ���
--============================================
function Broadcast_Close()
	this:Hide()
end