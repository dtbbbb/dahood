getgenv().key = Enum.KeyCode.H 

loadstring(game:HttpGet("https://gist.githubusercontent.com/murderspree/84309f4b27fc481923f1a647c204826d/raw/a1134751b9ab8cdae1b4fbc7db9230516d8d0eca/gistfile1.txt"))()
function StartAntiFling()
    local main = Instance.new("Part", workspace)
    main.Transparency = 1
    main.Name = "Main"
    local weld = Instance.new("Weld", main)
    weld.Part0 = main
    weld.Part1 = game.Players.LocalPlayer.Character.HumanoidRootPart
    local bodyvel = Instance.new("BodyVelocity", main)
    bodyvel.maxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyvel.Velocity = Vector3.new()

            
end
local DesyncStrenght;    
local Toggle = false
game:GetService("UserInputService").InputBegan:Connect(function(keybind, processed)
    if keybind.KeyCode == getgenv().key and processed == false then
        if Toggle == false then
            game.StarterGui:SetCore("SendNotification", {
                Title = "Desync",
                Text = "Enabled"
            })
            StartAntiFling()
            DesyncStrenght = 3233
            getgenv().DesyncLoop = game.RunService.Heartbeat:Connect(function()
                game.RunService.RenderStepped:wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity.X, game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity.Y, game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity.Z) - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * DesyncStrenght
                game.RunService.Heartbeat:wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity.X, game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity.Y, game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity.Z) + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * DesyncStrenght
            end)
            wait(.5)
            workspace.Main:Destroy()
            Toggle = true
        elseif Toggle == true then
            game.StarterGui:SetCore("SendNotification", {
                Title = "Desync",
                Text = "Disabled"
            })

            StartAntiFling()
            DesyncStrenght = 0
            wait(.5)
            getgenv().DesyncLoop:Disconnect()
            workspace.Main:Destroy()
            Toggle = false
        end
    end
end)


while wait() do -- loop
    pcall(function() -- so it doesnt break when dead
        if Toggle then -- check
            if game.Players.LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then -- moving check
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, -555, 0)
            else
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, 0.00013, 0)
            end
        end
    end)
end
