--==================================================
-- SAFE RAYFIELD LOADER
--==================================================
local Rayfield
local success = pcall(function()
    Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not success or not Rayfield then
    Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
end

--==================================================
-- WINDOW
--==================================================
local Window = Rayfield:CreateWindow({
    Name = "🔥 Knockout Simulator OP SCRIPT 🔥",
    LoadingTitle = ":)",
    LoadingSubtitle = "Made by Ohtr 😎",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "KnockoutHub",
        FileName = "Config"
    },
    Discord = { Enabled = false },
    KeySystem = false,
    Theme = "Green" -- ✅ Green Theme applied
})

--==================================================
-- TABS
--==================================================
local OPTab = Window:CreateTab("💀 OP Tab", 4483362458)
local MainTab = Window:CreateTab("⚙️ Main Tab", 4483362458)

--==================================================
-- SECTIONS
--==================================================
OPTab:CreateSection("💪 Power & 🏆 Wins")
MainTab:CreateSection("⚡ Powers")
MainTab:CreateSection("🎛 UI Controls")

--==================================================
-- OP TAB
--==================================================

-- Strength
OPTab:CreateInput({
    Name = "💪 Strength Amount",
    PlaceholderText = "Enter Strength",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local power = tonumber(Text)
        if power then
            pcall(function()
                game.ReplicatedStorage.Event.Train:FireServer(power)
            end)
        end
    end
})

-- Wins
OPTab:CreateInput({
    Name = "🏆 Win Amount",
    PlaceholderText = "Enter Wins",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local wins = tonumber(Text)
        if wins then
            pcall(function()
                game.ReplicatedStorage.Event.WinGain:FireServer(wins)
            end)
        end
    end
})

--==================================================
-- MAIN TAB
--==================================================

-- Get All Powers
MainTab:CreateButton({
    Name = "⚡ Get All Powers",
    Callback = function()
        local powers = workspace:FindFirstChild("DisplayPowers")
        local player = game.Players.LocalPlayer
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        if not powers or not hrp then
            Rayfield:Notify({
                Title = "Error",
                Content = "DisplayPowers or HRP not found ❌",
                Duration = 4
            })
            return
        end

        local oldCFrame = hrp.CFrame

        for _, power in ipairs(powers:GetChildren()) do
            local prompt = power:FindFirstChildWhichIsA("ProximityPrompt", true)
            local part = power:FindFirstChildWhichIsA("BasePart", true)

            if prompt and part then
                hrp.CFrame = part.CFrame + Vector3.new(0, 3, 0)
                task.wait(0.15)
                fireproximityprompt(prompt)
                task.wait(0.15)
            end
        end

        hrp.CFrame = oldCFrame

        Rayfield:Notify({
            Title = "Success",
            Content = "Attempted to buy all powers ⚡",
            Duration = 4
        })
    end
})

--==================================================
-- UI CONTROLS
--==================================================
MainTab:CreateParagraph({
    Title = "⌨️ Toggle UI",
    Content = "Press K to open / close the UI"
})

--==================================================
-- CREDITS
--==================================================
MainTab:CreateSection("📌 Credits")

MainTab:CreateParagraph({
    Title = "👑 Knockout Simulator Hub",
    Content = "Made by Ohtr \nUI: Rayfield\nStatus: Clean & Stable"
})

--==================================================
-- LOADED NOTIFY
--==================================================
Rayfield:Notify({
    Title = "Ultra Trainer Loaded",
    Content = "RightShift to toggle UI 🔑",
    Duration = 6
})
