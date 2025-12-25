--==================================================
-- SAFE RAYFIELD LOADER
--==================================================
local Rayfield
pcall(function()
    Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not Rayfield then
    Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
end

--==================================================
-- SERVICES
--==================================================
local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--==================================================
-- WINDOW
--==================================================
local Window = Rayfield:CreateWindow({
    Name = "Shoot The Boss / FREE 6K ROBUX GAMEPASS / OP SCRIPT",
    LoadingTitle = "Best Shoot the Boss Script",
    LoadingSubtitle = "Made by Ohtr ",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "ShootTheBossHub",
        FileName = "Config"
    },
    Discord = { Enabled = false },
    KeySystem = false,
    Theme = "Ocean"
})

--==================================================
-- TABS
--==================================================
local OPTab   = Window:CreateTab("OP Tab", 4483362458)
local MainTab = Window:CreateTab("Guns", 4483362458)

--==================================================
-- SECTIONS
--==================================================
OPTab:CreateSection("🔫 Train / 💰 Money / ♻ Rebirth / Warpeeler")
MainTab:CreateSection("🔫 Guns")

--==================================================
-- OP TAB
--==================================================

-- Train Amount
OPTab:CreateInput({
    Name = "🔫 Train Amount",
    PlaceholderText = "e.g. 100000",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local v = tonumber(Text)
        if v then
            pcall(function()
                RS.Event.Train:FireServer(v)
            end)
        end
    end
})

-- Money Amount
OPTab:CreateInput({
    Name = "💰 Money Amount",
    PlaceholderText = "e.g. 100000",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local v = tonumber(Text)
        if v then
            pcall(function()
                RS.Event.WinGain:FireServer(v)
            end)
        end
    end
})

-- Auto Rebirth
local AutoRebirth = false
OPTab:CreateToggle({
    Name = "♻ Auto Rebirth",
    CurrentValue = false,
    Callback = function(Value)
        AutoRebirth = Value
        task.spawn(function()
            while AutoRebirth do
                pcall(function()
                    RS.Event.HealthAdd:FireServer(0)
                end)
                task.wait(1)
            end
        end)
    end
})

--==================================================
-- GET ALL GUNS (TP + PROMPT)
--==================================================
MainTab:CreateButton({
    Name = "/̵͇̿̿/’̿’̿ ̿ ̿̿ ̿̿ ̿̿  Get All Guns (Stable)",
    Callback = function()
        local powers = workspace:FindFirstChild("DisplayPowers")
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not powers or not hrp then return end

        local old = hrp.CFrame

        for _, gun in ipairs(powers:GetChildren()) do
            local prompt = gun:FindFirstChildWhichIsA("ProximityPrompt", true)
            local part = gun:FindFirstChildWhichIsA("BasePart", true)
            if prompt and part then
                for i = 1, 2 do
                    hrp.CFrame = part.CFrame + Vector3.new(0,3,0)
                    task.wait(0.25)
                    fireproximityprompt(prompt)
                end
            end
        end

        hrp.CFrame = old
    end
})

--==================================================
-- GET BEST PET BUTTON
--==================================================
OPTab:CreateButton({
    Name = "🥇 Get Best Pet [Warpeeler]",
    Callback = function()
        local success, err = pcall(function()
            local args = {
                [1] = "Warpeeler", -- Pet name
                [2] = "Big"        -- Egg / category
            }
            game.ReplicatedStorage.PEV.CRAFT:FireServer(unpack(args))
        end)

        if success then
            Rayfield:Notify({
                Title = "Success",
                Content = "Warpeeler added! ",
                Duration = 4
            })
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Failed to get Warpeeler ❌\n"..tostring(err),
                Duration = 4
            })
        end
    end
})


--==================================================
-- INFINITE PETS BUTTON
--==================================================
OPTab:CreateButton({
    Name = "🐾 Max Pets [∞]",
    Callback = function()
        local plr = game.Players.LocalPlayer
        local success, err = pcall(function()
            if plr:FindFirstChild("MaxEquipped") and plr.MaxEquipped:IsA("NumberValue") then
                plr.MaxEquipped.Value = math.huge
            end
        end)

        if success then
            Rayfield:Notify({
                Title = "Success",
                Content = "MaxEquipped set to ∞ 🐾",
                Duration = 4
            })
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Failed to set MaxEquipped ❌\n"..tostring(err),
                Duration = 4
            })
        end
    end
})


--==================================================
-- GET BEST GUN BUTTON
--==================================================
MainTab:CreateButton({
    Name = "🎄 Get Best Gun (6K Robux)",
    Callback = function()
        local success, err = pcall(function()
            local args = {
                [1] = "Giantcane", -- Name of the gun
                [2] = 0            -- Cost or placeholder as per your game
            }
            game.ReplicatedStorage.Event.BuyPower:FireServer(unpack(args))
        end)

        if success then
            Rayfield:Notify({
                Title = "Success",
                Content = "Bought the best gun 💰",
                Duration = 4
            })
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Failed to buy the gun ❌\n"..tostring(err),
                Duration = 4
            })
        end
    end
})
