-- =====================================================
-- PROJECT CHIMERA - ULTIMATE PERFORMANCE EDITION
-- For Solara Executor - AIMBOT FIXED + FLY OVERHAULED
-- =====================================================

-- Wait for game to load
repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- =====================================================
-- GUI TOGGLE SYSTEM
-- =====================================================
local GUI = nil
local GUIEnabled = false
local ToggleKey = Enum.KeyCode.RightControl

local function CreateGUI()
    if GUI then
        GUI:Destroy()
        GUI = nil
    end
    
    GUI = Instance.new("ScreenGui")
    GUI.Name = "ProjectChimera"
    GUI.Parent = game:GetService("CoreGui")
    GUI.ResetOnSpawn = false
    GUI.Enabled = true
    GUIEnabled = true

    -- Main window
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 650, 0, 550)
    MainFrame.Position = UDim2.new(0.5, -325, 0.5, -275)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = GUI

    -- Title bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 35)
    TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame

    local TitleText = Instance.new("TextLabel")
    TitleText.Size = UDim2.new(1, -70, 1, 0)
    TitleText.Position = UDim2.new(0, 10, 0, 0)
    TitleText.BackgroundTransparency = 1
    TitleText.Text = "🔥 PROJECT CHIMERA - ULTIMATE"
    TitleText.TextColor3 = Color3.fromRGB(255, 100, 100)
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.Font = Enum.Font.GothamBold
    TitleText.TextSize = 18
    TitleText.Parent = TitleBar

    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 1, 0)
    CloseButton.Position = UDim2.new(1, -35, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 18
    CloseButton.Parent = TitleBar
    CloseButton.MouseButton1Click:Connect(function() 
        GUI.Enabled = false
        GUIEnabled = false
    end)

    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 30, 1, 0)
    MinimizeButton.Position = UDim2.new(1, -70, 0, 0)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    MinimizeButton.Text = "🗕"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.TextSize = 18
    MinimizeButton.Parent = TitleBar
    MinimizeButton.MouseButton1Click:Connect(function()
        GUI.Enabled = false
        GUIEnabled = false
    end)

    -- Tab bar
    local TabBar = Instance.new("Frame")
    TabBar.Size = UDim2.new(1, 0, 0, 45)
    TabBar.Position = UDim2.new(0, 0, 0, 35)
    TabBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    TabBar.BorderSizePixel = 0
    TabBar.Parent = MainFrame

    -- Content area
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -20, 1, -100)
    ContentFrame.Position = UDim2.new(0, 10, 0, 90)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Parent = MainFrame

    -- Tab buttons and content
    local Tabs = {"Aimbot", "ESP", "Visuals", "Movement", "Settings"}
    local Icons = {"🎯", "👁️", "✨", "🚀", "⚙️"}
    local TabButtons = {}
    local TabFrames = {}

    for i, tabName in ipairs(Tabs) do
        -- Create tab button
        local tab = Instance.new("TextButton")
        tab.Size = UDim2.new(0, 120, 1, 0)
        tab.Position = UDim2.new(0, (i-1)*120, 0, 0)
        tab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        tab.Text = Icons[i] .. "  " .. tabName
        tab.TextColor3 = Color3.fromRGB(180, 180, 180)
        tab.Font = Enum.Font.GothamSemibold
        tab.TextSize = 14
        tab.Parent = TabBar
        TabButtons[i] = tab

        -- Create content frame
        local frame = Instance.new("ScrollingFrame")
        frame.Name = tabName
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        frame.BorderSizePixel = 0
        frame.ScrollBarThickness = 5
        frame.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 100)
        frame.CanvasSize = UDim2.new(0, 0, 0, 0)
        frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        frame.Visible = (i == 1)
        frame.Parent = ContentFrame
        TabFrames[i] = frame

        -- Tab click handler
        tab.MouseButton1Click:Connect(function()
            for j, btn in ipairs(TabButtons) do
                btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
                btn.TextColor3 = Color3.fromRGB(180, 180, 180)
                TabFrames[j].Visible = false
            end
            tab.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
            tab.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabFrames[i].Visible = true
        end)
    end

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
            Prediction = 0.15,
            AimAssist = true, -- New: subtle aim assist
            AutoShoot = false, -- New: auto fire when on target
        },
        ESP = {
            Enabled = true,
            Boxes = true,
            BoxColor = Color3.fromRGB(255, 70, 70),
            HealthBars = true,
            Names = true,
            Distance = true,
            Tracers = false,
            TeamColor = true,
        },
        Visuals = {
            FOVCircle = true,
            CircleColor = Color3.fromRGB(255, 255, 255),
            CircleTransparency = 0.7,
            Crosshair = true,
        },
        Movement = {
            FlyEnabled = false,
            FlySpeed = 50,
            FlyAcceleration = 10, -- New: smooth acceleration
            FlyKey = "Space",
            NoClip = false,
        }
    }

    -- =====================================================
    -- UI ELEMENT CREATION FUNCTIONS
    -- =====================================================

    local function CreateSection(parent, title, yPos)
        local section = Instance.new("Frame")
        section.Size = UDim2.new(1, -20, 0, 30)
        section.Position = UDim2.new(0, 10, 0, yPos)
        section.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        section.BorderSizePixel = 0
        section.Parent = parent

        local line = Instance.new("Frame")
        line.Size = UDim2.new(1, -20, 0, 2)
        line.Position = UDim2.new(0, 10, 1, -2)
        line.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        line.BorderSizePixel = 0
        line.Parent = section

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = title
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Font = Enum.Font.GothamBold
        label.TextSize = 16
        label.Parent = section

        return yPos + 40
    end

    local function CreateToggle(parent, text, yPos, default, callback)
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Size = UDim2.new(1, -20, 0, 30)
        toggleFrame.Position = UDim2.new(0, 10, 0, yPos)
        toggleFrame.BackgroundTransparency = 1
        toggleFrame.Parent = parent

        local toggle = Instance.new("TextButton")
        toggle.Size = UDim2.new(0, 20, 0, 20)
        toggle.Position = UDim2.new(0, 0, 0, 5)
        toggle.BackgroundColor3 = default and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(60, 60, 70)
        toggle.Text = ""
        toggle.Parent = toggleFrame

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -30, 1, 0)
        label.Position = UDim2.new(0, 30, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(220, 220, 220)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.Parent = toggleFrame

        local state = default
        toggle.MouseButton1Click:Connect(function()
            state = not state
            toggle.BackgroundColor3 = state and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(60, 60, 70)
            callback(state)
        end)

        return yPos + 35
    end

    local function CreateSlider(parent, text, yPos, default, min, max, callback)
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Size = UDim2.new(1, -20, 0, 50)
        sliderFrame.Position = UDim2.new(0, 10, 0, yPos)
        sliderFrame.BackgroundTransparency = 1
        sliderFrame.Parent = parent

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 200, 0, 20)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(220, 220, 220)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.Parent = sliderFrame

        local valueLabel = Instance.new("TextLabel")
        valueLabel.Size = UDim2.new(0, 50, 0, 20)
        valueLabel.Position = UDim2.new(1, -50, 0, 0)
        valueLabel.BackgroundTransparency = 1
        valueLabel.Text = string.format("%.2f", default)
        valueLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right
        valueLabel.Font = Enum.Font.GothamBold
        valueLabel.TextSize = 14
        valueLabel.Parent = sliderFrame

        local sliderBg = Instance.new("Frame")
        sliderBg.Size = UDim2.new(1, 0, 0, 5)
        sliderBg.Position = UDim2.new(0, 0, 0, 30)
        sliderBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        sliderBg.BorderSizePixel = 0
        sliderBg.Parent = sliderFrame

        local sliderFill = Instance.new("Frame")
        sliderFill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
        sliderFill.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        sliderFill.BorderSizePixel = 0
        sliderFill.Parent = sliderBg

        local sliderButton = Instance.new("TextButton")
        sliderButton.Size = UDim2.new(1, 0, 1, 0)
        sliderButton.BackgroundTransparency = 1
        sliderButton.Text = ""
        sliderButton.Parent = sliderBg

        local dragging = false
        local value = default

        sliderButton.MouseButton1Down:Connect(function(input)
            dragging = true
            local pos = input.Position.X - sliderBg.AbsolutePosition.X
            local percent = math.clamp(pos / sliderBg.AbsoluteSize.X, 0, 1)
            value = min + (max - min) * percent
            sliderFill.Size = UDim2.new(percent, 0, 1, 0)
            valueLabel.Text = string.format("%.2f", value)
            callback(value)
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local pos = input.Position.X - sliderBg.AbsolutePosition.X
                local percent = math.clamp(pos / sliderBg.AbsoluteSize.X, 0, 1)
                value = min + (max - min) * percent
                sliderFill.Size = UDim2.new(percent, 0, 1, 0)
                valueLabel.Text = string.format("%.2f", value)
                callback(value)
            end
        end)

        return yPos + 60
    end

    local function CreateDropdown(parent, text, yPos, options, default, callback)
        local dropdownFrame = Instance.new("Frame")
        dropdownFrame.Size = UDim2.new(1, -20, 0, 40)
        dropdownFrame.Position = UDim2.new(0, 10, 0, yPos)
        dropdownFrame.BackgroundTransparency = 1
        dropdownFrame.Parent = parent

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 200, 0, 20)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(220, 220, 220)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.Parent = dropdownFrame

        local dropdown = Instance.new("TextButton")
        dropdown.Size = UDim2.new(0, 150, 0, 30)
        dropdown.Position = UDim2.new(0, 0, 0, 20)
        dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        dropdown.Text = default
        dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
        dropdown.Font = Enum.Font.Gotham
        dropdown.TextSize = 14
        dropdown.Parent = dropdownFrame

        local dropdownMenu = Instance.new("Frame")
        dropdownMenu.Size = UDim2.new(0, 150, 0, #options * 30)
        dropdownMenu.Position = UDim2.new(0, 0, 0, 50)
        dropdownMenu.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        dropdownMenu.BorderSizePixel = 0
        dropdownMenu.Visible = false
        dropdownMenu.Parent = dropdownFrame

        for i, option in ipairs(options) do
            local optionBtn = Instance.new("TextButton")
            optionBtn.Size = UDim2.new(1, 0, 0, 30)
            optionBtn.Position = UDim2.new(0, 0, 0, (i-1)*30)
            optionBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            optionBtn.Text = option
            optionBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            optionBtn.Font = Enum.Font.Gotham
            optionBtn.TextSize = 14
            optionBtn.Parent = dropdownMenu

            optionBtn.MouseButton1Click:Connect(function()
                dropdown.Text = option
                dropdownMenu.Visible = false
                callback(option)
            end)
        end

        dropdown.MouseButton1Click:Connect(function()
            dropdownMenu.Visible = not dropdownMenu.Visible
        end)

        return yPos + 50
    end

    -- KEYBIND PICKER
    local function CreateKeybind(parent, text, yPos, default, callback)
        local keybindFrame = Instance.new("Frame")
        keybindFrame.Size = UDim2.new(1, -20, 0, 50)
        keybindFrame.Position = UDim2.new(0, 10, 0, yPos)
        keybindFrame.BackgroundTransparency = 1
        keybindFrame.Parent = parent

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 200, 0, 20)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(220, 220, 220)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.Parent = keybindFrame

        local keyButton = Instance.new("TextButton")
        keyButton.Size = UDim2.new(0, 150, 0, 30)
        keyButton.Position = UDim2.new(0, 0, 0, 20)
        keyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        keyButton.Text = default
        keyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        keyButton.Font = Enum.Font.Gotham
        keyButton.TextSize = 14
        keyButton.Parent = keybindFrame

        local listening = false
        keyButton.MouseButton1Click:Connect(function()
            listening = true
            keyButton.Text = "Press any key/mouse..."
        end)

        local inputConnection
        inputConnection = UserInputService.InputBegan:Connect(function(input)
            if listening then
                listening = false
                local keyName = ""
                
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    keyName = input.KeyCode.Name
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                    keyName = "MouseButton1"
                elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                    keyName = "MouseButton2"
                elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
                    keyName = "MouseButton3"
                else
                    return
                end
                
                keyButton.Text = keyName
                callback(keyName)
                task.wait(0.1)
                if inputConnection then
                    inputConnection:Disconnect()
                end
            end
        end)

        return yPos + 60
    end

    -- =====================================================
    -- POPULATE AIMBOT TAB (WITH NEW OPTIONS)
    -- =====================================================
    local yPos = 10
    yPos = CreateSection(TabFrames[1], "Aimbot Settings", yPos)
    yPos = CreateToggle(TabFrames[1], "Enable Aimbot", yPos, Config.Aimbot.Enabled, function(v) Config.Aimbot.Enabled = v end)
    yPos = CreateKeybind(TabFrames[1], "Activation Key", yPos, Config.Aimbot.Key, function(v) Config.Aimbot.Key = v end)
    yPos = CreateSlider(TabFrames[1], "Smoothness", yPos, Config.Aimbot.Smoothness, 0.1, 1.0, function(v) Config.Aimbot.Smoothness = v end)
    yPos = CreateSlider(TabFrames[1], "FOV", yPos, Config.Aimbot.FOV, 30, 300, function(v) Config.Aimbot.FOV = v end)
    yPos = CreateToggle(TabFrames[1], "Visible Check", yPos, Config.Aimbot.VisibleCheck, function(v) Config.Aimbot.VisibleCheck = v end)
    yPos = CreateToggle(TabFrames[1], "Team Check", yPos, Config.Aimbot.TeamCheck, function(v) Config.Aimbot.TeamCheck = v end)
    yPos = CreateDropdown(TabFrames[1], "Hit Part", yPos, {"Head", "HumanoidRootPart", "Torso", "UpperTorso"}, Config.Aimbot.HitPart, function(v) Config.Aimbot.HitPart = v end)
    yPos = CreateSlider(TabFrames[1], "Prediction", yPos, Config.Aimbot.Prediction, 0, 0.5, function(v) Config.Aimbot.Prediction = v end)
    yPos = CreateToggle(TabFrames[1], "Aim Assist (Subtle)", yPos, Config.Aimbot.AimAssist, function(v) Config.Aimbot.AimAssist = v end)
    yPos = CreateToggle(TabFrames[1], "Auto Shoot", yPos, Config.Aimbot.AutoShoot, function(v) Config.Aimbot.AutoShoot = v end)

    -- =====================================================
    -- POPULATE ESP TAB
    -- =====================================================
    yPos = 10
    yPos = CreateSection(TabFrames[2], "ESP Settings", yPos)
    yPos = CreateToggle(TabFrames[2], "Enable ESP", yPos, Config.ESP.Enabled, function(v) Config.ESP.Enabled = v end)
    yPos = CreateToggle(TabFrames[2], "Box ESP", yPos, Config.ESP.Boxes, function(v) Config.ESP.Boxes = v end)
    yPos = CreateToggle(TabFrames[2], "Health Bars", yPos, Config.ESP.HealthBars, function(v) Config.ESP.HealthBars = v end)
    yPos = CreateToggle(TabFrames[2], "Player Names", yPos, Config.ESP.Names, function(v) Config.ESP.Names = v end)
    yPos = CreateToggle(TabFrames[2], "Distance", yPos, Config.ESP.Distance, function(v) Config.ESP.Distance = v end)
    yPos = CreateToggle(TabFrames[2], "Tracers", yPos, Config.ESP.Tracers, function(v) Config.ESP.Tracers = v end)
    yPos = CreateToggle(TabFrames[2], "Team Colors", yPos, Config.ESP.TeamColor, function(v) Config.ESP.TeamColor = v end)

    -- =====================================================
    -- POPULATE VISUALS TAB
    -- =====================================================
    yPos = 10
    yPos = CreateSection(TabFrames[3], "Visual Overlays", yPos)
    yPos = CreateToggle(TabFrames[3], "Show FOV Circle", yPos, Config.Visuals.FOVCircle, function(v) Config.Visuals.FOVCircle = v end)
    yPos = CreateToggle(TabFrames[3], "Custom Crosshair", yPos, Config.Visuals.Crosshair, function(v) Config.Visuals.Crosshair = v end)

    -- =====================================================
    -- POPULATE MOVEMENT TAB (OVERHAULED FLY)
    -- =====================================================
    yPos = 10
    yPos = CreateSection(TabFrames[4], "Flight System - OVERHAULED", yPos)
    yPos = CreateToggle(TabFrames[4], "Enable Fly", yPos, Config.Movement.FlyEnabled, function(v) 
        Config.Movement.FlyEnabled = v 
        if v then
            StartFly()
        else
            StopFly()
        end
    end)
    yPos = CreateSlider(TabFrames[4], "Fly Speed", yPos, Config.Movement.FlySpeed, 10, 200, function(v) Config.Movement.FlySpeed = v end)
    yPos = CreateSlider(TabFrames[4], "Acceleration", yPos, Config.Movement.FlyAcceleration, 5, 30, function(v) Config.Movement.FlyAcceleration = v end)
    yPos = CreateKeybind(TabFrames[4], "Fly Key", yPos, Config.Movement.FlyKey, function(v) Config.Movement.FlyKey = v end)
    yPos = CreateToggle(TabFrames[4], "No Clip", yPos, Config.Movement.NoClip, function(v) Config.Movement.NoClip = v end)

    -- =====================================================
    -- POPULATE SETTINGS TAB
    -- =====================================================
    yPos = 10
    yPos = CreateSection(TabFrames[5], "GUI Settings", yPos)
    yPos = CreateKeybind(TabFrames[5], "Toggle GUI Key", yPos, "RightControl", function(v)
        ToggleKey = Enum.KeyCode[v] or Enum.KeyCode.RightControl
    end)
    
    local reopenFrame = Instance.new("Frame")
    reopenFrame.Size = UDim2.new(1, -20, 0, 50)
    reopenFrame.Position = UDim2.new(0, 10, 0, yPos)
    reopenFrame.BackgroundTransparency = 1
    reopenFrame.Parent = TabFrames[5]
    
    local reopenBtn = Instance.new("TextButton")
    reopenBtn.Size = UDim2.new(0, 200, 0, 40)
    reopenBtn.Position = UDim2.new(0, 0, 0, 10)
    reopenBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    reopenBtn.Text = "🔄 Reopen GUI (if closed)"
    reopenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    reopenBtn.Font = Enum.Font.GothamBold
    reopenBtn.TextSize = 16
    reopenBtn.Parent = reopenFrame
    reopenBtn.MouseButton1Click:Connect(function()
        if GUI and not GUI.Enabled then
            GUI.Enabled = true
            GUIEnabled = true
        end
    end)

    -- =====================================================
    -- OVERHAULED FLY SYSTEM - SMOOTH AND RESPONSIVE
    -- =====================================================
    local flying = false
    local flyConnection = nil
    local noclipConnection = nil
    local flyBodyVelocity = nil
    local flyBodyGyro = nil
    local currentVelocity = Vector3.new(0, 0, 0)

    function StartFly()
        local character = LocalPlayer.Character
        if not character then return end
        
        local humanoid = character:FindFirstChild("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        
        if not humanoid or not rootPart then return end
        
        flying = true
        currentVelocity = Vector3.new(0, 0, 0)
        
        -- BodyVelocity for movement
        flyBodyVelocity = Instance.new("BodyVelocity")
        flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        flyBodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        flyBodyVelocity.P = 1250 -- Higher P for more responsive
        flyBodyVelocity.Parent = rootPart
        
        -- BodyGyro for orientation
        flyBodyGyro = Instance.new("BodyGyro")
        flyBodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
        flyBodyGyro.P = 1000
        flyBodyGyro.D = 50
        flyBodyGyro.Parent = rootPart
        
        -- Disable default physics
        humanoid.PlatformStand = true
        rootPart.Velocity = Vector3.new(0, 0, 0)
        rootPart.RotVelocity = Vector3.new(0, 0, 0)
        
        -- Main fly loop with smooth acceleration
        flyConnection = RunService.Heartbeat:Connect(function(deltaTime)
            if not flying or not Config.Movement.FlyEnabled then
                StopFly()
                return
            end
            
            if not character or not character.Parent then
                StopFly()
                return
            end
            
            -- Calculate target velocity based on input
            local targetVelocity = Vector3.new(0, 0, 0)
            local cameraCFrame = Camera.CFrame
            
            -- Forward/Backward (WASD)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                targetVelocity = targetVelocity + cameraCFrame.LookVector * Config.Movement.FlySpeed
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                targetVelocity = targetVelocity - cameraCFrame.LookVector * Config.Movement.FlySpeed
            end
            
            -- Strafe (A/D)
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                targetVelocity = targetVelocity - cameraCFrame.RightVector * Config.Movement.FlySpeed
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                targetVelocity = targetVelocity + cameraCFrame.RightVector * Config.Movement.FlySpeed
            end
            
            -- Vertical (Space/Ctrl)
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                targetVelocity = targetVelocity + Vector3.new(0, Config.Movement.FlySpeed, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.C) then
                targetVelocity = targetVelocity - Vector3.new(0, Config.Movement.FlySpeed, 0)
            end
            
            -- Smooth acceleration
            if targetVelocity.Magnitude > 0 then
                targetVelocity = targetVelocity.Unit * Config.Movement.FlySpeed
                -- Smoothly interpolate current velocity to target
                currentVelocity = currentVelocity:Lerp(targetVelocity, Config.Movement.FlyAcceleration * deltaTime)
            else
                -- Decelerate when no input
                currentVelocity = currentVelocity:Lerp(Vector3.new(0, 0, 0), Config.Movement.FlyAcceleration * deltaTime * 2)
            end
            
            -- Apply velocity
            if flyBodyVelocity then
                flyBodyVelocity.Velocity = currentVelocity
            end
            
            -- Keep orientation aligned with camera
            if flyBodyGyro then
                flyBodyGyro.CFrame = cameraCFrame
            end
            
            -- NoClip
            if Config.Movement.NoClip then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part ~= rootPart then
                        part.CanCollide = false
                    end
                end
                -- Keep rootpart can-collide true to prevent falling through world
                rootPart.CanCollide = true
            end
        end)
    end

    function StopFly()
        flying = false
        
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        if flyBodyVelocity then
            flyBodyVelocity:Destroy()
            flyBodyVelocity = nil
        end
        
        if flyBodyGyro then
            flyBodyGyro:Destroy()
            flyBodyGyro = nil
        end
        
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
            end
            
            -- Restore collision
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end

    -- =====================================================
    -- CORE ENGINE (ESP + AIMBOT)
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
            Health = Drawing.new("Text"),
            Distance = Drawing.new("Text"),
            Tracer = Drawing.new("Line"),
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
        
        esp.Health.Visible = false
        esp.Health.Size = 14
        esp.Health.Center = true
        esp.Health.Outline = true
        esp.Health.Color = Color3.fromRGB(0, 255, 0)
        
        esp.Distance.Visible = false
        esp.Distance.Size = 12
        esp.Distance.Center = true
        esp.Distance.Outline = true
        esp.Distance.Color = Color3.fromRGB(255, 255, 255)
        
        esp.Tracer.Visible = false
        esp.Tracer.Thickness = 1
        esp.Tracer.Color = Config.ESP.BoxColor
        
        espObjects[player] = esp
    end

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

    local function IsVisible(startPos, targetPart)
        if not Config.Aimbot.VisibleCheck then return true end
        local ray = Ray.new(startPos, (targetPart.Position - startPos).Unit * 1000)
        local hit = workspace:FindPartOnRay(ray, LocalPlayer.Character)
        return hit and hit:IsDescendantOf(targetPart.Parent) or false
    end

    -- Check if a key is pressed
    local function IsKeyPressed(keyName)
        if not keyName then return false end
        
        for _, enum in pairs(Enum.KeyCode:GetEnumItems()) do
            if enum.Name == keyName then
                return UserInputService:IsKeyDown(enum)
            end
        end
        
        if keyName == "MouseButton1" then
            return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
        elseif keyName == "MouseButton2" then
            return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
        elseif keyName == "MouseButton3" then
            return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton3)
        end
        
        return false
    end

    -- IMPROVED AIMBOT TARGET SELECTION
    local function GetClosestTarget()
        local closest = nil
        local closestDist = Config.Aimbot.FOV
        local closestScreenDist = Config.Aimbot.FOV * 10
        
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
                    -- Check distance
                    local dist = (targetPart.Position - localRoot.Position).Magnitude
                    if dist <= Config.Aimbot.FOV then
                        -- Check visibility
                        if Config.Aimbot.VisibleCheck then
                            if not IsVisible(localRoot.Position, targetPart) then
                                continue
                            end
                        end
                        
                        -- Get screen position
                        local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                        if onScreen then
                            local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - (Camera.ViewportSize/2)).Magnitude
                            local combinedScore = dist * 0.3 + screenDist * 0.7 -- Weighted score
                            
                            if combinedScore < closestDist then
                                closestDist = combinedScore
                                closest = player
                            end
                        end
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
        FOVCircle.Transparency = Config.Visuals.CircleTransparency
        FOVCircle.Color = Config.Visuals.CircleColor
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
        if FOVCircle then
            FOVCircle.Position = Camera.ViewportSize / 2
            FOVCircle.Radius = Config.Aimbot.FOV
            FOVCircle.Visible = Config.Visuals.FOVCircle
            FOVCircle.Transparency = Config.Visuals.CircleTransparency
            FOVCircle.Color = Config.Visuals.CircleColor
        end
        
        -- Update Crosshair
        if CrosshairX and CrosshairY then
            if Config.Visuals.Crosshair then
                local center = Camera.ViewportSize / 2
                CrosshairX.From = Vector2.new(center.X - 10, center.Y)
                CrosshairX.To = Vector2.new(center.X + 10, center.Y)
                CrosshairY.From = Vector2.new(center.X, center.Y - 10)
                CrosshairY.To = Vector2.new(center.X, center.Y + 10)
                CrosshairX.Visible = true
                CrosshairY.Visible = true
            else
                CrosshairX.Visible = false
                CrosshairY.Visible = false
            end
        end
        
        -- ESP Update
        if Drawing and Config.ESP.Enabled then
            for player, esp in pairs(espObjects) do
                if IsAlive(player) and player ~= LocalPlayer then
                    local character = player.Character
                    local root = character:FindFirstChild("HumanoidRootPart")
                    local head = character:FindFirstChild("Head")
                    local humanoid = character:FindFirstChild("Humanoid")
                    
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
                                esp.Health.Text = string.format("%d/%d", math.floor(humanoid.Health), math.floor(humanoid.MaxHealth))
                                esp.Health.Color = Color3.fromRGB(0, 255, 0)
                            else
                                esp.Health.Visible = false
                            end
                            
                            -- Distance
                            if Config.ESP.Distance and LocalPlayer.Character then
                                local localRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                if localRoot then
                                    local dist = (root.Position - localRoot.Position).Magnitude
                                    esp.Distance.Visible = true
                                    esp.Distance.Position = Vector2.new(pos.X, boxY - 40)
                                    esp.Distance.Text = string.format("%.0f studs", dist)
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
        elseif Drawing then
            for _, esp in pairs(espObjects) do
                esp.Box.Visible = false
                esp.Name.Visible = false
                esp.Health.Visible = false
                esp.Distance.Visible = false
                esp.Tracer.Visible = false
            end
        end
        
        -- IMPROVED AIMBOT LOGIC
        if Config.Aimbot.Enabled and IsKeyPressed(Config.Aimbot.Key) then
            local target = GetClosestTarget()
            if target and target.Character then
                local targetPart = target.Character:FindFirstChild(Config.Aimbot.HitPart) or target.Character:FindFirstChild("HumanoidRootPart")
                if targetPart then
                    -- Prediction
                    local velocity = Vector3.new(0, 0, 0)
                    if targetPart:FindFirstChild("Velocity") then
                        velocity = targetPart.Velocity.Value * Config.Aimbot.Prediction
                    end
                    
                    local targetPos = targetPart.Position + velocity
                    local screenPos = Camera:WorldToViewportPoint(targetPos)
                    local currentPos = Vector2.new(Mouse.X, Mouse.Y)
                    local delta = Vector2.new(screenPos.X, screenPos.Y) - currentPos
                    
                    -- Apply smoothness
                    local moveDelta = delta * (1 - Config.Aimbot.Smoothness)
                    
                    -- Apply aim assist (even smoother movement when near target)
                    if Config.Aimbot.AimAssist and delta.Magnitude < 50 then
                        moveDelta = delta * 0.5 -- Extra smoothing when close
                    end
                    
                    if mousemoverel then
                        mousemoverel(moveDelta.X, moveDelta.Y)
                    end
                    
                    -- Auto shoot
                    if Config.Aimbot.AutoShoot and delta.Magnitude < 20 then
                        -- Simulate click (executor may need different method)
                        if mouse1press then
                            mouse1press()
                            task.wait(0.05)
                            mouse1release()
                        end
                    end
                end
            end
        end
    end)

    -- Cleanup
    GUI.Destroying:Connect(function()
        if flying then
            StopFly()
        end
    end)
end

-- =====================================================
-- GUI TOGGLE SYSTEM
-- =====================================================

CreateGUI()

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == ToggleKey then
        if GUI then
            if GUI.Enabled then
                GUI.Enabled = false
                GUIEnabled = false
            else
                GUI.Enabled = true
                GUIEnabled = true
            end
        else
            CreateGUI()
        end
    end
end)

-- Notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Project Chimera ULTIMATE",
    Text = "Aimbot FIXED | Fly OVERHAULED | Press RightControl",
    Duration = 5
})

print("[+] Project Chimera ULTIMATE - Aimbot fixed, Fly overhauled")
