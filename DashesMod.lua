-- DashesModGUI.lua
-- Put this LocalScript in StarterPlayerScripts (or StarterGui)

--[[ 
WARNING:
Modifies every dash move in the game, including Kaiser Dash.
Some dash abilities (e.g. Undead Dribbling) may glitch or not function as intended.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- ===== CONFIG DEFAULTS =====
local speedMultiplier = 1.0
local forceMultiplier = 1.0
local enabled = false

-- internal state
local moddedBVs = {}
local connections = {}

-- ===== UI CREATION =====
local function makeGui()
	-- cleanup
	if player.PlayerGui:FindFirstChild("DashesModGUI") then
		player.PlayerGui.DashesModGUI:Destroy()
	end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "DashesModGUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = player:WaitForChild("PlayerGui")

	local main = Instance.new("Frame")
	main.Name = "Main"
	main.Size = UDim2.new(0, 320, 0, 210)
	main.Position = UDim2.new(0, 20, 0, 100)
	main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	main.BorderSizePixel = 0
	main.Parent = screenGui

	-- TITLE
	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -10, 0, 28)
	title.Position = UDim2.new(0, 5, 0, 5)
	title.BackgroundTransparency = 1
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Font = Enum.Font.SourceSansBold
	title.TextSize = 20
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Text = "Dashes Mod GUI  ⚠"
	title.Parent = main

	-- WARNING LABEL (VISIBLE)
	local warning = Instance.new("TextLabel")
	warning.Size = UDim2.new(1, -10, 0, 44)
	warning.Position = UDim2.new(0, 5, 0, 36)
	warning.BackgroundTransparency = 1
	warning.TextWrapped = true
	warning.TextXAlignment = Enum.TextXAlignment.Left
	warning.TextYAlignment = Enum.TextYAlignment.Top
	warning.Font = Enum.Font.SourceSans
	warning.TextSize = 13
	warning.TextColor3 = Color3.fromRGB(255, 120, 120)
	warning.Text =
		"⚠ Modifies every dash move in the game, including Kaiser Dash.\n" ..
		"Some dash abilities (e.g. Undead Dribbling) may glitch or not function as intended."
	warning.Parent = main

	-- helpers
	local function makeLabel(y, text)
		local lbl = Instance.new("TextLabel")
		lbl.Size = UDim2.new(0, 140, 0, 20)
		lbl.Position = UDim2.new(0, 10, 0, y)
		lbl.BackgroundTransparency = 1
		lbl.Text = text
		lbl.Font = Enum.Font.SourceSans
		lbl.TextSize = 14
		lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
		lbl.TextXAlignment = Enum.TextXAlignment.Left
		lbl.Parent = main
		return lbl
	end

	local function makeBox(y, placeholder)
		local box = Instance.new("TextBox")
		box.Size = UDim2.new(0, 120, 0, 22)
		box.Position = UDim2.new(0, 170, 0, y)
		box.PlaceholderText = placeholder
		box.Text = ""
		box.TextSize = 14
		box.Font = Enum.Font.SourceSans
		box.ClearTextOnFocus = false
		box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		box.TextColor3 = Color3.fromRGB(255, 255, 255)
		box.Parent = main
		return box
	end

	-- INPUTS
	makeLabel(88, "Speed multiplier")
	local speedBox = makeBox(86, "1.0")

	makeLabel(116, "Force multiplier")
	local forceBox = makeBox(114, "1.0")

	-- BUTTONS
	local enableBtn = Instance.new("TextButton")
	enableBtn.Size = UDim2.new(0, 140, 0, 30)
	enableBtn.Position = UDim2.new(0, 10, 0, 155)
	enableBtn.Text = "Enable"
	enableBtn.Font = Enum.Font.SourceSansBold
	enableBtn.TextSize = 16
	enableBtn.TextColor3 = Color3.fromRGB(255,255,255)
	enableBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
	enableBtn.Parent = main

	local resetBtn = Instance.new("TextButton")
	resetBtn.Size = UDim2.new(0, 140, 0, 30)
	resetBtn.Position = UDim2.new(0, 170, 0, 155)
	resetBtn.Text = "Reset"
	resetBtn.Font = Enum.Font.SourceSans
	resetBtn.TextSize = 14
	resetBtn.TextColor3 = Color3.fromRGB(255,255,255)
	resetBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
	resetBtn.Parent = main

	-- handlers
	speedBox.FocusLost:Connect(function()
		local v = tonumber(speedBox.Text)
		if v and v > 0 then
			speedMultiplier = v
		else
			speedBox.Text = tostring(speedMultiplier)
		end
	end)

	forceBox.FocusLost:Connect(function()
		local v = tonumber(forceBox.Text)
		if v and v > 0 then
			forceMultiplier = v
		else
			forceBox.Text = tostring(forceMultiplier)
		end
	end)

	enableBtn.MouseButton1Click:Connect(function()
		enabled = not enabled
		if enabled then
			enableBtn.Text = "Disable"
			enableBtn.BackgroundColor3 = Color3.fromRGB(80, 170, 80)
			startWatchingCharacter()
		else
			enableBtn.Text = "Enable"
			enableBtn.BackgroundColor3 = Color3.fromRGB(170, 80, 80)
			stopWatchingCharacter()
		end
	end)

	resetBtn.MouseButton1Click:Connect(function()
		speedMultiplier = 1.0
		forceMultiplier = 1.0
		speedBox.Text = "1.0"
		forceBox.Text = "1.0"
	end)

	speedBox.Text = tostring(speedMultiplier)
	forceBox.Text = tostring(forceMultiplier)
end

-- ===== BodyVelocity modification helpers =====
local function modBodyVelocity(bv)
	if not bv or not bv.Parent then return end
	if bv:GetAttribute("DashesMod_Modded") then return end
	bv:SetAttribute("DashesMod_Modded", true)

	local baseMag = bv.Velocity.Magnitude
	if baseMag <= 0.0001 then baseMag = 1 end

	moddedBVs[bv] = {
		baseMag = baseMag;
		origMax = bv.MaxForce;
	}
end

local renderConn
local function startRender()
	if renderConn then return end
	renderConn = RunService.RenderStepped:Connect(function()
		if not enabled then return end
		for bv, info in pairs(moddedBVs) do
			if bv and bv.Parent then
				local hrp = bv.Parent
				local dir = hrp:IsA("BasePart") and hrp.CFrame.LookVector or bv.Velocity.Unit
				bv.Velocity = dir.Unit * (info.baseMag * speedMultiplier)
				bv.MaxForce = info.origMax * forceMultiplier
			end
		end
	end)
end

local function stopRender()
	if renderConn then renderConn:Disconnect() renderConn = nil end
end

-- ===== Character watching =====
local function watchCharacter(char)
	for _,v in ipairs(char:GetDescendants()) do
		if v:IsA("BodyVelocity") then
			modBodyVelocity(v)
		end
	end

	connections.DescAdded = char.DescendantAdded:Connect(function(d)
		if d:IsA("BodyVelocity") then
			modBodyVelocity(d)
		end
	end)
end

function startWatchingCharacter()
	if player.Character then
		watchCharacter(player.Character)
	end
	connections.CharAdded = player.CharacterAdded:Connect(function(char)
		task.wait(0.2)
		watchCharacter(char)
	end)
	startRender()
end

function stopWatchingCharacter()
	for _,c in pairs(connections) do
		if typeof(c) == "RBXScriptConnection" then c:Disconnect() end
	end
	connections = {}
	moddedBVs = {}
	stopRender()
end

-- ===== START =====
makeGui()
