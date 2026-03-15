-- =====================================================
-- PROJECT CHIMERA - FPS GAME EDITION
-- For Solara Executor - AIMBOT FIXED FOR FPS GAMES
-- =====================================================

repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- =====================================================
-- GUI SYSTEM
-- =====================================================
local GUI = Instance.new("ScreenGui")
GUI.Name = "ProjectChimera"
GUI.Parent = game:GetService("CoreGui")
GUI.ResetOnSpawn = false

-- Main Window
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = GUI

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "🎯 FPS AIMBOT - CHIMERA"
TitleText.TextColor3 = Color3.fromRGB(255, 100, 100)
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 16
TitleText.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.Parent = TitleBar
CloseButton.MouseButton1Click:Connect(function() GUI.Enabled = false end)

-- Tab Buttons
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 40)
TabBar.Position = UDim2.new(0, 0, 0, 30)
TabBar.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
TabBar.Parent = MainFrame

-- Content Area
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -90)
ContentFrame.Position = UDim2.new(0, 10, 0, 80)
ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
ContentFrame.Parent = MainFrame

-- Tabs
local Tabs = {"Aimbot", "ESP", "Movement", "Settings"}
local TabButtons = {}
local TabFrames = {}

for i, tabName in ipairs(Tabs) do
    -- Tab Button
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(0, 120, 1, 0)
    tab.Position = UDim2.new(0, (i-1)*120 + 10, 0, 0)
    tab.BackgroundColor3 = i == 1 and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(45, 45, 50)
    tab.Text = tabName
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.Font = Enum.Font.GothamBold
    tab.TextSize = 14
    tab.Parent = TabBar
    TabButtons[i] = tab
    
    -- Tab Content Frame
    local frame = Instance.new("ScrollingFrame")
    frame.Name = tabName
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ScrollBarThickness = 5
    frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    frame.Visible = (i == 1)
    frame.Parent = ContentFrame
    TabFrames[i] = frame
    
    -- Tab Click
    tab.MouseButton1Click:Connect(function()
        for j, btn in ipairs(TabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
            TabFrames[j].Visible = false
        end
        tab.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        TabFrames[i].Visible = true
    end)
end

-- =====================================================
-- CONFIG
-- =====================================================
local Config = {
    Aimbot = {
        Enabled = false,
        Key = "Mouse2",  -- Right click default for FPS games
        Smoothness = 0.3,
        FOV = 150,
        TeamCheck = true,
        HitPart = "Head",
        AutoFire = false,
    },
    ESP = {
        Enabled = true,
        Boxes = true,
        BoxColor = Color3.fromRGB(255, 80, 80),
        HealthBars = true,
        Names = true,
        Distance = true,
        Tracers = false,
        TeamColor = true,
    },
    Movement = {
        BHop = false,
        Speed = false,
        SpeedAmount = 50,
    },
    Settings = {
        ToggleKey = "RightControl",
    }
}

-- =====================================================
-- UI ELEMENTS
-- =====================================================
local function CreateToggle(parent, text, yPos, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 35)
    frame.Position = UDim2.new(0, 5, 0, yPos)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 45, 0, 25)
    toggle.Position = UDim2.new(1, -50, 0, 5)
    toggle.BackgroundColor3 = default and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    toggle.Text = default and "ON" or "OFF"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 12
    toggle.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Parent = frame
    
    local state = default
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.BackgroundColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        toggle.Text = state and "ON" or "OFF"
        callback(state)
    end)
    
    return yPos + 40
end

local function CreateSlider(parent, text, yPos, default, min, max, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 50)
    frame.Position = UDim2.new(0, 5, 0, yPos)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Parent = frame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 50, 0, 20)
    valueLabel.Position = UDim2.new(1, -50, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(default)
    valueLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 14
    valueLabel.Parent = frame
    
    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, -10, 0, 5)
    slider.Position = UDim2.new(0, 0, 0, 30)
    slider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    slider.Parent = frame
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    fill.Parent = slider
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = slider
    
    local dragging = false
    local value = default
    
    button.MouseButton1Down:Connect(function(input)
        dragging = true
        local pos = input.Position.X - slider.AbsolutePosition.X
        local percent = math.clamp(pos / slider.AbsoluteSize.X, 0, 1)
        value = min + (max - min) * percent
        fill.Size = UDim2.new(percent, 0, 1, 0)
        valueLabel.Text = string.format("%.0f", value)
        callback(value)
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = input.Position.X - slider.AbsolutePosition.X
            local percent = math.clamp(pos / slider.AbsoluteSize.X, 0, 1)
            value = min + (max - min) * percent
            fill.Size = UDim2.new(percent, 0, 1, 0)
            valueLabel.Text = string.format("%.0f", value)
            callback(value)
        end
    end)
    
    return yPos + 60
end

local function CreateDropdown(parent, text, yPos, options, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.Position = UDim2.new(0, 5, 0, yPos)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Parent = frame
    
    local dropdown = Instance.new("TextButton")
    dropdown.Size = UDim2.new(0, 100, 0, 30)
    dropdown.Position = UDim2.new(1, -110, 0, 5)
    dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    dropdown.Text = default
    dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdown.Font = Enum.Font.Gotham
    dropdown.TextSize = 14
    dropdown.Parent = frame
    
    return yPos + 45
end

-- =====================================================
-- POPULATE AIMBOT TAB
-- =====================================================
local yPos = 10
yPos = CreateToggle(TabFrames[1], "Enable Aimbot", yPos, Config.Aimbot.Enabled, function(v) Config.Aimbot.Enabled = v end)
yPos = CreateDropdown(TabFrames[1], "Activation Key", yPos, {"Mouse1", "Mouse2", "E", "Q", "Shift"}, Config.Aimbot.Key, function(v) Config.Aimbot.Key = v end)
yPos = CreateSlider(TabFrames[1], "Smoothness", yPos, Config.Aimbot.Smoothness * 100, 10, 100, function(v) Config.Aimbot.Smoothness = v/100 end)
yPos = CreateSlider(TabFrames[1], "Aim FOV", yPos, Config.Aimbot.FOV, 30, 300, function(v) Config.Aimbot.FOV = v end)
yPos = CreateToggle(TabFrames[1], "Team Check", yPos, Config.Aimbot.TeamCheck, function(v) Config.Aimbot.TeamCheck = v end)
yPos = CreateDropdown(TabFrames[1], "Target Part", yPos, {"Head", "HumanoidRootPart", "Torso"}, Config.Aimbot.HitPart, function(v) Config.Aimbot.HitPart = v end)
yPos = CreateToggle(TabFrames[1], "Auto Fire", yPos, Config.Aimbot.AutoFire, function(v) Config.Aimbot.AutoFire = v end)

-- =====================================================
-- POPULATE ESP TAB
-- =====================================================
yPos = 10
yPos = CreateToggle(TabFrames[2], "Enable ESP", yPos, Config.ESP.Enabled, function(v) Config.ESP.Enabled = v end)
yPos = CreateToggle(TabFrames[2], "Box ESP", yPos, Config.ESP.Boxes, function(v) Config.ESP.Boxes = v end)
yPos = CreateToggle(TabFrames[2], "Health Bars", yPos, Config.ESP.HealthBars, function(v) Config.ESP.HealthBars = v end)
yPos = CreateToggle(TabFrames[2], "Player Names", yPos, Config.ESP.Names, function(v) Config.ESP.Names = v end)
yPos = CreateToggle(TabFrames[2], "Distance", yPos, Config.ESP.Distance, function(v) Config.ESP.Distance = v end)
yPos = CreateToggle(TabFrames[2], "Tracers", yPos, Config.ESP.Tracers, function(v) Config.ESP.Tracers = v end)
yPos = CreateToggle(TabFrames[2], "Team Colors", yPos, Config.ESP.TeamColor, function(v) Config.ESP.TeamColor = v end)

-- =====================================================
-- POPULATE MOVEMENT TAB
-- =====================================================
yPos = 10
yPos = CreateToggle(TabFrames[3], "Bunny Hop", yPos, Config.Movement.BHop, function(v) Config.Movement.BHop = v end)
yPos = CreateToggle(TabFrames[3], "Speed Hack", yPos, Config.Movement.Speed, function(v) Config.Movement.Speed = v end)
yPos = CreateSlider(TabFrames[3], "Speed Amount", yPos, Config.Movement.SpeedAmount, 16, 100, function(v) Config.Movement.SpeedAmount = v end)

-- =====================================================
-- POPULATE SETTINGS TAB
-- =====================================================
yPos = 10
yPos = CreateDropdown(TabFrames[4], "Toggle GUI Key", yPos, {"RightControl", "LeftControl", "Insert", "Delete"}, Config.Settings.ToggleKey, function(v) 
    Config.Settings.ToggleKey = v 
end)

-- =====================================================
-- FPS AIMBOT - ACTUALLY WORKS
-- =====================================================
local function IsAlive(player)
    return player and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0
end

local function IsKeyPressed(keyName)
    if keyName == "Mouse1" then
        return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
    elseif keyName == "Mouse2" then
        return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
    elseif keyName == "Shift" then
        return UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
    else
        for _, enum in pairs(Enum.KeyCode:GetEnumItems()) do
            if enum.Name == keyName then
                return UserInputService:IsKeyDown(enum)
            end
        end
    end
    return false
end

local function GetClosestTarget()
    local closest = nil
    local closestDist = Config.Aimbot.FOV
    local localChar = LocalPlayer.Character
    if not localChar then return nil end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and IsAlive(player) then
            if Config.Aimbot.TeamCheck and player.Team == LocalPlayer.Team then
                continue
            end
            
            local targetPart = player.Character:FindFirstChild(Config.Aimbot.HitPart) or player.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                if onScreen then
                    local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if screenDist < closestDist then
                        closestDist = screenDist
                        closest = player
                    end
                end
            end
        end
    end
    
    return closest
end

-- ESP Objects
local espObjects = {}

local function CreateESP(player)
    if not Drawing then return end
    
    local esp = {
        Box = Drawing.new("Square"),
        Name = Drawing.new("Text"),
        Health = Drawing.new("Text"),
        Distance = Drawing.new("Text"),
        Tracer = Drawing.new("Line"),
    }
    
    esp.Box.Visible = false
    esp.Box.Thickness = 2
    esp.Box.Color = Config.ESP.BoxColor
    esp.Box.Filled = false
    
    esp.Name.Visible = false
    esp.Name.Size = 14
    esp.Name.Center = true
    esp.Name.Outline = true
    esp.Name.Color = Config.ESP.BoxColor
    
    esp.Health.Visible = false
    esp.Health.Size = 12
    esp.Health.Center = true
    esp.Health.Outline = true
    
    esp.Distance.Visible = false
    esp.Distance.Size = 12
    esp.Distance.Center = true
    esp.Distance.Outline = true
    
    esp.Tracer.Visible = false
    esp.Tracer.Thickness = 1
    esp.Tracer.Color = Config.ESP.BoxColor
    
    espObjects[player] = esp
end

if Drawing then
    for _, player in pairs(Players:GetPlayers()) do
        CreateESP(player)
    end
    
    Players.PlayerAdded:Connect(CreateESP)
end

-- FOV Circle
local FOVCircle = Drawing and Drawing.new("Circle")
if FOVCircle then
    FOVCircle.Visible = true
    FOVCircle.Thickness = 1
    FOVCircle.NumSides = 64
    FOVCircle.Radius = Config.Aimbot.FOV
    FOVCircle.Filled = false
    FOVCircle.Color = Color3.fromRGB(255, 255, 255)
end

-- Crosshair
local CrosshairX, CrosshairY
if Drawing then
    CrosshairX = Drawing.new("Line")
    CrosshairY = Drawing.new("Line")
    CrosshairX.Color = Color3.new(1,1,1)
    CrosshairY.Color = Color3.new(1,1,1)
    CrosshairX.Thickness = 2
    CrosshairY.Thickness = 2
    CrosshairX.Visible = true
    CrosshairY.Visible = true
end

-- Main Loop
RunService.RenderStepped:Connect(function()
    -- Update FOV Circle
    if FOVCircle then
        FOVCircle.Position = Camera.ViewportSize / 2
        FOVCircle.Radius = Config.Aimbot.FOV
    end
    
    -- Update Crosshair
    if CrosshairX and CrosshairY then
        local center = Camera.ViewportSize / 2
        CrosshairX.From = Vector2.new(center.X - 10, center.Y)
        CrosshairX.To = Vector2.new(center.X + 10, center.Y)
        CrosshairY.From = Vector2.new(center.X, center.Y - 10)
        CrosshairY.To = Vector2.new(center.X, center.Y + 10)
    end
    
    -- ESP Update
    if Drawing and Config.ESP.Enabled then
        for player, esp in pairs(espObjects) do
            if IsAlive(player) and player ~= LocalPlayer then
                local root = player.Character:FindFirstChild("HumanoidRootPart")
                local head = player.Character:FindFirstChild("Head")
                local humanoid = player.Character:FindFirstChild("Humanoid")
                
                if root and head and humanoid then
                    local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
                    local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1.5, 0))
                    
                    if onScreen then
                        local boxHeight = math.abs(headPos.Y - pos.Y) * 2
                        local boxWidth = boxHeight * 0.6
                        local boxY = headPos.Y - boxHeight / 2
                        local boxX = pos.X - boxWidth / 2
                        
                        local boxColor = Config.ESP.TeamColor and player.TeamColor.Color or Config.ESP.BoxColor
                        
                        -- Box
                        if Config.ESP.Boxes then
                            esp.Box.Visible = true
                            esp.Box.Position = Vector2.new(boxX, boxY)
                            esp.Box.Size = Vector2.new(boxWidth, boxHeight)
                            esp.Box.Color = boxColor
                        else
                            esp.Box.Visible = false
                        end
                        
                        -- Name
                        if Config.ESP.Names then
                            esp.Name.Visible = true
                            esp.Name.Position = Vector2.new(pos.X, boxY - 20)
                            esp.Name.Text = player.Name
                            esp.Name.Color = boxColor
                        else
                            esp.Name.Visible = false
                        end
                        
                        -- Health
                        if Config.ESP.HealthBars then
                            esp.Health.Visible = true
                            esp.Health.Position = Vector2.new(pos.X, boxY + boxHeight + 5)
                            esp.Health.Text = string.format("%.0f", humanoid.Health)
                            esp.Health.Color = Color3.fromRGB(255 * (1 - humanoid.Health/humanoid.MaxHealth), 255 * (humanoid.Health/humanoid.MaxHealth), 0)
                        else
                            esp.Health.Visible = false
                        end
                        
                        -- Distance
                        if Config.ESP.Distance and LocalPlayer.Character then
                            local localRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if localRoot then
                                local dist = (root.Position - localRoot.Position).Magnitude
                                esp.Distance.Visible = true
                                esp.Distance.Position = Vector2.new(pos.X, boxY - 35)
                                esp.Distance.Text = string.format("%.0f", dist)
                                esp.Distance.Color = boxColor
                            end
                        else
                            esp.Distance.Visible = false
                        end
                        
                        -- Tracer
                        if Config.ESP.Tracers then
                            esp.Tracer.Visible = true
                            esp.Tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                            esp.Tracer.To = Vector2.new(pos.X, pos.Y)
                            esp.Tracer.Color = boxColor
                        else
                            esp.Tracer.Visible = false
                        end
                    else
                        esp.Box.Visible = false
                        esp.Name.Visible = false
                        esp.Health.Visible = false
                        esp.Distance.Visible = false
                        esp.Tracer.Visible = false
                    end
                else
                    esp.Box.Visible = false
                    esp.Name.Visible = false
                    esp.Health.Visible = false
                    esp.Distance.Visible = false
                    esp.Tracer.Visible = false
                end
            else
                if esp then
                    esp.Box.Visible = false
                    esp.Name.Visible = false
                    esp.Health.Visible = false
                    esp.Distance.Visible = false
                    esp.Tracer.Visible = false
                end
            end
        end
    else
        for _, esp in pairs(espObjects) do
            if esp then
                esp.Box.Visible = false
                esp.Name.Visible = false
                esp.Health.Visible = false
                esp.Distance.Visible = false
                esp.Tracer.Visible = false
            end
        end
    end
    
    -- AIMBOT - FPS OPTIMIZED
    if Config.Aimbot.Enabled and IsKeyPressed(Config.Aimbot.Key) then
        local target = GetClosestTarget()
        if target and target.Character then
            local targetPart = target.Character:FindFirstChild(Config.Aimbot.HitPart) or target.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                local screenPos = Camera:WorldToViewportPoint(targetPart.Position)
                local currentPos = Vector2.new(Mouse.X, Mouse.Y)
                local targetScreen = Vector2.new(screenPos.X, screenPos.Y)
                
                -- Calculate movement
                local delta = targetScreen - currentPos
                local moveDelta = delta * (1 - Config.Aimbot.Smoothness)
                
                -- Move mouse
                if mousemoverel then
                    mousemoverel(moveDelta.X, moveDelta.Y)
                end
                
                -- Auto fire if close enough
                if Config.Aimbot.AutoFire and delta.Magnitude < 20 then
                    if mouse1press then
                        mouse1press()
                        task.wait(0.05)
                        mouse1release()
                    end
                end
            end
        end
    end
    
    -- Bunny Hop
    if Config.Movement.BHop and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid and humanoid.FloorMaterial ~= Enum.Material.Air then
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                humanoid.Jump = true
            end
        end
    end
    
    -- Speed Hack
    if Config.Movement.Speed and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = Config.Movement.SpeedAmount
        end
    end
end)

-- GUI Toggle
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode[Config.Settings.ToggleKey] then
        GUI.Enabled = not GUI.Enabled
    end
end)

-- Notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "FPS Chimera",
    Text = "Aimbot ready - Right click to aim",
    Duration = 3
})
