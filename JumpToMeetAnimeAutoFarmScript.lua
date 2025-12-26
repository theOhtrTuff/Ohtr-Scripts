
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer


pcall(function()
    game.CoreGui.JumpToMeetAnimeGUI:Destroy()
end)


local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "JumpToMeetAnimeGUI"
gui.ResetOnSpawn = false


local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 420, 0, 220)
main.Position = UDim2.new(0.5, -210, 0.4, -110)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true 

-- RAINBOW BAR
local rainbow = Instance.new("Frame", main)
rainbow.Size = UDim2.new(1,0,0,6)
rainbow.BorderSizePixel = 0

local grad = Instance.new("UIGradient", rainbow)
grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255,255,0)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0,255,0)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0,255,255)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0,0,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255,0,255)),
}


RunService.RenderStepped:Connect(function()
    grad.Rotation += 1
end)


local title = Instance.new("TextLabel", main)
title.Text = "Jump To Meet Anime! Auto Farm Script"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1,0,0,30)
title.Position = UDim2.new(0,0,0,10)


local status = Instance.new("TextLabel", main)
status.Text = "Status: Idle"
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.TextColor3 = Color3.fromRGB(180,180,180)
status.BackgroundTransparency = 1
status.Size = UDim2.new(1,0,0,20)
status.Position = UDim2.new(0,0,0,45)


local toggle = Instance.new("TextButton", main)
toggle.Size = UDim2.new(0,200,0,40)
toggle.Position = UDim2.new(0.5,-100,1,-60)
toggle.BackgroundColor3 = Color3.fromRGB(30,30,30)
toggle.TextColor3 = Color3.fromRGB(0,255,120)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 16
toggle.Text = "AUTO FARM : OFF"


local running = false

local function getChar()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    return hrp, hum
end

local function tp(cf)
    local hrp = getChar()
    hrp.CFrame = cf + Vector3.new(0,3,0)
end

task.spawn(function()
    while true do
        task.wait(0.1)
        if running then
            local hrp, hum = getChar()
            local cps = Workspace:WaitForChild("Checkpoints")
            local wins = Workspace:WaitForChild("WinsParts")

            status.Text = "Status: Running..."

            -- 1 → 24
            for i = 1, 24 do
                if not running then break end
                local cp = cps:FindFirstChild("Checkpoint_"..i)
                if cp then
                    hrp.CFrame = cp.CFrame + Vector3.new(0,3,0)
                    task.wait(0.3)
                end
            end

            if not running then continue end

            hrp.CFrame = cps.Checkpoint_45.CFrame + Vector3.new(0,3,0)
            task.wait(0.4)

            hrp.CFrame = cps.Checkpoint_52.CFrame + Vector3.new(0,3,0)
            task.wait(0.5)

            hrp.CFrame = wins.WinPart5.CFrame + Vector3.new(0,3,0)
            task.wait(0.3)

            hum.Health = 0
            player.CharacterAdded:Wait()
            task.wait(0.6)
        end
    end
end)


toggle.MouseButton1Click:Connect(function()
    running = not running
    if running then
        toggle.Text = "AUTO FARM : ON"
        toggle.TextColor3 = Color3.fromRGB(255,80,80)
        status.Text = "Status: Enabled"
    else
        toggle.Text = "AUTO FARM : OFF"
        toggle.TextColor3 = Color3.fromRGB(0,255,120)
        status.Text = "Status: Disabled"
    end
end)

status.Text = "Status: Ready"
