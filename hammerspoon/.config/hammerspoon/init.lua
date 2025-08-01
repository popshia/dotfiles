hs.application.enableSpotlightForNameSearches(true)

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

hs.hotkey.bind({ "cmd" }, "m", function()
	local figma = hs.application.get("Figma")
	if figma then
		if figma:isFrontmost() then
			figma:selectMenuItem("Hide Figma")
			-- browser:hide()
		else
			hs.application.launchOrFocus("Figma")
			-- browser:activate()
		end
	else
		hs.application.launchOrFocus("Figma")
		-- browser:activate()
	end
end)

hs.hotkey.bind({ "cmd" }, "d", function()
	local zed = hs.application.get("Zed")
	if zed then
		if zed:isFrontmost() then
			zed:selectMenuItem("Hide Zed")
			-- browser:hide()
		else
			hs.application.launchOrFocus("Zed")
			-- browser:activate()
		end
	else
		hs.application.launchOrFocus("Zed")
		-- browser:activate()
	end
end)
