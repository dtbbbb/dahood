-- // .gg/lootenconfigs ', .gg/shhhhconfigs ', .gg/shhhh ', .gg/looten -- //
-- // .gg/lootenconfigs ', .gg/shhhhconfigs ', .gg/shhhh ', .gg/looten -- //
-- // .gg/lootenconfigs ', .gg/shhhhconfigs ', .gg/shhhh ', .gg/looten -- //
-- // .gg/lootenconfigs ', .gg/shhhhconfigs ', .gg/shhhh ', .gg/looten -- //
-- // .gg/lootenconfigs ', .gg/shhhhconfigs ', .gg/shhhh ', .gg/looten -- //

getgenv().Looten = {
    ['StartUP'] = {
        Key = '', -- replace with luarmor key
        UWP_Optimize = true,
        UnlockFPS = true,
        Intro = true
    },
    ['Panic'] = {
        Enabled = false,
        Key = 'L',
    },
    ['Silent'] = {
        Normal = {
            Enabled = true,
            HitChance = 999999999999999999999999,
        },
        KeyBind = {
            Enabled = true,
            KeyBind = ']',
            Notification = true,
        },
        HitPart = {
            NearestPoint = true,
            HitPart = 'HumanoidRootPart',
        },
        Prediction = {
            Enabled = true,
            AutoMated = false, -- auto prediction
            Prediction = 0.13731284913,
        },
    },
    ['CamLock'] = {
        Normal = {
            Enabled = true,
            ThirdPerson = true,
            FirstPerson = true,
        },
        KeyBind = {
            Hold = false,
            Mode = 'KeyBind', -- or "Mouse"
            KeyBind = 'c',
            MouseBind = Enum.UserInputType.MouseButton2,
        },
        Prediction = {
            Enabled = true,
            Prediction = 0.1437,
        },
        Style = {
            First = 'Sine',
            Second = 'Circular'
        },
        Smoothness = {
            Enabled = true,
            Smoothness = 0.5,
            AirShot = 0.7,
        },
        Shake = {
            Enabled = false,
            DirectionX = 1,
            DirectionY = 6,
            DirectionZ = 3,
        },
        HitPart = {
            NearestPoint = true,
            AirShot = true,
            Part = 'HumanoidRootPart',
            AirPart = 'Head',
        },
        AutoUnLock = {
            Reloading = false,
            Typing = false,
        },
    },
    ['Fov'] = {
        CamLock = {
            Show = false,
            Use_Radius = false,
            Radius = 240,
            Model = 'Circle'
        },
        SilentAim = {
            Show = false,
            Use_Radius = true,
            Radius = 45.39,
            Model = 'Circle',
            StickFov = false,
        },
    },
    ['Adjustment'] = {
      ['Checks'] = {
            Resolver = true,
            Anti_Aim_Viewer = true,
            Wall_Check = true,
            Disable_Ground_Shots = true,
            Crew_Check = false,
            Knocked_Check = true,
            AntiCurve = true,
            NoGroundShots = true,
        },
        ['Gun_Fov'] = {
            Enabled = true,
            DoubleBarrel = 51.193,
            Revolver = 49.492,
            Shotgun = 54.391,
            TacticalShotgun = 55.499,
            Smg = 46.491,
            Silencer = 43.191,
            P90 = 45.599,
            Ak47 = 48.391,
            DrumGun = 49.390,
        },
        ['FakeSpike'] = {
            Enabled = false,
            FakeSpikeKeybind = 'B',
            SpikeDuration = 1,            
        },
        ['Anti_Lock'] = {
            Enabled = true,
            KeyBind = Enum.KeyCode.U
        },
        ['Macro'] = {
            Enabled = true,
            Hold_Key = false,
            KeyBind = Enum.KeyCode.Z,
            Mode = '1' -- 1 = ioio 2 = scroll
        },
        ['FrameSkip'] = {
            Enabled = true,
            Notification = true,
            Use_KeyBind = false,
            ToggleKey = 'y',
        },
        ['Auto360'] = {
            Enabled = true,
            SpinKeybind = 'Q',
            SpinSpeed = 19.391,
        },
        ['TriggerBot'] = {
            Enabled = false,
            Delay = 0.1,
                KeyBinds = {
                    Enabled = true,
                    Notifications = true,
                    KeyBind = 't',
            },
        },
        ['Memory'] = {
            Enable = true,
            Start = 1939.39,
            End = 2049.49,
            Speed = 1.35,
        },
        ['Sorting'] = {
            ['Enabled'] = true,
            ['Key Bind'] = Enum.KeyCode.X,
            ['Tool 1'] = "[Double-Barrel SG]",
            ['Tool 2'] = "[TacticalShotgun]",
            ['Tool 3'] = "[Revolver]",
            ['Tool 4'] = "[Chicken]",
            ['Tool 5'] = "[Chicken]",
            ['Tool 6'] = "[Pizza]",
            ['Tool 7'] = "[Pizza]",
            ['Tool 8'] = "",
            ['Tool 9'] = "",
            ['Tool l0'] = "[Katana]",
        },
        ['Animation'] = { -- keybind = use animation
            Lay = true,
            LayKey = Enum.KeyCode.T,
            Greet = true,
            GreetKey = Enum.KeyCode.G,
            Speed = false,
            SpeedKey = Enum.KeyCode.N,
            Sturdy = false,
            SturdyKey = Enum.KeyCode.H,
            Griddy = false,
            GriddyKey = Enum.KeyCode.G,
        },
        ['Chat'] = {
            Enabled = true, --  example !fov 120
            SilentAim_Fov_Size = '!fov',
            SilentAim_Prediction = '!Prediction',
            CamLock_fov_Size = '/fov',
            CamLock_Smoothness = '/Smoothness',
            CamLock_PreDiction = '/ped',
        },
        ['ESP'] = {
            Enabled = true,
            KeyBind = true,
            KeyBindNotification = true,
            Key = Enum.KeyCode.N,
            box = true,
            boxcolor1 = Color3.fromRGB(255,255,255),
            name = true,
            displayname = true,
            headdot = false,
            health = true,
            healthcolor = Color3.fromRGB(255,255,255),
            healthtransparency = 1,
            healthbar = true,
            healthbarcolor1 = Color3.fromRGB(0,255,0),
            healthbarcolor2 = Color3.fromRGB(255,0,0),
            distance = true,
            outoffovarrows = false,
            arrowsoffset = 10,
            arrowscolor = Color3.fromRGB(255,255,255),
            arrowsfilled = false,
            arrowsthickness = 2.5,
            textcase = 1,
            maxtextlength = 2^16,
            hpvisibilitycap = 100,
            checks = {
                false, -- alive check
                false, -- distance check 
            },
            maxdistance = 2^14,
        },
    },
  }

loadstring(game:HttpGet("https://raw.githubusercontent.com/xlanddd/looten/main/looten", true))()
