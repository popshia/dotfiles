hs.hotkey.bind({ "cmd" }, "g", function()
	local browser = hs.application.get("Google Chrome")
	if browser then
		if browser:isFrontmost() then
			browser:selectMenuItem("Hide Google Chrome")
			-- browser:hide()
		else
			hs.application.launchOrFocus("Google Chrome")
			-- browser:activate()
		end
	else
		hs.application.launchOrFocus("Google Chrome")
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
