-- =====================================================
-- PROJECT CHIMERA - SELF-CONTAINED EDITION
-- For Solara Executor - NO DOWNLOADS NEEDED
-- =====================================================

-- Wait for game to load
repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- =====================================================
-- SIMPLE GUI LIBRARY (BUILT-IN, NO DOWNLOADS)
-- =====================================================
local Library = {}
local GUI = Instance.new("ScreenGui")
GUI.Name = "ProjectChimera"
GUI.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = GUI

-- Title bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Project Chimera | Solara Edition"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 16
TitleText.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = TitleBar
CloseButton.MouseButton1Click:Connect(function() GUI.Enabled = false end)

-- Tabs
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 40)
TabBar.Position = UDim2.new(0, 0, 0, 30)
TabBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local Tabs = {}
local CurrentTab = "Aimbot"

local function CreateTab(name, position)
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(0, 100, 1, 0)
    tab.Position = UDim2.new(0, (position-1)*100, 0, 0)
    tab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tab.Text = name
    tab.TextColor3 = Color3.fromRGB(200, 200, 200)
    tab.Font = Enum.Font.Gotham
    tab.TextSize = 14
    tab.Parent = TabBar
    
    tab.MouseButton1Click:Connect(function()
        CurrentTab = name
        for _, t in pairs(Tabs) do t.Visible = false end
        ContentFrame.Visible = true
        for i, child in ipairs(ContentFrame:GetChildren()) do
            if child:IsA("Frame") then
                child.Visible = (child.Name == name)
            end
        end
    end)
    
    return tab
end

-- Content area
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -70)
ContentFrame.Position = UDim2.new(0, 0, 0, 70)
ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

-- Create tab content frames
local function CreateTabContent(name)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = UDim2.new(1, -20, 1, -20)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Visible = (name == "Aimbot")
    frame.Parent = ContentFrame
    return frame
end

-- Create tabs
CreateTab("Aimbot", 1)
CreateTab("ESP", 2)
CreateTab("Visuals", 3)
CreateTab("Settings", 4)

-- Aimbot Tab
local AimbotFrame = CreateTabContent("Aimbot")
local ESPFrame = CreateTabContent("ESP")
local VisualsFrame = CreateTabContent("Visuals")
local SettingsFrame = CreateTabContent("Settings")

-- =====================================================
-- CONFIGURATION
-- =====================================================
local Config = {
    Aimbot = {
        Enabled = false,
        Key = "E",
        Smoothness = 0.3,
        FOV = 150,
        VisibleCheck = true,
        TeamCheck = true,
        HitPart = "Head",
    },
    ESP = {
        Enabled = true,
        Boxes = true,
        BoxColor = Color3.fromRGB(255, 70, 70),
        Names = true,
        TeamColor = true,
    },
    Visuals = {
        FOVCircle = true,
        Crosshair = true,
    }
}

-- Helper function to create toggles
local function CreateToggle(parent, text, yPos, default, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 20, 0, 20)
    toggle.Position = UDim2.new(0, 10, 0, yPos)
    toggle.BackgroundColor3 = default and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 100)
    toggle.Text = ""
    toggle.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 0, 20)
    label.Position = UDim2.new(0, 35, 0, yPos)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Parent = parent
    
    local state = default
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.BackgroundColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 100)
        callback(state)
    end)
end

-- Helper function to create sliders
local function CreateSlider(parent, text, yPos, default, min, max, callback)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 0, 20)
    label.Position = UDim2.new(0, 10, 0, yPos)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. default
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Parent = parent
    
    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(0, 200, 0, 5)
    slider.Position = UDim2.new(0, 10, 0, yPos + 25)
    slider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    slider.Parent = parent
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min)/(max - min), 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    fill.Parent = slider
    
    local value = default
    -- Slider dragging logic (simplified)
    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local drag = input:GetPosition()
            -- In a full implementation, you'd track mouse movement
        end
    end)
end

-- Helper function to create dropdowns
local function CreateDropdown(parent, text, yPos, options, default, callback)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 0, 20)
    label.Position = UDim2.new(0, 10, 0, yPos)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Parent = parent
    
    local dropdown = Instance.new("TextButton")
    dropdown.Size = UDim2.new(0, 150, 0, 25)
    dropdown.Position = UDim2.new(0, 150, 0, yPos - 3)
    dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    dropdown.Text = default
    dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdown.Parent = parent
end

-- Populate Aimbot Tab
CreateToggle(AimbotFrame, "Enable Aimbot", 10, Config.Aimbot.Enabled, function(v) Config.Aimbot.Enabled = v end)
CreateSlider(AimbotFrame, "Smoothness", 40, Config.Aimbot.Smoothness, 0.1, 1.0, function(v) Config.Aimbot.Smoothness = v end)
CreateSlider(AimbotFrame, "FOV", 80, Config.Aimbot.FOV, 30, 300, function(v) Config.Aimbot.FOV = v end)
CreateToggle(AimbotFrame, "Visible Check", 120, Config.Aimbot.VisibleCheck, function(v) Config.Aimbot.VisibleCheck = v end)
CreateToggle(AimbotFrame, "Team Check", 150, Config.Aimbot.TeamCheck, function(v) Config.Aimbot.TeamCheck = v end)
CreateDropdown(AimbotFrame, "Hit Part", 180, {"Head", "HumanoidRootPart", "Torso"}, Config.Aimbot.HitPart, function(v) Config.Aimbot.HitPart = v end)

-- Populate ESP Tab
CreateToggle(ESPFrame, "Enable ESP", 10, Config.ESP.Enabled, function(v) Config.ESP.Enabled = v end)
CreateToggle(ESPFrame, "Box ESP", 40, Config.ESP.Boxes, function(v) Config.ESP.Boxes = v end)
CreateToggle(ESPFrame, "Names", 70, Config.ESP.Names, function(v) Config.ESP.Names = v end)
CreateToggle(ESPFrame, "Team Colors", 100, Config.ESP.TeamColor, function(v) Config.ESP.TeamColor = v end)

-- Populate Visuals Tab
CreateToggle(VisualsFrame, "Show FOV Circle", 10, Config.Visuals.FOVCircle, function(v) Config.Visuals.FOVCircle = v end)
CreateToggle(VisualsFrame, "Custom Crosshair", 40, Config.Visuals.Crosshair, function(v) Config.Visuals.Crosshair = v end)

-- =====================================================
-- CORE ENGINE
-- =====================================================

-- Check Drawing support
if not Drawing then
    warn("Drawing library not supported - ESP disabled")
end

-- ESP Objects
local espObjects = {}

local function CreateESP(player)
    if not Drawing or espObjects[player] then return end
    
    local esp = {
        Box = Drawing.new("Square"),
        Name = Drawing.new("Text"),
    }
    
    esp.Box.Visible = false
    esp.Box.Thickness = 2
    esp.Box.Color = Config.ESP.BoxColor
    esp.Box.Filled = false
    
    esp.Name.Visible = false
    esp.Name.Size = 16
    esp.Name.Center = true
    esp.Name.Outline = true
    esp.Name.Color = Config.ESP.BoxColor
    
    espObjects[player] = esp
end

-- Initialize ESP
if Drawing then
    Players.PlayerAdded:Connect(CreateESP)
    for _, player in pairs(Players:GetPlayers()) do
        CreateESP(player)
    end
end

-- Utility functions
local function IsAlive(player)
    return player and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0
end

local function GetClosestTarget()
    local closest, closestDist = nil, Config.Aimbot.FOV
    local localChar = LocalPlayer.Character
    if not localChar then return nil end
    
    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    if not localRoot then return nil end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and IsAlive(player) then
            if Config.Aimbot.TeamCheck and player.Team == LocalPlayer.Team then
                continue
            end
            
            local targetPart = player.Character:FindFirstChild(Config.Aimbot.HitPart) or player.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                local dist = (targetPart.Position - localRoot.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closest = player
                end
            end
        end
    end
    
    return closest
end

-- FOV Circle
local FOVCircle
if Drawing then
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Visible = Config.Visuals.FOVCircle
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
end

-- Main loop
RunService.RenderStepped:Connect(function()
    -- Update FOV Circle
    if FOVCircle and Config.Visuals.FOVCircle then
        FOVCircle.Position = Camera.ViewportSize / 2
        FOVCircle.Radius = Config.Aimbot.FOV
        FOVCircle.Visible = true
    elseif FOVCircle then
        FOVCircle.Visible = false
    end
    
    -- Update Crosshair
    if CrosshairX and CrosshairY and Config.Visuals.Crosshair then
        local center = Camera.ViewportSize / 2
        CrosshairX.From = Vector2.new(center.X - 10, center.Y)
        CrosshairX.To = Vector2.new(center.X + 10, center.Y)
        CrosshairY.From = Vector2.new(center.X, center.Y - 10)
        CrosshairY.To = Vector2.new(center.X, center.Y + 10)
        CrosshairX.Visible = true
        CrosshairY.Visible = true
    elseif CrosshairX and CrosshairY then
        CrosshairX.Visible = false
        CrosshairY.Visible = false
    end
    
    -- ESP Update
    if Drawing and Config.ESP.Enabled then
        for player, esp in pairs(espObjects) do
            if IsAlive(player) and player ~= LocalPlayer then
                local root = player.Character:FindFirstChild("HumanoidRootPart")
                local head = player.Character:FindFirstChild("Head")
                
                if root and head then
                    local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
                    if onScreen then
                        -- Box
                        if Config.ESP.Boxes then
                            local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0,1.5,0))
                            local height = math.abs(headPos.Y - pos.Y) * 2
                            local width = height * 0.6
                            esp.Box.Visible = true
                            esp.Box.Position = Vector2.new(pos.X - width/2, headPos.Y - height/2)
                            esp.Box.Size = Vector2.new(width, height)
                            esp.Box.Color = Config.ESP.TeamColor and player.TeamColor.Color or Config.ESP.BoxColor
                        else
                            esp.Box.Visible = false
                        end
                        
                        -- Name
                        if Config.ESP.Names then
                            esp.Name.Visible = true
                            esp.Name.Position = Vector2.new(pos.X, pos.Y - 50)
                            esp.Name.Text = player.Name
                            esp.Name.Color = Config.ESP.TeamColor and player.TeamColor.Color or Config.ESP.BoxColor
                        else
                            esp.Name.Visible = false
                        end
                    else
                        esp.Box.Visible = false
                        esp.Name.Visible = false
                    end
                else
                    esp.Box.Visible = false
                    esp.Name.Visible = false
                end
            else
                if esp then
                    esp.Box.Visible = false
                    esp.Name.Visible = false
                end
            end
        end
    elseif Drawing then
        for _, esp in pairs(espObjects) do
            esp.Box.Visible = false
            esp.Name.Visible = false
        end
    end
    
    -- Aimbot
    if Config.Aimbot.Enabled and UserInputService:IsKeyDown(Enum.KeyCode[Config.Aimbot.Key]) then
        local target = GetClosestTarget()
        if target and target.Character then
            local targetPart = target.Character:FindFirstChild(Config.Aimbot.HitPart) or target.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                local screenPos = Camera:WorldToViewportPoint(targetPart.Position)
                local currentPos = Vector2.new(Mouse.X, Mouse.Y)
                local delta = Vector2.new(screenPos.X, screenPos.Y) - currentPos
                local moveDelta = delta * (1 - Config.Aimbot.Smoothness)
                
                if mousemoverel then
                    mousemoverel(moveDelta.X, moveDelta.Y)
                end
            end
        end
    end
end)

-- Notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Project Chimera",
    Text = "Loaded successfully! (No downloads)",
    Duration = 3
})

print("[+] Project Chimera loaded - Self-contained edition")
