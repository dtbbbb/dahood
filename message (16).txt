-- aura.cc leaked



getgenv().Settings = {
    rewrittenmain = {
        Enabled = true,
        Key = "c",
        DOT = true,
        AIRSHOT = true,
        NOTIF = true,
        AUTOPRED = false,
        FOV = math.huge,
        RESOVLER = false,
    }
}
 
local SelectedPart = "HumanoidRootPart"
local Prediction = true
getgenv().PredictionValue = 0.15
 getgenv().AntiGroundShots = true

    local AnchorCount = 0
    local MaxAnchor = 50
 
    local CC = game:GetService"Workspace".CurrentCamera
    local Plr;
    local enabled = false
    local mouse = game.Players.LocalPlayer:GetMouse()
    local placemarker = Instance.new("Part", game.Workspace)
 
    function makemarker(Parent, Adornee, Color, Size, Size2)
        local e = Instance.new("BillboardGui", Parent)
        e.Name = "PP"
        e.Adornee = Adornee
        e.Size = UDim2.new(Size, Size2, Size, Size2)
        e.AlwaysOnTop = Settings.rewrittenmain.DOT
        local a = Instance.new("Frame", e)
        if Settings.rewrittenmain.DOT == true then
        a.Size = UDim2.new(0.5, 0, 0.5, 0)
        else
        a.Size = UDim2.new(0, 0, 0, 0)
        end
        if Settings.rewrittenmain.DOT == true then
        a.Transparency = 0
        a.BackgroundTransparency = 0
        else
        a.Transparency = 1
        a.BackgroundTransparency = 1
        end
        a.BackgroundColor3 = Color
        local g = Instance.new("UICorner", a)
        if Settings.rewrittenmain.DOT == false then
        g.CornerRadius = UDim.new(0, 0)
        else
        g.CornerRadius = UDim.new(1, 1) 
        end
        return(e)
    end
 
 
    local data = game.Players:GetPlayers()
    function noob(player)
        local character
        repeat wait() until player.Character
        local handler = makemarker(guimain, player.Character:WaitForChild(SelectedPart), Color3.fromRGB(107, 184, 255), 0.3, 3)
        handler.Name = player.Name
        player.CharacterAdded:connect(function(Char) handler.Adornee = Char:WaitForChild(SelectedPart) end)
 
 
        spawn(function()
            while wait() do
                if player.Character then
                end
            end
        end)
    end
 
    for i = 1, #data do
        if data[i] ~= game.Players.LocalPlayer then
            noob(data[i])
        end
    end
 
    game.Players.PlayerAdded:connect(function(Player)
        noob(Player)
    end)
 
    spawn(function()
        placemarker.Anchored = true
        placemarker.CanCollide = false
        if Settings.rewrittenmain.DOT == true then
        placemarker.Size = Vector3.new(0, 0, 0)
        else
        placemarker.Size = Vector3.new(0, 0, 0) 
        end
        placemarker.Transparency = -1
        if Settings.rewrittenmain.DOT then
        makemarker(placemarker, placemarker, Color3.fromRGB(255, 0, 0), 0.40, 0)
        end
    end)

 game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(k)
        if k == Settings.rewrittenmain.Key and Settings.rewrittenmain.Enabled then
            if enabled == true then
                enabled = false
                if Settings.rewrittenmain.NOTIF == true then
                    Plr = getClosestPlayerToCursor()
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Aura.cc";
                    Text = "Unlocked",
                    Duration = 5
                })
            end
            else
                Plr = getClosestPlayerToCursor()
                enabled = true
                if Settings.rewrittenmain.NOTIF == true then
 
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "Aura.cc";
                        Text = "Target: "..tostring(Plr.Character.Humanoid.DisplayName),
                        Duration = 5
                    })
 
                end
            end
        end
    end)

    function getClosestPlayerToCursor()
        local closestPlayer
        local shortestDistance = getgenv().Settings.rewrittenmain.FOV

        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
                local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude
                if magnitude < shortestDistance then
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            end
        end
        return closestPlayer
    end
 
    local pingvalue = nil;
    local split = nil;
    local ping = nil;
 
    game:GetService("RunService").Stepped:connect(function()
        if enabled and Plr.Character ~= nil and Plr.Character:FindFirstChild("HumanoidRootPart") then
            placemarker.CFrame = CFrame.new(Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*getgenv().PredictionValue))
        else
            placemarker.CFrame = CFrame.new(0, 9999, 0)
        end

        if getgenv().Settings.rewrittenmain.AUTOPRED == true then
   local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    local split = string.split(pingvalue,'(')
    local ping = tonumber(split[1])
    if ping > 300 then
        getgenv().PredictionValue = 0.234
    elseif ping > 290 then
        getgenv().PredictionValue = 0.222
    elseif ping > 280 then
        getgenv().PredictionValue = 0.24
    elseif ping > 270 then
        getgenv().PredictionValue = 0.2385
    elseif ping > 260 then
        getgenv().PredictionValue = 0.2158
    elseif ping > 250 then
        getgenv().PredictionValue = 0.2148
    elseif ping > 240 then
        getgenv().PredictionValue = 0.24
    elseif ping > 230 then
        getgenv().PredictionValue = 0.23
    elseif ping > 220 then
        getgenv().PredictionValue = 0.2
    elseif ping > 210 then
        getgenv().PredictionValue = 0.19834398934
    elseif ping > 200 then
        getgenv().PredictionValue = 0.198439891120
    elseif ping > 190 then
        getgenv().PredictionValue = 0.194924892910
    elseif ping > 180 then
        getgenv().PredictionValue = 0.19291198328
    elseif ping > 180 then
        getgenv().PredictionValue = 0.19291198328
    elseif ping > 170 then
        getgenv().PredictionValue = 0.18
    elseif ping > 160 then
        getgenv().PredictionValue = 0.1754
    elseif ping  >150 then
        getgenv().PredictionValue = 0.171
    elseif ping  >140 then
        getgenv().PredictionValue = 0.17
       elseif ping > 130 then
        getgenv().PredictionValue = 0.157
    elseif ping > 120 then
        getgenv().PredictionValue = 0.166
    elseif ping > 110 then
        getgenv().PredictionValue = 0.1642271
    elseif ping > 100 then
        getgenv().PredictionValue = 0.1533
    elseif ping > 90 then
        getgenv().PredictionValue = 0.13573
    elseif ping > 80 then
        getgenv().PredictionValue = 0.165
    elseif ping > 70 then
        getgenv().PredictionValue = 0.142
    elseif ping > 50 then
        getgenv().PredictionValue = 0.1267
    elseif ping > 40 then
        getgenv().PredictionValue = 0.12
    elseif ping > 30 then
        getgenv().PredictionValue = 0.112
   elseif ping > 20 then
        getgenv().PredictionValue = 0.102
   elseif ping > 10 then
        getgenv().PredictionValue = 0.087
            end
        end
    end)
 
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(...)
        local args = {...}
        local sex = {"UpdateMousePos", "GetMousePos", "MousePos"}
        if enabled and table.find(sex, args[2]) and getnamecallmethod() == "FireServer" and getgenv().Settings.rewrittenmain.Enabled and Plr.Character ~= nil then
 
            -- args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*getgenv().PredictionValue)
            --[[
            if getgenv().Settings.rewrittenmain.AIRSHOT == true then
                if game.Workspace.Players[Plr.Name].Humanoid:GetState() == Enum.HumanoidStateType.Freefall then -- Plr.Character:WaitForChild("Humanoid"):GetState() == Enum.HumanoidStateType.Freefall
 
                    --// Airshot
                    args[3] = Plr.Character.LeftFoot.Position+(Plr.Character.LeftFoot.Velocity*getgenv().PredictionValue)
 
                else
                    args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*getgenv().PredictionValue)
 
                end
            else
                    args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*getgenv().PredictionValue)
            end
            ]]
            if Prediction == true then
 
            args[3] = Plr.Character[SelectedPart].Position+(Plr.Character[SelectedPart].Velocity*getgenv().PredictionValue)
 
            else
 
            args[3] = Plr.Character[SelectedPart].Position
 
            end
 
            return old(unpack(args))
        end
        return old(...)
    end)
 
    game:GetService("RunService").RenderStepped:Connect(function()
        if getgenv().Settings.rewrittenmain.RESOVLER == true and Plr.Character ~= nil and enabled and getgenv().Settings.rewrittenmain.Enabled then
        if getgenv().Settings.rewrittenmain.AIRSHOT == true and enabled and Plr.Character ~= nil then
 
            if game.Workspace.Players[Plr.Name].Humanoid:GetState() == Enum.HumanoidStateType.Freefall then -- Plr.Character:WaitForChild("Humanoid"):GetState() == Enum.HumanoidStateType.Freefall
 
                --// Airshot
 
                --// Anchor Check
 
                if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
                    AnchorCount = AnchorCount + 1
                    if AnchorCount >= MaxAnchor then
                        Prediction = false
                        wait(2)
                        AnchorCount = 0;
                    end
                else
                    Prediction = true
                    AnchorCount = 0;
                end
 
                SelectedPart = "LeftFoot"
 
            else
                --// Anchor Check
 
                if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
                    AnchorCount = AnchorCount + 1
                    if AnchorCount >= MaxAnchor then
                        Prediction = false
                        wait(2)
                        AnchorCount = 0;
                    end
                else
                    Prediction = true
                    AnchorCount = 0;
                end
 
                SelectedPart = "HumanoidRootPart"
 
            end
            else
 
                --// Anchor Check
 
                if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
                    AnchorCount = AnchorCount + 1
                    if AnchorCount >= MaxAnchor then
                        Prediction = false
                        wait(2)
                        AnchorCount = 0;
                    end
                else
                    Prediction = true
                    AnchorCount = 0;
                end
 
                SelectedPart = "HumanoidRootPart"
            end
 
        else
                SelectedPart = "HumanoidRootPart"
        end
    end)

game:GetService("RunService").RenderStepped:connect(function()
if getgenv().AntiGroundShots == true and Plr.Character.Humanoid.Jump == true and Plr.Character.Humanoid.FloorMaterial == Enum.Material.Air then
    pcall(function()
        local TargetVelv5 = Plr.Character.HumanoidRootPart
TargetVelv5.Velocity = Vector3.new(TargetVelv5.Velocity.X, math.abs(TargetVelv5.Velocity.Y * 0.36),
 TargetVelv5.Velocity.Z)
        TargetVelv5.AssemblyLinearVelocity = Vector3.new(TargetVelv5.Velocity.X, math.abs(TargetVelv5.Velocity.Y * 0.36), TargetVelv5.Velocity.Z)
    end)
    end
end)
