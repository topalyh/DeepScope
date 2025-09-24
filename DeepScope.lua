if DS_LOADED then return end
pcall(function() getgenv().DS_LOADED = true end)
local function createInstance(name, tbl)
	local any = Instance.new(name)
	for i, v in tbl do
		any[i] = v
	end
	return any
end
function missing(t, f, fallback)
	if type(f) == t then return f end
	return fallback
end
cloneref = missing("function", cloneref, function(...) return ... end)
everyClipboard = missing("function", setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set))
local UserInputService = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local LocalPlayer = game:GetService('Players').LocalPlayer
local GuiService = game:GetService('GuiService')
repeat wait() until LocalPlayer.Character
local suffixes = {
	'',
	'k',
	'm',
	'b',
	't',
	'qa',
	'qi',
	'sx',
	'sp',
	'oc',
	'no',
	'dc',
	'und'
}
local units = {
	['k'] = 1e3,
	['m'] = 1e6,
	['b'] = 1e9,
	['t'] = 1e12,
	['qa'] = 1e15,
	['qi'] = 1e18,
	['sx'] = 1e21,
	['sp'] = 1e24,
	['oc'] = 1e27,
	['no'] = 1e30,
	['dc'] = 1e33,
	['und'] = 1e36
}
local fullUnits = {
	['k'] = 'Thousand',
	['m'] = 'Million',
	['b'] = 'Billion',
	['t'] = 'Trillion',
	['qa'] = 'Quadrillion',
	['qi'] = 'Quintillion',
	['sx'] = 'Sextillion',
	['sp'] = 'Septillion',
	['oc'] = 'Octillion',
	['no'] = 'Nonillion',
	['dc'] = 'Decillion',
	['und'] = 'Undecillion'
}
local icons = {
	size = {19, 19},
	UIsize = {19, 19},
	icons = {
		Unknown = {1.5, 1.5},
		NumberValue = {73.5, 1.5},
		BoolValue = {73.5, 1.5},
		BrickColorValue = {73.5, 1.5},
		IntValue = {73.5, 1.5},
		ObjectValue = {73.5, 1.5},
		CFrameValue = {73.5, 1.5},
		Vector3Value = {73.5, 1.5},
		Color3Value = {73.5, 1.5},
		RayValue = {73.5, 1.5},
		StringValue = {73.5, 1.5},
		Folder = {1.5, 92},
		Part = {19.5, 1.5},
		Model = {37.5, 1.5},
		Configuration = {37.5, 73.5},
		UnionOperation = {127.5, 91.5},
		Tool = {55.5, 19.5},
		PointLight = {235.5, 1.5},
		SpotLight = {235.5, 1.5},
		SurfaceLight = {235.5, 1.5},
		Lighting = {235.5, 1.5},
		Weld = {109.5, 37.5},
		ManualWeld = {109.5, 37.5},
		JointsServer = {109.5, 37.5},
		WeldConstraint = {109.5, 37.5},
		Glue = {109.5, 37.5},
		Motor6D = {109.5, 37.5},
		Script = {109.5, 1.5},
		LocalScript = {73.5, 19.5},
		ModuleScript = {19.5, 91.5},
		Mesh = {146, 2},
		SpecialMesh = {146, 2},
		MeshContentProvider = {146, 2},
		Terrain = {163.5, 73.5},
		Camera = {91.5, 1.5},
		Decal = {127.5, 1.5},
		Humanoid = {164, 1.5},
		Texture = {182, 1.5},
		Sound = {199.5, 1.5},
		Player = {217.5, 1.5},
		Workspace = {91.5, 19.5},
		Players = {127.5, 19.5},
		SpawnLocation = {199.5, 19.5},
		Sky = {1.5, 37.5},
		Accessory = {73.5, 37.5},
		Seat = {127.5, 37.5},
		VehicleSeat = {127.5, 37.5},
		ScreenGui = {91.5, 55.5},
		Frame = {110, 55.5},
		ImageLabel = {128, 55.5},
		TextLabel = {146, 55.5},
		TextService = {146, 55.5},
		TextButton = {164, 55.5},
		ImageButton = {181.5, 55.5},
		Handles = {199.5, 55.5},
		SelectionBox = {218, 55.5},
		SurfaceSelection = {236, 55.5},
		Selection = {236, 55.5},
		ArcHandles = {1.5, 73.5},
		BillboardGui = {146.5, 73.5},
		BindableFunction = {182, 73.5},
		['Run Service'] = {182, 73.5},
		BindableEvent = {200, 73.5},
		ParticleEmitter = {235.5, 73.5},
		ReplicatedFirst = {37.5, 91.5},
		ReplicatedStorage = {37.5, 91.5},
		InsertService = {37.5, 91.5},
		AssetService = {37.5, 91.5},
		RemoteFunction = {163.5, 91.5},
		RemoveEvent = {181.5, 91.5},
		HingeConstraint = {91.5, 109.5},
		StarterPlayer = {73.5, 109.5},
		StarterCharacterScripts = {217.5, 91.5},
		StarterPlayerScripts = {217.5, 91.5},
		PlayerScripts = {217.5, 91.5},
		Attachment = {145.5, 109.5},
		BallSocketConstraint = {235.5, 109.5},
		RodConstraint = {19.5, 127.5},
		RopeConstraint = {38, 127.5},
		PrismaticConstraint = {55.5, 127.5},
		SpringConstraint = {73.5, 127.5},
		Debris = {37.5, 37.5},
		PhysicsService = {37.5, 37.5},
		CollectionService = {37.5, 37.5},
		CookiesService = {127.5, 145.5},
		Backpack = {109.5, 19.5},
		StarterGear = {109.5, 19.5},
		StarterPack = {109.5, 19.5},
		PlayerGui = {73.5, 55.5},
		StarterGui = {73.5, 55.5},
		CoreGui = {73.5, 55.5},
		['Script Context'] = {217.5, 91.5},
		CoreScript = {127.5, 109.5},
		ScriptService = {127.5, 109.5},
		Animation = {73.5, 73.5},
		Smoke = {55.5, 73.5},
		Fire = {90.5, 73.5},
		Shirt = {20, 55.5},
		Pants = {38, 55.5},
		ShirtGraphic = {217.5, 37.5},
		TestService = {217.5, 73.5},
		NetworkClient = {37.5, 19.5},
		ServerStorage = {73.5, 91.5},
		ServerScriptService = {73.5, 91.5},
		Chat = {91.5, 37.5},
		AdService = {55.5, 91.5},
		BadgeService = {91.5, 91.5},
		ContextActionService = {235.5, 37.5},
		ContentProvider = {37.5, 91.5},
		GamePassService = {91.5, 19.5},
		GuiService = {91.5, 55.5},
		HapticService = {1.5, 109.5},
		HttpService = {109.5, 127.5},
		PathFindingService = {163.5, 37.5},
		KeyframeSequenceProvider = {73.5, 73.5},
		LogService = {55.5, 109.5},
		MarketplaceService = {73.5, 55.5},
		PointsService = {235.5, 91.5},
		['Teleport Service'] = {199.5, 91.5},
		UserInputService = {1.5, 109.5},
		ClickDetector = {91.5, 127.5},
		DragDetector = {91.5, 127.5},
		UIDragDetector = {91.5, 127.5},
		ColorCorrectionEffect = {109.5, 109.5},
		Atmosphere = {109.5, 109.5},
		BloomEffect = {109.5, 109.5},
		BlurEffect = {109.5, 109.5},
		SunRaysEffect = {109.5, 109.5},
	},
	UIicons = {
		dropdown_closed = {199.5, 199.5},
		dropdown_closedhover = {199.5, 217.5},
		dropdown_opened = {217.5, 199.5},
		dropdown_openedhover = {217.5, 217.5},
		delete = {163.5, 217.5},
		delete_locked = {163.5, 199.5}
	}
}
local add_objects = {
	size = {19, 19},
	objects = {
		['3D Interfaces'] = {
			ClickDetector = {
				Name = 'ClickDetector',
				Order = 1
			},
			Decal = {
				Name = 'Decal',
				Order = 2
			},
			Dialog = {
				Name = 'Dialog',
				Order = 3
			},
			DialogChoise = {
				Name = 'DialogChoise',
				Order = 4
			},
			DragDetector = {
				Name = 'DragDetector',
				Order = 5
			},
			MaterialVariant = {
				Name = 'MaterialVariant',
				Order = 6
			},
			ProximityPrompt = {
				Name = 'ProximityPropmpt',
				Order = 7
			},
			SurfaceAppearance = {
				Name = 'SurfaceAppearance',
				Order = 8
			},
			TerrainDetail = {
				Name = 'TerrainDetail',
				Order = 9
			},
			Texture = {
				Name = 'Texture',
				Order = 10
			}
		},
		['Adornments'] = {
			ArcHandles = {
				Name = 'ArcHandles',
				Order = 12
			},
			BoxHandleAdornment = {
				Name = 'BoxHandleAdornment',
				Order = 13
			},
			ConeHandleAdornment = {
				Name = 'ConeHandleAdornment',
				Order = 14
			},
			CylinderHandleAdornment = {
				Name = 'CylinderHandleAdornment',
				Order = 15
			},
			Handles = {
				Name = 'Handles',
				Order = 16
			},
			ImageHandleAdornment = {
				Name = 'ImageHandleAdornment',
				Order = 17
			},
			LineHandleAdornment = {
				Name = 'LineHandleAdornment',
				Order = 18
			},
			PathFindingLink = {
				Name = 'PathFindingLink',
				Order = 19
			},
			PathFindingModifier = {
				Name = 'PathFindingModifier',
				Order = 20
			},
			SelectionBox = {
				Name = 'SelectionBox',
				Order = 21
			},
			SelectionSphere = {
				Name = 'SelectionSphere',
				Order = 22
			},
			SphereHandleAdornment = {
				Name = 'SphereHandleAdornment',
				Order = 23
			},
			SurfaceSelection = {
				Name = 'SurfaceSelection',
				Order = 24
			},
			WireframeHandleAdornment = {
				Name = 'WireframeHandleAdornment',
				Order = 25
			}
		},
		['Ads'] = {
			AdGui = {
				Name = 'AdGui',
				Order = 27
			}
		},
		['Animations'] = {
			Animation = {
				Name = 'Animation',
				Order = 29
			},
			AnimationController = {
				Name = 'AnimationController',
				Order = 30
			},
			Animator = {
				Name = 'Animator',
				Order = 31
			},
			Bone = {
				Name = 'Bone',
				Order = 32
			},
			FaceControls = {
				Name = 'FaceControls',
				Order = 33
			},
			IKControl = {
				Name = 'IKControl',
				Order = 34
			},
			Motor6D = {
				Name = 'Motor6D',
				Order = 35
			}
		},
		['Avatar'] = {
			Accessory = {
				Name = 'Accessory',
				Order = 37
			},
			BodyColors = {
				Name = 'BodyColors',
				Order = 39
			},
			ForceField = {
				Name = 'ForceField',
				Order = 44
			},
			Humanoid = {
				Name = 'Humanoid',
				Order = 46
			},
			Pants = {
				Name = 'Pants',
				Order = 47
			},
			Shirt = {
				Name = 'Shirt',
				Order = 48
			},
			ShirtGraphic = {
				Name = 'ShirtGraphic',
				Order = 49
			}
		},
		['Constraints'] = {
			AlignOrientation = {
				Name = 'AlignOrientation',
				Order = 51
			},
			AlignPosition = {
				Name = 'AlignPosition',
				Order = 52
			},
			AngularVelocity = {
				Name = 'AngularVelocity',
				Order = 53
			},
			Attachment = {
				Name = 'Attachment',
				Order = 55
			},
			BallSocketConstraint = {
				Name = 'BallSocketConstraint',
				Order = 56
			},
			CylindricalConstraint = {
				Name = 'CylindricalConstraint',
				Order = 57
			},
			HingeConstraint = {
				Name = 'HingeConstraint',
				Order = 58
			},
			LinearVelocity = {
				Name = 'LinearVelocity',
				Order = 59
			},
			LineForce = {
				Name = 'LineForce',
				Order = 60
			},
			NoCollisionConstraint = {
				Name = 'NoCollisionConstraint',
				Order = 61
			},
			PrismaticConstraint = {
				Name = 'PrismaticConstraint',
				Order = 63
			},
			RigidConstraint = {
				Name = 'RigitConstraint',
				Order = 64
			},
			RodConstraint = {
				Name = 'RodConstraint',
				Order = 65
			},
			RopeConstraint = {
				Name = 'RopeConstraint',
				Order = 66
			},
			SpringConstraint = {
				Name = 'SpringConstraint',
				Order = 67
			},
			Torque = {
				Name = 'Torque',
				Order = 68
			},
			VectorForce = {
				Name = 'VectorForce',
				Order = 71
			},
			WeldConstraint = {
				Name = 'WeldConstraint',
				Order = 72
			}
		},
		['Effects'] = {
			Beam = {
				Name = 'Beam',
				Order = 74
			},
			Explosion = {
				Name = 'Explosion',
				Order = 75
			},
			Fire = {
				Name = 'Fire',
				Order = 76
			},
			Highlight = {
				Name = 'Highlight',
				Order = 77
			},
			ParticleEmitter = {
				Name = 'ParticleEmitter',
				Order = 78
			},
			Smoke = {
				Name = 'Smoke',
				Order = 79
			},
			Sparkles = {
				Name = 'Sparkles',
				Order = 80
			},
			Trail = {
				Name = 'Trail',
				Order = 81
			}
		},
		['Environment'] = {
			Atmosphere = {
				Name = 'Atmosphere',
				Order = 85
			},
			Clouds = {
				Name = 'Clouds',
				Order = 86
			},
			Sky = {
				Name = 'Sky',
				Order = 87
			}
		},
		['Interaction'] = {
			Seat = {
				Name = 'Seat',
				Order = 121
			},
			SpawnLocation = {
				Name = 'SpawnLocation',
				Order = 122
			},
			Tool = {
				Name = 'Tool',
				Order = 124
			},
			VehicleSeat = {
				Name = 'VehicleSeat',
				Order = 125
			}
		},
		['Lights'] = {
			PointLight = {
				Name = 'PointLight',
				Order = 127
			},
			SpotLight = {
				Name = 'SpotLight',
				Order = 128
			},
			SurfaceLight = {
				Name = 'SurfaceLight',
				Order = 129
			}
		},
		['Parts'] = {
			CornerWedgePart = {
				Name = 'Sky',
				Order = 134
			},
			Part = {
				Name = 'Part',
				Order = 136
			},
			TrussPart = {
				Name = 'TrussPart',
				Order = 137
			},
			WedgePart = {
				Name = 'Sky',
				Order = 138
			}
		}
	}
}
local explorerBlacklistInstances = {'cheatGui', 'ServerScriptService'}
local currentUnit = 'K'
local selectedplr = 'nobody'
local cheatEnabled = false
local lastcf = CFrame.new(0, 0, 0)
local mode = 'follow'
local guiHiden = false
local explorerOpened = true
local explorerData = {}
local draggingExplorer = false
local draggingColorPicker = false
local resizingExplorer = false
local resizingLogMenu = false
local resizingColorPicker = false
local startExplorerSize = UDim2.fromOffset(0, 0)
local startExplorerPos = UDim2.fromOffset(0, 0)
local startPickerSize = UDim2.fromOffset(0, 0)
local startLogSize = UDim2.fromOffset(0, 0)
local startMousePos = UDim2.fromOffset(0, 0)
local startLogsPos = UDim2.fromOffset(0, 0)
local dragConn = nil
local explorerUsing = false
local countdowns = {}
local selectedObject = nil
local hoveringObject = nil
local pickerMode = 'circle'
local currentScale = 1
local pickerOpened = false
local pickingColor = false
local humanoid = LocalPlayer.Character.Humanoid
local humanoidRootPart = LocalPlayer.Character.PrimaryPart
local currentVelocity = Vector3.new(0, 0, 0)
local flySpeed = 1
local acceleration = 0.075
local Enabled = false
local FreecamEnabled = false
local BodyPos = nil
local BodyGyro = nil
local moveDirection = Vector3.new()
local notificationSoundId = 'rbxassetid://17208372272'
local isDied = false
local commandPrefix = ";"
local commandKey = Enum.KeyCode.Semicolon
local notify_amount = 0
local notify_streak = 0
local lastDeath = 0
local lastRespawn = 0
local infoList = nil
local logList = nil
local placeInfoOpened = false
local logsOpened = false
local initMessages = {
	'Nice to see you {player}!',
	'Having a good day, {player}?',
	'Have a nice day {player}!'
}
local currentUIColor = Color3.fromRGB(163, 162, 165)
local usingSlider = {
	enabled = false
}
local logConfig = {
	colors = {
		normal = {204, 204, 204},
		info = {97, 161, 241},
		error = {255, 0, 0},
		warn = {255, 115, 21}
	},
	stringFormat = "%s - %s  -  %s",
	messages = 0,
	limit = 200
}
local lastVelocity = Vector3.zero
local lastTime = tick()
local currentColor = Color3.fromHSV(0, 1, 1)
local colors = {
	h = 0,
	s = 0,
	v = 1,
	r = 255,
	g = 255,
	b = 255
}
local trianglePoints = {
	[1] = Vector2.new(0.5,0),
	[2] = Vector2.new(0,1),
	[3] = Vector2.new(1,1)
}
local triangleHeight = math.sqrt(3) / 2
local function heightToTriangleHeight(h)
	return h / triangleHeight - (1 - triangleHeight) / 2
end
local function toPolar(v)
	return math.atan2(v.Y,v.X),v.Magnitude
end
_createForces = function(hrp)
	local bp = Instance.new('BodyPosition')
	bp.MaxForce = Vector3.new(1e7, 1e7, 1e7)
	bp.D = 500
	bp.P = 1e7
	bp.Position = hrp.Position
	bp.Parent = hrp

	local bg = Instance.new('BodyGyro')
	bg.MaxTorque = Vector3.new(1e4, 1e4, 1e4)
	bg.D = 500
	bg.P = 1e4
	bg.CFrame = hrp.CFrame
	bg.Parent = hrp

	BodyPos = bp
	BodyGyro = bg
end
local modules = {
	circle = {
		GetColor = function(mousePos)
			local toWheelMid = mousePos - Vector2.new(0.5,0.5)
			local phi, len = toPolar(toWheelMid * Vector2.new(1,-1))

			local h, s = math.clamp((phi + math.pi) / (2 * math.pi),0,1), math.clamp(len * 2,0,1)
			return {h, s, colors.v}
		end,
		GetPointerPositionFromColor = function(h,s,v)
			local h2 = h * math.pi * 2
			return UDim2.fromScale(
				0.5 - (math.cos(h2) / 2 * s),
				0.5 + (math.sin(h2) / 2 * s)
			)
		end
	},
	square = {
		GetColor = function(mousePos)
			local s = math.clamp(mousePos.X,0,1)
			local v = 1 - math.clamp(mousePos.Y,0,1)
			return {colors.h,s,v}
		end,
		GetPointerPositionFromColor = function(h,s,v)
			return UDim2.fromScale(s,1 - v)
		end
	},
	triangle = {
		GetColor = function(mousePos)
			local x = mousePos.X
			local y = math.clamp(heightToTriangleHeight(mousePos.Y),0,1)
			x = math.clamp(x,0.5 - (y / 2),0.5 + (y / 2))

			local tri1,tri2,tri3 = trianglePoints[1],trianglePoints[2],trianglePoints[3]

			local l1 = ((tri2.Y - tri3.Y) * (x - tri3.X) + (tri3.X - tri2.X) * (y - tri3.Y))
				/ ((tri2.Y - tri3.Y) * (tri1.X - tri3.X) + (tri3.X - tri2.X) * (tri1.Y - tri3.Y))

			local l2 = ((tri3.Y - tri1.Y) * (x - tri3.X) + (tri1.X - tri3.X) * (y - tri3.Y))
				/ ((tri2.Y - tri3.Y) * (tri1.X - tri3.X) + (tri3.X - tri2.X) * (tri1.Y - tri3.Y))

			local l3 = 1 - l1 - l2

			l1,l2,l3 = math.clamp(l1,0,1),math.clamp(l2,0,1),math.clamp(l3,0,1)

			local hue = Color3.fromHSV(colors.h,1,1)
			local color = Color3.new(
				l1 * hue.R + l2 * 0 + l3 * 1,
				l1 * hue.G + l2 * 0 + l3 * 1,
				l1 * hue.B + l2 * 0 + l3 * 1
			)

			local _,newS,newV = color:ToHSV()
			return {colors.h,newS,newV}
		end,
		GetPointerPositionFromColor = function(h,s,v)
			local pos = Vector2.new(0.5,0):Lerp(Vector2.new(1,1),1 - s):Lerp(Vector2.new(0,1),1 - v)
			return UDim2.fromScale(pos.X,(1 - triangleHeight) / 2 + pos.Y * triangleHeight)
		end
	},
	slider = {
		GetValue = function(slider, mousePos)
			local value = math.clamp(math.round((mousePos.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X), 0, 1)
			return value
		end,
		GetPointerPositionFromColor = function(value, gradientColor, slider, tweenInfo)
			if gradientColor and slider then
				slider.UIGradient.Color = gradientColor
			end
			if slider then
				local name = slider.Name:sub(1, 1):lower()
				if name == 's' or name == 'v' then
					slider.value.Text = math.round(value * 100)
				end
				if name == 'h' then
					slider.value.Text = math.round(value * 360)
				end
				if name == 'r' or name == 'g' or name == 'b' then
					slider.value.Text = math.round(value * 255)
				end
			end
			return UDim2.fromScale(value, 0.5)
		end,
	},
	settings = {

	},
	other = {
		fly = {
			DefaultKey = Enum.KeyCode.F,

			UpdateFlying = function(enabled, flyspeed)
				flySpeed = flyspeed or 1
				if enabled then
					_createForces(humanoidRootPart)
					humanoid.PlatformStand = true
				else
					humanoid.PlatformStand = false
					if BodyPos then BodyPos:Destroy() BodyPos = nil end
					if BodyGyro then BodyGyro:Destroy() BodyGyro = nil end
					currentVelocity = Vector3.new()
				end
				Enabled = enabled
			end,

			UpdateMoveDirection = function()
				local direction = Vector3.new()
				if UserInputService:IsKeyDown(Enum.KeyCode.W) then
					direction += Vector3.new(0, 0, -1)
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.S) then
					direction += Vector3.new(0, 0, 1)
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.A) then
					direction += Vector3.new(-1, 0, 0)
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.D) then
					direction += Vector3.new(1, 0, 0)
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
					direction += Vector3.new(0, -1, 0)
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.E) then
					direction += Vector3.new(0, 1, 0)
				end
				moveDirection = direction.Magnitude > 0 and direction.Unit or Vector3.new()
			end,

			Loop = function()
				if Enabled and BodyPos and BodyGyro then
					local camCF = workspace.CurrentCamera.CFrame
					local moveVec = moveDirection.Magnitude > 0 and moveDirection.Unit or Vector3.new()
					local targetVelocity = camCF:VectorToWorldSpace(moveVec) * flySpeed

					-- Плавное приближение
					currentVelocity = currentVelocity:Lerp(targetVelocity, acceleration)

					BodyPos.Position = humanoidRootPart.Position + currentVelocity
					BodyGyro.CFrame = CFrame.lookAt(humanoidRootPart.Position, humanoidRootPart.Position + camCF.LookVector)
				end
			end,

			Respawn = function(char)
				local hrp = char:WaitForChild('HumanoidRootPart')
				humanoid = char:WaitForChild('Humanoid')
				humanoidRootPart = hrp

				if Enabled then
					humanoid.PlatformStand = true
					_createForces(hrp)
				end
			end,
		},
		placeinfo = {
			CreateText = function(infoTxt, copyableTxt)
				local template = createInstance('Frame', {
					Parent = infoList,
					Name = 'template',
					Size = UDim2.new(1, -15, 0, 20),
					Visible = false,
					BorderColor3 = Color3.new(0, 0, 0),
					BorderSizePixel = 0
				})
				local placeInfoFrame1 = createInstance('UIPadding', {
					Parent = template,
					PaddingLeft = UDim.new(0, 5),
					PaddingRight = UDim.new(0, 5)
				})
				local placeInfoFrame2 = createInstance('TextBox', {
					Parent = template,
					Name = 'copyableinfo',
					BackgroundTransparency = 1,
					AnchorPoint = Vector2.new(1, 0),
					AutomaticSize = Enum.AutomaticSize.X,
					ClearTextOnFocus = false,
					Position = UDim2.fromScale(1, 0),
					Size = UDim2.fromScale(0, 1),
					TextEditable = false,
					FontFace = Font.new('rbxassetid://12187374954'),
					Text = 'aWYgeW91IHNlZSB0aGlzLCBkb250IGV4cGxvaXQgYW55bW9yZSE=',
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 19,
					TextXAlignment = Enum.TextXAlignment.Right,
					BorderColor3 = Color3.new(0, 0, 0),
					BorderSizePixel = 0
				})
				local placeInfoFrame3 = createInstance('TextLabel', {
					Parent = template,
					Name = 'info',
					BackgroundTransparency = 1,
					AutomaticSize = Enum.AutomaticSize.X,
					Size = UDim2.fromScale(0, 1),
					FontFace = Font.new('rbxassetid://12187374954'),
					Text = 'aWYgeW91IHNlZSB0aGlzLCBkb250IGV4cGxvaXQgYW55bW9yZSE=',
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 19,
					TextXAlignment = Enum.TextXAlignment.Left,
					BorderColor3 = Color3.new(1, 1, 1),
					BorderSizePixel = 0
				})

				local newTemplate = template:Clone()
				newTemplate.Parent = infoList
				newTemplate.Visible = true
				newTemplate.copyableinfo.Text = copyableTxt
				newTemplate.info.Text = infoTxt
			end,
			CreateSeparator = function(text)
				local separatorTemplate = createInstance('Frame', {
					Parent = infoList,
					Name = 'separator',
					BackgroundTransparency = 1,
					Size = UDim2.new(1, -15, 0, 40),
					Visible = false
				})
				local separatorGui1 = createInstance('Frame', {
					Parent = separatorTemplate,
					Name = 'divider',
					BackgroundColor3 = Color3.new(1, 1, 1),
					AnchorPoint = Vector2.new(0.5, 1),
					Position = UDim2.fromScale(0.5, 1),
					Size = UDim2.new(1, 0, 0, 1),
					BorderColor3 = Color3.new(1, 1, 1),
					BorderSizePixel = 0
				})
				local separatorGui2 = createInstance('TextLabel', {
					Parent = separatorTemplate,
					BackgroundTransparency = 1,
					AnchorPoint = Vector2.new(0, 0.5),
					AutomaticSize = Enum.AutomaticSize.X,
					Position = UDim2.fromScale(0, 0.5),
					Size = UDim2.fromScale(0, 0.7),
					FontFace = Font.new('rbxasset://fonts/families/Oswald.json', Enum.FontWeight.Bold),
					Text = 'aWYgeW91IHNlZSB0aGlzLCBkb250IGV4cGxvaXQgYW55bW9yZSE=',
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 28,
					TextXAlignment = Enum.TextXAlignment.Left
				})

				local newTemplate = separatorTemplate:Clone()
				newTemplate.Parent = infoList
				newTemplate.Visible = true
				newTemplate.TextLabel.Text = text
			end,
			UpdateText = function(name, newText)
				local template = infoList:FindFirstChild(name)
				if template then
					template.copyableinfo.Text = newText
				end
			end,
		},
		colorTranslations = {
			rgbToHSV = function(r, g, b)
				r = math.clamp(r, 0, 1)
				g = math.clamp(g, 0, 1)
				b = math.clamp(b, 0, 1)
				local hsv = Color3.new(r, g, b):ToHSV()

				return {hsv}
			end,
			hsvToRGB = function(h, s, v)
				h = math.clamp(h, 0, 1)
				s = math.clamp(s, 0, 1)
				v = math.clamp(v, 0, 1)
				local rgb = Color3.fromHSV(h, s, v)
				local r, g, b = math.floor(rgb.R * 255), math.floor(rgb.G * 255), math.floor(rgb.B * 255)

				return {r, g, b}
			end,
			rgbToHSL = function(r, g, b)
				r = math.clamp(r, 0, 1)
				g = math.clamp(g, 0, 1)
				b = math.clamp(b, 0, 1)
				local min = math.min(r, g, b)
				local max = math.max(r, g, b)
				local l = (min + max) / 2
				local s = 0
				local h = 0

				if max == min then
					h, s = 0, 0
				else
					local d = max - min
					s = d / (1 - math.abs(2 * l - 1))

					if max == r then
						h = ((g - b) / d) % 6
					elseif max == g then
						h = ((b - r) / d) + 2
					else
						h = ((r - g) / d) + 4
					end

					h =  h * 60
					if h < 0 then h = h + 360 end
				end

				return {h, s, l}
			end,
			hslToRGB = function(h, s, l)
				local c = (1 - math.abs(2 * l - 1)) * s
				local x = c * (1 - math.abs((h / 60) % 2 - 1))
				local m = l - c / 2

				local r2, g2, b2
				if h < 60 then
					r2, g2, b2 = c, x, 0
				elseif h < 120 then
					r2, g2, b2 = x, c, 0
				elseif h < 180 then
					r2, g2, b2 = 0, c, x
				elseif h < 240 then
					r2, g2, b2 = 0, x, c
				elseif h < 300 then
					r2, g2, b2 = x, 0, c
				else
					r2, g2, b2 = c, 0, x
				end

				local r = (r2 + m) * 255
				local g = (g2 + m) * 255
				local b = (b2 + m) * 255

				return {math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5)}
			end,
			cmykToRGB = function(c, m, y, k)
				local r = 255 * (1 - c) * (1 - k)
				local g = 255 * (1 - m) * (1 - k)
				local b = 255 * (1 - y) * (1 - k)

				return {math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5)}
			end,
			rgbToCMYK = function(r, g, b)
				r, g, b = r / 255, g / 255, b / 255
				local k = 1 - math.max(r, g, b)

				if k >= 1 then
					return 0, 0, 0, 1
				end

				local c = (1 - r - k) / (1 - k)
				local m = (1 - g - k) / (1 - k)
				local y = (1 - b - k) / (1 - k)

				return {c, m, y, k}
			end,
		}
	}
}

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if isDied then return end
	if input.KeyCode == modules.other.fly.DefaultKey then
		Enabled = not Enabled
		modules.other.fly.UpdateFlying(Enabled)
	end
	modules.other.fly.UpdateMoveDirection(processed)
end)
UserInputService.InputEnded:Connect(function(processed)
	if not isDied then
		modules.other.fly.UpdateMoveDirection(processed)
	end
end)
spawn(function()
	while task.wait() do
		if not isDied then
			modules.other.fly.Loop()
		end
	end
end)
local function AddLog(text, sourse, type)
	if not type then type = "normal" end
	repeat wait() until logList
	local gui = createInstance("TextLabel", {
		Name = "log",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -15, 0, 20),
		FontFace = Font.new('rbxassetid://12187374954', Enum.FontWeight.Medium),
		Text = "aWYgeW91IHNlZSB0aGlzLCBkb250IGV4cGxvaXQgYW55bW9yZSE=",
		TextColor3 = Color3.fromRGB(204, 204, 204),
		TextSize = 19,
		RichText = true,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextXAlignment = Enum.TextXAlignment.Left,
		Visible = false
	})
	local gui2 = createInstance("UIPadding", {
		Parent = gui,
		PaddingLeft = UDim.new(0, 5)
	})
	local timeNow = os.date("%X", tick())
	local ok, textResult = pcall(function()
		return logConfig.stringFormat:format(timeNow, ("<font color='rgb(%d,%d,%d)'>%s</font>"):format(logConfig.colors[type][1], logConfig.colors[type][2], logConfig.colors[type][3], text), sourse or "DeepScope")
	end)
	logConfig.messages += 1
	local newTemplate = gui:Clone()
	newTemplate.Parent = logList
	newTemplate.Name = "log"..logConfig.messages
	newTemplate.LayoutOrder = -logConfig.messages
	newTemplate.Visible = true
	if ok then
		newTemplate.Text = textResult
	else
		newTemplate.Text = timeNow.."  game.ReplicatedStorage._DeepScopeCore.Logs:4727: "..textResult.."  -  DeepScope"
	end
end
local function createGui()
	local gui1 = createInstance('ScreenGui', {
		DisplayOrder = 2147483647,
		Name = 'cheatGui',
		Parent = cloneref(game:GetService("CoreGui")),
		IgnoreGuiInset = true,
		ResetOnSpawn = false
	})
	local gui2 = createInstance('Frame', {
		Parent = gui1,
		Name = 'main',
		AnchorPoint = Vector2.new(0.2, 0),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.1, 0),
		Size = UDim2.new(0.9, 0, 0.15, 0),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0
	})
	local gui3 = createInstance('TextButton', {
		Parent = gui2,
		Name = 'mode',
		Position = UDim2.new(0.479, 0, -0.35, 0),
		Size = UDim2.new(0.206, 0, 0.572, 0),
		Text = 'mode: follow',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true
	})
	local gui4 = createInstance('TextButton', {
		Parent = gui2,
		Name = 'startbutton',
		Position = UDim2.new(0.364, 0, -0.332, 0),
		Size = UDim2.new(0.101, 0, 0.572, 0),
		Text = 'start',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true
	})
	local gui5 = createInstance('ScrollingFrame', {
		Parent = gui2,
		Name = 'list',
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollBarThickness = 5,
		VerticalScrollBarInset = Enum.ScrollBarInset.Always,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0
	})
	local ui_object1 = createInstance('UIListLayout', {
		Parent = gui5,
		Padding = UDim.new(0, 5),
		HorizontalAlignment = Enum.HorizontalAlignment.Center
	})
	local gui7 = createInstance('TextLabel', {
		Parent = gui2,
		Name = 'label',
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.065, 0, -0.206, 0),
		Size = UDim2.new(0.13, 0, 0.257, 0),
		Text = 'select player',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true
	})
	local gui8 = createInstance('TextLabel', {
		Parent = gui2,
		Name = 'currentplr',
		Position = UDim2.new(0.141, 0, -0.343, 0),
		Size = UDim2.new(0.212, 0, 0.257, 0),
		Text = 'selectedPlayer: nobody',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextScaled = true
	})
	local gui9 = createInstance('TextBox', {
		Parent = gui2,
		Name = 'searchPlayer',
		Position = UDim2.new(0.141, 0, -0.023),
		Size = UDim2.new(0.212, 0, 0.257, 0),
		Text = '',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true,
		PlaceholderText = 'search player (username)'
	})
	local gui10 = createInstance('TextLabel', {
		Parent = gui2,
		Name = 'distance',
		Position = UDim2.new(0.141, 0, 0.309, 0),
		Size = UDim2.new(0, 0, 0.257, 0),
		Text = 'distance from character: unknown',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextScaled = true,
		AutomaticSize = Enum.AutomaticSize.X
	})
	local gui11 = createInstance('TextLabel', {
		Parent = gui2,
		Name = 'spawndistance',
		Position = UDim2.new(0.141, 0, 0.64, 0),
		Size = UDim2.new(0, 0, 0.257, 0),
		Text = 'distance from spawn: unknown',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextScaled = true,
		AutomaticSize = Enum.AutomaticSize.X
	})
	local gui12 = createInstance('TextLabel', {
		Parent = gui2,
		Name = 'currentspeed',
		Position = UDim2.new(0.141, 0, 0.972, 0),
		Size = UDim2.new(0, 0, 0.257, 0),
		Text = 'current speed: unknown | 0:0',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextScaled = true,
		AutomaticSize = Enum.AutomaticSize.X
	})
	local gui14 = createInstance('TextButton', {
		Parent = gui2,
		Name = 'unitformat',
		Size = UDim2.new(0.138, 0, 0.252, 0),
		Position = UDim2.new(0.003, 0, 1.326, 0),
		Text = 'format: M',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true
	})
	local gui15 = createInstance('TextButton', {
		Parent = gui2,
		Name = 'hidebutton',
		Size = UDim2.new(0.054, 0, 0.389, 0),
		Position = UDim2.new(0.694, 0, -0.544, 0),
		Text = 'hide',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true
	})
	local gui16 = createInstance('TextButton', {
		Parent = gui2,
		Name = 'explorer',
		Size = UDim2.new(0.138, 0, 0.343, 0),
		Position = UDim2.new(0.003, 0, 1.658, 0),
		Text = 'open explorer',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true,
		Visible = true
	})
	local gui16 = createInstance('TextButton', {
		Parent = gui2,
		Name = 'uicolor',
		Size = UDim2.new(0.181, 0, 0.194, 0),
		Position = UDim2.new(0.502, 0, -0.555, 0),
		Text = 'set UI color',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true
	})
	local gui17 = createInstance('TextButton', {
		Parent = gui2,
		Name = 'placeinfo',
		Size = UDim2.new(0.181, 0, 0.194, 0),
		Position = UDim2.new(0.32, 0, -0.555, 0),
		Text = 'place info',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true
	})
	local gui18 = createInstance('TextButton', {
		Parent = gui2,
		Name = 'logs',
		Size = UDim2.new(0.181, 0, 0.194, 0),
		Position = UDim2.new(0.129, 0, -0.555, 0),
		Text = 'open logs',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true
	})
	local gui_obj_2 = createInstance('UIPadding', {
		Parent = gui10,
		PaddingBottom = UDim.new(0, 5),
		PaddingLeft = UDim.new(0, 5),
		PaddingRight = UDim.new(0, 5),
		PaddingTop = UDim.new(0, 5),
	})
	local gui_obj_3 = createInstance('UIPadding', {
		Parent = gui11,
		PaddingBottom = UDim.new(0, 5),
		PaddingLeft = UDim.new(0, 5),
		PaddingRight = UDim.new(0, 5),
		PaddingTop = UDim.new(0, 5),
	})
	local gui_obj_4 = createInstance('UIPadding', {
		Parent = gui12,
		PaddingBottom = UDim.new(0, 5),
		PaddingLeft = UDim.new(0, 5),
		PaddingRight = UDim.new(0, 5),
		PaddingTop = UDim.new(0, 5),
	})
	local gui_obj_6 = createInstance('UISizeConstraint', {
		Parent = gui10,
		MaxSize = Vector2.new(590, 1e308)
	})
	local gui_obj_7 = createInstance('UISizeConstraint', {
		Parent = gui11,
		MaxSize = Vector2.new(590, 1e308)
	})
	local gui_obj_8 = createInstance('UISizeConstraint', {
		Parent = gui12,
		MaxSize = Vector2.new(590, 1e308)
	})

	local explorerGui1 = createInstance('Frame', {
		Parent = gui1,
		Name = 'explorer',
		BackgroundColor3 = Color3.fromRGB(102, 101, 103),
		Position = UDim2.fromOffset(0, 88),
		Size = UDim2.fromOffset(240, 160),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Visible = false
	})
	local explorerGui2 = createInstance('ScrollingFrame', {
		Parent = explorerGui1,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		AutomaticCanvasSize = Enum.AutomaticSize.XY,
		BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',
		ScrollBarImageColor3 = Color3.new(),
		CanvasSize = UDim2.fromScale(0, 0),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',
	})
	local explorerGui3 = createInstance('UIListLayout', {Parent = explorerGui2})
	local explorerGui4 = createInstance('TextButton', {
		Parent = explorerGui1,
		Name = 'dragbutton',
		BackgroundColor3 = Color3.fromRGB(102, 101, 103),
		AnchorPoint = Vector2.new(0, 1),
		Size = UDim2.new(1, 0, 0, 30),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = 'explorer',
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 20,
		FontFace = Font.new('rbxassetid://12187374954'),
		AutoButtonColor = false,
		ClipsDescendants = true
	})
	local explorerGui5 = createInstance('Frame', {
		Parent = explorerGui4,
		Name = 'outline',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.fromScale(1, 2),
	})
	local explorerGui6 = createInstance('TextButton', {
		Parent = explorerGui1,
		Name = 'resizebottom',
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, -2, 0, 7),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = '',
		AutoButtonColor = false
	})
	local explorerGui7 = createInstance('TextButton', {
		Parent = explorerGui1,
		Name = 'resizeside',
		BackgroundTransparency = 1,
		Position = UDim2.new(1, 0, 0, -30),
		Size = UDim2.new(0, 7, 1, 28),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = '',
		AutoButtonColor = false
	})
	local explorerGui8 = createInstance('TextButton', {
		Parent = explorerGui4,
		Name = 'fullclose',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -5, 0, 5),
		Size = UDim2.fromOffset(20, 20),
		Text = ''
	})
	local explorerGui9 = createInstance('UIStroke', {
		Parent = explorerGui8,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.new(1, 1, 1),
		LineJoinMode = Enum.LineJoinMode.Miter
	})
	local explorerGui10 = createInstance('ImageLabel', {
		Parent = explorerGui8,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = 'rbxassetid://74120900238837'
	})
	local explorerGui11 = createInstance('TextButton', {
		Parent = explorerGui4,
		Name = 'close',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -30, 0, 5),
		Size = UDim2.fromOffset(20, 20),
		Text = ''
	})
	local explorerGui12 = createInstance('UIStroke', {
		Parent = explorerGui11,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.new(1, 1, 1),
		LineJoinMode = Enum.LineJoinMode.Miter
	})
	local explorerGui13 = createInstance('ImageLabel', {
		Parent = explorerGui11,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = 'rbxassetid://15396333997'
	})
	local explorerGui14 = createInstance('TextButton', {
		Parent = explorerGui1,
		Name = 'resizeboth',
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(1, 1),
		Size = UDim2.fromOffset(7, 7),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = '',
		AutoButtonColor = false
	})
	explorerGui11:SetAttribute('ClosedImage', 'rbxassetid://12072054746')
	explorerGui11:SetAttribute('OpenedImage', 'rbxassetid://15396333997')

	local pickerGui1 = createInstance('Frame', {
		Parent = gui1,
		Name = 'colorpicker',
		BackgroundColor3 = Color3.fromRGB(88, 87, 89),
		Position = UDim2.fromOffset(0, 88),
		Size = UDim2.fromOffset(220, 320),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Visible = false
	})
	local pickerGui2 = createInstance('UIScale', {Parent = pickerGui1})
	local pickerGui3 = createInstance('Frame', {
		Parent = pickerGui1,
		Name = 'middlebar',
		BackgroundColor3 = Color3.fromRGB(102, 101, 103),
		Position = UDim2.fromOffset(0, 170),
		Size = UDim2.fromOffset(220, 30),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui4 = createInstance('Frame', {
		Parent = pickerGui3,
		Name = 'divider',
		BackgroundColor3 = Color3.new(1, 1, 1),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(0, 1, 1, 0),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui5 = createInstance('Frame', {
		Parent = pickerGui3,
		Name = 'result',
		BackgroundColor3 = Color3.fromRGB(88, 87, 89),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -5, 0, 2),
		Size = UDim2.fromOffset(100, 26),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui6 = createInstance('Frame', {
		Parent = pickerGui5,
		Name = 'color',
		BackgroundColor3 = Color3.new(1, 0, 0),
		Position = UDim2.fromOffset(3, 2),
		Size = UDim2.fromOffset(94, 22),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui7 = createInstance('TextButton', {
		Parent = pickerGui5,
		Name = 'color_switch',
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.52, 0.077),
		Size = UDim2.fromOffset(44, 22),
		ClipsDescendants = true,
		Text = '',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Visible = false
	})
	pickerGui7:SetAttribute('HSVPos', 0)
	pickerGui7:SetAttribute('RGBPos', -27)
	local pickerGui8 = createInstance('Frame', {
		Parent = pickerGui7,
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(44, 49),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui9 = createInstance('TextLabel', {
		Parent = pickerGui8,
		Name = 'hsv',
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(44, 22),
		FontFace = Font.new('rbxassetid://12187374954'),
		Text = 'HSV',
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 21,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui10 = createInstance('TextLabel', {
		Parent = pickerGui8,
		Name = 'rgb',
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, 27),
		Size = UDim2.fromOffset(44, 22),
		FontFace = Font.new('rbxassetid://12187374954'),
		Text = 'RGB',
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 21,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui11 = createInstance('TextLabel', {
		Parent = pickerGui3,
		Name = 'hex',
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(95, 30),
		FontFace = Font.new('rbxassetid://12187374954'),
		Text = 'hex:',
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Left,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui12 = createInstance('UIPadding', {Parent = pickerGui11,PaddingLeft = UDim.new(0, 5)})
	local pickerGui13 = createInstance('TextBox', {
		Parent = pickerGui11,
		BackgroundTransparency = 1,
		ClearTextOnFocus = false,
		Position = UDim2.fromScale(0.286, 0),
		Size = UDim2.fromOffset(64, 30),
		FontFace = Font.new('rbxassetid://12187374954'),
		Text = '#ff0000',
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 22,
		TextXAlignment = Enum.TextXAlignment.Left,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui14 = createInstance('UIPadding', {Parent = pickerGui13,PaddingLeft = UDim.new(0, 5)})
	local pickerGui15 = createInstance('Frame', {
		Parent = pickerGui1,
		Name = 'options',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -5, 0, 15),
		Size = UDim2.fromOffset(25, 150),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui16 = createInstance('Frame', {
		Parent = pickerGui15,
		Name = 'modes',
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(25, 60),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui17 = createInstance('Frame', {
		Parent = pickerGui16,
		Name = 'circle',
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 16),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui18 = createInstance('Frame', {
		Parent = pickerGui17,
		Name = 'selected',
		BackgroundColor3 = Color3.fromRGB(52, 52, 52),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(24, 24),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui19 = createInstance('UICorner', {
		Parent = pickerGui18,
		CornerRadius = UDim.new(0.5, 0)
	})
	local pickerGui20 = createInstance('TextButton', {
		Parent = pickerGui17,
		Name = 'button',
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = '',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui21 = createInstance('ImageLabel', {
		Parent = pickerGui17,
		Name = 'icon',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(16, 16),
		Image = 'rbxassetid://91460273345882',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui22 = createInstance('Frame', {
		Parent = pickerGui16,
		Name = 'square',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.new(1, 0, 0, 16),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui23 = createInstance('Frame', {
		Parent = pickerGui22,
		Name = 'selected',
		BackgroundColor3 = Color3.fromRGB(52, 52, 52),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(24, 24),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Visible = false
	})
	local pickerGui24 = createInstance('UICorner', {
		Parent = pickerGui23,
		CornerRadius = UDim.new(0, 6)
	})
	local pickerGui25 = createInstance('TextButton', {
		Parent = pickerGui22,
		Name = 'button',
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = '',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui26 = createInstance('ImageLabel', {
		Parent = pickerGui22,
		Name = 'icon',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(16, 16),
		Image = 'rbxassetid://81707513428574',
		ImageTransparency = 0.5,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui27 = createInstance('Frame', {
		Parent = pickerGui16,
		Name = 'triangle',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, 0, 0, 16),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui28 = createInstance('ImageLabel', {
		Parent = pickerGui27,
		Name = 'selected',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(26, 26),
		Image = 'rbxassetid://90218356450094',
		ImageColor3 = Color3.fromRGB(52, 52, 52),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Visible = false
	})
	local pickerGui29 = createInstance('TextButton', {
		Parent = pickerGui27,
		Name = 'button',
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = '',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui30 = createInstance('ImageLabel', {
		Parent = pickerGui27,
		Name = 'icon',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(16, 16),
		Image = 'rbxassetid://114667886210601',
		ImageTransparency = 0.5,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui31 = createInstance('Frame', {
		Parent = pickerGui1,
		Name = 'picker',
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(35, 15),
		Size = UDim2.fromOffset(150, 150),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui32 = createInstance('Frame', {
		Parent = pickerGui31,
		Name = 'square',
		BackgroundColor3 = Color3.new(1, 0, 0),
		Size = UDim2.fromScale(1, 1),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Visible = false
	})
	local pickerGui33 = createInstance('Frame', {
		Parent = pickerGui32,
		Name = 'blackgradient',
		BackgroundColor3 = Color3.new(),
		Size = UDim2.fromScale(1, 1),
		ZIndex = 3,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui34 = createInstance('UIGradient', {
		Parent = pickerGui33,
		Rotation = -90,
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(1, 1)
		})
	})
	local pickerGui35 = createInstance('Frame', {
		Parent = pickerGui32,
		Name = 'whitegradient',
		BackgroundColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromScale(1, 1),
		ZIndex = 2,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui36 = createInstance('UIGradient', {
		Parent = pickerGui35,
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(1, 1)
		})
	})
	local pickerGui37 = createInstance('TextButton', {
		Parent = pickerGui31,
		Name = 'activateregion',
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = '',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui38 = createInstance('ImageLabel', {
		Parent = pickerGui31,
		Name = 'circle',
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = 'rbxassetid://2849458409',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui39 = createInstance('ImageLabel', {
		Parent = pickerGui31,
		Name = 'pointer',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(30, 30),
		Image = 'rbxassetid://133734996035045',
		ZIndex = 4,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui40 = createInstance('ImageLabel', {
		Parent = pickerGui31,
		Name = 'triangle',
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = 'rbxassetid://119614645478849',
		ImageColor3 = Color3.new(1, 0, 0),
		Visible = false,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui41 = createInstance('ImageLabel', {
		Parent = pickerGui40,
		Name = 'black',
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = 'rbxassetid://90395096352510',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		ZIndex = 2
	})
	local pickerGui42 = createInstance('ImageLabel', {
		Parent = pickerGui40,
		Name = 'white',
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = 'rbxassetid://114393129271758',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui43 = createInstance('Frame', {
		Parent = pickerGui1,
		Name = 'sliders',
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, 220),
		Size = UDim2.fromOffset(200, 211),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui44 = createInstance('UIListLayout', {
		Parent = pickerGui43,
		Padding = UDim.new(0, 25),
		SortOrder = Enum.SortOrder.LayoutOrder
	})
	local pickerGui45 = createInstance('Frame', {
		Parent = pickerGui43,
		Name = 'hue',
		BackgroundColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromOffset(170, 10),
		LayoutOrder = 1,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui46 = createInstance('UIGradient', {
		Parent = pickerGui45,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)),
			ColorSequenceKeypoint.new(1 / 6, Color3.new(1, 1, 0)),
			ColorSequenceKeypoint.new(2 / 6, Color3.new(0, 1, 0)),
			ColorSequenceKeypoint.new(3 / 6, Color3.new(0, 1, 1)),
			ColorSequenceKeypoint.new(4 / 6, Color3.new(0, 0, 1)),
			ColorSequenceKeypoint.new(5 / 6, Color3.new(1, 0, 1)),
			ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0)),
		}),
	})
	local pickerGui47 = createInstance('Frame', {
		Parent = pickerGui45,
		Name = 'pointer',
		BackgroundColor3 = Color3.new(),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.fromOffset(3, 20),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui48 = createInstance('TextButton', {
		Parent = pickerGui45,
		Name = 'activateregion',
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = '',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui49 = createInstance('TextBox', {
		Parent = pickerGui45,
		Name = 'value',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(1, 0.5),
		Size = UDim2.fromOffset(30, 20),
		FontFace = Font.new('rbxassetid://12187374954'),
		Text = '100',
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 18,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui50 = createInstance('Frame', {
		Parent = pickerGui43,
		Name = 'saturation',
		BackgroundColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromOffset(170, 10),
		LayoutOrder = 2,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui51 = createInstance('UIGradient', {
		Parent = pickerGui50,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
			ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))
		})
	})
	local pickerGui52 = createInstance('Frame', {
		Parent = pickerGui50,
		Name = 'pointer',
		BackgroundColor3 = Color3.new(),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.fromOffset(3, 20),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui53 = createInstance('TextButton', {
		Parent = pickerGui50,
		Name = 'activateregion',
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = '',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui54 = createInstance('TextBox', {
		Parent = pickerGui50,
		Name = 'value',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(1, 0.5),
		Size = UDim2.fromOffset(30, 20),
		FontFace = Font.new('rbxassetid://12187374954'),
		Text = '100',
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 18,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui55 = createInstance('Frame', {
		Parent = pickerGui43,
		Name = 'value',
		BackgroundColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromOffset(170, 10),
		LayoutOrder = 3,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui56 = createInstance('UIGradient', {
		Parent = pickerGui55,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new()),
			ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))
		})
	})
	local pickerGui57 = createInstance('Frame', {
		Parent = pickerGui55,
		Name = 'pointer',
		BackgroundColor3 = Color3.new(),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.fromOffset(3, 20),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui58 = createInstance('TextButton', {
		Parent = pickerGui55,
		Name = 'activateregion',
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = '',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui59 = createInstance('TextBox', {
		Parent = pickerGui55,
		Name = 'value',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(1, 0.5),
		Size = UDim2.fromOffset(30, 20),
		FontFace = Font.new('rbxassetid://12187374954'),
		Text = '100',
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 18,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui60 = createInstance('Frame', {
		Parent = pickerGui43,
		Name = 'R',
		BackgroundColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromOffset(170, 10),
		LayoutOrder = 4,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui61 = createInstance('UIGradient', {
		Parent = pickerGui60,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new()),
			ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))
		})
	})
	local pickerGui62 = createInstance('Frame', {
		Parent = pickerGui60,
		Name = 'pointer',
		BackgroundColor3 = Color3.new(),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.fromOffset(3, 20),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui63 = createInstance('TextButton', {
		Parent = pickerGui60,
		Name = 'activateregion',
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = '',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui64 = createInstance('TextBox', {
		Parent = pickerGui60,
		Name = 'value',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(1, 0.5),
		Size = UDim2.fromOffset(30, 20),
		FontFace = Font.new('rbxassetid://12187374954'),
		Text = '100',
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 18,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui65 = createInstance('Frame', {
		Parent = pickerGui43,
		Name = 'G',
		BackgroundColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromOffset(170, 10),
		LayoutOrder = 5,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui66 = createInstance('UIGradient', {
		Parent = pickerGui65,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new()),
			ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))
		})
	})
	local pickerGui67 = createInstance('Frame', {
		Parent = pickerGui65,
		Name = 'pointer',
		BackgroundColor3 = Color3.new(),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.fromOffset(3, 20),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui68 = createInstance('TextButton', {
		Parent = pickerGui65,
		Name = 'activateregion',
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = '',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui69 = createInstance('TextBox', {
		Parent = pickerGui65,
		Name = 'value',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(1, 0.5),
		Size = UDim2.fromOffset(30, 20),
		FontFace = Font.new('rbxassetid://12187374954'),
		Text = '100',
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 18,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui70 = createInstance('Frame', {
		Parent = pickerGui43,
		Name = 'B',
		BackgroundColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromOffset(170, 10),
		LayoutOrder = 6,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui71 = createInstance('UIGradient', {
		Parent = pickerGui70,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new()),
			ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))
		})
	})
	local pickerGui72 = createInstance('Frame', {
		Parent = pickerGui70,
		Name = 'pointer',
		BackgroundColor3 = Color3.new(),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.fromOffset(3, 20),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui73 = createInstance('TextButton', {
		Parent = pickerGui70,
		Name = 'activateregion',
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = '',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui74 = createInstance('TextBox', {
		Parent = pickerGui70,
		Name = 'value',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(1, 0.5),
		Size = UDim2.fromOffset(30, 20),
		FontFace = Font.new('rbxassetid://12187374954'),
		Text = '100',
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 18,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui75 = createInstance('ImageButton', {
		Parent = pickerGui1,
		Name = 'resize',
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(209, 309),
		Size = UDim2.fromOffset(44, 44),
		Image = 'rbxassetid://10928806245',
		ImageTransparency = 1,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(0, 0, 512, 512),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui76 = createInstance('TextButton', {
		Parent = pickerGui1,
		Name = 'dragbutton',
		BackgroundColor3 = Color3.fromRGB(102, 101, 103),
		AnchorPoint = Vector2.new(0, 1),
		Size = UDim2.new(1, 0, 0, 30),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = 'color picker',
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 20,
		FontFace = Font.new('rbxassetid://12187374954'),
		AutoButtonColor = false,
		ClipsDescendants = true,
	})
	local pickerGui77 = createInstance('TextButton', {
		Parent = pickerGui76,
		Name = 'fullclose',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -5, 0, 5),
		Size = UDim2.fromOffset(20, 20),
		Text = '',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui78 = createInstance('UIStroke', {
		Parent = pickerGui77,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.new(1, 1, 1),
		LineJoinMode = Enum.LineJoinMode.Miter
	})
	local pickerGui79 = createInstance('ImageLabel', {
		Parent = pickerGui77,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = 'rbxassetid://74120900238837',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui80 = createInstance('TextButton', {
		Parent = pickerGui76,
		Name = 'close',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -30, 0, 5),
		Size = UDim2.fromOffset(20, 20),
		Text = '',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui81 = createInstance('UIStroke', {
		Parent = pickerGui80,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.new(1, 1, 1),
		LineJoinMode = Enum.LineJoinMode.Miter
	})
	local pickerGui82 = createInstance('ImageLabel', {
		Parent = pickerGui80,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = 'rbxassetid://15396333997',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui83 = createInstance('ImageButton', {
		Parent = pickerGui15,
		Name = 'close',
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(25, 25),
		Position = UDim2.fromScale(0, 0.473),
		Image = 'rbxassetid://3192543734',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui84 = createInstance('TextButton', {
		Parent = pickerGui1,
		Name = 'resizebottom',
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, -2, 0, 7),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = '',
		AutoButtonColor = false
	})
	local notifyGui1 = createInstance('Frame', {
		Parent = gui1,
		Name = 'notification',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 1),
		Size = UDim2.new(0, 200, 1, -20),
		Position = UDim2.new(1, -10, 1, -10),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local notifyGui2 = createInstance('UIListLayout', {
		Parent = notifyGui1,
		Padding = UDim.new(0, 5),
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
		VerticalAlignment = Enum.VerticalAlignment.Bottom
	})
	local placeInfoGui1 = createInstance('Frame', {
		Parent = gui1,
		Name = 'placeinfo',
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(88, 87, 89),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.4, 0.4),
		Visible = false,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0
	})
	local placeInfoGui2 = createInstance('UIAspectRatioConstraint', {
		Parent = placeInfoGui1,
		AspectRatio = 1.215
	})
	local placeInfoGui3 = createInstance('UIStroke', {
		Parent = placeInfoGui1,
		Color = Color3.fromRGB(163, 162, 165),
		LineJoinMode = Enum.LineJoinMode.Miter,
		Thickness = 5
	})
	local placeInfoGui4 = createInstance('ScrollingFrame', {
		Parent = placeInfoGui1,
		Name = 'list',
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, 10),
		Size = UDim2.new(1, -20, 1, -20),
		CanvasSize = UDim2.fromScale(0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
	})
	local placeInfoGui5 = createInstance('UIListLayout', {
		Parent = placeInfoGui4,
		Padding = UDim.new(0, 2),
		SortOrder = Enum.SortOrder.LayoutOrder
	})
	local placeInfoGui6 = createInstance('TextButton', {
		Parent = gui1,
		Name = 'closeregion',
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = '',
		Visible = false,
		ZIndex = 0
	})
	local logGui1 = createInstance("Frame", {
		Parent = gui1,
		Name = "logs",
		BackgroundColor3 = Color3.fromRGB(102, 101, 103),
		Position = UDim2.fromOffset(246, 211),
		Size = UDim2.fromOffset(240, 160),
		Visible = false,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0
	})
	local logGui2 = createInstance("ScrollingFrame", {
		Parent = logGui1,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		CanvasSize = UDim2.fromScale(0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
		TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	})
	local logGui3 = createInstance("UIListLayout", {
		Parent = logGui2,
		SortOrder = Enum.SortOrder.LayoutOrder
	})
	local logGui4 = createInstance('TextButton', {
		Parent = logGui1,
		Name = 'dragbutton',
		BackgroundColor3 = Color3.fromRGB(102, 101, 103),
		AnchorPoint = Vector2.new(0, 1),
		Size = UDim2.new(1, 0, 0, 30),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = 'logs.txt',
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 20,
		FontFace = Font.new('rbxassetid://12187374954'),
		AutoButtonColor = false,
		ClipsDescendants = true,
	})
	local logGui5 = createInstance('TextButton', {
		Parent = logGui4,
		Name = 'fullclose',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -5, 0, 5),
		Size = UDim2.fromOffset(20, 20),
		Text = '',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local logGui6 = createInstance('UIStroke', {
		Parent = logGui5,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.new(1, 1, 1),
		LineJoinMode = Enum.LineJoinMode.Miter
	})
	local logGui7 = createInstance('ImageLabel', {
		Parent = logGui5,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = 'rbxassetid://74120900238837',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local logGui8 = createInstance('TextButton', {
		Parent = logGui4,
		Name = 'close',
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -30, 0, 5),
		Size = UDim2.fromOffset(20, 20),
		Text = '',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local logGui9 = createInstance('UIStroke', {
		Parent = logGui8,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.new(1, 1, 1),
		LineJoinMode = Enum.LineJoinMode.Miter
	})
	local logGui10 = createInstance('ImageLabel', {
		Parent = logGui8,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = 'rbxassetid://15396333997',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local logGui11 = createInstance('TextButton', {
		Parent = logGui1,
		Name = 'resizebottom',
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, -2, 0, 7),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = '',
		AutoButtonColor = false
	})
	local logGui12 = createInstance('TextButton', {
		Parent = logGui1,
		Name = 'resizeside',
		BackgroundTransparency = 1,
		Position = UDim2.new(1, 0, 0, -30),
		Size = UDim2.new(0, 7, 1, 28),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = '',
		AutoButtonColor = false
	})
	local logGui13 = createInstance('TextButton', {
		Parent = logGui1,
		Name = 'resizeboth',
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(1, 1),
		Size = UDim2.fromOffset(7, 7),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = '',
		AutoButtonColor = false
	})
	local commandGui1 = createInstance("Frame", {
		Parent = gui1,
		Name = "commandbar",
		BackgroundColor3 = Color3.fromRGB(88, 87, 89),
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.fromOffset(195, 18),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local commandGui2 = createInstance("ScrollingFrame", {
		Parent = commandGui1,
		Name = "commandlist",
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, 38),
		Size = UDim2.new(0, 195, 0, 100),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollBarThickness = 0
	})
	local commandGui3 = createInstance("UIListLayout", {
		Parent = commandGui2
	})
	local commandGui4 = createInstance("TextBox", {
		Parent = commandGui1,
		Name = "input",
		BackgroundColor3 = Color3.fromRGB(78, 77, 79),
		Position = UDim2.fromOffset(0, 18),
		Size = UDim2.fromOffset(195, 20),
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold),
		PlaceholderColor3 = Color3.new(1, 1, 1),
		PlaceholderText = "Command output ("..commandPrefix..")",
		Text = "",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Left,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local commandGui5 = createInstance("UIPadding", {
		Parent = commandGui4,
		PaddingLeft = UDim.new(0, 5),
		PaddingRight = UDim.new(0, 5)
	})
	local commandGui6 = createInstance("TextLabel", {
		Parent = commandGui1,
		Name = "title",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 18),
		FontFace = Font.new("rbxassetid://12187365977"),
		Text = "DeepScope Command bar",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 16,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local commandGui7 = createInstance("TextButton", {
		Parent = commandGui1,
		Name = "hoverregion",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	commandGui1:SetAttribute("Hovering", false)
	infoList = placeInfoGui4
	logList = logGui2

	return gui2
end
local newgui = createGui()
local function getMousePos()
	return game.UserInputService:GetMouseLocation()
end

local function makeFakeScripts()
	local folder = createInstance('Folder', {
		Parent = game.ReplicatedStorage,
		Name = '_DeepScopeCore'
	})
	local fakeScript1 = createInstance('ModuleScript', {
		Parent = folder,
		Name = 'Core'
	})
	local fakeScript2 = createInstance('ModuleScript', {
		Parent = fakeScript1,
		Name = 'Explorer'
	})
	local fakeScript3 = createInstance('ModuleScript', {
		Parent = fakeScript1,
		Name = 'Properties'
	})
	local fakeScript4 = createInstance('ModuleScript', {
		Parent = folder,
		Name = 'ColorPicker'
	})
	local fakeScript5 = createInstance('ModuleScript', {
		Parent = folder,
		Name = 'Notifications'
	})
	local fakeScript6 = createInstance('ModuleScript', {
		Parent = folder,
		Name = 'BuildMode'
	})
	local fakeScript7 = createInstance('ModuleScript', {
		Parent = folder,
		Name = 'Logs'
	})
end

local function notify(icon, text, countdown)
	if not countdown then countdown = 3 end
	local template = createInstance('Frame', {
		Parent = newgui.Parent.notification,
		Name = 'template',
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(200, 50),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Visible = false
	})
	local notifyGui4 = createInstance('Frame', {
		Parent = template,
		Name = 'inner',
		Size = UDim2.fromOffset(200, 50),
		Position = UDim2.fromOffset(210, 0),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local notifyGui5 = createInstance('Frame', {
		Parent = notifyGui4,
		Name = 'countdown',
		BackgroundColor3 = Color3.new(1, 1, 1),
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, 0, 0, 3),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local notifyGui6 = createInstance('Frame', {
		Parent = notifyGui4,
		Name = 'mainframe',
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(1, 0, 0, 30),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local notifyGui7 = createInstance('UIListLayout', {
		Parent = notifyGui6,
		Padding = UDim.new(0, 5),
		FillDirection = Enum.FillDirection.Horizontal
	})
	local notifyGui8 = createInstance('UIPadding', {
		Parent = notifyGui6,
		PaddingLeft = UDim.new(0, 5),
		PaddingRight = UDim.new(0, 5)
	})
	local notifyGui9 = createInstance('ImageLabel', {
		Parent = notifyGui6,
		Name = 'icon',
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(30, 30),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local notifyGui10 = createInstance('TextLabel', {
		Parent = notifyGui6,
		Name = 'title',
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(155, 30),
		Text = 'hi',
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 13,
		RichText = true,
		TextWrapped = true,
		FontFace = Font.new('rbxassetid://12187374954'),
		TextXAlignment = Enum.TextXAlignment.Left,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	notify_amount += 1
	local newTemplate = template:Clone()
	newTemplate.Parent = newgui.Parent.notification
	game.TweenService:Create(newTemplate.inner, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		Position = UDim2.new(0, 0, 0, 0)
	}):Play()
	newTemplate.inner.mainframe.title.Size = UDim2.fromOffset(icon ~= nil and 155 or 190, 30)
	newTemplate.inner.mainframe.icon.Visible = icon ~= nil
	newTemplate.inner.mainframe.icon.Image = icon ~= nil and icon or ''
	newTemplate.inner.mainframe.title.Text = text
	newTemplate.LayoutOrder = -notify_amount
	newTemplate.Name = 'template' .. notify_amount
	newTemplate.Visible = true
	local sound = Instance.new('Sound')
	sound.Parent = newTemplate.inner
	sound.SoundId = notificationSoundId
	sound:Play()
	game.Debris:AddItem(newTemplate, countdown + 1.4)
	delay(0.3, function()
		game.TweenService:Create(newTemplate.inner.countdown, TweenInfo.new(countdown, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Size = UDim2.fromOffset(0, 3)
		}):Play()
	end)
	delay(countdown + 0.8, function()
		game.TweenService:Create(newTemplate.inner, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Position = UDim2.new(0, 210, 0, 0)
		}):Play()
	end)
	delay(countdown + 1.15, function()
		game.TweenService:Create(newTemplate, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Size = UDim2.fromOffset(200, 0)
		}):Play()
	end)
end

makeFakeScripts()
LocalPlayer.CharacterAdded:Connect(function(char)
	delay(1, function()
		modules.other.fly.Respawn(char)
	end)
end)

local function buildExplorerData(instance)
	if explorerData[instance] then
		return explorerData[instance]
	end

	local node = {
		Data = {
			Name = instance.Name,
			ClassName = instance.ClassName,
			FullPath = instance:GetFullName(),
			Parent = instance.Parent,
			ChildrenCount = #instance:GetChildren(),
		},
		Instance = instance,
		Children = {}, -- пока пусто, заполним при раскрытии
		ChildrenBuilt = false
	}

	explorerData[instance] = node

	-- Только имя, без лишних сигналов
	instance:GetPropertyChangedSignal("Name"):Connect(function()
		node.Data.Name = instance.Name
	end)

	return node
end

-- при раскрытии
local function buildChildren(node)
	if node.ChildrenBuilt then return end
	for _, child in ipairs(node.Instance:GetChildren()) do
		if not table.find(explorerBlacklistInstances, child.Name) then
			local childNode = buildExplorerData(child)
			table.insert(node.Children, childNode)
		end
	end
	node.ChildrenBuilt = true
end

-- обновляет размер фрейма рекурсивно вверх
local function updateSizeRecursively(frame)
	if not frame or not frame:IsA("Frame") then return end

	local dropdown = frame:FindFirstChild("dropdown")
	local baseHeight = 32
	local totalHeight = baseHeight

	if dropdown and dropdown.Visible then
		totalHeight = totalHeight + dropdown.UIListLayout.AbsoluteContentSize.Y
	end

	frame.Size = UDim2.new(1, 0, 0, totalHeight)

	if frame.Parent and frame.Parent:IsA("Frame") then
		updateSizeRecursively(frame.Parent)
	end
end


local function createEntryForInstance(node, parentGui)
	local template = createInstance('Frame', {
		Parent = nil,
		Name = 'template',
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(228, 32),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local explorerGui5 = createInstance('Frame', {
		Parent = template,
		Name = 'mainframe',
		BackgroundColor3 = Color3.fromRGB(88, 87, 89),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 32)
	})
	local explorerGui6 = createInstance('UIListLayout', {
		Parent = explorerGui5,
		Padding = UDim.new(0, 2),
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder
	})
	local explorerGui7 = createInstance('UIPadding', {
		Parent = explorerGui5,
		PaddingLeft = UDim.new(0, 2)
	})
	local explorerGui8 = createInstance('UIGradient', {
		Parent = explorerGui5,
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.95, 0),
			NumberSequenceKeypoint.new(1, 1)
		})
	})
	local explorerGui9 = createInstance('ImageButton', {
		Parent = explorerGui5,
		Name = 'dropdownbutton',
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(29, 29),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0
	})
	local explorerGui10 = createInstance('ImageLabel', {
		Parent = explorerGui9,
		Name = 'icon',
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		BorderColor3 = Color3.new(0, 0, 0),
		Rotation = -90,
		BorderSizePixel = 0,
		Image = 'rbxassetid://11552476728',
	})
	local explorerGui11 = createInstance('ImageLabel', {
		Parent = explorerGui5,
		Name = 'icon',
		BackgroundTransparency = 1,
		LayoutOrder = 1,
		Size = UDim2.fromOffset(28, 28),
		Image = 'rbxassetid://765660635',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		ImageRectOffset = Vector2.new(1.5, 1.5),
		ImageRectSize = Vector2.new(table.unpack(icons.size))
	})
	local explorerGui12 = createInstance('TextLabel', {
		Parent = explorerGui5,
		Name = 'name',
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		LayoutOrder = 2,
		Size = UDim2.fromOffset(0, 28),
		FontFace = Font.new('rbxassetid://12187374954'),
		Text = 'hi',
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 15,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextXAlignment = Enum.TextXAlignment.Left
	})
	local explorerGui17 = createInstance('ImageButton', {
		Parent = explorerGui5,
		Name = 'add',
		BackgroundTransparency = 1,
		LayoutOrder = 3,
		Size = UDim2.fromOffset(25, 15),
		Image = 'rbxassetid://88065133864491',
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		ScaleType = Enum.ScaleType.Fit,
		Visible = false
	})
	local explorerGui13 = createInstance('UISizeConstraint', {
		Parent = explorerGui12,
		MaxSize = Vector2.new(163, 1e308)
	})
	local explorerGui14 = createInstance('Frame', {
		Parent = template,
		Name = 'dropdown',
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(32, 32),
		Size = UDim2.fromScale(1, 0),
		Visible = false
	})
	local explorerGui15 = createInstance('UIListLayout', {Parent = explorerGui14})
	local explorerGui16 = createInstance('TextButton', {
		Parent = template,
		Name = 'activateregion',
		BackgroundTransparency = 1,
		Text = '',
		Size = UDim2.fromScale(1, 1),
		ZIndex = 0
	})

	local newTemplate = template:Clone()
	newTemplate.Parent = parentGui
	newTemplate.Name = node.Data.Name
	newTemplate.mainframe.name.Text = node.Data.Name

	local iconCoords = icons.icons[node.Data.ClassName] or icons.icons.Unknown
	newTemplate.mainframe.icon.ImageRectOffset = Vector2.new(iconCoords[1], iconCoords[2])
	newTemplate.mainframe.icon.ImageRectSize = Vector2.new(table.unpack(icons.size))

	-- дропдаун (пока скрыт)
	local dropdown = newTemplate.dropdown
	dropdown.Size = UDim2.new(1, 0, 0, 0)
	dropdown.Visible = false

	if node.Data.ChildrenCount > 0 then
		newTemplate:SetAttribute("ChildrenBuilt", false)
		newTemplate.mainframe.dropdownbutton.Visible = true

		newTemplate.mainframe.dropdownbutton.MouseButton1Click:Connect(function()
			-- если ещё не строили детей — строим
			if not node.ChildrenBuilt then
				buildChildren(node)
				for _, childNode in ipairs(node.Children) do
					createEntryForInstance(childNode, dropdown)
				end
			end

			-- переключаем видимость
			dropdown.Visible = not dropdown.Visible
			newTemplate.mainframe.dropdownbutton.icon.Rotation = dropdown.Visible and 0 or -90

			if dropdown.Visible then
				dropdown.Size = UDim2.new(1, 0, 0, dropdown.UIListLayout.AbsoluteContentSize.Y)
			else
				dropdown.Size = UDim2.new(1, 0, 0, 0)
			end

			-- ✅ пересчитываем размер вверх
			updateSizeRecursively(newTemplate)
		end)
	else
		-- если детей нет — убираем кнопку
		newTemplate.mainframe.dropdownbutton.icon:Destroy()
		dropdown:Destroy()
	end

	newTemplate.Size = UDim2.new(1, 0, 0, 32)
	return newTemplate
end

local function setExplorer()
	explorerUsing = true
	explorerData = {}
	local explorer = newgui.Parent.explorer
	explorer.Visible = true
	local list = explorer.ScrollingFrame

	-- очищаем список
	for _, child in ipairs(list:GetChildren()) do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end

	-- только верхний уровень
	for _, child in ipairs(game:GetChildren()) do
		if not table.find(explorerBlacklistInstances, child.Name) then
			local node = buildExplorerData(child)
			createEntryForInstance(node, list)
		end
	end
	local MIN_WIDTH, MIN_HEIGHT = 240, 32
	local MAX_WIDTH, MAX_HEIGHT = workspace.CurrentCamera.ViewportSize.X-100, workspace.CurrentCamera.ViewportSize.Y-100
	workspace.CurrentCamera:GetPropertyChangedSignal('ViewportSize'):Connect(function()
		MAX_WIDTH, MAX_HEIGHT = workspace.CurrentCamera.ViewportSize.X-100, workspace.CurrentCamera.ViewportSize.Y-100
	end)
	explorer.resizebottom.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if explorerOpened then
				if not countdowns['explorer'] then
					resizingExplorer = 'Y'
					startMousePos = getMousePos()
					startExplorerSize = explorer.Size
				end
			end
		end
	end)

	explorer.resizeside.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if not countdowns['explorer'] then
				resizingExplorer = 'X'
				startMousePos = getMousePos()
				startExplorerSize = explorer.Size
			end
		end
	end)

	explorer.resizeboth.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if not countdowns['explorer'] then
				resizingExplorer = 'XY'
				startMousePos = getMousePos()
				startExplorerSize = explorer.Size
			end
		end
	end)

	game:GetService('UserInputService').InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			resizingExplorer = false
		end
	end)

	game:GetService('RunService').RenderStepped:Connect(function()
		if resizingExplorer then
			local mouse = getMousePos()

			if resizingExplorer == 'Y' then
				local deltaY = mouse.Y - startMousePos.Y
				local newHeight = math.clamp(startExplorerSize.Y.Offset + deltaY, MIN_HEIGHT, MAX_HEIGHT)
				explorer.Size = UDim2.new(startExplorerSize.X.Scale, startExplorerSize.X.Offset, 0, newHeight)
			elseif resizingExplorer == 'X' then
				local deltaX = mouse.X - startMousePos.X
				local newWidth = math.clamp(startExplorerSize.X.Offset + deltaX, MIN_WIDTH, MAX_HEIGHT)
				explorer.Size = UDim2.new(0, newWidth, startExplorerSize.Y.Scale, startExplorerSize.Y.Offset)
			elseif resizingExplorer == 'XY' then
				local deltaX = mouse.X - startMousePos.X
				local deltaY = mouse.Y - startMousePos.Y
				local newWidth = math.clamp(startExplorerSize.X.Offset + deltaX, MIN_WIDTH, MAX_WIDTH)
				local newHeight = math.clamp(startExplorerSize.Y.Offset + deltaY, MIN_HEIGHT, MAX_HEIGHT)
				explorer.Size = UDim2.new(0, newWidth, 0, newHeight)
			end
		end
		if draggingExplorer then
			local newX = getMousePos().X - startMousePos.X
			local newY = getMousePos().Y - startMousePos.Y
			local minX = 0
			local maxX = newgui.Parent.AbsoluteSize.X - explorer.AbsoluteSize.X
			local minY = game.GuiService.TopbarInset.Height + explorer.dragbutton.AbsoluteSize.Y
			local maxY = newgui.Parent.AbsoluteSize.Y - explorer.AbsoluteSize.Y
			newX = math.clamp(startExplorerPos.X.Offset + newX, minX, maxX)
			newY = math.clamp(startExplorerPos.Y.Offset + newY, minY, maxY) 

			explorer.Position = UDim2.new(0, newX, 0, newY)
		end
	end)

	explorer.resizebottom.MouseEnter:Connect(function()
		game.TweenService:Create(explorer.resizebottom, TweenInfo.new(0.2), {
			BackgroundTransparency = 0.5
		}):Play()
	end)
	explorer.resizebottom.MouseLeave:Connect(function()
		game.TweenService:Create(explorer.resizebottom, TweenInfo.new(0.2), {
			BackgroundTransparency = 1
		}):Play()
	end)
	explorer.resizeside.MouseEnter:Connect(function()
		game.TweenService:Create(explorer.resizeside, TweenInfo.new(0.2), {
			BackgroundTransparency = 0.5
		}):Play()
	end)
	explorer.resizeside.MouseLeave:Connect(function()
		game.TweenService:Create(explorer.resizeside, TweenInfo.new(0.2), {
			BackgroundTransparency = 1
		}):Play()
	end)
	explorer.resizeboth.MouseEnter:Connect(function()
		game.TweenService:Create(explorer.resizeboth, TweenInfo.new(0.2), {
			BackgroundTransparency = 0.5
		}):Play()
	end)
	explorer.resizeboth.MouseLeave:Connect(function()
		game.TweenService:Create(explorer.resizeboth, TweenInfo.new(0.2), {
			BackgroundTransparency = 1
		}):Play()
	end)
	explorer.dragbutton.close.MouseButton1Click:Connect(function()
		explorerOpened = not explorerOpened
		if not explorerOpened then
			countdowns.explorer = true
			explorer.dragbutton.close.ImageLabel.Image = explorer.dragbutton.close:GetAttribute('ClosedImage')
			explorer:SetAttribute('oldysize', explorer.Size.Y.Offset)
			explorer:TweenSize(UDim2.fromOffset(explorer.Size.X.Offset, 0), 'InOut', 'Sine', 0.2, true)
			delay(0.2, function()
				countdowns.explorer = nil
			end)
		else
			countdowns.explorer = true
			explorer.dragbutton.close.ImageLabel.Image = explorer.dragbutton.close:GetAttribute('OpenedImage')
			explorer:TweenSize(UDim2.fromOffset(explorer.Size.X.Offset, explorer:GetAttribute('oldysize')), 'InOut', 'Sine', 0.2, true)
			explorer:SetAttribute('oldysize', nil)
			delay(0.2, function()
				countdowns.explorer = nil
			end)
		end
	end)
	explorer.dragbutton.fullclose.MouseButton1Click:Connect(function()
		explorerUsing = false
		explorerData = {}
		for _, child in list:GetChildren() do
			if child:IsA('Frame') then
				child:Destroy()
			end
		end
		explorer.Visible = false
	end)
	RunService.RenderStepped:Connect(function()
		if explorerUsing and explorer.Visible then
			local mousePos = UserInputService:GetMouseLocation() - Vector2.new(0, GuiService.TopbarInset.Height)
			local guiObjects = LocalPlayer.PlayerGui:GetGuiObjectsAtPosition(mousePos.X, mousePos.Y)

			local topEntry = nil
			for _, obj in ipairs(guiObjects) do
				if obj:FindFirstChild('mainframe') then
					topEntry = obj
					break
				end
			end

			for _, v in explorer.ScrollingFrame:GetDescendants() do
				if v:IsA('Frame') and v:FindFirstChild('mainframe') then
					if v == topEntry then
						v.mainframe.BackgroundColor3 = Color3.fromRGB(67, 66, 68)
						v.mainframe.add.Visible = true
						hoveringObject = v
					else
						v.mainframe.BackgroundColor3 = Color3.fromRGB(88, 87, 89)
						v.mainframe.add.Visible = false
					end
				end
			end
		end
	end)
end
local function setMode(mode)
	local picker = newgui.Parent.colorpicker
	local module = modules[mode]
	local function setVisualMode()
		local modes = picker.options.modes
		local button = modes[mode]
		for _, v in modes:GetChildren() do
			v.selected.Visible = false
			v.icon.ImageTransparency = 0.5
		end
		button.selected.Visible = true
		button.icon.ImageTransparency = 0
	end
	if mode == 'square' then
		picker.picker.square.Visible = true
		picker.picker.circle.Visible = false
		picker.picker.triangle.Visible = false
	elseif mode == 'circle' then
		picker.picker.square.Visible = false
		picker.picker.circle.Visible = true
		picker.picker.triangle.Visible = false
	elseif mode == 'triangle' then
		picker.picker.square.Visible = false
		picker.picker.circle.Visible = false
		picker.picker.triangle.Visible = true
	end
	picker.picker.pointer.Position = module.GetPointerPositionFromColor(colors.h, colors.s, colors.v)
	setVisualMode()
	pickerMode = mode
end
local function setColorMode()
	if colorMode == 'hsv' then
		colorMode = 'rgb'
	else
		colorMode = 'hsv'
	end
	newgui.Parent.colorpicker.middlebar.result.color_switch.Frame:TweenPosition(UDim2.new(0, 0, 0, colorMode == 'rgb' and -27 or 0), 'InOut', 'Quad', 0.2, true)
	if colorMode == 'rgb' then
		newgui.Parent.colorpicker.sliders.R.Visible = true
		newgui.Parent.colorpicker.sliders.G.Visible = true
		newgui.Parent.colorpicker.sliders.B.Visible = true
		newgui.Parent.colorpicker.sliders.hue.Visible = false
		newgui.Parent.colorpicker.sliders.saturation.Visible = false
		newgui.Parent.colorpicker.sliders.value.Visible = false
	else
		newgui.Parent.colorpicker.sliders.R.Visible = false
		newgui.Parent.colorpicker.sliders.G.Visible = false
		newgui.Parent.colorpicker.sliders.B.Visible = false
		newgui.Parent.colorpicker.sliders.hue.Visible = true
		newgui.Parent.colorpicker.sliders.saturation.Visible = true
		newgui.Parent.colorpicker.sliders.value.Visible = true
	end
end
local function setColorPicker(color, gui)
	pickerOpened = true
	local picker = newgui.Parent.colorpicker
	if color then
		colors.h, colors.s, colors.v = color:ToHSV()
		colors.r, colors.g, colors.b = math.round(color.R * 255), math.round(color.G * 255), math.round(color.B * 255)
		local pointer = picker.picker.pointer
		local module = modules[pickerMode]
		pointer.Position = module.GetPointerPositionFromColor(colors.h, colors.s, colors.v)
		picker.middlebar.result.color.BackgroundColor3 = Color3.fromHSV(colors.h, colors.s, colors.v)
		picker.middlebar.hex.TextBox.Text = string.format('#%02x%02x%02x', colors.r, colors.g, colors.b)
		picker.sliders.hue.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.h, nil, picker.sliders.hue)
		picker.sliders.saturation.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.s, ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(colors.h, 1, 1))
		}), picker.sliders.saturation)
		picker.sliders.value.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.v, ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new()),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(colors.h, colors.s, 1))
		}), picker.sliders.value)
		picker.sliders.R.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.r/255, ColorSequence.new({
			ColorSequenceKeypoint.new(0,Color3.new(0,colors.g/255,colors.b/255)),
			ColorSequenceKeypoint.new(1,Color3.new(1,colors.g/255,colors.b/255))
		}), picker.sliders.R)
		picker.sliders.G.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.g/255, ColorSequence.new({
			ColorSequenceKeypoint.new(0,Color3.new(colors.r/255,0,colors.b/255)),
			ColorSequenceKeypoint.new(1,Color3.new(colors.r/255,1,colors.b/255))
		}), picker.sliders.G)
		picker.sliders.B.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.b/255, ColorSequence.new({
			ColorSequenceKeypoint.new(0,Color3.new(colors.r/255,colors.g/255,0)),
			ColorSequenceKeypoint.new(1,Color3.new(colors.r/255,colors.g/255,1))
		}), picker.sliders.B)
		newgui.Parent.colorpicker.picker.triangle.ImageColor3 = Color3.fromHSV(colors.h, 1, 1)
		newgui.Parent.colorpicker.picker.square.BackgroundColor3 = Color3.fromHSV(colors.h, 1, 1)
	else
		colors.h, colors.s, colors.v = 0, 0, 1
	end
	game:GetService('RunService').RenderStepped:Connect(function()
		if draggingColorPicker then
			local newX = getMousePos().X - startMousePos.X
			local newY = getMousePos().Y - startMousePos.Y
			local minX = 0
			local maxX = newgui.Parent.AbsoluteSize.X - picker.AbsoluteSize.X
			local minY = game.GuiService.TopbarInset.Height + picker.dragbutton.AbsoluteSize.Y
			local maxY = newgui.Parent.AbsoluteSize.Y - picker.AbsoluteSize.Y
			newX = math.clamp(startExplorerPos.X.Offset + newX, minX, maxX)
			newY = math.clamp(startExplorerPos.Y.Offset + newY, minY, maxY) 

			picker.Position = UDim2.new(0, newX, 0, newY)
		end
		if pickingColor then
			local mousePos = (getMousePos() - picker.picker.AbsolutePosition - Vector2.new(0, GuiService.TopbarInset.Height)) / picker.picker.AbsoluteSize
			local pointer = picker.picker.pointer
			local module = modules[pickerMode]
			local colorResult = module.GetColor(mousePos)
			local h, s, v = colorResult[1], colorResult[2], colorResult[3]
			colors.h, colors.s, colors.v = h, s, v
			colors.r, colors.g, colors.b = math.round(Color3.fromHSV(h, s, v).R * 255), math.round(Color3.fromHSV(h, s, v).G * 255), math.round(Color3.fromHSV(h, s, v).B * 255)
			pointer.Position = module.GetPointerPositionFromColor(h, s, v)
			picker.middlebar.result.color.BackgroundColor3 = Color3.fromHSV(h, s, v)
			picker.middlebar.hex.TextBox.Text = string.format('#%02x%02x%02x', colors.r, colors.g, colors.b)
			picker.sliders.hue.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.h, nil, picker.sliders.hue)
			picker.sliders.saturation.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.s, ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
				ColorSequenceKeypoint.new(1, Color3.fromHSV(colors.h, 1, 1))
			}), picker.sliders.saturation)
			picker.sliders.value.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.v, ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.new()),
				ColorSequenceKeypoint.new(1, Color3.fromHSV(colors.h, colors.s, 1))
			}), picker.sliders.value)
			picker.sliders.R.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.r/255, ColorSequence.new({
				ColorSequenceKeypoint.new(0,Color3.new(0,colors.g/255,colors.b/255)),
				ColorSequenceKeypoint.new(1,Color3.new(1,colors.g/255,colors.b/255))
			}), picker.sliders.R)
			picker.sliders.G.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.g/255, ColorSequence.new({
				ColorSequenceKeypoint.new(0,Color3.new(colors.r/255,0,colors.b/255)),
				ColorSequenceKeypoint.new(1,Color3.new(colors.r/255,1,colors.b/255))
			}), picker.sliders.G)
			picker.sliders.B.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.b/255, ColorSequence.new({
				ColorSequenceKeypoint.new(0,Color3.new(colors.r/255,colors.g/255,0)),
				ColorSequenceKeypoint.new(1,Color3.new(colors.r/255,colors.g/255,1))
			}), picker.sliders.B)
			newgui.Parent.colorpicker.picker.triangle.ImageColor3 = Color3.fromHSV(colors.h, 1, 1)
			newgui.Parent.colorpicker.picker.square.BackgroundColor3 = Color3.fromHSV(colors.h, 1, 1)
		end
		if usingSlider.enabled then
			local mousePos = (getMousePos() - usingSlider.slider.AbsolutePosition - Vector2.new(0, GuiService.TopbarInset.Height)) / usingSlider.slider.AbsoluteSize
			local name = usingSlider.slider.Name:sub(1, 1):lower()
			local module = modules[pickerMode]
			if name == 'h' or name == 's' or name == 'v' then
				colors[name] = math.clamp(mousePos.X, 0, 1)
				colors.r, colors.g, colors.b = math.floor(Color3.fromHSV(colors.h, colors.s, colors.v).R * 255), math.floor(Color3.fromHSV(colors.h, colors.s, colors.v).G * 255), math.floor(Color3.fromHSV(colors.h, colors.s, colors.v).B * 255)
			end
			if name == 'r' or name == 'g' or name == 'b' then
				colors[name] = math.clamp(mousePos.X, 0, 1)*255
				colors.h, colors.s, colors.v = Color3.new(colors.r/255, colors.g/255, colors.b/255):ToHSV()
			end
			picker.middlebar.result.color.BackgroundColor3 = Color3.fromHSV(colors.h, colors.s, colors.v)
			picker.middlebar.hex.TextBox.Text = string.format('#%02x%02x%02x', colors.r, colors.g, colors.b)
			picker.sliders.hue.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.h, nil, picker.sliders.hue)
			picker.sliders.saturation.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.s, ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
				ColorSequenceKeypoint.new(1, Color3.fromHSV(colors.h, 1, 1))
			}), picker.sliders.saturation)
			picker.sliders.value.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.v, ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.new()),
				ColorSequenceKeypoint.new(1, Color3.fromHSV(colors.h, colors.s, 1))
			}), picker.sliders.value)
			picker.sliders.R.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.r/255, ColorSequence.new({
				ColorSequenceKeypoint.new(0,Color3.new(0,colors.g/255,colors.b/255)),
				ColorSequenceKeypoint.new(1,Color3.new(1,colors.g/255,colors.b/255))
			}), picker.sliders.R)
			picker.sliders.G.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.g/255, ColorSequence.new({
				ColorSequenceKeypoint.new(0,Color3.new(colors.r/255,0,colors.b/255)),
				ColorSequenceKeypoint.new(1,Color3.new(colors.r/255,1,colors.b/255))
			}), picker.sliders.G)
			picker.sliders.B.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.b/255, ColorSequence.new({
				ColorSequenceKeypoint.new(0,Color3.new(colors.r/255,colors.g/255,0)),
				ColorSequenceKeypoint.new(1,Color3.new(colors.r/255,colors.g/255,1))
			}), picker.sliders.B)
			picker.picker.pointer.Position = module.GetPointerPositionFromColor(colors.h, colors.s, colors.v)
			newgui.Parent.colorpicker.picker.triangle.ImageColor3 = Color3.fromHSV(colors.h, 1, 1)
			newgui.Parent.colorpicker.picker.square.BackgroundColor3 = Color3.fromHSV(colors.h, 1, 1)
			if colorMode == 'rgb' then
				local h, s, v = Color3.fromRGB(colors.r, colors.g, colors.b):ToHSV()
				newgui.Parent.colorpicker.picker.pointer.Position = module.GetPointerPositionFromColor(h, s, v)
			end
		end
		if resizingColorPicker then
			local function snap(number)
				return math.floor(number / 33.3) * 33.3
			end
			local MAX_HEIGHT = 421
			local mousePos = getMousePos()
			local deltaY = mousePos.Y - startMousePos.Y
			local newHeight = math.clamp(snap(startPickerSize.Y.Offset + deltaY), 320, MAX_HEIGHT)
			picker.Size = UDim2.new(startPickerSize.X.Scale, startPickerSize.X.Offset, 0, newHeight)
		end
		if picker.Size.Y.Offset > 320 + 100/3 then
			picker.sliders.R.Visible = true
		else
			picker.sliders.R.Visible = false
		end
		if picker.Size.Y.Offset > 320 + 100/2 then
			picker.sliders.G.Visible = true
		else
			picker.sliders.G.Visible = false
		end
		if picker.Size.Y.Offset > 420 then
			picker.sliders.B.Visible = true
		else
			picker.sliders.B.Visible = false
		end
	end)
	for _, v in picker.sliders:GetChildren() do
		if v:IsA('Frame') then
			v.activateregion.MouseButton1Down:Connect(function()
				usingSlider = {
					enabled = true,
					slider = v
				}
			end)
			v.value.FocusLost:Connect(function()
				local module = modules[pickerMode]
				local name = v.Name:sub(1, 1):lower()
				if name == 'r' or name == 'g' or name == 'b' then
					local ok, error = pcall(function()
						colors[v.Name:sub(1, 1):lower()] = math.clamp(tonumber(v.value.Text)/255 or 0, 0, 1) * 255
					end)
					colors.h, colors.s, colors.v = Color3.new(colors.r/255, colors.g/255, colors.b/255):ToHSV()
					if not ok then
						v.value.Text = 0
					end
				end
				if name == 's' or name == 'v' then
					local ok, error = pcall(function()
						colors[v.Name:sub(1, 1):lower()] = math.clamp(tonumber(v.value.Text)/100 or 0, 0, 1)
					end)
					if not ok then
						v.value.Text = 0
					end
				end
				if name == 'h' then
					local ok, error = pcall(function()
						colors[v.Name:sub(1, 1):lower()] = math.clamp(tonumber(v.value.Text)/360 or 0, 0, 1)
					end)
					if not ok then
						v.value.Text = 0
					end
				end
				local r, g, b = math.round(Color3.fromHSV(colors.h, colors.s, colors.v).R * 255), math.round(Color3.fromHSV(colors.h, colors.s, colors.v).G * 255), math.round(Color3.fromHSV(colors.h, colors.s, colors.v).B * 255)
				picker.middlebar.result.color.BackgroundColor3 = Color3.fromHSV(colors.h, colors.s, colors.v)
				picker.middlebar.hex.TextBox.Text = string.format('#%02x%02x%02x', r, g, b)
				picker.sliders.hue.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.h, nil, picker.sliders.hue)
				picker.sliders.saturation.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.s, ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
					ColorSequenceKeypoint.new(1, Color3.fromHSV(colors.h, 1, 1))
				}), picker.sliders.saturation)
				picker.sliders.value.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.v, ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.new()),
					ColorSequenceKeypoint.new(1, Color3.fromHSV(colors.h, colors.s, 1))
				}), picker.sliders.value)
				picker.sliders.R.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.r/255, ColorSequence.new({
					ColorSequenceKeypoint.new(0,Color3.new(0,colors.g/255,colors.b/255)),
					ColorSequenceKeypoint.new(1,Color3.new(1,colors.g/255,colors.b/255))
				}), picker.sliders.R)
				picker.sliders.G.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.g/255, ColorSequence.new({
					ColorSequenceKeypoint.new(0,Color3.new(colors.r/255,0,colors.b/255)),
					ColorSequenceKeypoint.new(1,Color3.new(colors.r/255,1,colors.b/255))
				}), picker.sliders.G)
				picker.sliders.B.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.b/255, ColorSequence.new({
					ColorSequenceKeypoint.new(0,Color3.new(colors.r/255,colors.g/255,0)),
					ColorSequenceKeypoint.new(1,Color3.new(colors.r/255,colors.g/255,1))
				}), picker.sliders.B)
				picker.picker.pointer.Position = module.GetPointerPositionFromColor(colors.h, colors.s, colors.v)
				newgui.Parent.colorpicker.picker.triangle.ImageColor3 = Color3.fromHSV(colors.h, 1, 1)
				newgui.Parent.colorpicker.picker.square.BackgroundColor3 = Color3.fromHSV(colors.h, 1, 1)
				if colorMode == 'rgb' then
					local h, s, v = Color3.fromRGB(colors.r, colors.g, colors.b):ToHSV()
					newgui.Parent.colorpicker.picker.pointer.Position = module.GetPointerPositionFromColor(h, s, v)
				end
			end)
		end
	end
	for _, v in picker.options.modes:GetChildren() do
		local button = v:FindFirstChild('button')
		button.MouseButton1Click:Connect(function()
			setMode(v.Name)
		end)
	end
	picker.resize.MouseEnter:Connect(function()
		game.TweenService:Create(picker.resize, TweenInfo.new(0.2), {
			ImageTransparency = 0.5
		}):Play()
	end)
	picker.resize.MouseLeave:Connect(function()
		game.TweenService:Create(picker.resize, TweenInfo.new(0.2), {
			ImageTransparency = 1
		}):Play()
	end)
	picker.middlebar.result.color_switch.MouseButton1Click:Connect(function()
		setColorMode()
	end)
	picker.Visible = true
	picker.options.close.MouseButton1Click:Connect(function()
		currentUIColor = Color3.fromRGB(colors.r, colors.g, colors.b)
		picker.Visible = false
		pickerOpened = false
		for _, v in newgui:GetDescendants() do
			if v:IsA('TextButton') or v:IsA('Frame') or v:IsA('TextBox') or v:IsA('TextLabel') then
				if v.BackgroundTransparency ~= 1 then
					v.BackgroundColor3 = currentUIColor
				end
			end
		end
	end)
end
local function setLogMenu()
	logsOpened = true
	local logMenu = newgui.Parent.logs
	logMenu.Visible = true
	local MIN_WIDTH, MIN_HEIGHT = 170, 20
	local MAX_WIDTH, MAX_HEIGHT = workspace.CurrentCamera.ViewportSize.X-100, workspace.CurrentCamera.ViewportSize.Y-100
	workspace.CurrentCamera:GetPropertyChangedSignal('ViewportSize'):Connect(function()
		MAX_WIDTH, MAX_HEIGHT = workspace.CurrentCamera.ViewportSize.X-100, workspace.CurrentCamera.ViewportSize.Y-100
	end)
	logMenu.resizebottom.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if explorerOpened then
				if not countdowns['logMenu'] then
					resizingLogMenu = 'Y'
					startMousePos = getMousePos()
					startLogSize = logMenu.Size
				end
			end
		end
	end)

	logMenu.resizeside.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if not countdowns['logMenu'] then
				resizingLogMenu = 'X'
				startMousePos = getMousePos()
				startLogSize = logMenu.Size
			end
		end
	end)

	logMenu.resizeboth.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if not countdowns['logMenu'] then
				resizingLogMenu = 'XY'
				startMousePos = getMousePos()
				startLogSize = logMenu.Size
			end
		end
	end)

	game:GetService('UserInputService').InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			resizingLogMenu = false
		end
	end)

	game:GetService('RunService').RenderStepped:Connect(function()
		if resizingLogMenu then
			local mouse = getMousePos()

			if resizingLogMenu == 'Y' then
				local deltaY = mouse.Y - startMousePos.Y
				local newHeight = math.clamp(startLogSize.Y.Offset + deltaY, MIN_HEIGHT, MAX_HEIGHT)
				logMenu.Size = UDim2.new(startLogSize.X.Scale, startLogSize.X.Offset, 0, newHeight)
			elseif resizingLogMenu == 'X' then
				local deltaX = mouse.X - startMousePos.X
				local newWidth = math.clamp(startLogSize.X.Offset + deltaX, MIN_WIDTH, MAX_WIDTH)
				logMenu.Size = UDim2.new(0, newWidth, startLogSize.Y.Scale, startLogSize.Y.Offset)
			elseif resizingLogMenu == 'XY' then
				local deltaX = mouse.X - startMousePos.X
				local deltaY = mouse.Y - startMousePos.Y
				local newWidth = math.clamp(startLogSize.X.Offset + deltaX, MIN_WIDTH, MAX_WIDTH)
				local newHeight = math.clamp(startLogSize.Y.Offset + deltaY, MIN_HEIGHT, MAX_HEIGHT)
				logMenu.Size = UDim2.new(0, newWidth, 0, newHeight)
			end
		end
		if draggingLogs then
			local newX = getMousePos().X - startMousePos.X
			local newY = getMousePos().Y - startMousePos.Y
			local minX = 0
			local maxX = newgui.Parent.AbsoluteSize.X - logMenu.AbsoluteSize.X
			local minY = game.GuiService.TopbarInset.Height + logMenu.dragbutton.AbsoluteSize.Y
			local maxY = newgui.Parent.AbsoluteSize.Y - logMenu.AbsoluteSize.Y
			newX = math.clamp(startLogsPos.X.Offset + newX, minX, maxX)
			newY = math.clamp(startLogsPos.Y.Offset + newY, minY, maxY) 

			logMenu.Position = UDim2.new(0, newX, 0, newY)
		end
	end)

	logMenu.resizebottom.MouseEnter:Connect(function()
		game.TweenService:Create(logMenu.resizebottom, TweenInfo.new(0.2), {
			BackgroundTransparency = 0.5
		}):Play()
	end)
	logMenu.resizebottom.MouseLeave:Connect(function()
		game.TweenService:Create(logMenu.resizebottom, TweenInfo.new(0.2), {
			BackgroundTransparency = 1
		}):Play()
	end)
	logMenu.resizeside.MouseEnter:Connect(function()
		game.TweenService:Create(logMenu.resizeside, TweenInfo.new(0.2), {
			BackgroundTransparency = 0.5
		}):Play()
	end)
	logMenu.resizeside.MouseLeave:Connect(function()
		game.TweenService:Create(logMenu.resizeside, TweenInfo.new(0.2), {
			BackgroundTransparency = 1
		}):Play()
	end)
	logMenu.resizeboth.MouseEnter:Connect(function()
		game.TweenService:Create(logMenu.resizeboth, TweenInfo.new(0.2), {
			BackgroundTransparency = 0.5
		}):Play()
	end)
	logMenu.resizeboth.MouseLeave:Connect(function()
		game.TweenService:Create(logMenu.resizeboth, TweenInfo.new(0.2), {
			BackgroundTransparency = 1
		}):Play()
	end)
end
function toClipboard(txt)
	if everyClipboard then
		everyClipboard(tostring(txt))
		notify(nil, "Copied to clipboard", 5)
	else
		notify(nil, "Your executor doesn't have the ability to use the clipboard", 5)
	end
end

newgui.explorer.MouseButton1Click:Connect(function()
	if not explorerUsing then
		setExplorer()
	end
end)
newgui.logs.MouseButton1Click:Connect(function()
	if not logsOpened then
		setLogMenu()
	end
end)
newgui.Parent.colorpicker.middlebar.hex.TextBox.FocusLost:Connect(function()
	local success,color = pcall(function() return Color3.fromHex(newgui.Parent.colorpicker.middlebar.hex.TextBox.Text:gsub('#', '')) end)

	if success and color then
		local r, g, b = math.round(color.R * 255), math.round(color.G * 255), math.round(color.B * 255)
		local h, s, v = Color3.fromRGB(r, g, b):ToHSV()
		colors.r, colors.g, colors.b = r, g, b
		colors.h, colors.s, colors.v = h, s, v
		local module = modules[pickerMode]
		local pointer = newgui.Parent.colorpicker.picker.pointer
		pointer.Position = module.GetPointerPositionFromColor(h, s, v)
		newgui.Parent.colorpicker.middlebar.result.color.BackgroundColor3 = Color3.fromHSV(h, s, v)
		newgui.Parent.colorpicker.middlebar.hex.TextBox.Text = string.format('#%02x%02x%02x', colors.r, colors.g, colors.b)
		newgui.Parent.colorpicker.sliders.hue.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.h, nil, newgui.Parent.colorpicker.sliders.hue)
		newgui.Parent.colorpicker.sliders.saturation.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.s, ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(colors.h, 1, 1))
		}), newgui.Parent.colorpicker.sliders.saturation)
		newgui.Parent.colorpicker.sliders.value.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.v, ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new()),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(colors.h, 1, 1))
		}), newgui.Parent.colorpicker.sliders.value)
		newgui.Parent.colorpicker.sliders.R.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.r/255, ColorSequence.new({
			ColorSequenceKeypoint.new(0,Color3.new(0,colors.g/255,colors.b/255)),
			ColorSequenceKeypoint.new(1,Color3.new(1,colors.g/255,colors.b/255))
		}), newgui.Parent.colorpicker.sliders.R)
		newgui.Parent.colorpicker.sliders.G.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.g/255, ColorSequence.new({
			ColorSequenceKeypoint.new(0,Color3.new(colors.r/255,0,colors.b/255)),
			ColorSequenceKeypoint.new(1,Color3.new(colors.r/255,1,colors.b/255))
		}), newgui.Parent.colorpicker.sliders.G)
		newgui.Parent.colorpicker.sliders.B.pointer.Position = modules.slider.GetPointerPositionFromColor(colors.b/255, ColorSequence.new({
			ColorSequenceKeypoint.new(0,Color3.new(colors.r/255,colors.g/255,0)),
			ColorSequenceKeypoint.new(1,Color3.new(colors.r/255,colors.g/255,1))
		}), newgui.Parent.colorpicker.sliders.B)
		newgui.Parent.colorpicker.picker.triangle.ImageColor3 = Color3.fromHSV(colors.h, 1, 1)
		newgui.Parent.colorpicker.picker.square.BackgroundColor3 = Color3.fromHSV(colors.h, 1, 1)
		local h, s, v = Color3.fromRGB(colors.r, colors.g, colors.b):ToHSV()
		newgui.Parent.colorpicker.picker.pointer.Position = module.GetPointerPositionFromColor(h, s, v)
	else
		newgui.Parent.colorpicker.middlebar.hex.TextBox.Text = string.format('#%02x%02x%02x', colors.r, colors.g, colors.b)
	end
end)
newgui.Parent.colorpicker.resizebottom.MouseButton1Down:Connect(function()
	startMousePos = game.UserInputService:GetMouseLocation()
	startPickerSize = newgui.Parent.colorpicker.Size
	resizingColorPicker = true
end)
newgui.Parent.explorer.dragbutton.MouseButton1Down:Connect(function()
	startMousePos = game.UserInputService:GetMouseLocation()
	startExplorerPos = newgui.Parent.explorer.Position
	draggingExplorer = true
end)
newgui.Parent.logs.dragbutton.MouseButton1Down:Connect(function()
	startMousePos = game.UserInputService:GetMouseLocation()
	startLogsPos = newgui.Parent.logs.Position
	draggingLogs = true
end)
newgui.Parent.colorpicker.dragbutton.MouseButton1Down:Connect(function()
	startMousePos = game.UserInputService:GetMouseLocation()
	startExplorerPos = newgui.Parent.colorpicker.Position
	draggingColorPicker = true
end)
newgui.Parent.colorpicker.picker.activateregion.MouseButton1Down:Connect(function()
	pickingColor = true
end)
game.UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingExplorer = false
		draggingColorPicker = false
		pickingColor = false
		draggingLogs = false
		resizingColorPicker = false
		usingSlider = {
			enabled = false,
			slider = nil
		}
	end
end)

newgui.placeinfo.MouseButton1Click:Connect(function()
	newgui.Parent.placeinfo.Visible = true
	newgui.Parent.closeregion.Visible = true
	local module = modules.other.placeinfo
	local placeId = game.PlaceId
	local gameInfo = game.MarketplaceService:GetProductInfo(placeId)
	module.CreateText('Name', gameInfo.Name)
	module.CreateText('ID', gameInfo.AssetId)
	module.CreateText('Updated', gameInfo.Updated:sub(1, 10):gsub('-', '/'))
	module.CreateText('Created', gameInfo.Created:sub(1, 10):gsub('-', '/'))
	module.CreateSeparator('CREATOR INFO')
	if gameInfo.Creator.HasVerifiedBadge then
		module.CreateText('Creator', gameInfo.Creator.Name..utf8.char(0xE000))
	else
		module.CreateText('Creator', gameInfo.Creator.Name)
	end
	module.CreateText('UserId', gameInfo.Creator.Id)
	module.CreateSeparator('SERVER INFO')
	module.CreateText("PartsAmount", Stats().PrimitivesCount)
	module.CreateText("PartsMoving", Stats().MovingPrimitivesCount)
	module.CreateText("ServerAge", math.floor(workspace.DistributedGameTime))
	module.CreateSeparator("RENDER")
	module.CreateText("RenderedTriangles", Stats().SceneTriangleCount)
	module.CreateText("ShadowRenderedTriangles", Stats().SceneTriangleCount)
end)
newgui.Parent.closeregion.MouseButton1Click:Connect(function()
	newgui.Parent.placeinfo.Visible = false
	newgui.Parent.closeregion.Visible = false
	for _, v in newgui.Parent.placeinfo.list:GetChildren() do
		if v:IsA('Frame') then
			v:Destroy()
		end
	end
end)
newgui.uicolor.MouseButton1Click:Connect(function()
	if not pickerOpened then
		setColorPicker(currentUIColor)
	end
end)
local function format(number, useCommas, useShort, demicals)
	demicals = demicals or 1
	if type(number) ~= 'number' then
		error('Expected number, got ' .. typeof(number))
	end

	local absNumber = math.round(tonumber(tostring(number):format('%.0f', number)))

	if useShort then
		if absNumber < 1000 then
			return tostring(number)
		end

		local tier = math.round(math.log10(absNumber) / 3) -- 3 digits per suffix
		if tier >= #suffixes then
			return string.format('%.0f', number)
		end

		local suffix = ''
		local scaled = 0
		local succ, err = pcall(function()
			suffix = suffixes[tier + 1]:upper()
			scaled = number / (10 ^ (tier * 3))
		end)

		if scaled % 1 == 0 then
			return string.format('%d%s', scaled, suffix)
		else
			return string.format(`%.{demicals}f%s`, scaled, suffix)
		end
	end

	if useCommas then
		local formatted = string.format('%.0f', math.round(number))
		local k
		while true do
			formatted, k = formatted:gsub('^(-?%d+)(%d%d%d)', '%1,%2')
			if k == 0 then break end
		end
		return formatted
	end

	return math.round(number)
end

local function fixMagnitudeLimit(x, y, z)
	return math.sqrt(x^2 + y^2 + z^2)
end

local guiobj_1 = newgui.list

local function search()
	local text = newgui.searchPlayer.Text:lower()
	local list = guiobj_1:GetChildren()

	for _, v in list do
		if v:IsA('TextButton') then
			if text == '' then
				v.Visible = true
			else
				local name = v.Text:split(' | ')[1]:lower()
				if name:find(text, 1, true) then
					v.Visible = true
				else
					v.Visible = false
				end
			end
		end
	end
end

local function updatePlayerList()
	local gui_template = createInstance('TextButton', {
		Parent = nil,
		Name = 'template',
		Size = UDim2.new(1, 0, 0.2, 0),
		Text = '',
		BackgroundColor3 = currentUIColor,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Visible = false,
		TextScaled = true
	})
	for _, v in guiobj_1:GetChildren() do
		if v:IsA('TextButton') then
			v:Destroy()
		end
	end
	for _, v in game.Players:GetPlayers() do
		if v.Name ~= LocalPlayer.Name then
			local new = gui_template:Clone()
			new.Name = v.Name
			new.Text = v.Name..' | '..v.DisplayName
			new.Parent = guiobj_1
			new.MouseButton1Click:Connect(function()
				newgui.currentplr.Text = 'selectedPlayer: '..v.Name
				selectedplr = v.Name
				AddLog("Player Attached.", "info")
			end)
			new.MouseButton2Click:Connect(function()
				newgui.currentplr.Text = 'selectedPlayer: nobody'
				selectedplr = 'nobody'
				AddLog("Player Deattached.", "Server", "info")
			end)
		end
	end
	search()
	newgui.label.Text = 'select player | total players: '..#game.Players:GetPlayers()
end
updatePlayerList()
game.Players.ChildAdded:Connect(function(plr)
	updatePlayerList()
	notify(nil, 'Player '..plr.Name..' Joined.', 4)
	AddLog("Player "..plr.Name.." Joined.", "Server", "info")
end)
game.Players.ChildRemoved:Connect(function(plr)
	updatePlayerList()
	notify(nil, 'Player '..plr.Name..' Left.', 4)
	AddLog("Player "..plr.Name.." Left.", "Server", "info")
	if plr.Name == selectedplr then
		notify(nil, 'Player '..plr.Name..' Left, target deattached')
		selectedplr = 'nobody'
		newgui.currentplr.Text = 'selectedPlayer: '..selectedplr
	end
end)
local db = false
newgui.hidebutton.MouseButton1Click:Connect(function()
	if not db then
		guiHiden = not guiHiden
		db = true
		for _, v in newgui:GetChildren() do
			if v.Name ~= 'hidebutton' then
				if guiHiden then
					v:TweenPosition(UDim2.fromScale(v.Position.X.Scale, v.Position.Y.Scale - 3), 'InOut', 'Quad', 0.5, true)
				else
					v:TweenPosition(UDim2.fromScale(v.Position.X.Scale, v.Position.Y.Scale + 3), 'InOut', 'Quad', 0.5, true)
				end
				task.wait(0.05)
			end
		end
		delay(1, function()
			db = false
		end)
		newgui.hidebutton.Text = guiHiden and 'show' or 'hide'
	end
end)

newgui.unitformat.MouseButton1Click:Connect(function()
	if currentUnit == 'K' then
		currentUnit = 'M'
	elseif currentUnit == 'M' then
		currentUnit = 'B'
	elseif currentUnit == 'B' then
		currentUnit = 'T'
	elseif currentUnit == 'T' then
		currentUnit = 'QA'
	elseif currentUnit == 'QA' then
		currentUnit = 'QI'
	elseif currentUnit == 'QI' then
		currentUnit = 'SX'
	elseif currentUnit == 'SX' then
		currentUnit = 'SP'
	elseif currentUnit == 'SP' then
		currentUnit = 'OC'
	elseif currentUnit == 'OC' then
		currentUnit = 'NO'
	elseif currentUnit == 'NO' then
		currentUnit = 'DC'
	elseif currentUnit == 'DC' then
		currentUnit = 'UND'
	elseif currentUnit == 'UND' then
		currentUnit = 'K'
	end
	AddLog("Number format changed to: "..currentUnit, "DeepScope", "info")
	newgui.unitformat.Text = 'format: '..currentUnit
end)

newgui.startbutton.MouseButton1Down:Connect(function()
	cheatEnabled = not cheatEnabled
	newgui.startbutton.Text = cheatEnabled and 'stop' or 'start'
	if cheatEnabled == true then
		lastcf = LocalPlayer.Character:GetPrimaryPartCFrame()
	else
		LocalPlayer.Character:SetPrimaryPartCFrame(lastcf)
		lastcf = CFrame.new(0, 0, 0)
	end
end)
newgui.Parent.commandbar:GetAttributeChangedSignal("Hovering"):Connect(function()
	if newgui.Parent.commandbar:GetAttribute("Hovering") then
		newgui.Parent.commandbar:TweenSize(UDim2.fromOffset(195, 138), "InOut", "Sine", 0.3, true)
	else
		newgui.Parent.commandbar:TweenSize(UDim2.fromOffset(195, 18), "InOut", "Sine", 0.3, true)
	end
end)
local textBox: TextBox = newgui.Parent.commandbar.input
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == commandKey then
		textBox:CaptureFocus()
		textBox.Text = ""
		textBox.Parent:SetAttribute("Hovering", true)
	end
end)
newgui.Parent.commandbar.hoverregion.MouseEnter:Connect(function()
	textBox.Parent:SetAttribute("Hovering", true)
end)
newgui.Parent.commandbar.hoverregion.MouseLeave:Connect(function()
	textBox.Parent:SetAttribute("Hovering", false)
end)
newgui.searchPlayer.Changed:Connect(function()
	search()
end)
notify('rbxthumb://type=AvatarHeadShot&id='..LocalPlayer.UserId..'&w=420&h=420', initMessages[math.random(1, #initMessages)]:gsub('{player}', LocalPlayer.DisplayName), 10)
warn('aWYgeW91IHNlZSB0aGlzLCBkb250IGV4cGxvaXQgYW55bW9yZSE=')
newgui.mode.MouseButton1Down:Connect(function()
	if mode == 'follow' then
		mode = 'spectate'
	elseif mode == 'spectate' then
		mode = 'follow'
	end
	newgui.mode.Text = 'mode: '..mode
end)
LocalPlayer.Character.Humanoid.Seated:Connect(function(active, seat)
	if Enabled and seat and seat:IsA('VehicleSeat') then
		humanoid.Sit = false
		humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 15, 0)

		notify('rbxassetid://6525485104', 'You cant seat on VehicleSeat while Flying!', 6)
	end
end)
local commands = {}
local function checkIfR15(char)
	return char:FindFirstChild("UpperTorso") ~= nil
end
local function registerCommand(name, callback)
	local template = createInstance("TextButton", {
		Parent = newgui.Parent.commandbar.commandlist,
		Name = name,
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(195, 15),
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold),
		Text = name,
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Left,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local piece2 = createInstance("UIPadding", {
		Parent = template,
		PaddingLeft = UDim.new(0, 5),
		PaddingRight = UDim.new(0, 5)
	})
	commands[name] = callback
end
local function runCommand(input)
	if input == "" then
		return
	end
	if input:sub(1, 1) == commandPrefix then
		input = input:sub(2)
	end

	local parts = input:split(' ')
	local commandName = parts[1]:lower()
	local args = {}

	for i = 2, #parts do
		table.insert(args, parts[i])
	end

	local command = commands[commandName]
	if command then
		local success, err = pcall(function()
			command(args)
		end)
		if not success then
			AddLog("game.ReplicatedStorage._DeepScopeCore.Command:2733: "..err, "DeepScope", "error")
		end
	else
		AddLog("Unknown command: "..commandName, "DeepScope", "warn")
	end
end
textBox.FocusLost:Connect(function()
	textBox.Parent:SetAttribute("Hovering", false)
	runCommand(textBox.Text)
end)
textBox.Changed:Connect(function()
	local text = textBox.Text:lower()
	local list = newgui.Parent.commandbar.commandlist:GetChildren()

	for _, v in list do
		if v:IsA('TextButton') then
			if text == '' then
				v.Visible = true
			else
				local name = v.Text:lower()
				if name:find(text, 1, true) then
					v.Visible = true
				else
					v.Visible = false
				end
			end
		end
	end
end)
registerCommand("fly", function(args)
	local speed = tonumber(args[1]) or 1
	if not Enabled then
		Enabled = true
		modules.other.fly.UpdateFlying(Enabled, speed)
	end
end)
registerCommand("unfly", function()
	if Enabled then
		Enabled = false
		modules.other.fly.UpdateFlying(Enabled)
	end
end)
registerCommand("flyspeed", function(args)
	local speed = tonumber(args[1]) or 1
	flySpeed = speed
end)
registerCommand("goto", function(args)
	local targetName = args[1]
	local targetPlayer = game.Players:FindFirstChild(targetName)
	if targetPlayer then
		LocalPlayer.Character:SetPrimaryPartCFrame(targetPlayer.Character:GetPrimaryPartCFrame())
	end
end)
registerCommand("freeze", function()
	local partsToFreeze = {
		"Head",
		"LeftFoot",
		"LeftHand",
		"LeftLowerArm",
		"LeftLowerLeg",
		"LeftUpperArm",
		"LeftUpperLeg",
		"LowerTorso",
		"RightFoot",
		"RightHand",
		"RightLowerArm",
		"RightLowerLeg",
		"RightUpperArm",
		"RightUpperLeg",
		"UpperTorso",
		"HumanoidRootPart"
	}
	if not checkIfR15(LocalPlayer.Character) then
		partsToFreeze = {
			"Head",
			"Left Arm",
			"Left Leg",
			"Right Arm",
			"Right Leg",
			"Torso",
			"HumanoidRootPart"
		}
	end
	for _, v in partsToFreeze do
		local part = LocalPlayer.Character:FindFirstChild(v)
		if part then
			part.Anchored = true
			part:SetAttribute("Freezed", true)
		end
	end
end)
registerCommand("unfreeze", function()
	for _, v in LocalPlayer.Character:GetChildren() do
		if v:IsA("BasePart") and v:GetAttribute("Freezed") then
			v.Anchored = false
			v:SetAttribute("Freezed", nil)
		end
	end
end)
registerCommand("toggledeepscope", function()
	cheatEnabled = not cheatEnabled
	newgui.startbutton.Text = cheatEnabled and 'stop' or 'start'
	if cheatEnabled == true then
		lastcf = LocalPlayer.Character:GetPrimaryPartCFrame()
	else
		LocalPlayer.Character:SetPrimaryPartCFrame(lastcf)
		lastcf = CFrame.new(0, 0, 0)
	end
end)
registerCommand("setvelocity", function(args)
	local x = tonumber(args[1]) or 0
	local y = tonumber(args[2]) or 0
	local z = tonumber(args[3]) or 0
	local velocity = Vector3.new(x, y, z)
	if LocalPlayer.Character.PrimaryPart then
		LocalPlayer.Character.PrimaryPart.AssemblyLinearVelocity = velocity
	end
end)
local vector3YLimit = 340282346638528859811704183484516925440
registerCommand("offset", function(args)
	local x = math.clamp(tonumber(args[1]) or 0, -vector3YLimit, vector3YLimit)
	local y = math.clamp(tonumber(args[2]) or 0, -vector3YLimit, vector3YLimit)
	local z = math.clamp(tonumber(args[3]) or 0, -vector3YLimit, vector3YLimit)
	local offset = Vector3.new(x, y, z)
	if LocalPlayer.Character.PrimaryPart then
		LocalPlayer.Character.PrimaryPart.CFrame = LocalPlayer.Character.PrimaryPart.CFrame + offset
	end
end)
registerCommand("jerk", function()
	local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	local backpack = LocalPlayer:FindFirstChild("Backpack")
	if not humanoid and not backpack then return end
	
	local tool = createInstance("Tool", {
		Parent = backpack,
		Name = "Jerk Off",
		RequiresHandle = false,
	})
	local joking = false
	local track = nil
	
	local function stopAnims()
		joking = false
		if track then
			track:Stop()
			track = nil
		end
	end
	
	tool.Equipped:Connect(function() joking = true end)
	tool.Unequipped:Connect(stopAnims)
	humanoid.Died:Connect(stopAnims)
	
	while task.wait() do
		if not joking then continue end

		local isR15 = checkIfR15(LocalPlayer.Character)
		if not track then
			local anim = Instance.new("Animation")
			anim.AnimationId = not isR15 and "rbxassetid://72042024" or "rbxassetid://698251653"
			track = humanoid:LoadAnimation(anim)
		end

		track:Play()
		track:AdjustSpeed(isR15 and 0.7 or 0.65)
		track.TimePosition = 0.6
		task.wait(0.1)
		while track and track.TimePosition < (not isR15 and 0.65 or 0.7) do task.wait(0.1) end
		if track then
			track:Stop()
			track = nil
		end
	end
end)
registerCommand("info", function()
	notify(nil, `Welcome! This command is inspired by <font color="rgb(85,0,255)">IY</font>. all design and functionality credit goes to EdgeIY's <font color="rgb(85,0,255)">Infinity Yield</font>.`, 10)
end)
local Noclipping = nil
registerCommand("noclip", function()
	wait(0.1)
	local function NoclipLoop()
		if LocalPlayer.Character ~= nil then
			for _, child in pairs(LocalPlayer.Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true then
					child.CanCollide = false
				end
			end
		end
	end
	Noclipping = RunService.Stepped:Connect(NoclipLoop)
	notify(nil, "Noclip enabled")
end)
registerCommand("unnoclip", function()
	if Noclipping then
		Noclipping:Disconnect()
		notify(nil, "Noclip disabled")
	end
end)
registerCommand("rejoin", function()
	if #game.Players:GetPlayers() <= 1 then
		LocalPlayer:Kick("\nRejoining...")
		wait()
		game["Teleport Service"]:Teleport(game.PlaceId, LocalPlayer)
	else
		game["Teleport Service"]:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
	end
end)
registerCommand("exit", function()
	game:Shutdown()
end)
registerCommand("align", function(args)
	local unit = tostring(args[1]) or "right"
	for _, v in newgui.Parent.commandbar:GetDescendants() do
		if v:IsA("TextButton") or v:IsA("TextLabel") or v:IsA("TextBox") then
			if v.Name ~= "title" then
				v.TextXAlignment = unit == "left" and Enum.TextXAlignment.Left or unit == "center" and Enum.TextXAlignment.Center or Enum.TextXAlignment.Right or v.TextXAlignment
			end
		end
	end
	newgui.Parent.commandbar.AnchorPoint = unit == "left" and Vector2.new(0, 1) or unit == "center" and Vector2.new(0.5, 1) or Vector2.new(1, 1) or newgui.Parent.commandbar.AnchorPoint
	newgui.Parent.commandbar.Position = unit == "left" and UDim2.fromScale(0, 1) or unit == "center" and UDim2.fromScale(0.5, 1) or UDim2.fromScale(1, 1) or newgui.Parent.commandbar.Position
end)
registerCommand("discord", function()
	toClipboard("https://discord.gg/J7WWbFWR")
end)
while true do
	task.wait()
	modules.other.placeinfo.UpdateText("PartsAmount", Stats().PrimitivesCount)
	modules.other.placeinfo.UpdateText("PartsMoving", Stats().MovingPrimitivesCount)
	modules.other.placeinfo.UpdateText("RenderedTriangles", Stats().SceneTriangleCount)
	modules.other.placeinfo.UpdateText("ShadowRenderedTriangles", Stats().ShadowsTriangleCount)
	modules.other.placeinfo.UpdateText("ServerAge", workspace.DistributedGameTime)
	if selectedplr ~= 'nobody' then
		local player = workspace:FindFirstChild(selectedplr)
		if player then
			if player.PrimaryPart then
				if LocalPlayer.Character.PrimaryPart and player.PrimaryPart then
					pcall(function()
						local distance = fixMagnitudeLimit(
							LocalPlayer.Character.PrimaryPart.Position.X - player.PrimaryPart.Position.X,
							LocalPlayer.Character.PrimaryPart.Position.Y - player.PrimaryPart.Position.Y,
							LocalPlayer.Character.PrimaryPart.Position.Z - player.PrimaryPart.Position.Z
						)
						local demicals = 4
						local precent_toT = string.format(`%.{demicals}f`, math.clamp((distance / units[currentUnit:lower()]) * 100, 0, 100))
						newgui.distance.Text = 'distance from character: ' ..  format(math.round(distance), false, true, 3) .. ' | ' .. format(distance, true, false) .. ` ({precent_toT}% to one {fullUnits[currentUnit:lower()]})`
						newgui.spawndistance.TextColor3 = Color3.new(math.clamp(distance / units[currentUnit:lower()], 0, 1), 0, 0)	
					end)
				else
					newgui.distance.Text = 'distance from character: unknown | unknown'
				end
				if cheatEnabled == true then
					if LocalPlayer.Character.PrimaryPart then
						if mode == 'follow' then
							LocalPlayer.Character:SetPrimaryPartCFrame(player.PrimaryPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, math.pi, 0))
						end
						pcall(function()
							workspace.CurrentCamera.CameraSubject = player.Humanoid
						end)
					end
				else
					pcall(function()
						workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
					end)
					cheatEnabled = false
				end
			end
			pcall(function()
				newgui.currentspeed.Text = 'current speed: ' .. format(math.round(
					math.round(
						fixMagnitudeLimit(
							player.PrimaryPart.AssemblyLinearVelocity.X,
							player.PrimaryPart.AssemblyLinearVelocity.Y,
							player.PrimaryPart.AssemblyLinearVelocity.Z
						)
					)
					), false, true, 3) .. ' | ' .. format(player.Humanoid.WalkSpeed, false, true, 3)..' | '..string.format('%.6f',
					fixMagnitudeLimit(
						player.PrimaryPart.AssemblyLinearVelocity.X,
						player.PrimaryPart.AssemblyLinearVelocity.Y,
						player.PrimaryPart.AssemblyLinearVelocity.Z
					)
						/player.Humanoid.WalkSpeed)..':1'
			end)
		else
			workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
			cheatEnabled = false
		end
	else
		pcall(function()
			newgui.currentspeed.Text = 'current speed: ' .. format(math.round(
				math.round(
					fixMagnitudeLimit(
						LocalPlayer.Character.PrimaryPart.AssemblyLinearVelocity.X,
						LocalPlayer.Character.PrimaryPart.AssemblyLinearVelocity.Y,
						LocalPlayer.Character.PrimaryPart.AssemblyLinearVelocity.Z
					)
				)
				), false, true, 3) .. ' | ' .. format(LocalPlayer.Character.Humanoid.WalkSpeed, false, true, 3)..' | '..string.format('%.6f',
				fixMagnitudeLimit(
					LocalPlayer.Character.PrimaryPart.AssemblyLinearVelocity.X,
					LocalPlayer.Character.PrimaryPart.AssemblyLinearVelocity.Y,
					LocalPlayer.Character.PrimaryPart.AssemblyLinearVelocity.Z
				)
					/LocalPlayer.Character.Humanoid.WalkSpeed)..':1'
		end)
	end
	if LocalPlayer.Character.PrimaryPart then
		local distance = fixMagnitudeLimit(
			LocalPlayer.Character.PrimaryPart.Position.X,
			LocalPlayer.Character.PrimaryPart.Position.Y,
			LocalPlayer.Character.PrimaryPart.Position.Z
		)
		local demicals = 4
		local precent_toT = string.format(`%.{demicals}f`, math.clamp((distance / units[currentUnit:lower()]) * 100, 0, 100))
		newgui.spawndistance.Text = 'distance from spawn: ' ..  format(math.round(distance), false, true, 3) .. ' | ' .. format(distance, true, false) .. ` ({precent_toT}% to one {fullUnits[currentUnit:lower()]})`
		newgui.spawndistance.TextColor3 = Color3.new(math.clamp(distance / units[currentUnit:lower()], 0, 1), 0, 0)
	else
		newgui.spawndistance.Text = 'distance from spawn: unknown | unknown'
	end
end
