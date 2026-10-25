-- NEON MM2 | GUI for your own Roblox experience
-- Put this in a LocalScript in Roblox Studio

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "NeonMM2"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local purple = Color3.fromRGB(175, 80, 255)
local dark = Color3.fromRGB(22, 18, 32)

local function corner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = obj
end

local panel = Instance.new("Frame")
panel.Size = UDim2.fromOffset(240, 260)
panel.Position = UDim2.new(0.5, -120, 0.5, -130)
panel.BackgroundColor3 = dark
panel.Parent = gui
corner(panel, 16)

local border = Instance.new("UIStroke")
border.Color = purple
border.Thickness = 2
border.Parent = panel

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 45)
title.Position = UDim2.fromOffset(12, 0)
title.BackgroundTransparency = 1
title.Text = "✦ NEON MM2"
title.TextColor3 = purple
title.Font = Enum.Font.GothamBold
title.TextSize = 19
title.Parent = panel

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -24, 1, -58)
content.Position = UDim2.fromOffset(12, 50)
content.BackgroundTransparency = 1
content.Parent = panel

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.Parent = content

local function addButton(text, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(48, 34, 65)
    b.Text = text
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamSemibold
    b.TextSize = 14
    b.Parent = content
    corner(b, 10)
    b.Activated:Connect(callback)
    return b
end

local espOn = false
local highlights = {}

local function refreshESP()
    for _, h in pairs(highlights) do
        h:Destroy()
    end
    table.clear(highlights)

    if not espOn then return end

    for _, target in ipairs(Players:GetPlayers()) do
        if target ~= player and target.Character then
            local h = Instance.new("Highlight")
            h.Adornee = target.Character
            h.FillColor = purple
            h.OutlineColor = Color3.new(1, 1, 1)
            h.FillTransparency = 0.65
            h.Parent = gui
            highlights[target] = h
        end
    end
end

addButton("ESP: ON / OFF", function()
    espOn = not espOn
    refreshESP()
end)

addButton("REFRESH ESP", refreshESP)

addButton("EMOTES", function()
    print("Add your own emotes here")
end)

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(34, 34)
close.Position = UDim2.new(1, -39, 0, 5)
close.Text = "—"
close.TextColor3 = Color3.new(1, 1, 1)
close.BackgroundColor3 = Color3.fromRGB(65, 42, 85)
close.Parent = panel
corner(close, 10)

local mini = Instance.new("TextButton")
mini.Size = UDim2.fromOffset(54, 54)
mini.Position = UDim2.new(0, 15, 0.5, -27)
mini.Text = "✦"
mini.TextSize = 25
mini.TextColor3 = purple
mini.BackgroundColor3 = dark
mini.Visible = false
mini.Parent = gui
corner(mini, 27)

close.Activated:Connect(function()
    panel.Visible = false
    mini.Visible = true
end)

mini.Activated:Connect(function()
    mini.Visible = false
    panel.Visible = true
end)

Players.PlayerAdded:Connect(function()
    task.wait(1)
    refreshESP()
end)

Players.PlayerRemoving:Connect(function(target)
    if highlights[target] then
        highlights[target]:Destroy()
        highlights[target] = nil
    end
end)

print("NEON MM2 loaded!")
