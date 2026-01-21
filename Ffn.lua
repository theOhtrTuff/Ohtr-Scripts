-- Find The FNAF Script
-- by ohtr

local Material = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/NiceBBMBThai12/NBTScript/main/Gui%20Th%20Edit%20free%2001"
))()

local UI = Material.Load({
    Title = "Find The FNAF Script",
    Style = 1,
    SizeX = 420,
    SizeY = 210,
    Theme = "Dark"
})

-- Services
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

Player.CharacterAdded:Connect(function(char)
    Character = char
end)

-- Tabs
local Main = UI.New({ Title = "Main" })
local Credit = UI.New({ Title = "Credit" })

-- TP All FNAF (1 by 1 + auto respawn)
Main.Button({
    Text = "TP All FNAF (1 by 1 + Respawn)",
    Callback = function()
        local folder = workspace:FindFirstChild("Brainrots")
        if not folder then
            warn("Brainrots folder not found")
            return
        end

        if not Character or not Character:FindFirstChild("HumanoidRootPart") then
            return
        end

        for _, obj in ipairs(folder:GetChildren()) do
            if obj:IsA("BasePart") then
                Character:PivotTo(obj.CFrame * CFrame.new(0, 3, 0))
                task.wait(0.5) -- delay between each TP
            end
        end

        -- Auto respawn at the end
        Player:LoadCharacter()
    end
})

-- Credits
Credit.Button({
    Text = "Copy Discord (discord.gg/c7dxukSu8j)",
    Callback = function()
        setclipboard("https://discord.gg/c7dxukSu8j")
    end
})

Credit.Button({
    Text = "Script by ohtr",
    Callback = function() end
})

print("✅ Find The FNAF Script Loaded | by ohtr")
