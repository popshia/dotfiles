hs.hotkey.bind({ "cmd" }, "g", function()
	local browser = hs.application.get("Arc")
	if browser then
		if browser:isFrontmost() then
			browser:selectMenuItem("Hide Arc")
			-- browser:hide()
		else
			hs.application.launchOrFocus("Arc")
			-- browser:activate()
		end
	else
		hs.application.launchOrFocus("Arc")
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
