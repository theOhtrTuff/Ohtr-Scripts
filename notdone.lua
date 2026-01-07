-- Ohtr Auto Diamond (Auto-return + "Get rid of all Diamonds")
-- Paste into StarterPlayerScripts or run in executor

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Cleanup old GUI
if playerGui:FindFirstChild("OhtrAutoDiamondGUI") then
    playerGui.OhtrAutoDiamondGUI:Destroy()
end

--------------------------------------------------
-- STATE
--------------------------------------------------
local enabled = false
local diamondConn = nil
local autoReturn = true           -- NEW: auto-return toggle
local returnTimeout = 8           -- seconds to wait before returning if diamond isn't removed

--------------------------------------------------
-- HELPERS
--------------------------------------------------
local function getChar()
    return player.Character or player.CharacterAdded:Wait()
end

local function getHRP()
    local char = getChar()
    return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
end

local function getHumanoid()
    local char = player.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

--------------------------------------------------
-- GUI (build first so notify works)
--------------------------------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "OhtrAutoDiamondGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 340, 0, 200) -- increased height to fit new buttons
main.Position = UDim2.new(0.5, -170, 0.35, -90)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(28,28,28)
main.BorderSizePixel = 0
main.Active = true
main.Parent = screenGui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 38)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -120, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "💎 Auto Diamond"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(0, 170, 255)
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 28, 0, 24)
closeBtn.Position = UDim2.new(1, -36, 0, 7)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundColor3 = Color3.fromRGB(180,40,40)
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,6)

local status = Instance.new("TextLabel", main)
status.Size = UDim2.new(1, -20, 0, 20)
status.Position = UDim2.new(0, 10, 0, 46)
status.BackgroundTransparency = 1
status.Text = "Status: OFF"
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.TextColor3 = Color3.fromRGB(220,220,220)
status.TextXAlignment = Enum.TextXAlignment.Left

local toggleBtn = Instance.new("TextButton", main)
toggleBtn.Size = UDim2.new(0, 92, 0, 34)
toggleBtn.Position = UDim2.new(1, -110, 0, 40)
toggleBtn.Text = "OFF"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 16
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
toggleBtn.BackgroundColor3 = Color3.fromRGB(190,40,40)
toggleBtn.BorderSizePixel = 0
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0,8)

-- Auto-return toggle
local autoReturnBtn = Instance.new("TextButton", main)
autoReturnBtn.Size = UDim2.new(0, 110, 0, 28)
autoReturnBtn.Position = UDim2.new(0, 10, 0, 72)
autoReturnBtn.Text = "Auto Return: ON"
autoReturnBtn.Font = Enum.Font.Gotham
autoReturnBtn.TextSize = 13
autoReturnBtn.TextColor3 = Color3.fromRGB(255,255,255)
autoReturnBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
autoReturnBtn.BorderSizePixel = 0
Instance.new("UICorner", autoReturnBtn).CornerRadius = UDim.new(0,6)

local info = Instance.new("TextLabel", main)
info.Size = UDim2.new(1, -140, 0, 80)
info.Position = UDim2.new(0, 10, 0, 108)
info.BackgroundTransparency = 1
info.Text = "Only teleports to NEW Diamonds when they spawn.\nDrag header or the background to move GUI.\nUse 'Get rid' to remove/hide current Diamonds."
info.Font = Enum.Font.Gotham
info.TextSize = 13
info.TextWrapped = true
info.TextXAlignment = Enum.TextXAlignment.Left
info.TextColor3 = Color3.fromRGB(200,200,200)

-- Get rid button
local removeBtn = Instance.new("TextButton", main)
removeBtn.Size = UDim2.new(0, 200, 0, 28)
removeBtn.Position = UDim2.new(1, -210, 0, 72)
removeBtn.Text = "Get rid of all Diamonds"
removeBtn.Font = Enum.Font.Gotham
removeBtn.TextSize = 14
removeBtn.TextColor3 = Color3.fromRGB(255,255,255)
removeBtn.BackgroundColor3 = Color3.fromRGB(160,40,40)
removeBtn.BorderSizePixel = 0
Instance.new("UICorner", removeBtn).CornerRadius = UDim.new(0,6)

-- Simple popup notification (temporary)
local function notify(msg)
    local lbl = Instance.new("TextLabel", main)
    lbl.Size = UDim2.new(1, -20, 0, 24)
    lbl.Position = UDim2.new(0, 10, 1, -34)
    lbl.BackgroundTransparency = 0.75
    lbl.BackgroundColor3 = Color3.fromRGB(0,0,0)
    lbl.Text = msg
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", lbl).CornerRadius = UDim.new(0,6)
    task.delay(1.6, function()
        pcall(function() lbl:Destroy() end)
    end)
end

--------------------------------------------------
-- DIAMOND HANDLING (NEW SPAWNS ONLY) + AUTO RETURN
--------------------------------------------------
local function getDiamondCFrame(d)
    if not d then return nil end
    if d:IsA("BasePart") then
        return d.CFrame
    elseif d:IsA("Model") then
        if d.PrimaryPart then return d.PrimaryPart.CFrame end
        for _,c in ipairs(d:GetDescendants()) do
            if c:IsA("BasePart") then return c.CFrame end
        end
    end
    return nil
end

local function teleportToCFrame(cf)
    if not cf then return end
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not hrp then return end

    local pos = cf.Position + Vector3.new(0, 3, 0)
    local look = hrp.CFrame.LookVector

    local ok = pcall(function()
        if humanoid and humanoid.Sit and humanoid.SeatPart and humanoid.SeatPart:IsA("BasePart") then
            local seat = humanoid.SeatPart
            seat.Anchored = true
            seat.CFrame = CFrame.new(pos, pos + look)
            task.wait(0.05)
            seat.Anchored = false
        else
            hrp.Anchored = true
            hrp.CFrame = CFrame.new(pos, pos + look)
            task.wait(0.05)
            hrp.Anchored = false
        end
    end)

    if not ok then
        -- fallback direct set
        pcall(function()
            if humanoid and humanoid.Sit and humanoid.SeatPart and humanoid.SeatPart:IsA("BasePart") then
                humanoid.SeatPart.CFrame = CFrame.new(pos, pos + look)
            else
                hrp.CFrame = CFrame.new(pos, pos + look)
            end
        end)
    end
end

-- Wait for removal (returns true if removed within timeout)
local function waitForRemoval(obj, timeout)
    timeout = timeout or returnTimeout
    local start = tick()
    -- if object already removed:
    if not obj or not obj:IsDescendantOf(workspace) then return true end

    local removed = false
    local conn
    conn = obj.AncestryChanged:Connect(function()
        if not obj:IsDescendantOf(workspace) then
            removed = true
            if conn then conn:Disconnect() end
        end
    end)

    while tick() - start < timeout do
        if removed then
            return true
        end
        if not obj or not obj:IsDescendantOf(workspace) then
            if conn then conn:Disconnect() end
            return true
        end
        task.wait(0.12)
    end

    if conn then conn:Disconnect() end
    return false
end

-- main handler when new Diamond spawns
local function onDiamondAdded(obj)
    if not enabled then return end
    if not obj or obj.Name ~= "Diamond" then return end

    -- short delay to allow model to initialize
    task.wait(0.06)

    local cf = getDiamondCFrame(obj)
    if not cf then return end

    -- store current player CFrame for return
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local returnCFrame = hrp and hrp.CFrame

    -- teleport to diamond
    teleportToCFrame(cf)
    notify("💎 New Diamond found — teleported")

    if autoReturn and returnCFrame then
        -- wait for the diamond to be removed (collected) or timeout
        local removed = waitForRemoval(obj, returnTimeout)
        task.wait(0.12) -- small pause after removal
        -- return to previous location (if still valid)
        if removed then
            -- double-check character exists
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                teleportToCFrame(returnCFrame)
                notify("Returned to original position")
            end
        else
            -- timed out — still return (optional)
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                teleportToCFrame(returnCFrame)
                notify("Return (timeout)")
            end
        end
    end
end

local function startWatching()
    if diamondConn then return end
    diamondConn = workspace.DescendantAdded:Connect(onDiamondAdded)
    notify("Started watching for new Diamonds")
end

local function stopWatching()
    if diamondConn then
        diamondConn:Disconnect()
        diamondConn = nil
        notify("Stopped watching for Diamonds")
    end
end

--------------------------------------------------
-- "Get rid of all Diamonds" implementation
--------------------------------------------------
local function removeAllDiamonds()
    local found = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "Diamond" then
            found = found + 1
            -- Try to destroy (may fail on most servers)
            local ok, err = pcall(function() obj:Destroy() end)
            if not ok then
                -- fallback: hide locally for BaseParts
                if obj:IsA("BasePart") then
                    pcall(function()
                        obj.LocalTransparencyModifier = 1
                        obj.CanCollide = false
                        -- optionally anchor so it doesn't interfere
                        obj.Anchored = true
                    end)
                elseif obj:IsA("Model") then
                    for _, part in ipairs(obj:GetDescendants()) do
                        if part:IsA("BasePart") then
                            pcall(function()
                                part.LocalTransparencyModifier = 1
                                part.CanCollide = false
                                part.Anchored = true
                            end)
                        end
                    end
                end
            end
        end
    end
    notify("Tried to remove/hide " .. tostring(found) .. " Diamonds")
end

--------------------------------------------------
-- TOGGLE / BUTTONS
--------------------------------------------------
toggleBtn.MouseButton1Click:Connect(function()
    enabled = not enabled
    if enabled then
        toggleBtn.Text = "ON"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(60,200,120)
        status.Text = "Status: ON (waiting for spawn)"
        startWatching()
    else
        toggleBtn.Text = "OFF"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(190,40,40)
        status.Text = "Status: OFF"
        stopWatching()
    end
end)

autoReturnBtn.MouseButton1Click:Connect(function()
    autoReturn = not autoReturn
    if autoReturn then
        autoReturnBtn.Text = "Auto Return: ON"
        autoReturnBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
        notify("Auto Return enabled")
    else
        autoReturnBtn.Text = "Auto Return: OFF"
        autoReturnBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
        notify("Auto Return disabled")
    end
end)

removeBtn.MouseButton1Click:Connect(function()
    removeAllDiamonds()
end)

closeBtn.MouseButton1Click:Connect(function()
    stopWatching()
    pcall(function() screenGui:Destroy() end)
end)

--------------------------------------------------
-- DRAGGING (header + background)
--------------------------------------------------
do
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil

    local function beginDrag(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragInput = input
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end

    header.InputBegan:Connect(beginDrag)
    main.InputBegan:Connect(beginDrag) -- allow dragging by background too

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Final ready notify
notify("Auto Diamond GUI ready — toggle to start")
print("Ohtr Auto Diamond (auto-return + remove) loaded")
