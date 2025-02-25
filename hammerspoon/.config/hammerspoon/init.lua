hs.hotkey.bind({ "cmd" }, "g", function()
	local browser = hs.application.get("Arc")
	-- local browser = hs.application.get("Google Chrome")
	-- local browser = hs.application.get("Safari")
	if browser then
		if browser:isFrontmost() then
			browser:selectMenuItem("Hide Arc")
			-- browser:selectMenuItem("Hide Google Chrome")
			-- browser:selectMenuItem("Hide Safari")
			-- browser:hide()
		else
			hs.application.launchOrFocus("Arc")
			-- hs.application.launchOrFocus("Google Chrome")
			-- hs.application.launchOrFocus("Safari")
			-- browser:activate()
		end
	else
		hs.application.launchOrFocus("Arc")
		-- hs.application.launchOrFocus("Google Chrome")
		-- hs.application.launchOrFocus("Safari")
		-- browser:activate()
	end
end)

hs.hotkey.bind({ "cmd" }, "r", function()
	local terminal = hs.application.get("kitty")
	if terminal then
		if terminal:isFrontmost() then
			terminal:selectMenuItem("Hide kitty")
			-- terminal:hide()
		else
			hs.application.launchOrFocus("kitty")
			-- browser:activate()
		end
	else
		hs.application.launchOrFocus("kitty")
		-- browser:activate()
	end
end)
