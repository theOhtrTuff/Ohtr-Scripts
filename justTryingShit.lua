-- Safe Rayfield loader
local ok, Rayfield = pcall(function()
	return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)
if not ok or not Rayfield then
	warn("Rayfield failed to load:", Rayfield)
	return
end

-- Capybara custom theme
local CapybaraTheme = {
	TextColor = Color3.fromRGB(255, 240, 220),

	Background = Color3.fromRGB(97, 73, 50),
	Topbar = Color3.fromRGB(82, 60, 42),
	Shadow = Color3.fromRGB(60, 45, 35),

	NotificationBackground = Color3.fromRGB(60, 45, 35),
	NotificationActionsBackground = Color3.fromRGB(230, 230, 230),

	TabBackground = Color3.fromRGB(125, 95, 65),
	TabStroke = Color3.fromRGB(82, 60, 42),
	TabBackgroundSelected = Color3.fromRGB(165, 116, 80),
	TabTextColor = Color3.fromRGB(255, 240, 220),
	SelectedTabTextColor = Color3.fromRGB(60, 45, 35),

	ElementBackground = Color3.fromRGB(110, 85, 55),
	ElementBackgroundHover = Color3.fromRGB(125, 95, 65),
	SecondaryElementBackground = Color3.fromRGB(97, 73, 50),
	ElementStroke = Color3.fromRGB(82, 60, 42),
	SecondaryElementStroke = Color3.fromRGB(60, 45, 35),

	SliderBackground = Color3.fromRGB(165, 116, 80),
	SliderProgress = Color3.fromRGB(165, 116, 80),
	SliderStroke = Color3.fromRGB(210, 150, 100),

	ToggleBackground = Color3.fromRGB(97, 73, 50),
	ToggleEnabled = Color3.fromRGB(165, 116, 80),
	ToggleDisabled = Color3.fromRGB(110, 85, 55),
	ToggleEnabledStroke = Color3.fromRGB(210, 150, 100),
	ToggleDisabledStroke = Color3.fromRGB(82, 60, 42),
	ToggleEnabledOuterStroke = Color3.fromRGB(125, 95, 65),
	ToggleDisabledOuterStroke = Color3.fromRGB(60, 45, 35),

	DropdownSelected = Color3.fromRGB(125, 95, 65),
	DropdownUnselected = Color3.fromRGB(97, 73, 50),

	InputBackground = Color3.fromRGB(97, 73, 50),
	InputStroke = Color3.fromRGB(82, 60, 42),
	PlaceholderColor = Color3.fromRGB(178, 178, 178)
}

-- Create Rayfield window
local Window = Rayfield:CreateWindow({
    Name = "Capybara Hub",
    LoadingTitle = "Capybara Hub Loading...",
    LoadingSubtitle = "by Ohtr",
    Theme = CapybaraTheme,
    ToggleUIKeybind = "K",
    KeySystem = false
})

-- Main tab
local MainTab = Window:CreateTab("Main", 12517661299)

local Note = MainTab:CreateLabel(
	"You must be in the game for these scripts to work",
	13343542158,
	Color3.fromRGB(0, 0, 0),
	false
)

Note.BackgroundColor3 = Color3.fromRGB(255, 210, 150)
Note.BackgroundTransparency = 0
Note.TextStrokeTransparency = 0
Note.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
Note.TextScaled = true

-- "Who's the Spy? Admin Script"
MainTab:CreateButton({
	Name = "Who's the Spy? Admin Script",
	Callback = function()
		if game.PlaceId ~= 17218259625 then
			Rayfield:Notify({
				Title = "Wrong Game",
				Content = "Join the correct game before running this script!",
				Duration = 5
			})
			return
		end

		local player = game.Players.LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
		local interface = playerGui:WaitForChild("Interface")
		local main = interface:WaitForChild("Main")
		local adminFrame = main:WaitForChild("adminFrame")

		local toggleGui = Instance.new("ScreenGui", playerGui)
		toggleGui.Name = "ToggleGUI"

		local bg = Instance.new("Frame", toggleGui)
		bg.Size = UDim2.new(0, 250, 0, 120)
		bg.Position = UDim2.new(0, 50, 0, 50)
		bg.BackgroundColor3 = Color3.fromRGB(30,30,30)
		bg.Active = true
		bg.Draggable = true

		local title = Instance.new("TextLabel", bg)
		title.Size = UDim2.new(1, -20, 0, 30)
		title.Position = UDim2.new(0, 10, 0, 10)
		title.Text = "Who's the Spy? Admin Script"
		title.TextScaled = true
		title.TextColor3 = Color3.fromRGB(255,255,255)
		title.BackgroundTransparency = 1

		local toggleButton = Instance.new("TextButton", bg)
		toggleButton.Size = UDim2.new(1, -20, 0, 50)
		toggleButton.Position = UDim2.new(0, 10, 0, 60)
		toggleButton.Text = "Admin: OFF"
		toggleButton.TextScaled = true
		toggleButton.BackgroundColor3 = Color3.fromRGB(165, 116, 80)
		toggleButton.TextColor3 = Color3.fromRGB(255,255,255)

		adminFrame.Visible = false

		toggleButton.MouseButton1Click:Connect(function()
			adminFrame.Visible = not adminFrame.Visible
			if adminFrame.Visible then
				toggleButton.Text = "Admin: ON"
				toggleButton.BackgroundColor3 = Color3.fromRGB(210, 150, 100)
			else
				toggleButton.Text = "Admin: OFF"
				toggleButton.BackgroundColor3 = Color3.fromRGB(165, 116, 80)
			end
		end)
	end
})

-- Glass Bridge Loop Money
MainTab:CreateButton({
	Name = "The $1,000,000 Glass Bridge Loop Money",
	Callback = function()
		if game.PlaceId ~= 87854376962069 then
			Rayfield:Notify({
				Title = "Wrong Game",
				Content = "Join the correct game before running this script!",
				Duration = 5
			})
			return
		end

		local player = game.Players.LocalPlayer
		local RS = game:GetService("ReplicatedStorage")
		local event = RS:WaitForChild("GiveClaimMoney")

		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "MoneyLoopGUI"
		screenGui.ResetOnSpawn = false
		screenGui.Parent = player:WaitForChild("PlayerGui")

		local button = Instance.new("TextButton")
		button.Size = UDim2.new(0, 200, 0, 50)
		button.Position = UDim2.new(0.4, 0, 0.1, 0)
		button.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
		button.TextColor3 = Color3.new(1, 1, 1)
		button.TextScaled = true
		button.Font = Enum.Font.GothamBold
		button.Text = "Loop 10K Money: OFF"
		button.Parent = screenGui

		local looping = false

		button.MouseButton1Click:Connect(function()
			looping = not looping
			if looping then
				button.Text = "Loop 10K Money: ON"
				button.BackgroundColor3 = Color3.fromRGB(60, 255, 60)
				task.spawn(function()
					while looping do
						event:FireServer(player)
						task.wait(0.05)
					end
				end)
			else
				button.Text = "Loop 10K Money: OFF"
				button.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
			end
		end)
	end
})

-- SAMMY JUMP ROPE Loop Money
MainTab:CreateButton({
	Name = "SAMMY JUMP ROPE Loop Money",
	Callback = function()
		if game.PlaceId ~= 97622296096899 then
			Rayfield:Notify({
				Title = "Wrong Game",
				Content = "Join the correct game before running this script!",
				Duration = 5
			})
			return
		end

		local player = game:GetService("Players").LocalPlayer
		local RS = game:GetService("ReplicatedStorage")
		local event = RS:WaitForChild("Remotes"):WaitForChild("ClaimMoney")

		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "ClaimMoneyGUI"
		screenGui.ResetOnSpawn = false
		screenGui.Parent = player:WaitForChild("PlayerGui")

		local button = Instance.new("TextButton")
		button.Size = UDim2.new(0, 220, 0, 50)
		button.Position = UDim2.new(0.4, 0, 0.1, 0)
		button.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
		button.TextColor3 = Color3.new(1, 1, 1)
		button.TextScaled = true
		button.Font = Enum.Font.GothamBold
		button.Text = "ClaimMoney Loop: OFF"
		button.Parent = screenGui

		local dragging
		local dragInput
		local dragStart
		local startPos

		local function update(input)
			local delta = input.Position - dragStart
			button.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end

		button.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true
				dragStart = input.Position
				startPos = button.Position

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)

		button.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				dragInput = input
			end
		end)

		game:GetService("UserInputService").InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				update(input)
			end
		end)

		local looping = false

		button.MouseButton1Click:Connect(function()
			looping = not looping
			if looping then
				button.Text = "ClaimMoney Loop: ON"
				button.BackgroundColor3 = Color3.fromRGB(60, 255, 60)
				task.spawn(function()
					while looping do
						local args = {
							workspace:WaitForChild("Chest"):WaitForChild("Claim"):WaitForChild("ProximityPrompt")
						}
						event:FireServer(unpack(args))
						task.wait(0.01)
					end
				end)
			else
				button.Text = "ClaimMoney Loop: OFF"
				button.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
			end
		end)
	end
})

-- Math Murder Script
MainTab:CreateButton({
	Name = "Math Murder Script",
	Callback = function()
		if game.PlaceId ~= 127707120843339 then
			Rayfield:Notify({
				Title = "Wrong Game",
				Content = "Join the correct game before running this script!",
				Duration = 5
			})
			return
		end

		loadstring(game:HttpGet("https://pastebin.com/raw/M4GuPPVA"))()
	end
})

MainTab:CreateButton({
      Name = "Knockout Simulator Script",
    Callback = function()
        if game.PlaceId ~= 13667319624 then
            Rayfield:Notify({
                Title = "Wrong Game",
                Content = "Join the correct game before running this script!",
                Duration = 5
            })
            return
        end

        loadstring(game:HttpGet("https://raw.githubusercontent.com/theOhtrTuff/Ohtr-Scripts/main/KnockoutSimulator.lua"))()
    end
})

MainTab:CreateButton({
    Name = "Break In 2 OP Script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EnesXVC/Breakin2/main/script"))()
    end
})

MainTab:CreateButton({
    Name = "ShaderX-Universal",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AsiiXacx/AcxScripter/refs/heads/main/ShaderX-Universal"))()
    end
})

MainTab:CreateButton({
    Name = "Shoot The Boss OP Script / FREE GAMEPASS ",
    Callback = function()
        if game.PlaceId ~= 115196082055466 then
            Rayfield:Notify({
                Title = "Wrong Game",
                Content = "Join the correct game before running this script!",
                Duration = 5
            })
            return
        end

        loadstring(game:HttpGet("https://raw.githubusercontent.com/theOhtrTuff/Ohtr-Scripts/main/ShootTheBoss.lua"))()
    end
})

MainTab:CreateButton({
      Name = "Murderers VS Sheriffs DUELS zephyr Scirpt",
    Callback = function()
        if game.PlaceId ~= 12355337193 then
            Rayfield:Notify({
                Title = "Wrong Game",
                Content = "Join the correct game before running this script!",
                Duration = 5
            })
            return
        end

        loadstring(game:HttpGet("https://raw.githubusercontent.com/TheRealAvrwm/Zephyr-V2/refs/heads/main/ZephyrV2", true))()
    end
})

MainTab:CreateButton({
      Name = "Speed Freddy Escape OP Script",
    Callback = function()
        if game.PlaceId ~= 122409947397263 then
            Rayfield:Notify({
                Title = "Wrong Game",
                Content = "Join the correct game before running this script!",
                Duration = 5
            })
            return
        end

        loadstring(game:HttpGet("https://pastebin.com/raw/zbsmigp6"))()
    end
})

MainTab:CreateButton({
    Name = "Speed Run Simulator Script",
    Callback = function()
        if game.PlaceId ~= 5293755937 then
            Rayfield:Notify({
                Title = "Wrong Game",
                Content = "Join the correct game before running this script!",
                Duration = 5
            })
            return
        end

        loadstring(game:HttpGet("https://raw.githubusercontent.com/OhtrTheRealOne/Main.lua/main/SpeedRunHub.lua"))()
    end
})

MainTab:CreateButton({
    Name = "Ban or Get Banned auto farm",
    Callback = function()
        if game.PlaceId ~= 96017656548489 then
            Rayfield:Notify({
                Title = "Wrong Game",
                Content = "Join the correct game before running this script!",
                Duration = 5
            })
            return
        end

        loadstring(game:HttpGet("https://pastebin.com/raw/p4w4V2cB"))()
    end
})

MainTab:CreateButton({
      Name = "Blue Lock: Skibidi Script",
    Callback = function()
        if game.PlaceId ~= 77021749781226 then
            Rayfield:Notify({
                Title = "Wrong Game",
                Content = "Join the correct game before running this script!",
                Duration = 5
            })
            return
        end

        loadstring(game:HttpGet("https://pastebin.com/raw/rtkeSkPE"))()
    end
})

MainTab:CreateButton({
      Name = "Tower of Hell Free tools",
    Callback = function()
        if game.PlaceId ~= 1962086868 then
            Rayfield:Notify({
                Title = "Wrong Game",
                Content = "Join the correct game before running this script!",
                Duration = 5
            })
            return
        end

        loadstring(game:HttpGet("https://pastebin.com/raw/ngajQNQ3"))()
    end
})

MainTab:CreateButton({
      Name = "Don't Get Crushed By 67 Auto Farm",
    Callback = function()
        if game.PlaceId ~= 124082555806669 then
            Rayfield:Notify({
                Title = "Wrong Game",
                Content = "Join the correct game before running this script!",
                Duration = 5
            })
            return
        end

        loadstring(game:HttpGet("https://raw.githubusercontent.com/theOhtrTuff/Ohtr-Scripts/main/67Script.lua"))()
    end
})


local MainTab = Window:CreateTab("Script Origins", 91967227182381)

-- Scripts made by Ohtr
MainTab:CreateLabel("Tower of Hell — Free Tools: by Ohtr")
MainTab:CreateLabel("Blue Lock: Skibidi Script: by Ohtr & AYETANO88")
MainTab:CreateLabel("Speed Run Simulator Script: by Ohtr")
MainTab:CreateLabel("Shoot The Boss OP Script : by Ohtr")
MainTab:CreateLabel("SAMMY JUMP ROPE — Loop Money: by Ohtr the goat")
MainTab:CreateLabel("The $1,000,000 Glass Bridge — Loop Money: by Ohtr")
MainTab:CreateLabel("Who's the Spy? — Admin Script: by Ohtr")
MainTab:CreateLabel("Speed Freddy Escape Script: by Ohtr")

-- Scripts by others / unknown
MainTab:CreateLabel("Ban or Get Banned — Auto Farm: by Scriptyyz")
MainTab:CreateLabel("ShaderX-Universal: by AcxScripter")
MainTab:CreateLabel("Break In 2 — OP Script: by Unknown")
MainTab:CreateLabel("Math Murder Script: by Unknown")
MainTab:CreateLabel("Don't Get Crushed By 67 Auto Farm: by Ohtr")
----------------------------------------------------------------
-- ScriptHelperX TAB (FULL, CLEAN LABELS)
----------------------------------------------------------------

-- Create tab (working icon)
local ScriptHelperXTab = Window:CreateTab("ScriptHelperX", 4483362458)

----------------------------------------------------------------
-- DEV TOOLS
----------------------------------------------------------------
ScriptHelperXTab:CreateSection("Dev Tools")

ScriptHelperXTab:CreateButton({
    Name = "DEX Explorer",
    Callback = function()
        loadstring(game:HttpGet(
            "https://rawscripts.net/raw/Universal-Script-Dex-Explorer-DPP-73687"
        ))()
    end
})

ScriptHelperXTab:CreateButton({
    Name = "Remote Spy (SimpleSpy)",
    Callback = function()
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"
        ))()
    end
})

ScriptHelperXTab:CreateButton({
    Name = "Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"
        ))()
    end
})

ScriptHelperXTab:CreateButton({
    Name = "RSpy (Solara Supported)",
    Callback = function()
        loadstring(game:HttpGet(
            "https://rawscripts.net/raw/Universal-Script-require-viewer-SOLARA-SUPPORTED-48326"
        ))()
    end
})

----------------------------------------------------------------
-- EXECUTOR
----------------------------------------------------------------
ScriptHelperXTab:CreateSection("Executor")

local ScriptText = ""

local ScriptInput = ScriptHelperXTab:CreateInput({
    Name = "Paste Lua Script",
    PlaceholderText = "Paste script here",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        ScriptText = text or ""
    end
})

ScriptHelperXTab:CreateButton({
    Name = "Execute Script",
    Callback = function()
        if ScriptText == "" then
            Rayfield:Notify({
                Title = "ScriptHelperX",
                Content = "No script to execute.",
                Duration = 2
            })
            return
        end

        local ok, err = pcall(function()
            loadstring(ScriptText)()
        end)

        if not ok then
            warn("Executor Error:", err)
            Rayfield:Notify({
                Title = "Script Error",
                Content = tostring(err),
                Duration = 4
            })
        end
    end
})

ScriptHelperXTab:CreateButton({
    Name = "Clear Script",
    Callback = function()
        ScriptText = ""
        ScriptInput:Set("")
        Rayfield:Notify({
            Title = "ScriptHelperX",
            Content = "Script cleared.",
            Duration = 2
        })
    end
})

----------------------------------------------------------------
-- SCRIPT NOTES (SMALL, READABLE LABELS)
----------------------------------------------------------------
ScriptHelperXTab:CreateSection("How Scripts Work")

ScriptHelperXTab:CreateLabel("A script is Lua code that tells Roblox what to do.")
ScriptHelperXTab:CreateLabel("Executors run scripts using loadstring().")
ScriptHelperXTab:CreateLabel("Scripts can run on the client or server.")

ScriptHelperXTab:CreateLabel("")

ScriptHelperXTab:CreateLabel("Core Services:")
ScriptHelperXTab:CreateLabel("• Players → access players & LocalPlayer")
ScriptHelperXTab:CreateLabel("• Workspace → the game map")
ScriptHelperXTab:CreateLabel("• ReplicatedStorage → remotes & shared items")
ScriptHelperXTab:CreateLabel("• UserInputService → keyboard & mouse")

ScriptHelperXTab:CreateLabel("")

ScriptHelperXTab:CreateLabel("Client vs Server:")
ScriptHelperXTab:CreateLabel("• LocalScripts run on your client")
ScriptHelperXTab:CreateLabel("• Scripts run on the server")
ScriptHelperXTab:CreateLabel("• RemoteEvents connect both sides")

ScriptHelperXTab:CreateLabel("")

ScriptHelperXTab:CreateLabel("Important Rules:")
ScriptHelperXTab:CreateLabel("• Always use pcall() to prevent crashes")
ScriptHelperXTab:CreateLabel("• Never use while true without task.wait()")
ScriptHelperXTab:CreateLabel("• Read errors carefully")

ScriptHelperXTab:CreateLabel("")

ScriptHelperXTab:CreateLabel("Dev Tools:")
ScriptHelperXTab:CreateLabel("• Dex → explore game objects")
ScriptHelperXTab:CreateLabel("• SimpleSpy → see remote calls")
ScriptHelperXTab:CreateLabel("• Infinite Yield → admin utilities")

ScriptHelperXTab:CreateLabel("")

ScriptHelperXTab:CreateLabel("How to Learn:")
ScriptHelperXTab:CreateLabel("1) Copy small scripts")
ScriptHelperXTab:CreateLabel("2) Understand each line")
ScriptHelperXTab:CreateLabel("3) Rewrite it yourself")
ScriptHelperXTab:CreateLabel("4) Improve it")

ScriptHelperXTab:CreateLabel("")

ScriptHelperXTab:CreateLabel("Practice is everything.")
ScriptHelperXTab:CreateLabel("Break scripts.")
ScriptHelperXTab:CreateLabel("Fix them.")
ScriptHelperXTab:CreateLabel("Get better.")
