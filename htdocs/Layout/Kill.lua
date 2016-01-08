local 	g_Kill_Windows = {}
local	BEGIN = 0
local	MOVED = 1
local	ENDED = 2
local	STATE = 0

function	Kill_PreLoad()
	this:RegisterEvent("KILL_LOAD")						-- ‘ÿ»Î¥∞ø⁄
end

function	Kill_OnLoad()
	
	g_Kill_Windows[1] = Kill_Window

	g_Kill_Windows[2] = Kill_Value

	g_Kill_Windows[3] = Kill_Godkill

	g_Kill_Windows[4] = Kill_Image

	g_Kill_Windows[5] = Kill_TimeMich

end

function	Kill_OnEvent(event)

	if event == "KILL_LOAD" then
		
		local number = tonumber( arg0 )

		if number == nil or number <=0 then
			this:Hide()
			return ;		
		end

		this:Show()
		
		g_Kill_Windows[3]:Hide()

		g_Kill_Windows[2]:Show()
		
		local g_Width ,g_Height = g_Kill_Windows[2]:GetSize()
		local g_Xposition,g_Yposition = g_Kill_Windows[2]:GetPosition()
		local t_Widht ,t_Height = g_Kill_Windows[4]:GetSize()
			
		local u_Position =  ( 800 - ( g_Width + t_Widht ) ) / 2
			
		g_Kill_Windows[2]:SetPosition(u_Position,g_Yposition)
			
		g_Kill_Windows[4]:SetPosition(u_Position + g_Width ,g_Yposition)
		
		if number == 1 then	-- 	1 kill

			g_Kill_Windows[2]:SetAtlasTexture("ms_1.png")

		elseif number == 2 then	--	2 kill

			g_Kill_Windows[2]:SetAtlasTexture("ms_2.png")

		elseif number == 3 then	--	3 kill
		
			g_Kill_Windows[2]:SetAtlasTexture("ms_3.png")
			
		elseif number > 3 then	--	god kill
			
			local g_Width ,g_Height = g_Kill_Windows[3]:GetSize()
			local g_Xposition,g_Yposition = g_Kill_Windows[3]:GetPosition()
			local t_Widht ,t_Height = g_Kill_Windows[4]:GetSize()
			
			local u_Position =  ( 800 - ( g_Width + t_Widht ) ) / 2
			
			g_Kill_Windows[3]:SetPosition(u_Position,g_Yposition)
			
			g_Kill_Windows[4]:SetPosition(u_Position + g_Width ,g_Yposition)
			
			g_Kill_Windows[2]:Hide()	

			g_Kill_Windows[3]:Show()

		end

		STATE = BEGIN

		--g_Kill_Windows[1]:SetPosition(0,0)

		--Kill_FadeIn()
		g_Kill_Windows[1]:PopUp(0.1)
		g_Kill_Windows[5]:StartTime(3, 0, 1, 0.4)
		
	end

end

function	Kill_Update()
	if STATE == MOVED then
	
		Kill_FadeOut()

		STATE = ENDED
		
	elseif STATE == ENDED then

		this:Hide()
		
		-- g_Kill_Windows[4]:StopTime()
		
	else
		STATE = MOVED
	end
end

function	Kill_FadeIn()
	
	g_Kill_Windows[1]:MoveTo(0.2,0,65)

end

function	Kill_FadeOut()
	
	g_Kill_Windows[1]:PopDown(0.1)

end


