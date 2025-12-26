local _, library = pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/TrixAde/Osmium/main/OsmiumLibrary.lua")))
local window = library:CreateWindow("Osmium UI Library")

-- Tabs
local mainTab = window:CreateTab("Main")
local autoFarmTab = window:CreateTab("Auto Farm")

-- =========================
-- Auto Farm Toggles + Money Info
-- =========================
local worlds = {
    ["BloodMoon"] = {name = "BloodMoon", money = 8400},
    ["Fire"] = {name = "Fire", money = 3150},
    ["Starter"] = {name = "Starter", money = 900},
    ["Toxic"] = {name = "Toxic", money = 5250}
}

local toggleStates = {}
local loops = {} -- store loop coroutines so we can manage them

for displayName, data in pairs(worlds) do
    toggleStates[data.name] = false
    loops[data.name] = nil

    -- Show toggle with money info
    local toggle = autoFarmTab:CreateToggle(displayName.." Auto Farm", false, function(state)
        toggleStates[data.name] = state

        if state then
            -- spawn a new loop only if not already running
            if not loops[data.name] then
                loops[data.name] = true
                spawn(function()
                    local player = game.Players.LocalPlayer
                    while toggleStates[data.name] do
                        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                        if not hrp then
                            wait(1)
                        else
                            local world = workspace:FindFirstChild("Worlds") and workspace.Worlds:FindFirstChild(data.name)
                            local win = world and world:FindFirstChild("Nodes") and world.Nodes:FindFirstChild("Win")
                            if win then
                                hrp.CFrame = win.CFrame + Vector3.new(0,3,0)
                                wait(21) -- cooldown for money
                                local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                                if humanoid then
                                    humanoid.Health = 0
                                    wait(3) -- wait for respawn
                                end
                            else
                                warn("Win not found for "..data.name)
                                wait(1)
                            end
                        end
                    end
                    loops[data.name] = nil -- mark loop as stopped
                end)
            end
        else
            print(displayName.." Auto Farm stopped")
        end
    end)

    -- Add a label showing how much money it gives
    autoFarmTab:CreateLabel(displayName.." Reward: "..data.money.." (scaled by rebirths)")
end

-- Add a general note about rebirth scaling
autoFarmTab:CreateLabel("Note: Money increases with your rebirth count!")

-- =========================
-- Main tab fun stuff
-- =========================
mainTab:CreateSlider("WalkSpeed", 16, 500, function(val)
    local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = val
    end
end)

mainTab:CreateSlider("JumpPower", 50, 300, function(val)
    local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.JumpPower = val
    end
end)

mainTab:CreateButton("Destroy GUI", function()
    for i, v in pairs(game.CoreGui:GetChildren()) do
        if v:FindFirstChild("Top") then
            v:Destroy()
        end
    end
end)
