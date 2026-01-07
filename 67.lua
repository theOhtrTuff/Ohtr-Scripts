-- Load Osmium library
local ok, library = pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/TrixAde/Osmium/main/OsmiumLibrary.lua")))
if not ok or not library then return end

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer

-- Anti-AFK
player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- UI
local window = library:CreateWindow("Osmium UI Library")
local mainTab = window:CreateTab("Main")
local autoFarmTab = window:CreateTab("Auto Farm")

-- Worlds
local worlds = {
    ["BloodMoon"] = {name = "BloodMoon", money = 8400},
    ["Fire"]      = {name = "Fire",      money = 3150},
    ["Starter"]   = {name = "Starter",   money = 900},
    ["Toxic"]     = {name = "Toxic",     money = 5250},
    ["CyberPunk"] = {name = "CyberPunk", money = 12000},
}

local toggleStates = {}
local loops = {}

for displayName, data in pairs(worlds) do
    toggleStates[data.name] = false
    loops[data.name] = false

    autoFarmTab:CreateToggle(displayName.." Auto Farm", false, function(state)
        toggleStates[data.name] = state
        if not state or loops[data.name] then return end

        loops[data.name] = true
        task.spawn(function()
            while toggleStates[data.name] do
                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")

                -- wait BEFORE teleport
                task.wait(21)
                if not toggleStates[data.name] then break end

                local world = workspace:FindFirstChild("Worlds")
                             and workspace.Worlds:FindFirstChild(data.name)
                local win = world
                            and world:FindFirstChild("Nodes")
                            and world.Nodes:FindFirstChild("Win")

                if win then
                    hrp.CFrame = win.CFrame + Vector3.new(0,3,0)
                    task.wait(1)

                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        hum.Health = 0
                        task.wait(3)
                    end
                else
                    warn("Win not found for "..data.name)
                    task.wait(1)
                end
            end
            loops[data.name] = false
        end)
    end)

    autoFarmTab:CreateLabel(displayName.." Reward: "..data.money.." (scaled by rebirths)")
end

autoFarmTab:CreateLabel("Note: waits 21s before teleport")

-- Main tab sliders
mainTab:CreateSlider("WalkSpeed", 16, 500, function(val)
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = val end
end)

mainTab:CreateSlider("JumpPower", 50, 300, function(val)
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = val end
end)

-- Destroy GUI button
mainTab:CreateButton("Destroy GUI", function()
    for _, v in pairs(game.CoreGui:GetChildren()) do
        if v:FindFirstChild("Top") then
            v:Destroy()
        end
    end
end)
