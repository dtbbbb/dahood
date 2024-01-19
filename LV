--[[


                                                   
   ________  _________  ____  ____ _____  ________ 
  / ___/ _ \/ ___/ __ \/ __ \/ __ `/ __ \/ ___/ _ \
 / /  /  __(__  ) /_/ / / / / /_/ / / / / /__/  __/
/_/   \___/____/\____/_/ /_/\__,_/_/ /_/\___/\___/ 
                                                   


	Credits:
	Mjzt - Main Development and features.
	as0w - Side Development and features 
	zepkup - Side Development. 
   	or as0w and zekup could be the same fucking person idk
	Stefanuk12 - Aiming Module
   

--]]






if not game:IsLoaded() then
	game.Loaded:Wait()
end



if getgenv().FullyLoaded == true then
	getgenv().FullyLoaded = false
	getgenv().DONTLOAD = true
end


if getgenv().FullyLoaded ~= true and getgenv().DONTLOAD == true then
	game.StarterGui:SetCore("SendNotification",{Title = "🕊️ resonance",Text = "Already Executed!",Duration = 5})
end

if getgenv().FullyLoaded ~= true and getgenv().DONTLOAD ~= true then
wait(1)
local h = Instance.new("Message")
h.Parent = Workspace
h.Text = "🕊️ resonance | fly with us | Version: 1.0.0 [ALPHA]  | UI Toggle: ']'"
wait(3)
h:Remove()
getgenv().FullyLoaded = true
end




--//Begin Script stuff\\--




setfpscap(999)

if getgenv().FullyLoaded == true then


game:GetService('Players').LocalPlayer.CameraMode = 'Classic'


---------------------------------ESP----------------------------------
---@region: Services
local cloneref = cloneref or function(obj) return(obj) end
local Workspace = cloneref(game:GetService("Workspace"))
local Players = cloneref(game:GetService("Players"))
local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
checkcaller = checkcaller
newcclosure = newcclosure
hookmetamethod = hookmetamethod


--@region: Service +
local LocalPlayer = Players.LocalPlayer
local RootPart = LocalPlayer.Character.HumanoidRootPart
local Humanoid = LocalPlayer.Character.Humanoid
local Mouse = LocalPlayer:GetMouse()
local CurrentCamera = Workspace.CurrentCamera

local ESP = {
    Enabled = false,
    Boxes = true,
    Tracers = true,
    BoxShift = CFrame.new(0,-1.5,0),
	BoxSize = Vector3.new(4,6.345,0),
    Color = Color3.fromRGB(255,255,255),
    FaceCamera = false,
    Names = false,
    TeamColor = false,
    Thickness = 1,
    AttachShift = 1,
    TeamMates = true,
    Players = true,
    
    Objects = setmetatable({}, {__mode="kv"}),
    Overrides = {}
}

--Declarations--
local cam = workspace.CurrentCamera
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local mouse = plr:GetMouse()

local V3new = Vector3.new
local WorldToViewportPoint = cam.WorldToViewportPoint

--Functions--
local function Draw(obj, props)
	local new = Drawing.new(obj)
	
	props = props or {}
	for i,v in pairs(props) do
		new[i] = v
	end
	return new
end

function ESP:GetTeam(p)
	local ov = self.Overrides.GetTeam
	if ov then
		return ov(p)
	end
	
	return p and p.Team
end

function ESP:IsTeamMate(p)
    local ov = self.Overrides.IsTeamMate
	if ov then
		return ov(p)
    end
    
    return self:GetTeam(p) == self:GetTeam(plr)
end

function ESP:GetColor(obj)
	local ov = self.Overrides.GetColor
	if ov then
		return ov(obj)
    end
    local p = self:GetPlrFromChar(obj)
	return p and self.TeamColor and p.Team and p.Team.TeamColor.Color or self.Color
end

function ESP:GetPlrFromChar(char)
	local ov = self.Overrides.GetPlrFromChar
	if ov then
		return ov(char)
	end
	
	return plrs:GetPlayerFromCharacter(char)
end

function ESP:Toggle(bool)
    self.Enabled = bool
    if not bool then
        for i,v in pairs(self.Objects) do
            if v.Type == "Box" then --fov circle etc
                if v.Temporary then
                    v:Remove()
                else
                    for i,v in pairs(v.Components) do
                        v.Visible = false
                    end
                end
            end
        end
    end
end

function ESP:GetBox(obj)
    return self.Objects[obj]
end

function ESP:AddObjectListener(parent, options)
    local function NewListener(c)
        if type(options.Type) == "string" and c:IsA(options.Type) or options.Type == nil then
            if type(options.Name) == "string" and c.Name == options.Name or options.Name == nil then
                if not options.Validator or options.Validator(c) then
                    local box = ESP:Add(c, {
                        PrimaryPart = type(options.PrimaryPart) == "string" and c:WaitForChild(options.PrimaryPart) or type(options.PrimaryPart) == "function" and options.PrimaryPart(c),
                        Color = type(options.Color) == "function" and options.Color(c) or options.Color,
                        ColorDynamic = options.ColorDynamic,
                        Name = type(options.CustomName) == "function" and options.CustomName(c) or options.CustomName,
                        IsEnabled = options.IsEnabled,
                        RenderInNil = options.RenderInNil
                    })
                    --TODO: add a better way of passing options
                    if options.OnAdded then
                        coroutine.wrap(options.OnAdded)(box)
                    end
                end
            end
        end
    end

    if options.Recursive then
        parent.DescendantAdded:Connect(NewListener)
        for i,v in pairs(parent:GetDescendants()) do
            coroutine.wrap(NewListener)(v)
        end
    else
        parent.ChildAdded:Connect(NewListener)
        for i,v in pairs(parent:GetChildren()) do
            coroutine.wrap(NewListener)(v)
        end
    end
end

local boxBase = {}
boxBase.__index = boxBase

function boxBase:Remove()
    ESP.Objects[self.Object] = nil
    for i,v in pairs(self.Components) do
        v.Visible = false
        v:Remove()
        self.Components[i] = nil
    end
end

function boxBase:Update()
    if not self.PrimaryPart then
        --warn("not supposed to print", self.Object)
        return self:Remove()
    end

    local color
    if ESP.Highlighted == self.Object then
       color = ESP.HighlightColor
    else
        color = self.Color or self.ColorDynamic and self:ColorDynamic() or ESP:GetColor(self.Object) or ESP.Color
    end

    local allow = true
    if ESP.Overrides.UpdateAllow and not ESP.Overrides.UpdateAllow(self) then
        allow = false
    end
    if self.Player and not ESP.TeamMates and ESP:IsTeamMate(self.Player) then
        allow = false
    end
    if self.Player and not ESP.Players then
        allow = false
    end
    if self.IsEnabled and (type(self.IsEnabled) == "string" and not ESP[self.IsEnabled] or type(self.IsEnabled) == "function" and not self:IsEnabled()) then
        allow = false
    end
    if not workspace:IsAncestorOf(self.PrimaryPart) and not self.RenderInNil then
        allow = false
    end

    if not allow then
        for i,v in pairs(self.Components) do
            v.Visible = false
        end
        return
    end

    if ESP.Highlighted == self.Object then
        color = ESP.HighlightColor
    end

    --calculations--
    local cf = self.PrimaryPart.CFrame
    if ESP.FaceCamera then
        cf = CFrame.new(cf.p, cam.CFrame.p)
    end
    local size = self.Size
    local locs = {
        TopLeft = cf * ESP.BoxShift * CFrame.new(size.X/2,size.Y/2,0),
        TopRight = cf * ESP.BoxShift * CFrame.new(-size.X/2,size.Y/2,0),
        BottomLeft = cf * ESP.BoxShift * CFrame.new(size.X/2,-size.Y/2,0),
        BottomRight = cf * ESP.BoxShift * CFrame.new(-size.X/2,-size.Y/2,0),
        TagPos = cf * ESP.BoxShift * CFrame.new(0,size.Y/2,0),
        Torso = cf * ESP.BoxShift
    }

    if ESP.Boxes then
        local TopLeft, Vis1 = WorldToViewportPoint(cam, locs.TopLeft.p)
        local TopRight, Vis2 = WorldToViewportPoint(cam, locs.TopRight.p)
        local BottomLeft, Vis3 = WorldToViewportPoint(cam, locs.BottomLeft.p)
        local BottomRight, Vis4 = WorldToViewportPoint(cam, locs.BottomRight.p)

        if self.Components.Quad then
            if Vis1 or Vis2 or Vis3 or Vis4 then
                self.Components.Quad.Visible = true
                self.Components.Quad.PointA = Vector2.new(TopRight.X, TopRight.Y)
                self.Components.Quad.PointB = Vector2.new(TopLeft.X, TopLeft.Y)
                self.Components.Quad.PointC = Vector2.new(BottomLeft.X, BottomLeft.Y)
                self.Components.Quad.PointD = Vector2.new(BottomRight.X, BottomRight.Y)
                self.Components.Quad.Color = color
            else
                self.Components.Quad.Visible = false
            end
        end
    else
        self.Components.Quad.Visible = false
    end

    if ESP.Names then
        local TagPos, Vis5 = WorldToViewportPoint(cam, locs.TagPos.p)
        
        if Vis5 then
            self.Components.Name.Visible = true
            self.Components.Name.Position = Vector2.new(TagPos.X, TagPos.Y)
            self.Components.Name.Text = self.Name
            self.Components.Name.Color = color
            
            self.Components.Distance.Visible = true
            self.Components.Distance.Position = Vector2.new(TagPos.X, TagPos.Y + 14)
            self.Components.Distance.Text = math.floor((cam.CFrame.p - cf.p).magnitude) .."m"
            self.Components.Distance.Color = color
        else
            self.Components.Name.Visible = false
            self.Components.Distance.Visible = false
        end
    else
        self.Components.Name.Visible = false
        self.Components.Distance.Visible = false
    end
    
    if ESP.Tracers then
        local TorsoPos, Vis6 = WorldToViewportPoint(cam, locs.Torso.p)

        if Vis6 then
            self.Components.Tracer.Visible = true
            self.Components.Tracer.From = Vector2.new(TorsoPos.X, TorsoPos.Y)
            self.Components.Tracer.To = Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y/ESP.AttachShift)
            self.Components.Tracer.Color = color
        else
            self.Components.Tracer.Visible = false
        end
    else
        self.Components.Tracer.Visible = false
    end
end

function ESP:Add(obj, options)
    if not obj.Parent and not options.RenderInNil then
        return warn(obj, "has no parent")
    end

    local box = setmetatable({
        Name = options.Name or obj.Name,
        Type = "Box",
        Color = options.Color --[[or self:GetColor(obj)]],
        Size = options.Size or self.BoxSize,
        Object = obj,
        Player = options.Player or plrs:GetPlayerFromCharacter(obj),
        PrimaryPart = options.PrimaryPart or obj.ClassName == "Model" and (obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")) or obj:IsA("BasePart") and obj,
        Components = {},
        IsEnabled = options.IsEnabled,
        Temporary = options.Temporary,
        ColorDynamic = options.ColorDynamic,
        RenderInNil = options.RenderInNil
    }, boxBase)

    if self:GetBox(obj) then
        self:GetBox(obj):Remove()
    end

    box.Components["Quad"] = Draw("Quad", {
        Thickness = self.Thickness,
        Color = color,
        Transparency = 0.7,
        Filled = false,
        Visible = self.Enabled and self.Boxes
    })
    box.Components["Name"] = Draw("Text", {
		Text = box.Name,
		Color = box.Color,
		Center = true,
		Outline = true,
        Size = 19,
        Visible = self.Enabled and self.Names
	})
	box.Components["Distance"] = Draw("Text", {
		Color = box.Color,
		Center = true,
		Outline = true,
        Size = 19,
        Visible = self.Enabled and self.Names
	})
	
	box.Components["Tracer"] = Draw("Line", {
		Thickness = ESP.Thickness,
		Color = box.Color,
        Transparency = 0.7,
        Visible = self.Enabled and self.Tracers
    })
    self.Objects[obj] = box
    
    obj.AncestryChanged:Connect(function(_, parent)
        if parent == nil and ESP.AutoRemove ~= false then
            box:Remove()
        end
    end)
    obj:GetPropertyChangedSignal("Parent"):Connect(function()
        if obj.Parent == nil and ESP.AutoRemove ~= false then
            box:Remove()
        end
    end)

    local hum = obj:FindFirstChildOfClass("Humanoid")
	if hum then
        hum.Died:Connect(function()
            if ESP.AutoRemove ~= false then
                box:Remove()
            end
		end)
    end

    return box
end

local function CharAdded(char)
    local p = plrs:GetPlayerFromCharacter(char)
    if not char:FindFirstChild("HumanoidRootPart") then
        local ev
        ev = char.ChildAdded:Connect(function(c)
            if c.Name == "HumanoidRootPart" then
                ev:Disconnect()
                ESP:Add(char, {
                    Name = p.Name,
                    Player = p,
                    PrimaryPart = c
                })
            end
        end)
    else
        ESP:Add(char, {
            Name = p.Name,
            Player = p,
            PrimaryPart = char.HumanoidRootPart
        })
    end
end
local function PlayerAdded(p)
    p.CharacterAdded:Connect(CharAdded)
    if p.Character then
        coroutine.wrap(CharAdded)(p.Character)
    end
end
plrs.PlayerAdded:Connect(PlayerAdded)
for i,v in pairs(plrs:GetPlayers()) do
    if v ~= plr then
        PlayerAdded(v)
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    cam = workspace.CurrentCamera
    for i,v in (ESP.Enabled and pairs or ipairs)(ESP.Objects) do
        if v.Update then
            local s,e = pcall(v.Update, v)
            if not s then warn("[EU]", e, v.Object:GetFullName()) end
        end
    end
end)
----------------------END ESP-----------------------------------------------


--@region: SERVICES


getgenv().RollAngles = false --- actual enable config


--@endregion



--@region: RNG
function RandomNumberGeneration(RNG)
	return math.random(-RNG * 180, RNG * 180) / 180
end
--@endregion




--@region: CHAR_POS_SPOOF
local DesyncTypes = {}
RunService.Heartbeat:Connect(function()
	if getgenv().RollAngles == true then
		DesyncTypes[1] = RootPart.CFrame
		local HRPCFRAME = RootPart.CFrame
		HRPCFRAME = HRPCFRAME * CFrame.new(Vector3.new(getgenv().AnimX, getgenv().AnimY, getgenv().AnimZ))
		HRPCFRAME = HRPCFRAME * CFrame.Angles(math.rad(getgenv().AnglY), math.rad(getgenv().AnglX), math.rad(getgenv().AnglZ))
		RootPart.CFrame = HRPCFRAME
		RunService.RenderStepped:Wait()
		RootPart.CFrame = DesyncTypes[1]
	end 

end)
 --@endregion

--@region: HOOK_CHAR_CFRAME
local hooker = nil
hooker = hookmetamethod(game, "__index", newcclosure(function(self, key)
	if getgenv().RollAngles == true then
		if not checkcaller() then
			if key == "CFrame" and getgenv().RollAngles == true and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character:FindFirstChild("Humanoid").Health > 0 then
				if self == RootPart then
					return DesyncTypes[1] or CFrame.new()
				elseif self == LocalPlayer.Character.Head then
					return DesyncTypes[1] and DesyncTypes[1] + Vector3.new(0,RootPart.Size / 2 + 0.5, 0) or CFrame.new()
				end
			end
		end
	end
	return hooker(self, key)
end))
--@endregion







local Aiming = loadstring(game:HttpGet("https://paste.ee/r/EElNP"))()
Aiming.TeamCheck(true)


local Settings = {
    SilentAim = false,
    AimLock = false,
    Prediction = 0
}
getgenv().Settings = Settings

function Aiming.Check()
    if not (Aiming.Enabled == true and Aiming.Selected ~= LocalPlayer and Aiming.SelectedPart ~= nil) then
        return false
    end

    local Character = Aiming.Character(Aiming.Selected)

    return true
end

local __index
__index = hookmetamethod(game, "__index", function(t, k)
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and Aiming.Check()) then
        local SelectedPart = Aiming.SelectedPart

        if (Settings.SilentAim and (k == "Hit" or k == "Target")) then
            local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * Settings.Prediction)

            return (k == "Hit" and Hit or SelectedPart)
        end
    end

    return __index(t, k)
end)

RunService:BindToRenderStep("AimLock", 0, function()
    if (Settings.AimLock and Aiming.Check()) then
        local SelectedPart = Aiming.SelectedPart

        local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * Settings.Prediction)

        CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, Hit.Position)
    end
    end)



-------------------------------------------AUTOPEEK---------------------------------
getgenv().Autopeek = false
getgenv().Key = Enum.KeyCode.V

local APEF = Instance.new("Folder")
APEF.Parent = game.Workspace
APEF.Name = "APEF"
getgenv().oldc = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
getgenv().APE = false
game:service('UserInputService').InputBegan:connect(function(Key, IsChat)
	if IsChat then return end
	if Key.KeyCode == getgenv().Key and getgenv().Autopeek == true then
		if getgenv().APE == false then
local notifSound = Instance.new("Sound",workspace)
notifSound.PlaybackSpeed = 0.7
notifSound.Volume = 0.7
notifSound.SoundId = "rbxassetid://452267918"
notifSound.PlayOnRemove = true
notifSound:Destroy()
			getgenv().APE = true
			local APEPart = Instance.new("Part")
			APEPart.Parent = APEF
			APEPart.Name = "backTP"
			APEPart.Anchored = true
			APEPart.CanCollide = false
			APEPart.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, -3.3, 0)
			APEPart.Orientation = game.Players.LocalPlayer.Character.HumanoidRootPart.Orientation
			APEPart.Size = Vector3.new(4, 2, 2)
			APEPart.Shape = Enum.PartType.Ball
			APEPart.Transparency = 0
			APEPart.BrickColor = BrickColor.new("Really Red")
			APEPart.Material = "Neon"
			getgenv().oldc = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		elseif getgenv().APE == true then
			getgenv().APE = false
local notifSound = Instance.new("Sound",workspace)
notifSound.PlaybackSpeed = 0.8
notifSound.Volume = 0.8
notifSound.SoundId = "rbxassetid://4499400560"
notifSound.PlayOnRemove = true
notifSound:Destroy()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = getgenv().oldc
			game.Workspace.APEF.backTP:Destroy()
		end
	end
end)
-------------------------------------------END AUTOPEEK--------------------------------









-------------------YAW STUFF-------------
local y = {
	ShowingDot = false,
	spinbotgangy = false,
	spinbotsped =  100,
	spinbotangle = 110,
	cframespeed = false,
	cframespeedvalue = 10
};


---------------------------------END PRINTS-------------------------------


--//End Script stuff\\--

-----WINDOW STUFF---
loadstring(game:HttpGet('https://paste.ee/r/WCt6C'))() -- GUI --

local Library = initLibrary()
local Window = Library:Load({name = "         																			  🕊 resonance                																		    	", sizeX = 833, sizeY = 500, color = Color3.fromRGB(186,85,211)})

--- TAB STUFF---
local aimbot = Window:Tab("aimbot")
local rage = Window:Tab("anti-aim")
local visual = Window:Tab("visuals")
local movemint = Window:Tab("movement")
local misc = Window:Tab("miscellaneous")


--Aimbot tab Start--
local generalaim = aimbot:Section{name = "General", column = 1}
local accuraim = aimbot:Section{name = "Accuracy", column = 2}
local expaim = aimbot:Section{name = "Exploits", column = 1}


--Aimbot tab End--
 

--Rage tab Start--
local fakelag = rage:Section{name = "Fake Lags", column = 1}
local aa = rage:Section{name = "Desync", column = 2}
local others = rage:Section{name = "Other", column = 1}

--Miscellanous Tab End--

local plrvis = visual:Section{name = "player visuals", column = 1}
local wrldvis = visual:Section{name = "world visuals", column = 2}
local esp = visual:Section{name = "ESP", column = 1}

local movementplayer = movemint:Section{name = "Movement Exploits", column = 1}

local cmisc = misc:Section{name = "Community Luas", column = 1}
local dmisc = misc:Section{name = "Developer Luas", column = 2}
---------------------------TAB END--------------------

  

--// General Aimbot \\--

generalaim:Toggle {
Name = "Enable",
flag = "sillool", 
    callback = function(state)
   	Aiming.Enabled = state
   end
}

generalaim:Toggle {
Name = "Silent",
flag = "sillool", 
    callback = function(state)
	if state then
	Settings.SilentAim = true
    Settings.AimLock = false
else
	Settings.SilentAim = false
    Settings.AimLock = true
	end
   end
}


local MFOV =
	generalaim:Slider {
		Name = "FOV",
		Default = 1,
		Min = 1,
		Max = 180,
		Flag = "MFOV",
		callback = function(z)
			Aiming.FOV = tonumber(z)
		end
}
MFOV:SetValueText("FOV : [VALUE]/180")

generalaim:Toggle {
Name = "Visible Check",
flag = "civ", 
    callback = function(vcheck)
        Aiming.VisibleCheck = vcheck
   end
}




generalaim:dropdown {
	name = "Hitboxes",
	content = {"Head", "Torso", "Either"},
	Default = " ",
	multichoice = false,
	callback = function(State)
    		if State == "Head" then
            Aiming.TargetPart = {"Head"}
			
		elseif State == "Torso" then
        Aiming.TargetPart = {"Torso"}
			

		elseif State == "Either" then
        Aiming.TargetPart = {"Head", "Torso"}
		end
	end,
	flag = "silaimbone"
}

--// End Silent Aimbot \\--

--// Circle Options\\--







-- Resolvers --

local hcs =
	accuraim:Slider {
		Name = "hcs",
		Default = 100,
		Min = 0,
		Max = 110,
		Flag = "hcs",
		callback = function(e)
			Aiming.HitChance = tonumber(e)
		end
	}

hcs:SetValueText("Hitchance : [VALUE]/110")


expaim:Toggle {
Name = "Lag Compensation",
flag = "LC", 
    callback = function(state)
        if state then
        print("resonance | this makes other ppl lag however ur movement is still updated.")
        settings():GetService("NetworkSettings").IncomingReplicationLag = 1
       else
       settings():GetService("NetworkSettings").IncomingReplicationLag = 0
       end
    end
}




-- BEGIN YAW --------------




fakelag:Toggle {
Name = "Enable fake lag",
flag = "fakelagenable", 
    callback = function(state)
		getgenv().fakelagenable = state

			while getgenv().fakelagenable == true do
		game:GetService("NetworkClient"):SetOutgoingKBPSLimit(1)         
			wait(0.1 * getgenv().fllimit)
			game:GetService("NetworkClient"):SetOutgoingKBPSLimit(0)
		wait(0.001)
			end
	if getgenv().fakelagenable ~= true then
		game:GetService("NetworkClient"):SetOutgoingKBPSLimit(0)
	end
	end
}




local fllimit =
	fakelag:Slider {
		Name = "fllimit",
		Default = 1,
		Min = 1,
		Max = 16,
		Flag = "fllimit",
		callback = function(a)
			getgenv().fllimit = tonumber(a)
		end
}

fllimit:SetValueText("Limit : [VALUE]/16")


getgenv().MinTick = 0.00001000000000
getgenv().MaxTick = 0.0001000000000
aa:dropdown {
	name = "Desync Type",
	content = {"None", "Minimal", "Maximal"},
	Default = " ",
	multichoice = false,
	callback = function(State)
		if State == "None" then
		settings().Physics.AllowSleep = false
		getgenv().Minimal = false
		getgenv().Maximal = false
			
        elseif State == "Minimal" then

if getgenv().Maximal == true then
	getgenv().Maximal = false
end


getgenv().Minimal = true
while getgenv().Minimal == true do 
settings().Physics.AllowSleep = true    
task.wait()     
local loop = RunService.Heartbeat:Connect(function()
sethiddenproperty(RootPart, "NetworkIsSleeping", true)         
task.wait(getgenv().MaxTick * getgenv().DLimit)
sethiddenproperty(RootPart, "NetworkIsSleeping", false)     
end) 
task.wait(getgenv().MinTick * getgenv().DLimit)             
if loop then         
loop:Disconnect()     
end 
end
		elseif State == "Maximal" then
if getgenv().Minimal == true then
	getgenv().Minimal = false
end


getgenv().Maximal = true
while getgenv().Maximal do
settings().Physics.AllowSleep = true    
task.wait()     
local loop = RunService.Heartbeat:Connect(function()
sethiddenproperty(RootPart, "NetworkIsSleeping", true)         
task.wait(getgenv().MaxTick * getgenv().DLimit)
sethiddenproperty(RootPart, "NetworkIsSleeping", false)   
end) 
task.wait(getgenv().MaxTick * getgenv().DLimit)             
if loop then         
loop:Disconnect()     
end 
end

		end
	end,
	flag = "dsynctype"
}

local DLimit =
	aa:Slider {
		Name = "DLimit",
		Default = 1,
		Min = 1,
		Max = 90,
		Flag = "DLimit",
		callback = function(a)
			getgenv().DLimit = tonumber(a)
		end
}

DLimit:SetValueText("Desync Limit : [VALUE]/90")

aa:Label(" ")

aa:Toggle {
Name = "Roll Angles",
flag = "animdesyncing", 
    callback = function(state)
	getgenv().RollAngles = state
	end
}

aa:dropdown {
	name = "Roll Angle Type",
	content = {"Invert", "Sideways", "Spin", "Crooked", "Roll"},
	Default = " ",
	multichoice = false,
	callback = function(State)
			
		if State == "Invert" then
			if getgenv().SidewayReal == true then
				getgenv().SidewayReal = false
		end

		if getgenv().spinsterreal == true then
				getgenv().spinsterreal = false
		end
		if getgenv().PosJit == true then
			getgenv().PosJit = false
		end
			if getgenv().CrookedReal == true then
				getgenv().CrookedReal = false
		end

		if getgenv().RollReal == true then
				getgenv().RollReal = false
		end

		getgenv().InvertReal = true 

		while getgenv().InvertReal == true do
		getgenv().AnglX = 180
		getgenv().AnglY = 180
		getgenv().AnglZ = 0
		wait(-1337)
		getgenv().AnglX = 0
		getgenv().AnglY = 0
		getgenv().AnglZ = 0
		wait(-1337)
		end

		

		
		elseif State == "Sideways" then
		getgenv().AnglX = 0
		getgenv().AnglY = 0
		getgenv().AnglZ = 0
 
		if getgenv().spinsterreal == true then
				getgenv().spinsterreal = false
		end

		if getgenv().InvertReal == true then
			getgenv().InvertReal = false
		end

		if getgenv().CrookedReal == true then
				getgenv().CrookedReal = false
		end

		if getgenv().RollReal == true then
				getgenv().RollReal = false
		end
		getgenv().SidewayReal = true
		
		while getgenv().SidewayReal == true do
		getgenv().AnglX = 0
		getgenv().AnglY = 0
		getgenv().AnglZ = 90
		wait(-1337)
		getgenv().AnglX = 0
		getgenv().AnglY = 0
		getgenv().AnglZ = -90
		wait(-1337)
		end

		elseif State == "Spin" then
		getgenv().AnimX = 0
		getgenv().AnimY = 0
		getgenv().AnimZ = 0
		getgenv().AnglX = 0
		getgenv().AnglY = 0
		getgenv().AnglZ = 0
		if getgenv().SidewayReal == true then
			getgenv().SidewayReal = false
		end

		if getgenv().InvertReal == true then
				getgenv().InvertReal = false
		end

		if getgenv().CrookedReal == true then
				getgenv().CrookedReal = false
		end

		if getgenv().RollReal == true then
				getgenv().RollReal = false
		end

		getgenv().spinsterreal = true
		while getgenv().spinsterreal == true do
		getgenv().AnglX = RandomNumberGeneration(180)
		getgenv().AnglY = RandomNumberGeneration(180)
		getgenv().AnglZ = RandomNumberGeneration(180)
		wait(-1337)
		getgenv().AnglX = RandomNumberGeneration(180)
		getgenv().AnglY = RandomNumberGeneration(180)
		getgenv().AnglZ = RandomNumberGeneration(180)
		wait(-1337)
		end

		elseif State == "Crooked" then
		getgenv().AnimX = 0
		getgenv().AnimY = 0
		getgenv().AnimZ = 0
		getgenv().AnglX = 0
		getgenv().AnglY = 0
		getgenv().AnglZ = 0


		if getgenv().SidewayReal == true then
			getgenv().SidewayReal = false
		end

		if getgenv().spinsterreal == true then
				getgenv().spinsterreal = false
		end

		if getgenv().InvertReal == true then
				getgenv().InvertReal = false
		end
		if getgenv().RollReal == true then
				getgenv().RollReal = false
		end



		getgenv().CrookedReal = true
		
		while getgenv().CrookedReal == true do
		getgenv().AnglX = 0
		getgenv().AnglY = 35
		getgenv().AnglZ = 35
		wait(-1337)
		getgenv().AnglX = 0
		getgenv().AnglY = -35
		getgenv().AnglZ = -35
		wait(-1337)
		end

		elseif State == "Roll" then
		getgenv().AnimX = 0
		getgenv().AnimY = 0
		getgenv().AnimZ = 0
		getgenv().AnglX = 0
		getgenv().AnglY = 0
		getgenv().AnglZ = 0


		if getgenv().SidewayReal == true then
			getgenv().SidewayReal = false
		end

		if getgenv().spinsterreal == true then
				getgenv().spinsterreal = false
		end

		if getgenv().InvertReal == true then
				getgenv().InvertReal = false
		end

		if getgenv().CrookedReal == true then
				getgenv().CrookedReal = false
		end

		getgenv().RollReal = true
		while getgenv().RollReal == true do 
		getgenv().AnglY = RandomNumberGeneration(360)
		wait(-1337)
		getgenv().AnglY = RandomNumberGeneration(360)
		wait(-1337)
	end

		end
	end,
	flag = "cframepos"
}





movementplayer:Toggle {
Name = "Jump Bug",
flag = "JB", 
    callback = function(state)
if state then
if game.Players.LocalPlayer.Character.Humanoid.UseJumpPower == false then
game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
game.Players.LocalPlayer.Character.Humanoid.JumpPower = 59
end
else
game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = false
game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
	end
end
}



local fieldofview =
	plrvis:Slider {
		Name = "fovs",
		Default = false,
		Min = 70,
		Max = 120,
		Flag = "fieldofview",
		callback = function(state)
			workspace.CurrentCamera.FieldOfView = state
		end
}

fieldofview:SetValueText("FOV : [VALUE]/120")




plrvis:ToggleColorPicker {
	Name = "Aimbot FOV",
	Default = Color3.fromRGB(186,85,211),
	ToggleFlag = "togfov",
	ColorPickerFlag = "togfovcolor",
	ToggleCallback = function(hmm)
		getgenv().Aiming.ShowFOV = hmm
	end,
	ColorPickerCallback = function(color)
        getgenv().Aiming.FOVColour = color
	end
}






esp:ToggleColorPicker {
	Name = "Enabled",
	Default = Color3.fromRGB(186,85,211),
	ToggleFlag = "espenabled",
	ColorPickerFlag = "espcolor",
	ToggleCallback = function(e)
		ESP.Enabled = e
	end,
	ColorPickerCallback = function(LOL)
		ESP.Color = LOL
	end
}

esp:Toggle {
	Name = "Box",
	flag = "EspBoxesToggle",
	callback = function(e)
		ESP.Boxes = e
	end
}



esp:Toggle {
	Name = "Line",
	flag = "EspTracersToggle",
	callback = function(e)
		ESP.Tracers = e
	end
}

esp:Toggle {
	Name = "Info",
	flag = "EspInfoToggle",
	callback = function(e)
		ESP.Names = e
	end
}


esp:Toggle {
	Name = "Teammates",
	flag = "EspBoxesToggle",
	callback = function(e)
		ESP.TeamMates = e
	end
}

esp:Toggle {
	Name = "Team Color",
	flag = "EspBoxesToggle",
	callback = function(e)
		ESP.TeamColor = e
	end
}

esp:Toggle {
	Name = "Face Player",
	flag = "EspBoxesToggle",
	callback = function(e)
		ESP.FaceCamera = e
	end
}



dmisc:Toggle {
	Name = "Remove Foot Step SFX",
	flag = "EspInfoToggle",
	callback = function(state)
    if state then
   _G.FSSFX = true

    game.RunService.Heartbeat:Connect(function()
        if _G.FSSFX then    
        local vel = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
        game.RunService.RenderStepped:Wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = vel
        end    
    end)
    else
_G.FSSFX = false
end
	end
}

local speedsped =
	dmisc:Slider {
		Name = "speedsped",
		Default = false,
		Min = 16,
		Max = 200,
		Flag = "speedsped",
		callback = function(state)
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = state
		end
}

speedsped:SetValueText("Speed : [VALUE]/200")

local jp =
	dmisc:Slider {
		Name = "jp",
		Default = false,
		Min = 50,
		Max = 200,
		Flag = "jp",
		callback = function(state)
			game.Players.LocalPlayer.Character.Humanoid.JumpPower = state
		end
}

jp:SetValueText("Jump Power : [VALUE]/200")

dmisc:Button {
	Name = "Inf Stamina",
	Callback = function()
local plr = game:GetService("Players").LocalPlayer
for i,v in next, getgc() do 
    if type(v) == "function" and getfenv(v).script and getfenv(v).script == plr.Character.ClientInputHandler then 
        for i2,v2 in next, debug.getupvalues(v) do 
            if type(v2) == "number" then 
                debug.setupvalue(v, i2, math.huge)
            end
        end
    end
end
end
}

dmisc:Button {
	Name = "Rejoin",
	Callback = function()
local ts = game:GetService("TeleportService")

local p = game:GetService("Players").LocalPlayer

 

ts:Teleport(game.PlaceId, p)
end
}


others:Toggle {
Name = "Quick Peek Assist",
flag = "rollangs", 
    callback = function(state)
	getgenv().Autopeek = state
end
}
others:Keybind {
	name = "Quick Peek Keybind",
	default = Enum.KeyCode.V,
	blacklist = {
		Enum.KeyCode.Unknown,
		Enum.KeyCode.W,
		Enum.KeyCode.A,
		Enum.KeyCode.S,
		Enum.KeyCode.D,
		Enum.KeyCode.Slash,
		Enum.KeyCode.Tab,
		Enum.KeyCode.Backspace,
		Enum.KeyCode.Escape
	},
	flag = "autopeekkey",
	callback = function(ap)
		getgenv().Key = ap
	end
}

dmisc:Button {
	Name = "Desync Breaker",
	Callback = function()
	loadstring(game:HttpGet("https://paste.ee/r/QPGj1"))()
	end
}

end
