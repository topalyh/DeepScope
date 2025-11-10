print("Loading DS...")
local time = tick()
if DS_LOADED then warn("DS Is already loaded!") return end
pcall(function() getgenv().DS_LOADED = true end)
local function createInstance(name, tbl)
	local any = Instance.new(name)
	for i, v in tbl do
		any[i] = v
	end
	return any
end
function create(data)
	local insts = {}
	for i,v in pairs(data) do insts[v[1]] = Instance.new(v[2]) end

	for _,v in pairs(data) do
		for prop,val in pairs(v[3]) do
			if type(val) == "table" then
				insts[v[1]][prop] = insts[val[1]]
			else
				insts[v[1]][prop] = val
			end
		end
	end

	return insts[1]
end
function missing(t, f, fallback)
	if type(f) == t then return f end
	return fallback
end
local waxwritefile, waxreadfile = writefile, readfile
cloneref = missing("function", cloneref, function(...) return ... end)
everyClipboard = missing("function", setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set))
makefolder = missing("function", makefolder)
isfolder = missing("function", isfolder)
getcustomasset = missing("function", getcustomasset)
writefile = missing("function", waxwritefile) and function(file, data, safe)
	if safe == true then return pcall(waxwritefile, file, data) end
	waxwritefile(file, data)
end
readfile = missing("function", waxreadfile) and function(file, safe)
	if safe == true then return pcall(waxreadfile, file) end
	return waxreadfile(file)
end
isfile = missing("function", isfile, readfile and function(file)
	local success, result = pcall(function()
		return readfile(file)
	end)
	return success and result ~= nil and result ~= ""
end)
listfiles = missing("function", listfiles)
local UserInputService: UserInputService = cloneref(game:GetService("UserInputService"))
local RunService: RunService = cloneref(game:GetService("RunService"))
local LocalPlayer: Player = cloneref(game:GetService("Players")).LocalPlayer
local GuiService: GuiService = cloneref(game:GetService("GuiService"))
local TweenService: TweenService = cloneref(game:GetService("TweenService"))
local HttpService: HttpService = cloneref(game:GetService("HttpService"))
local CurrentCamera: Camera = cloneref(game:GetService("Workspace")).CurrentCamera
local TextService: TextService = cloneref(game:GetService("TextService"))
local stst: Stats = cloneref(game:GetService("Stats"))
local coreModules = {}
repeat wait() until LocalPlayer.Character
local suffixes = {
	"",
	"k",
	"m",
	"b",
	"t",
	"qa",
	"qi",
	"sx",
	"sp",
	"oc",
	"no",
	"dc",
	"und"
}
local units = {
	["k"] = 1e3,
	["m"] = 1e6,
	["b"] = 1e9,
	["t"] = 1e12,
	["qa"] = 1e15,
	["qi"] = 1e18,
	["sx"] = 1e21,
	["sp"] = 1e24,
	["oc"] = 1e27,
	["no"] = 1e30,
	["dc"] = 1e33,
	["und"] = 1e36
}
local fullUnits = {
	["k"] = "Thousand",
	["m"] = "Million",
	["b"] = "Billion",
	["t"] = "Trillion",
	["qa"] = "Quadrillion",
	["qi"] = "Quintillion",
	["sx"] = "Sextillion",
	["sp"] = "Septillion",
	["oc"] = "Octillion",
	["no"] = "Nonillion",
	["dc"] = "Decillion",
	["und"] = "Undecillion"
}
local fonts = {
	["SourceSansPro"] = "rbxasset://fonts/families/SourceSansPro.json",
	["BuilderSans"] = "rbxasset://fonts/families/BuilderSans.json",
	["BuilderMono"] = "rbxassetid://16658246179",
	["FiraSans"] = "rbxassetid://12187374954"
}
local icons = {
	size = {16, 16},
	index = {
		["Part"] = 1,
		["CornerWedge"] = 1,
		["Truss"] = 1,
		["Wedge"] = 1,
		["AdService"] = 145,
		["AdGui"] = 145,
		["AdPortal"] = 146,
		["TerrainDetail"] = 144,
		["MaterialService"] = 131,
		["MaterialVariant"] = 130,
		["FaceControls"] = 129,
		["PathfindingModifier"] = 128,
		["PathfindingLink"] = 128,
		["ProximityPrompt"] = 124,
		["ProximityPromptService"] = 124,
		["HumanoidDescription"] = 104,
		["BodyPartDescription"] = 104,
		["AccessoryDescription"] = 104,
		["ChorusSoundEffect"] = 84,
		["Highlight"] = 133,
		["LocalizationTable"] = 97,
		["LocalizationService"] = 92,
		["CompressorSoundEffect"] = 84,
		["DistortionSoundEffect"] = 84,
		["EchoSoundEffect"] = 84,
		["EqualizerSoundEffect"] = 84,
		["FlangeSoundEffect"] = 84,
		["PitchSoundEffect"] = 84,
		["ReverbSoundEffect"] = 84,
		["TremoloSoundEffect"] = 84,
		["SoundGroup"] = 85,
		["ViewportFrame"] = 120,
		["Beam"] = 96,
		["Trail"] = 93,
		["Accessory"] = 32,
		["AlignOrientation"] = 100,
		["AlignPosition"] = 99,
		["AngularVelocity"] = 104,
		["Animation"] = 60,
		["VideoFrame"] = 60,
		["AnimationController"] = 60,
		["AnimationTrack"] = 60,
		["ArcHandles"] = 56,
		["Atmosphere"] = 83,
		["Attachment"] = 81,
		["Backpack"] = 20,
		["BallSocketConstraint"] = 86,
		["BillboardGui"] = 64,
		["BindableEvent"] = 67,
		["BlockMesh"] = 8,
		["BloomEffect"] = 83,
		["BodyAngularVelocity"] = 14,
		["BodyForce"] = 14,
		["BodyGyro"] = 14,
		["BodyPosition"] = 14,
		["BodyThrust"] = 14,
		["BodyVelocity"] = 14,
		["Bone"] = 114,
		["BoolValue"] = 4,
		["DoubleConstrainedValue"] = 4,
		["IntConstrainedValue"] = 4,
		["BinaryStringValue"] = 4,
		["BoxHandleAdornment"] = 112,
		["BrickColorValue"] = 4,
		["CFrameValue"] = 4,
		["Camera"] = 5,
		["Chat"] = 33,
		["ClickDetector"] = 41,
		["Color3Value"] = 4,
		["ColorCorrection"] = 83,
		["ConeHandleAdornment"] = 111,
		["Configuration"] = 58,
		["CoreGui"] = 46,
		["CylinderHandleAdornment"] = 110,
		["CylindricalConstraint"] = 94,
		["Debris"] = 30,
		["Decal"] = 7,
		["Dialog"] = 62,
		["DialogChoise"] = 63,
		["Explosion"] = 36,
		["Fire"] = 61,
		["Flag"] = 38,
		["FlagStand"] = 39,
		["Folder"] = 77,
		["ForceField"] = 37,
		["TouchTransmister"] = 37,
		["Frame"] = 48,
		["ScrollingFrame"] = 48,
		["Glue"] = 34,
		["Handles"] = 53,
		["Hat"] = 45,
		["HingeConstraint"] = 85,
		["HopperBin"] = 22,
		["Humanoid"] = 9,
		["ImageButton"] = 52,
		["ImageHandleAdornment"] = 109,
		["ImageLabel"] = 49,
		["IntValue"] = 4,
		["Keyframe"] = 60,
		["KeyframeSequence"] = 60,
		["KeyframeSequenceProvider"] = 60,
		["Lighting"] = 13,
		["LineForce"] = 101,
		["LineHandleAdornment"] = 108,
		["LinearVelocity"] = 101,
		["LocalScript"] = 18,
		["ManualWeld"] = 34,
		["MeshPart"] = 1,
		["Model"] = 2,
		["ModuleScript"] = 76,
		["Motor"] = 34,
		["Motor6D"] = 107,
		["NegateOperation"] = 72,
		["NetworkClient"] = 16,
		["NoCollisionConstraint"] = 106,
		["NumberValue"] = 4,
		["Pants"] = 44,
		["ParticleEmitter"] = 80,
		["PhysicsService"] = 30,
		["PlaneConstraint"] = 134,
		["Player"] = 12,
		["Players"] = 21,
		["PointLight"] = 13,
		["PrismaticConstraint"] = 87,
		["RayValue"] = 4,
		["RemoteEvent"] = 75,
		["RemoteFunction"] = 74,
		["ReplicatedFirst"] = 70,
		["ReplicatedStorage"] = 70,
		["RigidConstraint"] = 135,
		["RodConstraint"] = 89,
		["RopeConstraint"] = 88,
		["Run Service"] = 66,
		["ScreenGui"] = 47,
		["Script"] = 6,
		["Seat"] = 35,
		["Selection"] = 55,
		["SelectionBox"] = 54,
		["SelectionPartLasso"] = 57,
		["SelectionPointLasso"] = 57,
		["ServerScriptService"] = 71,
		["ServerStorage"] = 69,
		["Shirt"] = 43,
		["ShirtGraphic"] = 40,
		["Sky"] = 28,
		["Smoke"] = 59,
		["Sound"] = 11,
		["SoundService"] = 31,
		["Sparkles"] = 42,
		["SpawnLocation"] = 25,
		["SpecialMesh"] = 8,
		["SphereHandleAdornment"] = 113,
		["WireframeHandleAdornment"] = 114,
		["SpotLight"] = 13,
		["SprintConstraint"] = 90,
		["StarterCharacterScripts"] = 78,
		["StarterGear"] = 20,
		["StarterGui"] = 46,
		["StarterPack"] = 20,
		["StarterPlayer"] = 79,
		["StarterPlayerScripts"] = 78,
		["StringValue"] = 3,
		["SunRays"] = 83,
		["SurfaceLight"] = 13,
		["Team"] = 24,
		["UICorner"] = 26,
		["UIGradient"] = 26,
		["UIGridLayout"] = 26,
		["UIListLayout"] = 26,
		["UIScale"] = 26,
		["UIStroke"] = 26,
		["UIAspectRatioConstraint"] = 26,
		["UISizeConstraint"] = 26,
		["UITextSizeConstraint"] = 26,
		["UITableLayout"] = 26,
		["Teams"] = 23,
		["Terrain"] = 65,
		["TestService"] = 68,
		["TextButton"] = 51,
		["TextBox"] = 51,
		["TextLabel"] = 50,
		["Texture"] = 10,
		["SurfaceAppearance"] = 10,
		["Tool"] = 17,
		["Torque"] = 103,
		["TorsionSpring"] = 125,
		["UnionOperation"] = 73,
		["UniversalConstraint"] = 123,
		["VectorForce"] = 102,
		["VehicleSeat"] = 35,
		["Weld"] = 34,
		["WeldConstraint"] = 93,
		["Workspace"] = 19
	},
}
local add_objects = {
	size = {19, 19},
	objects = {
		["3D Interfaces"] = {
			ClickDetector = {
				Name = "ClickDetector",
				Order = 1
			},
			Decal = {
				Name = "Decal",
				Order = 2
			},
			Dialog = {
				Name = "Dialog",
				Order = 3
			},
			DialogChoise = {
				Name = "DialogChoise",
				Order = 4
			},
			DragDetector = {
				Name = "DragDetector",
				Order = 5
			},
			MaterialVariant = {
				Name = "MaterialVariant",
				Order = 6
			},
			ProximityPrompt = {
				Name = "ProximityPropmpt",
				Order = 7
			},
			SurfaceAppearance = {
				Name = "SurfaceAppearance",
				Order = 8
			},
			TerrainDetail = {
				Name = "TerrainDetail",
				Order = 9
			},
			Texture = {
				Name = "Texture",
				Order = 10
			}
		},
		["Adornments"] = {
			ArcHandles = {
				Name = "ArcHandles",
				Order = 12
			},
			BoxHandleAdornment = {
				Name = "BoxHandleAdornment",
				Order = 13
			},
			ConeHandleAdornment = {
				Name = "ConeHandleAdornment",
				Order = 14
			},
			CylinderHandleAdornment = {
				Name = "CylinderHandleAdornment",
				Order = 15
			},
			Handles = {
				Name = "Handles",
				Order = 16
			},
			ImageHandleAdornment = {
				Name = "ImageHandleAdornment",
				Order = 17
			},
			LineHandleAdornment = {
				Name = "LineHandleAdornment",
				Order = 18
			},
			PathFindingLink = {
				Name = "PathFindingLink",
				Order = 19
			},
			PathFindingModifier = {
				Name = "PathFindingModifier",
				Order = 20
			},
			SelectionBox = {
				Name = "SelectionBox",
				Order = 21
			},
			SelectionSphere = {
				Name = "SelectionSphere",
				Order = 22
			},
			SphereHandleAdornment = {
				Name = "SphereHandleAdornment",
				Order = 23
			},
			SurfaceSelection = {
				Name = "SurfaceSelection",
				Order = 24
			},
			WireframeHandleAdornment = {
				Name = "WireframeHandleAdornment",
				Order = 25
			}
		},
		["Ads"] = {
			AdGui = {
				Name = "AdGui",
				Order = 27
			}
		},
		["Animations"] = {
			Animation = {
				Name = "Animation",
				Order = 29
			},
			AnimationController = {
				Name = "AnimationController",
				Order = 30
			},
			Animator = {
				Name = "Animator",
				Order = 31
			},
			Bone = {
				Name = "Bone",
				Order = 32
			},
			FaceControls = {
				Name = "FaceControls",
				Order = 33
			},
			IKControl = {
				Name = "IKControl",
				Order = 34
			},
			Motor6D = {
				Name = "Motor6D",
				Order = 35
			}
		},
		["Avatar"] = {
			Accessory = {
				Name = "Accessory",
				Order = 37
			},
			BodyColors = {
				Name = "BodyColors",
				Order = 39
			},
			ForceField = {
				Name = "ForceField",
				Order = 44
			},
			Humanoid = {
				Name = "Humanoid",
				Order = 46
			},
			Pants = {
				Name = "Pants",
				Order = 47
			},
			Shirt = {
				Name = "Shirt",
				Order = 48
			},
			ShirtGraphic = {
				Name = "ShirtGraphic",
				Order = 49
			}
		},
		["Constraints"] = {
			AlignOrientation = {
				Name = "AlignOrientation",
				Order = 51
			},
			AlignPosition = {
				Name = "AlignPosition",
				Order = 52
			},
			AngularVelocity = {
				Name = "AngularVelocity",
				Order = 53
			},
			Attachment = {
				Name = "Attachment",
				Order = 55
			},
			BallSocketConstraint = {
				Name = "BallSocketConstraint",
				Order = 56
			},
			CylindricalConstraint = {
				Name = "CylindricalConstraint",
				Order = 57
			},
			HingeConstraint = {
				Name = "HingeConstraint",
				Order = 58
			},
			LinearVelocity = {
				Name = "LinearVelocity",
				Order = 59
			},
			LineForce = {
				Name = "LineForce",
				Order = 60
			},
			NoCollisionConstraint = {
				Name = "NoCollisionConstraint",
				Order = 61
			},
			PrismaticConstraint = {
				Name = "PrismaticConstraint",
				Order = 63
			},
			RigidConstraint = {
				Name = "RigidConstraint",
				Order = 64
			},
			RodConstraint = {
				Name = "RodConstraint",
				Order = 65
			},
			RopeConstraint = {
				Name = "RopeConstraint",
				Order = 66
			},
			SpringConstraint = {
				Name = "SpringConstraint",
				Order = 67
			},
			Torque = {
				Name = "Torque",
				Order = 68
			},
			VectorForce = {
				Name = "VectorForce",
				Order = 71
			},
			WeldConstraint = {
				Name = "WeldConstraint",
				Order = 72
			}
		},
		["Effects"] = {
			Beam = {
				Name = "Beam",
				Order = 74
			},
			Explosion = {
				Name = "Explosion",
				Order = 75
			},
			Fire = {
				Name = "Fire",
				Order = 76
			},
			Highlight = {
				Name = "Highlight",
				Order = 77
			},
			ParticleEmitter = {
				Name = "ParticleEmitter",
				Order = 78
			},
			Smoke = {
				Name = "Smoke",
				Order = 79
			},
			Sparkles = {
				Name = "Sparkles",
				Order = 80
			},
			Trail = {
				Name = "Trail",
				Order = 81
			}
		},
		["Environment"] = {
			Atmosphere = {
				Name = "Atmosphere",
				Order = 85
			},
			Clouds = {
				Name = "Clouds",
				Order = 86
			},
			Sky = {
				Name = "Sky",
				Order = 87
			}
		},
		["Interaction"] = {
			Seat = {
				Name = "Seat",
				Order = 121
			},
			SpawnLocation = {
				Name = "SpawnLocation",
				Order = 122
			},
			Tool = {
				Name = "Tool",
				Order = 124
			},
			VehicleSeat = {
				Name = "VehicleSeat",
				Order = 125
			}
		},
		["Lights"] = {
			PointLight = {
				Name = "PointLight",
				Order = 127
			},
			SpotLight = {
				Name = "SpotLight",
				Order = 128
			},
			SurfaceLight = {
				Name = "SurfaceLight",
				Order = 129
			}
		},
		["Parts"] = {
			CornerWedgePart = {
				Name = "Sky",
				Order = 134
			},
			Part = {
				Name = "Part",
				Order = 136
			},
			TrussPart = {
				Name = "TrussPart",
				Order = 137
			},
			WedgePart = {
				Name = "Sky",
				Order = 138
			}
		}
	}
}
local executorConfig = {
	keywords = {
		{
			"\101\108\115\101",
			"\100\111",
			"\119\104\105\108\101",
			"\102\117\110\99\116\105\111\110",
			"\101\110\100",
			"\115\101\108\102",
			"\110\111\116",
			"\116\121\112\101",
			"\114\101\116\117\114\110",
			"\101\108\115\101\105\102",
			"\101\120\112\111\114\116",
			"\105\102",
			"\98\114\101\97\107",
			"\102\111\114",
			"\117\110\116\105\108",
			"\105\110",
			"\116\104\101\110",
			"\111\114",
			"\114\101\112\101\97\116",
			"\97\110\100",
			"\108\111\99\97\108",
		},
		"\60\102\111\110\116\32\99\111\108\111\114\61\39\114\103\98\40\50\52\56\44\49\48\57\44\49\50\52\41\39\62\60\98\62\37\115\60\47\98\62\60\47\102\111\110\116\62"
	},
	bools = {
		{
			"\116\114\117\101",
			"\110\105\108",
			"\102\97\108\115\101",
		},
		"\60\102\111\110\116\32\99\111\108\111\114\61\39\114\103\98\40\50\53\53\44\49\57\56\44\48\41\39\62\60\98\62\37\115\60\47\98\62\60\47\102\111\110\116\62"
	},
	operators = {
		{
			"\35",
			"\37",
			"\41",
			"\40",
			"\43",
			"\42",
			"\45",
			"\44",
			"\47",
			"\46",
			"\126",
			"\59",
			"\93",
			"\91",
			"\125",
			"\123",
			"\58",
			"\61",
			"\60",
			"\62",
			"\94",
		},
		"\60\102\111\110\116\32\99\111\108\111\114\61\39\114\103\98\40\50\48\52\44\50\48\52\44\50\48\52\41\39\62\37\115\60\47\102\111\110\116\62"
	},
	textColor = Color3.fromRGB(204,204,204),
	backgroundColor = Color3.fromRGB(37,37,37),
	commentColor = Color3.fromRGB(102,102,102),
	stringColor = Color3.fromRGB(173,241,149),
	numberColor = Color3.fromRGB(255,198,0),
	operatorColor = Color3.fromRGB(204,204,204),
	funcColor = Color3.fromRGB(253,251,172),
	libColor = Color3.fromRGB(132,214,247),
	propColor = Color3.fromRGB(0,139,219),
	keywordColor = Color3.fromRGB(248,109,124),
	boolsColor = Color3.fromRGB(255,198,0),
	exploitColor = Color3.fromRGB(171,84,247),
	font = Enum.Font.Code,
	TextSize = 15,
	json = {
		stringColor = Color3.fromRGB(124,220,254),
		numberColor = Color3.fromRGB(167,206,168),
		booleanColor = Color3.fromRGB(74,156,214),
		nullColor = Color3.fromRGB(74,156,214),
	}
}
local assets = {
	["Move"] = "rbxassetid://11836249225",
	["Rotate"] = "rbxassetid://11836255662",
	["Scale"] = "rbxassetid://11836236956"
}
local math = math
local table = table
local Color3 = Color3
local UDim2 = UDim2
local UDim = UDim
local Enum = Enum
local Vector3 = Vector3
local Vector2 = Vector2
local CFrame = CFrame
local string = string
local os = os
local function toRGB(color)
	local r = math.floor(color.R * 255)
	local g = math.floor(color.G * 255)
	local b = math.floor(color.B * 255)
	return string.format("rgb(%d,%d,%d)", r, g, b)
end
local function toJSONRGB(color)
	local r = math.floor(color.R * 255)
	local g = math.floor(color.G * 255)
	local b = math.floor(color.B * 255)
	local str = "json[%d|%d|%d]"
	local result = str:format(r, g, b)
	return result
end
local function fromJSONRGB(str)
	local r, g, b = str:match("json%[(%d+)%|(%d+)%|(%d+)%]")
	return Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))
end
local function toJSONFont(font)
	local font = font.Family
	local str = "font[%s]"
	return str:format(font)
end
local function fromJSONFONT(str)
	local font = str:match("font%[(.*)%]")
	return Font.new(font)
end
local function to_base64(data)
	local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	return ((data:gsub('.', function(x) 
		local r,b='',x:byte()
		for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
		return r;
	end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
		if (#x < 6) then return '' end
		local c=0
		for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
		return b:sub(c+1,c+1)
	end)..({ '', '==', '=' })[#data%3+1])
end

function from_base64(data)
	local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	data = string.gsub(data, '[^'..b..'=]', '')
	return (data:gsub('.', function(x)
		if (x == '=') then return '' end
		local r,f='',(b:find(x)-1)
		for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
		return r;
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if (#x ~= 8) then return '' end
		local c=0
		for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
		return string.char(c)
	end))
end
local function ParseXML(xml)
	local func = function()
		local entities, tentities = {}, nil

		local function defaultEntityTable()
			return { quot='"', apos='\'', lt='<', gt='>', amp='&', tab='\t', nbsp=' ', }
		end

		local function replaceEntities(s, entities)
			return s:gsub('&([^;]+);', entities)
		end

		local function createEntityTable(docEntities, resultEntities)
			entities = resultEntities or defaultEntityTable()
			for _,e in pairs(docEntities) do
				e.value = replaceEntities(e.value, entities)
				entities[e.name] = e.value
			end
			return entities
		end

		local trim = function(s)
			local from = s:match"^%s*()"
			return from > #s and "" or s:match(".*%S", from)
		end

		local gtchar = string.byte('>', 1)
		local slashchar = string.byte('/', 1)
		local D = string.byte('D', 1)
		local E = string.byte('E', 1)

		local function parse(s, evalEntities)
			s = s:gsub('<!%-%-(.-)%-%->', '')

			if evalEntities then
				local pos = s:find('<[_%w]')
				if pos then
					s:sub(1, pos):gsub('<!ENTITY%s+([_%w]+)%s+(.)(.-)%2', function(name, q, entity)
						entities[#entities+1] = {name=name, value=entity}
					end)
					tentities = createEntityTable(entities)
					s = replaceEntities(s:sub(pos), tentities)
				end
			end

			local t, l = {}, {}

			local addtext = function(txt)
				txt = txt:match'^%s*(.*%S)' or ''
				if #txt ~= 0 then
					t[#t+1] = {text=txt}
				end		
			end

			s:gsub('<([?!/]?)([-:_%w]+)%s*(/?>?)([^<]*)', function(type, name, closed, txt)
				if #type == 0 then
					local a = {}
					if #closed == 0 then
						local len = 0
						for all,aname,_,value,starttxt in string.gmatch(txt, "(.-([-_%w]+)%s*=%s*(.)(.-)%3%s*(/?>?))") do
							len = len + #all
							a[aname] = value
							if #starttxt ~= 0 then
								txt = txt:sub(len+1)
								closed = starttxt
								break
							end
						end
					end
					t[#t+1] = {tag=name, attrs=a, children={}}

					if closed:byte(1) ~= slashchar then
						l[#l+1] = t
						t = t[#t].children
					end

					addtext(txt)
				elseif '/' == type then
					t = l[#l]
					l[#l] = nil

					addtext(txt)
				elseif '!' == type then
					if E == name:byte(1) then
						txt:gsub('([_%w]+)%s+(.)(.-)%2', function(name, q, entity)
							entities[#entities+1] = {name=name, value=entity}
						end, 1)
					end
				end
			end)

			return {children=t, entities=entities, tentities=tentities}
		end
		local function parseText(txt)
			return parse(txt)
		end
		return parseText(xml)
	end
	local newEnv = setmetatable({},{__index = getfenv()})
	setfenv(func,newEnv)
	return func()
end
local function getAsset(name)
	local function parseAsset()
		local asset, err = pcall(function()
			return game:HttpGet(("https://raw.githubusercontent.com/topalyh/DeepScope/refs/heads/main/assets/icons/toolbar/%s"):format(name))
		end)
		if asset then
			return asset
		else
			warn("Error while fetching asset: "..err)
			return
		end
	end
	local asset = parseAsset()
	if asset then
		return getcustomasset(asset)
	end
end
local explorerBlacklistInstances = {"cheatGui", "ServerScriptService"}
local currentUnit = "K"
local selectedplr = "nobody"
local cheatEnabled = false
local lastcf = CFrame.new(0, 0, 0)
local mode = "follow"
local guiHiden = false
local explorerOpened = true
local draggingExplorer = false
local draggingExecutor = false
local draggingColorPicker = false
local resizingExplorer = false
local resizingLogMenu = false
local resizingColorPicker = false
local resizingExecutor = false
local startExplorerSize = UDim2.fromOffset(0, 0)
local startExplorerPos = UDim2.fromOffset(0, 0)
local startExecutorPos = UDim2.fromOffset(0, 0)
local startExecutorSize = UDim2.fromOffset(0, 0)
local startPickerSize = UDim2.fromOffset(0, 0)
local startLogSize = UDim2.fromOffset(0, 0)
local startMousePos = UDim2.fromOffset(0, 0)
local startLogsPos = UDim2.fromOffset(0, 0)
local startExecutorPos = UDim2.fromOffset(0, 0)
local dragConn = nil
local explorerUsing = false
local countdowns = {}
local selectedObject = nil
local hoveringObject = nil
local pickerMode = "circle"
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
local notificationSoundId = "rbxassetid://17208372272"
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
local utilsOpened = false
local initMessages = {
	"Nice to see you {player}!",
	"Having a good day, {player}?",
	"Have a nice day {player}!",
	"Enjoying DeepScope? {player}"
}
local code = [[]]
local saves = {}
local currentUIColor = Color3.fromHSV(0.722222, 0.018181, 0.647058)
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
}
local function AddLog(text, sourse, type)
	if not type then type = "normal" end
	repeat wait() until logList
	local gui = createInstance("TextLabel", {
		Name = "log",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -15, 0, 20),
		FontFace = Font.new(fonts.FiraSans, Enum.FontWeight.Medium),
		Text = "\97\87\89\103\101\87\57\49\73\72\78\108\90\83\66\48\97\71\108\122\76\67\66\107\98\50\53\48\73\71\86\52\99\71\120\118\97\88\81\103\89\87\53\53\98\87\57\121\90\83\69\61",
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
	local timeNow = os.date("%H:%M:%S")
	local ok, textResult = pcall(function()
		return logConfig.stringFormat:format(timeNow, ("<font color=\"rgb(%d,%d,%d)\">%s</font>"):format(logConfig.colors[type][1], logConfig.colors[type][2], logConfig.colors[type][3], text), sourse or "DeepScope")
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
local guiToNode = setmetatable({}, {__mode = "k"})
local function initFileSystem()
	print("Loading Kernel File System...")
	if makefolder and isfolder and writefile and isfile then
		local success, err = pcall(function()
			local folders = {
				"DeepScopeCore",
				"DeepScopeCore/Explorer",
				"DeepScopeCore/Properties",
				"DeepScopeCore/Executor",
			}
			local files = {
				"DeepScopeCore/Saves.json",
				"DeepScopeCore/Waypoints.json",
				"DeepScopeCore/Logs.txt",
				"DeepScopeCore/Properties/Instances.dsf",
				"DeepScopeCore/Executor/SavedScripts.dsf",
				"DeepScopeCore/Explorer/RMD.dat",
				"DeepScopeCore/Explorer/API.dat",
				"DeepScopeCore/Explorer/StudioIcons.png",
				"DeepScopeCore/PlayedGames.dat"
			}
			for _, v in ipairs(folders) do
				if not isfolder(v) then
					makefolder(v)
					print("created folder",v)
				else
					print(("folder \"%s\" is already created"):format(v))
				end
			end

			for _, v in ipairs(files) do
				if not isfile(v) then
					writefile(v, "")
					print("created file",v)
				else
					print(("file \"%s\" is already created"):format(v))
				end
			end
		end)
		if not success and err then
			AddLog("Failed to create KFS (Kernel File System)", "DeepScope.Kernel", "error")
		end
	end
	print("Kernel File System Loaded!")
end
local function prettyJSON(tbl, indent)
	indent = indent or 0
	local padding = string.rep("  ", indent)
	local nextPad = string.rep("  ", indent + 1)

	if typeof(tbl) == "table" then
		local isArray = (#tbl > 0)
		local result = {}
		if isArray then
			table.insert(result, "[")
			for i, v in ipairs(tbl) do
				table.insert(result, nextPad .. prettyJSON(v, indent + 1) .. (i < #tbl and "," or ""))
			end
			table.insert(result, padding .. "]")
		else
			table.insert(result, "{")
			local count, total = 0, 0
			for _ in pairs(tbl) do total += 1 end
			for k, v in pairs(tbl) do
				count += 1
				local key = HttpService:JSONEncode(k)
				table.insert(result, nextPad .. key .. ": " .. prettyJSON(v, indent + 1) .. (count < total and "," or ""))
			end
			table.insert(result, padding .. "}")
		end
		return table.concat(result, "\n")
	else
		return HttpService:JSONEncode(tbl)
	end
end
print("-----------------File System ----------------------")
initFileSystem()
print("-----------------File System ----------------------")
print("--------------------Others ------------------------")
print("Loading Explorer Icons...")
local png = game:HttpGet("https://raw.githubusercontent.com/topalyh/DeepScope/refs/heads/main/ClassImages.PNG")
print("Loading Properties API... (may take a while)")
local api = game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/refs/heads/main/rbx_api.dat")
print("Loading RMD... (may take a while)")
local rmd = game:HttpGet("https://raw.githubusercontent.com/CloneTrooper1019/Roblox-Client-Tracker/roblox/ReflectionMetadata.xml")
writefile("DeepScopeCore/Explorer/StudioIcons.png", png)
print("Explorer Icons Loaded!")
writefile("DeepScopeCore/Explorer/API.dat", api)
print("Properties API Loaded!")
writefile("DeepScopeCore/Explorer/RMD.dat", prettyJSON(ParseXML(rmd)))
print("RMD Loaded!")
print("--------------------Others ------------------------")
print("Fully loaded! Time took:",tick()-time)
local jsonAttempts = 0
local function savePlayedGames()
	local readSuccess, out = readfile("DeepScopeCore/PlayedGames.dat", true)
	if readSuccess then
		if out ~= nil and tostring(out):gsub("%s", "") ~= "" then
			local success, response = pcall(function()
				local gameId = game.PlaceId
				writefile("DeepScopeCore/PlayedGames.dat", out .. "," .. gameId)
			end)
			if not success then
				jsonAttempts = jsonAttempts + 1
				warn("Save Json Error:", response)
				warn("Overwriting Save File")
				writefile("DeepScopeCore/PlayedGames.dat", "", true)
				wait(0.5)
				savePlayedGames()
			end
		end
	end
end
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
local function getLineAmount(code)
	local result = ""
	local lines = #code:split("\n")
	for i = 1, lines do
		result ..= i .. "<br/>"
	end
	return result
end
_createForces = function(hrp)
	local bp = Instance.new("BodyPosition")
	bp.MaxForce = Vector3.new(1e7, 1e7, 1e7)
	bp.D = 500
	bp.P = 1e7
	bp.Position = hrp.Position
	bp.Parent = hrp

	local bg = Instance.new("BodyGyro")
	bg.MaxTorque = Vector3.new(1e7, 1e7, 1e7)
	bg.D = 500
	bg.P = 1e4
	bg.CFrame = hrp.CFrame
	bg.Parent = hrp

	BodyPos = bp
	BodyGyro = bg
end
local function generateRandomString()
	local length = 10
	local characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
	local array = {}
	for i = 1, length do
		local index = math.random(1, #characters)
		table.insert(array, characters:sub(index, index))
	end
	return table.concat(array)
end
local function eraseFormatTags(str)
	return str:gsub("<.->", "")
end
local function saveData(dataToSave)
	local data = dataToSave or {}
	data.UIColor =  {currentUIColor.R, currentUIColor.G, currentUIColor.B}
	data.BuildMode = {
		Saves = {}
	}
	data.Executor = {
		SavedCodes = {}
	}
	data.ExecutorConfig = {
		Colors = {
			Text = toJSONRGB(executorConfig.textColor),
			Background = toJSONRGB(executorConfig.backgroundColor),
			Operator = toJSONRGB(executorConfig.operatorColor),
			String = toJSONRGB(executorConfig.stringColor),
			Number = toJSONRGB(executorConfig.numberColor),
			Function = toJSONRGB(executorConfig.funcColor),
			Keywords = toJSONRGB(executorConfig.keywordColor),
			Bools = toJSONRGB(executorConfig.boolsColor),
			Comment = toJSONRGB(executorConfig.commentColor),
			BuildIn = toJSONRGB(executorConfig.libColor)
		},
		TextSize = executorConfig.TextSize,
		Font = toJSONFont(executorConfig.font)
	}
	local encoded = HttpService:JSONEncode(data)
	local filePath = "DeepScopeCore/Saves.json"
	writefile(filePath, encoded)
end
local function readData()
	local data = {}
	local result = {
		UIColor = {},
		BuildMode = {
			Saves = {}
		},
		Executor = {
			SavedCodes = {}
		},
		ExecutorConfig = {
			Colors = {},
			TextSize = 15,
			Font = ""
		}
	}
	local success, err = pcall(function()
		data = HttpService:JSONDecode(readfile("DeepScopeCore/Saves.json"))
	end)
	if not success then
		data = {}
	end
	for i, v in data.ExecutorConfig.Colors do
		local value = fromJSONRGB(v)
		if value then
			result.ExecutorConfig.Colors[i] = value
		end
	end
	for _, v in data.UIColor do
		table.insert(result.UIColor, v)
	end

	return result
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
				if name == "s" or name == "v" then
					slider.value.Text = math.round(value * 100)
				end
				if name == "h" then
					slider.value.Text = math.round(value * 360)
				end
				if name == "r" or name == "g" or name == "b" then
					slider.value.Text = math.round(value * 255)
				end
			end
			return UDim2.fromScale(value, 0.5)
		end,
	},
	other = {
		fly = {
			DefaultKey = Enum.KeyCode.F,

			UpdateFlying = function(enabled, flyspeed)
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

			Loop = function(dt)
				if Enabled and BodyPos and BodyGyro then
					local camCF = CurrentCamera.CFrame
					local moveVec = moveDirection.Magnitude > 0 and moveDirection.Unit or Vector3.new()
					local targetVelocity = camCF:VectorToWorldSpace(moveVec) * flySpeed * dt * 60

					currentVelocity = currentVelocity:Lerp(targetVelocity, acceleration)

					BodyPos.Position = humanoidRootPart.Position + currentVelocity
					BodyGyro.CFrame = CFrame.lookAt(humanoidRootPart.Position, humanoidRootPart.Position + camCF.LookVector)
				end
			end,

			Respawn = function(char)
				local hrp = char:WaitForChild("HumanoidRootPart")
				humanoid = char:WaitForChild("Humanoid")
				humanoidRootPart = hrp

				if Enabled then
					humanoid.PlatformStand = true
					_createForces(hrp)
				end
			end,
		},
		placeinfo = {
			CreateText = function(infoTxt, copyableTxt)
				local template = createInstance("Frame", {
					Parent = infoList,
					Name = "template",
					Size = UDim2.new(1, -15, 0, 20),
					Visible = false,
					BorderColor3 = Color3.new(0, 0, 0),
					BorderSizePixel = 0
				})
				local placeInfoFrame1 = createInstance("UIPadding", {
					Parent = template,
					PaddingLeft = UDim.new(0, 5),
					PaddingRight = UDim.new(0, 5)
				})
				local placeInfoFrame2 = createInstance("TextBox", {
					Parent = template,
					Name = "copyableinfo",
					BackgroundTransparency = 1,
					AnchorPoint = Vector2.new(1, 0),
					AutomaticSize = Enum.AutomaticSize.X,
					ClearTextOnFocus = false,
					Position = UDim2.fromScale(1, 0),
					Size = UDim2.fromScale(0, 1),
					TextEditable = false,
					RichText = true,
					FontFace = Font.new(fonts.FiraSans),
					Text = "\97\87\89\103\101\87\57\49\73\72\78\108\90\83\66\48\97\71\108\122\76\67\66\107\98\50\53\48\73\71\86\52\99\71\120\118\97\88\81\103\89\87\53\53\98\87\57\121\90\83\69\61",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 19,
					TextXAlignment = Enum.TextXAlignment.Right,
					BorderColor3 = Color3.new(0, 0, 0),
					BorderSizePixel = 0
				})
				local placeInfoFrame3 = createInstance("TextLabel", {
					Parent = template,
					Name = "info",
					BackgroundTransparency = 1,
					AutomaticSize = Enum.AutomaticSize.X,
					Size = UDim2.fromScale(0, 1),
					FontFace = Font.new(fonts.FiraSans),
					Text = "\97\87\89\103\101\87\57\49\73\72\78\108\90\83\66\48\97\71\108\122\76\67\66\107\98\50\53\48\73\71\86\52\99\71\120\118\97\88\81\103\89\87\53\53\98\87\57\121\90\83\69\61",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 19,
					RichText = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					BorderColor3 = Color3.new(1, 1, 1),
					BorderSizePixel = 0
				})

				local newTemplate = template:Clone()
				newTemplate.Parent = infoList
				newTemplate.Visible = true
				newTemplate.Name = infoTxt
				newTemplate.copyableinfo.Text = copyableTxt
				newTemplate.info.Text = infoTxt
			end,
			CreateSeparator = function(text)
				local separatorTemplate = createInstance("Frame", {
					Parent = infoList,
					Name = "separator",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, -15, 0, 40),
					Visible = false
				})
				local separatorGui1 = createInstance("Frame", {
					Parent = separatorTemplate,
					Name = "divider",
					BackgroundColor3 = Color3.new(1, 1, 1),
					AnchorPoint = Vector2.new(0.5, 1),
					Position = UDim2.fromScale(0.5, 1),
					Size = UDim2.new(1, 0, 0, 1),
					BorderColor3 = Color3.new(1, 1, 1),
					BorderSizePixel = 0
				})
				local separatorGui2 = createInstance("TextLabel", {
					Parent = separatorTemplate,
					BackgroundTransparency = 1,
					AnchorPoint = Vector2.new(0, 0.5),
					AutomaticSize = Enum.AutomaticSize.X,
					Position = UDim2.fromScale(0, 0.5),
					Size = UDim2.fromScale(0, 0.7),
					FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold),
					Text = "\97\87\89\103\101\87\57\49\73\72\78\108\90\83\66\48\97\71\108\122\76\67\66\107\98\50\53\48\73\71\86\52\99\71\120\118\97\88\81\103\89\87\53\53\98\87\57\121\90\83\69\61",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 28,
					RichText = true,
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
				r = math.clamp(r / 255, 0, 1)
				g = math.clamp(g / 255, 0, 1)
				b = math.clamp(b / 255, 0, 1)
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
		},
		executor = {

			highlightLuau = function(code)
				local tokens = {}
				local pos = 1
				local len = #code
				if len > 200000 then
					AddLog("Code overflow, limit is 200000.", "DS Executor", "warn")
					return
				end

				code = code:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")

				while pos <= len do
					local c = code:sub(pos, pos)

					if c == '"' or c == "'" then
						local closing = code:find(c, pos + 1, true) or (len + 1)
						if closing > len then closing = len end
						local str = code:sub(pos, closing)
						table.insert(tokens, string.format("<font color='%s'>%s</font>", "#"..executorConfig.stringColor:ToHex(), str))
						pos = closing + 1
					elseif code:sub(pos, pos+1) == "[[" then
						local closing = code:find("]]", pos+2, true) or len
						local str = code:sub(pos, closing+1)
						table.insert(tokens, string.format("<font color='%s'>%s</font>", "#"..executorConfig.stringColor:ToHex(), str))
						pos = closing + 2
					elseif code:sub(pos, pos+1) == "--" then
						local closing = code:find("", pos+2, true) or (len + 1)
						local com = code:sub(pos, closing-1)
						table.insert(tokens, string.format("<font color='%s'>%s</font>", "#"..executorConfig.commentColor:ToHex(), com))
						pos = closing
					elseif c:match("%d") then
						local num = code:match("%d+%.?%d*[eExXbB]?%-?%d*", pos)
						table.insert(tokens, string.format("<font color='%s'>%s</font>", "#"..executorConfig.numberColor:ToHex(), num))
						pos = pos + #num
					elseif code:match("^[%a_]", pos) then
						local word = code:match("^[%w_]+", pos)
						local afterWord = code:sub(pos + #word, pos + #word)
						local colored = nil
						if afterWord == "(" then
							colored = string.format("<font color='%s'>%s</font>", "#"..executorConfig.funcColor:ToHex(), word)
						end
						if table.find({
							"DockWidgetPluginGuiInfo",
							"rshift",
							"tostring",
							"UDim",
							"frexp",
							"pairs",
							"sqrt",
							"rep",
							"tonumber",
							"concat",
							"load",
							"fromUniversalTime",
							"Path2DControlPoint",
							"SecurityCapabilities",
							"atan",
							"fromHSV",
							"cos",
							"lookAt",
							"fromEulerAnglesXYZ",
							"fromNormalId",
							"log10",
							"extract",
							"bor",
							"dumpcodesize",
							"asin",
							"loadstring",
							"Font",
							"Version",
							"len",
							"fromAxisAngle",
							"spawn",
							"string",
							"setmemorycategory",
							"print",
							"remove",
							"UDim2",
							"upper",
							"cosh",
							"zAxis",
							"random",
							"Vector3",
							"offset",
							"xAxis",
							"Wait",
							"elapsedTime",
							"version",
							"vector",
							"find",
							"ipairs",
							"difftime",
							"fromAxis",
							"Vector3int16",
							"Vector2int16",
							"collectgarbage",
							"game",
							"Faces",
							"isyieldable",
							"stats",
							"Region3",
							"Stats",
							"table",
							"shared",
							"bnot",
							"identity",
							"Secret",
							"settings",
							"fromScale",
							"time",
							"RotationCurveKey",
							"one",
							"Ray",
							"pcall",
							"RaycastParams",
							"band",
							"Random",
							"printidentity",
							"ElapsedTime",
							"replace",
							"Angles",
							"create",
							"fromIsoDate",
							"charpattern",
							"math",
							"fmod",
							"plugin",
							"lshift",
							"OverlapParams",
							"ColorSequenceKeypoint",
							"loadfile",
							"newproxy",
							"log",
							"fromMatrix",
							"FloatCurveKey",
							"graphemes",
							"CFrame",
							"gcinfo",
							"lower",
							"gmatch",
							"resetmemorycategory",
							"DateTime",
							"tick",
							"clock",
							"format",
							"task",
							"getfenv",
							"randomseed",
							"tanh",
							"move",
							"insert",
							"max",
							"getmemorycategory",
							"rawlen",
							"wait",
							"char",
							"profilebegin",
							"Color3",
							"reverse",
							"pow",
							"profileend",
							"Delay",
							"Content",
							"info",
							"debug",
							"fromUnixTimestampMillis",
							"now",
							"fromUnixTimestamp",
							"_G",
							"fromLocalTime",
							"CatalogSearchParams",
							"lookAlong",
							"traceback",
							"UserSettings",
							"tan",
							"buffer",
							"bit32",
							"Brickcolor",
							"clamp",
							"clear",
							"ceil",
							"PhysicalProperties",
							"Instance",
							"nfcnormalize",
							"nfdnormalize",
							"codes",
							"fromRotationBetweenVectors",
							"min",
							"NumberSequenceKeypoint",
							"fromEulerAnglesYXZ",
							"Vector2",
							"fromEulerAngles",
							"Game",
							"delay",
							"fromOrientation",
							"FromAxis",
							"ypcall",
							"xpcall",
							"FromNormalId",
							"date",
							"fromOffset",
							"yAxis",
							"fromRGB",
							"unpack",
							"running",
							"deg",
							"typeof",
							"status",
							"Workspace",
							"require",
							"workspace",
							"TweenInfo",
							"fromHex",
							"setmetatable",
							"next",
							"codepoint",
							"wrap",
							"sin",
							"abs",
							"floor",
							"NumberSequence",
							"clone",
							"assert",
							"byte",
							"btest",
							"getmetatable",
							"Spawn",
							"lrotate",
							"rad",
							"modf",
							"acos",
							"ldexp",
							"ColorSequence",
							"PathWaypoint",
							"match",
							"arshift",
							"exp",
							"sort",
							"pack",
							"atan2",
							"resume",
							"rrotate",
							"new",
							"sub",
							"yield",
							"zero",
							"SharedTable",
							"select",
							"gsub",
							"sinh",
							"rawget",
							"bxor",
							"Rect",
							"rawequal",
							"dofile",
							"rawset",
							"File",
							"error",
							"setfenv",
							}, word) then
							if afterWord == "(" then
								colored = string.format("<font color='%s'>%s</font>", "#"..executorConfig.libColor:ToHex(), word)
							else
								colored = string.format("<font color='%s'>%s</font>", "#"..executorConfig.libColor:ToHex(), word)
							end
						end
						if table.find({
							"hookfunction",
							"isfile",
							"getgenv",
							"makefolder",
							"clonefunction",
							"setrawmetatable",
							"checkcaller",
							"getfenv",
							"hookmetamethod",
							"fireproximityprompt",
							"islclosure",
							"isfolder",
							"saveinstance",
							"crypt",
							"firetouchinterest",
							"appendfile",
							"getrenv",
							"getgc",
							"newcclosure",
							"iscclosure",
							"delfile",
							"readfile",
							"delfolder",
							"getcustomasset",
							"fireclickdetector",
							"cloneref",
							"filtergc",
							"decompile",
							"getfunctionhash",
							"Drawing",
							"getsenv",
							"listfiles",
							"setfenv",
							"isexecutorclosure",
							"writefile",
							"getrawmetatable",
							"loadfile",
							}, word) then
							if afterWord == "(" then
								colored = string.format("<font color='%s'><b>%s</b></font>", "#"..executorConfig.exploitColor:ToHex(), word)
							end
						end
						if table.find(executorConfig.keywords[1], word) then
							colored = string.format("<font color='%s'><b>%s</b></font>","#"..executorConfig.keywordColor:ToHex(), word)
						end
						if table.find(executorConfig.bools[1], word) then
							colored = string.format("<font color='%s'><b>%s</b></font>","#"..executorConfig.boolsColor:ToHex(), word)
						end

						table.insert(tokens, colored or word)
						pos = pos + #word
					elseif code:match("^function%s+[%w_]+%s*%b()", pos) then
						local full = code:match("^(function%s+[%w_]+%s*%b()[:%s%w_]*)", pos)
						local funcName, args, returnType = full:match("^function%s+([%w_]+)%s*%((.*)%)%s*:?%s*([%w_]*)")

						local highlightedArgs = args:gsub("([%w_]+)%s*:%s*([%w_]+)", function(argName, argType)
							return string.format(
								"<font color='%s'>%s</font><font color='%s'>: %s</font>",
								"#" .. executorConfig.textColor:ToHex(),
								argName,
								"#" .. executorConfig.libColor:ToHex(),
								argType
							)
						end)

						local result = string.format(
							"<font color='%s'><b>function</b></font> <font color='%s'>%s</font>(%s)",
							"#" .. executorConfig.keywordColor:ToHex(),
							"#" .. executorConfig.funcColor:ToHex(),
							funcName,
							highlightedArgs
						)

						if returnType and #returnType > 0 then
							result ..= string.format("<font color='%s'>: %s</font>",
								"#" .. executorConfig.libColor:ToHex(),
								returnType
							)
						end
						table.insert(tokens, result)
						pos = pos + #full
					elseif code:match("^Enum%.[%w_]+%.[%w_]+", pos) then
						local enum, category, value = code:match("^(Enum)%.([%w_]+)%.([%w_]+)", pos)
						if enum and category and value then
							local result = string.format(
								"<font color='%s'>%s</font>.<font color='%s'>%s</font>.<font color='%s'>%s</font>",
								"#" .. executorConfig.libColor:ToHex(), enum,
								"#" .. executorConfig.libColor:ToHex(), category,
								"#" .. executorConfig.propColor:ToHex(), value
							)
							table.insert(tokens, result)
							pos = pos + #("Enum." .. category .. "." .. value)
						else
							table.insert(tokens, c)
						end
					else
						table.insert(tokens, c)
						pos = pos + 1
					end
				end

				return table.concat(tokens)
			end,
			highlightJSON = function(json)

			end,
			runScript = function(codeToExecute)
				local executed, err = pcall(function()
					loadstring(codeToExecute)()
				end)
				if not executed then
					AddLog("game.ReplicatedStorage._DeepScopeCode.Core.Executor:3841: "..err, "DeepScope", "error")
				end
			end,
			downloadFile = function()
				local fileName = "DeepScopeCode"..os.time()..".txt"
				local source = code
				writefile(fileName, source)
			end,
			Update = function(code, label, linesGui)
				local lines = getLineAmount(code)
				local padding = 15
				local size = linesGui.TextBounds.X + padding
				local liveTween = nil
				linesGui.Text = lines
				linesGui.Size = UDim2.fromOffset(size, 1e6)
				linesGui.Parent.Size = UDim2.new(0, size, 1, -30)
				label.Parent.Position = UDim2.fromOffset(size, 0)
				label.Parent.Size = UDim2.new(1, -size, 1, -30)
				label.Parent:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
					local y = label.Parent.CanvasPosition.Y
					linesGui.Position = UDim2.fromOffset(0, -y)
				end)
				label:GetPropertyChangedSignal("CursorPosition"):Connect(function()
					local x = label.CursorPosition
					if x ~= -1 then
						local cutText = label.Text:sub(1, x - 1)
						local pos = TextService:GetTextSize(label.Text, 15, label.Font, Vector2.new())
						label.cursor.Position = UDim2.fromOffset(pos.X, pos.Y)
						label.cursor.Visible = true
					else
						liveTween = nil
						label.cursor.Visible = false
					end
				end)
				if not liveTween then
					label.cursor.BackgroundTransparency = 0
					liveTween = TweenService:Create(label.cursor, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true), {
						BackgroundTransparency = 1
					}):Play()
				end
			end,
		}
	}
}
coreModules.Lib = {}
coreModules.Lib.Settings = {}
coreModules.Lib.AdvancedFormat = game:HttpGet("https://raw.githubusercontent.com/topalyh/AdvancedFormat-Module/refs/heads/main/Sourse%20code.lua")
coreModules.Lib.Window = {}
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if isDied then return end
	if input.KeyCode == modules.other.fly.DefaultKey then
		Enabled = not Enabled
		modules.other.fly.UpdateFlying(Enabled)
	end
	modules.other.fly.UpdateMoveDirection(processed)
end)
function coreModules.Lib:FetchRMD()
	local parsed = HttpService:JSONDecode(readfile("DeepScopeCore/Explorer/RMD.dat"))
	local classList = parsed.children[1].children[1].children
	local enumList = parsed.children[1].children[2].children
	local propertyOrders = {}

	local classes,enums = {},{}
	for _,class in pairs(classList) do
		local className = ""
		for _,child in pairs(class.children) do
			if child.tag == "Properties" then
				local data = {Properties = {}, Functions = {}}
				local props = child.children
				for _,prop in pairs(props) do
					local name = prop.attrs.name
					name = name:sub(1,1):upper()..name:sub(2)
					data[name] = prop.children[1].text
				end
				className = data.Name
				classes[className] = data
			elseif child.attrs.class == "ReflectionMetadataProperties" then
				local members = child.children
				for _,member in pairs(members) do
					if member.attrs.class == "ReflectionMetadataMember" then
						local data = {}
						if member.children[1].tag == "Properties" then
							local props = member.children[1].children
							for _,prop in pairs(props) do
								if prop.attrs then
									local name = prop.attrs.name
									name = name:sub(1,1):upper()..name:sub(2)
									data[name] = prop.children[1].text
								end
							end
							if data.PropertyOrder then
								local orders = propertyOrders[className]
								if not orders then orders = {} propertyOrders[className] = orders end
								orders[data.Name] = tonumber(data.PropertyOrder)
							end
							classes[className].Properties[data.Name] = data
						end
					end
				end
			elseif child.attrs.class == "ReflectionMetadataFunctions" then
				local members = child.children
				for _,member in pairs(members) do
					if member.attrs.class == "ReflectionMetadataMember" then
						local data = {}
						if member.children[1].tag == "Properties" then
							local props = member.children[1].children
							for _,prop in pairs(props) do
								if prop.attrs then
									local name = prop.attrs.name
									name = name:sub(1,1):upper()..name:sub(2)
									data[name] = prop.children[1].text
								end
							end
							classes[className].Functions[data.Name] = data
						end
					end
				end
			end
		end
	end

	for _,enum in pairs(enumList) do
		local enumName = ""
		for _,child in pairs(enum.children) do
			if child.tag == "Properties" then
				local data = {Items = {}}
				local props = child.children
				for _,prop in pairs(props) do
					local name = prop.attrs.name
					name = name:sub(1,1):upper()..name:sub(2)
					data[name] = prop.children[1].text
				end
				enumName = data.Name
				enums[enumName] = data
			elseif child.attrs.class == "ReflectionMetadataEnumItem" then
				local data = {}
				if child.children[1].tag == "Properties" then
					local props = child.children[1].children
					for _,prop in pairs(props) do
						local name = prop.attrs.name
						name = name:sub(1,1):upper()..name:sub(2)
						data[name] = prop.children[1].text
					end
					enums[enumName].Items[data.Name] = data
				end
			end
		end
	end
	return {Classes = classes, Enums = enums, PropertyOrders = propertyOrders}
end
function coreModules.Lib:FetchAPI()
	local api = game:HttpGet(("http://setup.roblox.com/%s-API-Dump.json"):format(game:HttpGet("http://setup.roblox.com/versionQTStudio")))

	local classes,enums = {},{}
	local categoryOrder,seenCategories = {},{}

	local function insertAbove(t,item,aboveItem)
		local findPos = table.find(t,item)
		if not findPos then return end
		table.remove(t,findPos)

		local pos = table.find(t,aboveItem)
		if not pos then return end
		table.insert(t,pos,item)
	end

	for _,class in pairs(api.Classes) do
		local newClass = {}
		newClass.Name = class.Name
		newClass.Superclass = class.Superclass
		newClass.Properties = {}
		newClass.Functions = {}
		newClass.Events = {}
		newClass.Callbacks = {}
		newClass.Tags = {}

		if class.Tags then for c,tag in pairs(class.Tags) do newClass.Tags[tag] = true end end
		for __,member in pairs(class.Members) do
			local newMember = {}
			newMember.Name = member.Name
			newMember.Class = class.Name
			newMember.Security = member.Security
			newMember.Tags ={}
			if member.Tags then for c,tag in pairs(member.Tags) do newMember.Tags[tag] = true end end

			local mType = member.MemberType
			if mType == "Property" then
				local propCategory = member.Category or "Other"
				propCategory = propCategory:match("^%s*(.-)%s*$")
				if not seenCategories[propCategory] then
					categoryOrder[#categoryOrder+1] = propCategory
					seenCategories[propCategory] = true
				end
				newMember.ValueType = member.ValueType
				newMember.Category = propCategory
				newMember.Serialization = member.Serialization
				table.insert(newClass.Properties,newMember)
			elseif mType == "Function" then
				newMember.Parameters = {}
				newMember.ReturnType = member.ReturnType.Name
				for c,param in pairs(member.Parameters) do
					table.insert(newMember.Parameters,{Name = param.Name, Type = param.Type.Name})
				end
				table.insert(newClass.Functions,newMember)
			elseif mType == "Event" then
				newMember.Parameters = {}
				for c,param in pairs(member.Parameters) do
					table.insert(newMember.Parameters,{Name = param.Name, Type = param.Type.Name})
				end
				table.insert(newClass.Events,newMember)
			end
		end

		classes[class.Name] = newClass
	end

	for _,class in pairs(classes) do
		class.Superclass = classes[class.Superclass]
	end

	for _,enum in pairs(api.Enums) do
		local newEnum = {}
		newEnum.Name = enum.Name
		newEnum.Items = {}
		newEnum.Tags = {}

		if enum.Tags then for c,tag in pairs(enum.Tags) do newEnum.Tags[tag] = true end end
		for __,item in pairs(enum.Items) do
			local newItem = {}
			newItem.Name = item.Name
			newItem.Value = item.Value
			table.insert(newEnum.Items,newItem)
		end

		enums[enum.Name] = newEnum
	end

	local function getMember(class,member)
		if not classes[class] or not classes[class][member] then return end
		local result = {}

		local currentClass = classes[class]
		while currentClass do
			for _,entry in pairs(currentClass[member]) do
				result[#result+1] = entry
			end
			currentClass = currentClass.Superclass
		end

		table.sort(result,function(a,b) return a.Name < b.Name end)
		return result
	end

	insertAbove(categoryOrder,"Behavior","Tuning")
	insertAbove(categoryOrder,"Appearance","Data")
	insertAbove(categoryOrder,"Attachments","Axes")
	insertAbove(categoryOrder,"Cylinder","Slider")
	insertAbove(categoryOrder,"Localization","Jump Settings")
	insertAbove(categoryOrder,"Surface","Motion")
	insertAbove(categoryOrder,"Surface Inputs","Surface")
	insertAbove(categoryOrder,"Part","Surface Inputs")
	insertAbove(categoryOrder,"Assembly","Surface Inputs")
	insertAbove(categoryOrder,"Character","Controls")
	categoryOrder[#categoryOrder+1] = "Unscriptable"
	categoryOrder[#categoryOrder+1] = "Attributes"

	local categoryOrderMap = {}
	for i = 1,#categoryOrder do
		categoryOrderMap[categoryOrder[i]] = i
	end
	return {
		Classes = classes,
		Enums = enums,
		CategoryOrder = categoryOrderMap,
		GetMember = getMember
	}
end
UserInputService.InputEnded:Connect(function(processed)
	if not isDied then
		modules.other.fly.UpdateMoveDirection(processed)
	end
end)
RunService.RenderStepped:Connect(function(dt)
	modules.other.fly.Loop(dt)
end)
local function createGui()
	local gui1 = createInstance("ScreenGui", {
		DisplayOrder = 2147483647,
		Name = "cheatGui",
		Parent = cloneref(game:GetService("CoreGui")),
		IgnoreGuiInset = true,
		ResetOnSpawn = false
	})
	local gui2 = createInstance("Frame", {
		Parent = gui1,
		Name = "main",
		AnchorPoint = Vector2.new(0.2, 0),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.1, 0),
		Size = UDim2.new(0.9, 0, 0.15, 0),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0
	})
	local gui3 = createInstance("TextButton", {
		Parent = gui2,
		Name = "mode",
		Position = UDim2.new(0.479, 0, -0.35, 0),
		Size = UDim2.new(0.206, 0, 0.572, 0),
		Text = "mode: follow",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true
	})
	local gui4 = createInstance("TextButton", {
		Parent = gui2,
		Name = "startbutton",
		Position = UDim2.new(0.364, 0, -0.332, 0),
		Size = UDim2.new(0.101, 0, 0.572, 0),
		Text = "start",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true
	})
	local gui5 = createInstance("ScrollingFrame", {
		Parent = gui2,
		Name = "list",
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
	local ui_object1 = createInstance("UIListLayout", {
		Parent = gui5,
		Padding = UDim.new(0, 5),
		HorizontalAlignment = Enum.HorizontalAlignment.Center
	})
	local gui7 = createInstance("TextLabel", {
		Parent = gui2,
		Name = "label",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.065, 0, -0.206, 0),
		Size = UDim2.new(0.13, 0, 0.257, 0),
		Text = "select player",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true
	})
	local gui8 = createInstance("TextLabel", {
		Parent = gui2,
		Name = "currentplr",
		Position = UDim2.new(0.141, 0, -0.343, 0),
		Size = UDim2.new(0.212, 0, 0.257, 0),
		Text = "selectedPlayer: nobody",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextScaled = true
	})
	local gui9 = createInstance("TextBox", {
		Parent = gui2,
		Name = "searchPlayer",
		Position = UDim2.new(0.141, 0, -0.023),
		Size = UDim2.new(0.212, 0, 0.257, 0),
		Text = "",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true,
		PlaceholderText = "search player (username)"
	})
	local gui10 = createInstance("TextLabel", {
		Parent = gui2,
		Name = "distance",
		Position = UDim2.new(0.141, 0, 0.309, 0),
		Size = UDim2.new(0, 0, 0.257, 0),
		Text = "distance from character: unknown",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextScaled = true,
		AutomaticSize = Enum.AutomaticSize.X
	})
	local gui11 = createInstance("TextLabel", {
		Parent = gui2,
		Name = "spawndistance",
		Position = UDim2.new(0.141, 0, 0.64, 0),
		Size = UDim2.new(0, 0, 0.257, 0),
		Text = "distance from spawn: unknown",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextScaled = true,
		AutomaticSize = Enum.AutomaticSize.X
	})
	local gui12 = createInstance("TextLabel", {
		Parent = gui2,
		Name = "currentspeed",
		Position = UDim2.new(0.141, 0, 0.972, 0),
		Size = UDim2.new(0, 0, 0.257, 0),
		Text = "current speed: unknown | 0:0",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextScaled = true,
		AutomaticSize = Enum.AutomaticSize.X
	})
	local gui14 = createInstance("TextButton", {
		Parent = gui2,
		Name = "unitformat",
		Size = UDim2.new(0.138, 0, 0.252, 0),
		Position = UDim2.new(0.003, 0, 1.326, 0),
		Text = "format: M",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true
	})
	local gui15 = createInstance("TextButton", {
		Parent = gui2,
		Name = "hidebutton",
		Size = UDim2.new(0.054, 0, 0.389, 0),
		Position = UDim2.new(0.694, 0, -0.544, 0),
		Text = "hide",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true
	})
	local gui16 = createInstance("TextButton", {
		Parent = gui2,
		Name = "explorer",
		Size = UDim2.new(0.138, 0, 0.343, 0),
		Position = UDim2.new(0.003, 0, 1.658, 0),
		Text = "open explorer",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true,
		Visible = true
	})
	local gui16 = createInstance("TextButton", {
		Parent = gui2,
		Name = "settings",
		Size = UDim2.new(0.181, 0, 0.194, 0),
		Position = UDim2.new(0.502, 0, -0.555, 0),
		Text = "settings",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true
	})
	local gui17 = createInstance("TextButton", {
		Parent = gui2,
		Name = "placeinfo",
		Size = UDim2.new(0.181, 0, 0.194, 0),
		Position = UDim2.new(0.32, 0, -0.555, 0),
		Text = "place info",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true
	})
	local gui18 = createInstance("TextButton", {
		Parent = gui2,
		Name = "logs",
		Size = UDim2.new(0.181, 0, 0.194, 0),
		Position = UDim2.new(0.129, 0, -0.555, 0),
		Text = "open logs",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextScaled = true
	})
	local gui_obj_2 = createInstance("UIPadding", {
		Parent = gui10,
		PaddingBottom = UDim.new(0, 5),
		PaddingLeft = UDim.new(0, 5),
		PaddingRight = UDim.new(0, 5),
		PaddingTop = UDim.new(0, 5),
	})
	local gui_obj_3 = createInstance("UIPadding", {
		Parent = gui11,
		PaddingBottom = UDim.new(0, 5),
		PaddingLeft = UDim.new(0, 5),
		PaddingRight = UDim.new(0, 5),
		PaddingTop = UDim.new(0, 5),
	})
	local gui_obj_4 = createInstance("UIPadding", {
		Parent = gui12,
		PaddingBottom = UDim.new(0, 5),
		PaddingLeft = UDim.new(0, 5),
		PaddingRight = UDim.new(0, 5),
		PaddingTop = UDim.new(0, 5),
	})
	local gui_obj_6 = createInstance("UISizeConstraint", {
		Parent = gui10,
		MaxSize = Vector2.new(590, 1e308)
	})
	local gui_obj_7 = createInstance("UISizeConstraint", {
		Parent = gui11,
		MaxSize = Vector2.new(590, 1e308)
	})
	local gui_obj_8 = createInstance("UISizeConstraint", {
		Parent = gui12,
		MaxSize = Vector2.new(590, 1e308)
	})

	local explorerGui1 = createInstance("Frame", {
		Parent = gui1,
		Name = "explorer",
		BackgroundColor3 = Color3.fromRGB(102, 101, 103),
		Position = UDim2.fromOffset(0, 88),
		Size = UDim2.fromOffset(400, CurrentCamera.ViewportSize.Y-1),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Visible = false
	})
	local explorerGui2 = createInstance("ScrollingFrame", {
		Parent = explorerGui1,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		AutomaticCanvasSize = Enum.AutomaticSize.XY,
		BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
		ScrollBarImageColor3 = Color3.new(),
		CanvasSize = UDim2.fromScale(0, 0),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
	})
	local explorerGui3 = createInstance("UIListLayout", {Parent = explorerGui2, SortOrder = Enum.SortOrder.LayoutOrder})
	local explorerGui4 = createInstance("TextButton", {
		Parent = explorerGui1,
		Name = "dragbutton",
		BackgroundColor3 = Color3.fromRGB(102, 101, 103),
		AnchorPoint = Vector2.new(0, 1),
		Size = UDim2.new(1, 0, 0, 30),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = "explorer",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 20,
		FontFace = Font.new(fonts.FiraSans),
		AutoButtonColor = false,
		ClipsDescendants = true
	})
	local explorerGui5 = createInstance("Frame", {
		Parent = explorerGui4,
		Name = "outline",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.fromScale(1, 2),
	})
	local explorerGui6 = createInstance("TextButton", {
		Parent = explorerGui1,
		Name = "resizebottom",
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, -2, 0, 7),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = "",
		AutoButtonColor = false
	})
	local explorerGui7 = createInstance("TextButton", {
		Parent = explorerGui1,
		Name = "resizeside",
		BackgroundTransparency = 1,
		Position = UDim2.new(1, 0, 0, -30),
		Size = UDim2.new(0, 7, 1, 28),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = "",
		AutoButtonColor = false
	})
	local explorerGui8 = createInstance("TextButton", {
		Parent = explorerGui4,
		Name = "fullclose",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -5, 0, 5),
		Size = UDim2.fromOffset(20, 20),
		Text = ""
	})
	local explorerGui9 = createInstance("UIStroke", {
		Parent = explorerGui8,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.new(1, 1, 1),
		LineJoinMode = Enum.LineJoinMode.Miter
	})
	local explorerGui10 = createInstance("ImageLabel", {
		Parent = explorerGui8,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = "rbxassetid://74120900238837"
	})
	local explorerGui11 = createInstance("TextButton", {
		Parent = explorerGui4,
		Name = "close",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -30, 0, 5),
		Size = UDim2.fromOffset(20, 20),
		Text = ""
	})
	local explorerGui12 = createInstance("UIStroke", {
		Parent = explorerGui11,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.new(1, 1, 1),
		LineJoinMode = Enum.LineJoinMode.Miter
	})
	local explorerGui13 = createInstance("ImageLabel", {
		Parent = explorerGui11,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = "rbxassetid://15396333997"
	})
	local explorerGui14 = createInstance("TextButton", {
		Parent = explorerGui1,
		Name = "resizeboth",
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(1, 1),
		Size = UDim2.fromOffset(7, 7),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = "",
		AutoButtonColor = false
	})
	explorerGui11:SetAttribute("ClosedImage", "rbxassetid://12072054746")
	explorerGui11:SetAttribute("OpenedImage", "rbxassetid://15396333997")

	local pickerGui1 = createInstance("Frame", {
		Parent = gui1,
		Name = "colorpicker",
		BackgroundColor3 = Color3.fromRGB(88, 87, 89),
		Position = UDim2.fromOffset(0, 88),
		Size = UDim2.fromOffset(220, 420),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Visible = false
	})
	local pickerGui2 = createInstance("UIScale", {Parent = pickerGui1})
	local pickerGui3 = createInstance("Frame", {
		Parent = pickerGui1,
		Name = "middlebar",
		BackgroundColor3 = Color3.fromRGB(102, 101, 103),
		Position = UDim2.fromOffset(0, 170),
		Size = UDim2.fromOffset(220, 30),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui4 = createInstance("Frame", {
		Parent = pickerGui3,
		Name = "divider",
		BackgroundColor3 = Color3.new(1, 1, 1),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(0, 1, 1, 0),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui5 = createInstance("Frame", {
		Parent = pickerGui3,
		Name = "result",
		BackgroundColor3 = Color3.fromRGB(88, 87, 89),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -5, 0, 2),
		Size = UDim2.fromOffset(100, 26),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui6 = createInstance("Frame", {
		Parent = pickerGui5,
		Name = "color",
		BackgroundColor3 = Color3.new(1, 0, 0),
		Position = UDim2.fromOffset(3, 2),
		Size = UDim2.fromOffset(94, 22),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui7 = createInstance("TextButton", {
		Parent = pickerGui5,
		Name = "color_switch",
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.52, 0.077),
		Size = UDim2.fromOffset(44, 22),
		ClipsDescendants = true,
		Text = "",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Visible = false
	})
	pickerGui7:SetAttribute("HSVPos", 0)
	pickerGui7:SetAttribute("RGBPos", -27)
	local pickerGui8 = createInstance("Frame", {
		Parent = pickerGui7,
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(44, 49),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui9 = createInstance("TextLabel", {
		Parent = pickerGui8,
		Name = "hsv",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(44, 22),
		FontFace = Font.new(fonts.FiraSans),
		Text = "HSV",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 21,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui10 = createInstance("TextLabel", {
		Parent = pickerGui8,
		Name = "rgb",
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, 27),
		Size = UDim2.fromOffset(44, 22),
		FontFace = Font.new(fonts.FiraSans),
		Text = "RGB",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 21,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui11 = createInstance("TextLabel", {
		Parent = pickerGui3,
		Name = "hex",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(95, 30),
		FontFace = Font.new(fonts.FiraSans),
		Text = "hex:",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Left,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui12 = createInstance("UIPadding", {Parent = pickerGui11,PaddingLeft = UDim.new(0, 5)})
	local pickerGui13 = createInstance("TextBox", {
		Parent = pickerGui11,
		BackgroundTransparency = 1,
		ClearTextOnFocus = false,
		Position = UDim2.fromScale(0.286, 0),
		Size = UDim2.fromOffset(64, 30),
		FontFace = Font.new(fonts.FiraSans),
		Text = "#ff0000",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 22,
		TextXAlignment = Enum.TextXAlignment.Left,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui14 = createInstance("UIPadding", {Parent = pickerGui13,PaddingLeft = UDim.new(0, 5)})
	local pickerGui15 = createInstance("Frame", {
		Parent = pickerGui1,
		Name = "options",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -5, 0, 15),
		Size = UDim2.fromOffset(25, 150),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui16 = createInstance("Frame", {
		Parent = pickerGui15,
		Name = "modes",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(25, 60),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui17 = createInstance("Frame", {
		Parent = pickerGui16,
		Name = "circle",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 16),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui18 = createInstance("Frame", {
		Parent = pickerGui17,
		Name = "selected",
		BackgroundColor3 = Color3.fromRGB(52, 52, 52),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(24, 24),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui19 = createInstance("UICorner", {
		Parent = pickerGui18,
		CornerRadius = UDim.new(0.5, 0)
	})
	local pickerGui20 = createInstance("TextButton", {
		Parent = pickerGui17,
		Name = "button",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui21 = createInstance("ImageLabel", {
		Parent = pickerGui17,
		Name = "icon",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(16, 16),
		Image = "rbxassetid://91460273345882",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui22 = createInstance("Frame", {
		Parent = pickerGui16,
		Name = "square",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.new(1, 0, 0, 16),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui23 = createInstance("Frame", {
		Parent = pickerGui22,
		Name = "selected",
		BackgroundColor3 = Color3.fromRGB(52, 52, 52),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(24, 24),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Visible = false
	})
	local pickerGui24 = createInstance("UICorner", {
		Parent = pickerGui23,
		CornerRadius = UDim.new(0, 6)
	})
	local pickerGui25 = createInstance("TextButton", {
		Parent = pickerGui22,
		Name = "button",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui26 = createInstance("ImageLabel", {
		Parent = pickerGui22,
		Name = "icon",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(16, 16),
		Image = "rbxassetid://81707513428574",
		ImageTransparency = 0.5,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui27 = createInstance("Frame", {
		Parent = pickerGui16,
		Name = "triangle",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, 0, 0, 16),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui28 = createInstance("ImageLabel", {
		Parent = pickerGui27,
		Name = "selected",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(26, 26),
		Image = "rbxassetid://90218356450094",
		ImageColor3 = Color3.fromRGB(52, 52, 52),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Visible = false
	})
	local pickerGui29 = createInstance("TextButton", {
		Parent = pickerGui27,
		Name = "button",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui30 = createInstance("ImageLabel", {
		Parent = pickerGui27,
		Name = "icon",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(16, 16),
		Image = "rbxassetid://114667886210601",
		ImageTransparency = 0.5,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui31 = createInstance("Frame", {
		Parent = pickerGui1,
		Name = "picker",
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(35, 15),
		Size = UDim2.fromOffset(150, 150),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui32 = createInstance("Frame", {
		Parent = pickerGui31,
		Name = "square",
		BackgroundColor3 = Color3.new(1, 0, 0),
		Size = UDim2.fromScale(1, 1),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Visible = false
	})
	local pickerGui33 = createInstance("Frame", {
		Parent = pickerGui32,
		Name = "blackgradient",
		BackgroundColor3 = Color3.new(),
		Size = UDim2.fromScale(1, 1),
		ZIndex = 3,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui34 = createInstance("UIGradient", {
		Parent = pickerGui33,
		Rotation = -90,
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(1, 1)
		})
	})
	local pickerGui35 = createInstance("Frame", {
		Parent = pickerGui32,
		Name = "whitegradient",
		BackgroundColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromScale(1, 1),
		ZIndex = 2,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui36 = createInstance("UIGradient", {
		Parent = pickerGui35,
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(1, 1)
		})
	})
	local pickerGui37 = createInstance("TextButton", {
		Parent = pickerGui31,
		Name = "activateregion",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui38 = createInstance("ImageLabel", {
		Parent = pickerGui31,
		Name = "circle",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = "rbxassetid://2849458409",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui39 = createInstance("ImageLabel", {
		Parent = pickerGui31,
		Name = "pointer",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(30, 30),
		Image = "rbxassetid://133734996035045",
		ZIndex = 4,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui40 = createInstance("ImageLabel", {
		Parent = pickerGui31,
		Name = "triangle",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = "rbxassetid://119614645478849",
		ImageColor3 = Color3.new(1, 0, 0),
		Visible = false,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui41 = createInstance("ImageLabel", {
		Parent = pickerGui40,
		Name = "black",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = "rbxassetid://90395096352510",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		ZIndex = 2
	})
	local pickerGui42 = createInstance("ImageLabel", {
		Parent = pickerGui40,
		Name = "white",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = "rbxassetid://114393129271758",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui43 = createInstance("Frame", {
		Parent = pickerGui1,
		Name = "sliders",
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, 220),
		Size = UDim2.fromOffset(200, 211),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui44 = createInstance("UIListLayout", {
		Parent = pickerGui43,
		Padding = UDim.new(0, 25),
		SortOrder = Enum.SortOrder.LayoutOrder
	})
	local pickerGui45 = createInstance("Frame", {
		Parent = pickerGui43,
		Name = "hue",
		BackgroundColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromOffset(170, 10),
		LayoutOrder = 1,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui46 = createInstance("UIGradient", {
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
	local pickerGui47 = createInstance("Frame", {
		Parent = pickerGui45,
		Name = "pointer",
		BackgroundColor3 = Color3.new(),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.fromOffset(3, 20),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui48 = createInstance("TextButton", {
		Parent = pickerGui45,
		Name = "activateregion",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui49 = createInstance("TextBox", {
		Parent = pickerGui45,
		Name = "value",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(1, 0.5),
		Size = UDim2.fromOffset(30, 20),
		FontFace = Font.new(fonts.FiraSans),
		Text = "100",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 18,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui50 = createInstance("Frame", {
		Parent = pickerGui43,
		Name = "saturation",
		BackgroundColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromOffset(170, 10),
		LayoutOrder = 2,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui51 = createInstance("UIGradient", {
		Parent = pickerGui50,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
			ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))
		})
	})
	local pickerGui52 = createInstance("Frame", {
		Parent = pickerGui50,
		Name = "pointer",
		BackgroundColor3 = Color3.new(),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.fromOffset(3, 20),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui53 = createInstance("TextButton", {
		Parent = pickerGui50,
		Name = "activateregion",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui54 = createInstance("TextBox", {
		Parent = pickerGui50,
		Name = "value",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(1, 0.5),
		Size = UDim2.fromOffset(30, 20),
		FontFace = Font.new(fonts.FiraSans),
		Text = "100",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 18,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui55 = createInstance("Frame", {
		Parent = pickerGui43,
		Name = "value",
		BackgroundColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromOffset(170, 10),
		LayoutOrder = 3,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui56 = createInstance("UIGradient", {
		Parent = pickerGui55,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new()),
			ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))
		})
	})
	local pickerGui57 = createInstance("Frame", {
		Parent = pickerGui55,
		Name = "pointer",
		BackgroundColor3 = Color3.new(),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.fromOffset(3, 20),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui58 = createInstance("TextButton", {
		Parent = pickerGui55,
		Name = "activateregion",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui59 = createInstance("TextBox", {
		Parent = pickerGui55,
		Name = "value",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(1, 0.5),
		Size = UDim2.fromOffset(30, 20),
		FontFace = Font.new(fonts.FiraSans),
		Text = "100",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 18,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui60 = createInstance("Frame", {
		Parent = pickerGui43,
		Name = "R",
		BackgroundColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromOffset(170, 10),
		LayoutOrder = 4,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui61 = createInstance("UIGradient", {
		Parent = pickerGui60,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new()),
			ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))
		})
	})
	local pickerGui62 = createInstance("Frame", {
		Parent = pickerGui60,
		Name = "pointer",
		BackgroundColor3 = Color3.new(),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.fromOffset(3, 20),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui63 = createInstance("TextButton", {
		Parent = pickerGui60,
		Name = "activateregion",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui64 = createInstance("TextBox", {
		Parent = pickerGui60,
		Name = "value",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(1, 0.5),
		Size = UDim2.fromOffset(30, 20),
		FontFace = Font.new(fonts.FiraSans),
		Text = "100",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 18,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui65 = createInstance("Frame", {
		Parent = pickerGui43,
		Name = "G",
		BackgroundColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromOffset(170, 10),
		LayoutOrder = 5,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui66 = createInstance("UIGradient", {
		Parent = pickerGui65,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new()),
			ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))
		})
	})
	local pickerGui67 = createInstance("Frame", {
		Parent = pickerGui65,
		Name = "pointer",
		BackgroundColor3 = Color3.new(),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.fromOffset(3, 20),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui68 = createInstance("TextButton", {
		Parent = pickerGui65,
		Name = "activateregion",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui69 = createInstance("TextBox", {
		Parent = pickerGui65,
		Name = "value",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(1, 0.5),
		Size = UDim2.fromOffset(30, 20),
		FontFace = Font.new(fonts.FiraSans),
		Text = "100",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 18,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui70 = createInstance("Frame", {
		Parent = pickerGui43,
		Name = "B",
		BackgroundColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromOffset(170, 10),
		LayoutOrder = 6,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui71 = createInstance("UIGradient", {
		Parent = pickerGui70,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new()),
			ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))
		})
	})
	local pickerGui72 = createInstance("Frame", {
		Parent = pickerGui70,
		Name = "pointer",
		BackgroundColor3 = Color3.new(),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.fromOffset(3, 20),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui73 = createInstance("TextButton", {
		Parent = pickerGui70,
		Name = "activateregion",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui74 = createInstance("TextBox", {
		Parent = pickerGui70,
		Name = "value",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(1, 0.5),
		Size = UDim2.fromOffset(30, 20),
		FontFace = Font.new(fonts.FiraSans),
		Text = "100",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 18,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui75 = createInstance("ImageButton", {
		Parent = pickerGui1,
		Name = "resize",
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(209, 309),
		Size = UDim2.fromOffset(44, 44),
		Image = "rbxassetid://10928806245",
		ImageTransparency = 1,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(0, 0, 512, 512),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui76 = createInstance("TextButton", {
		Parent = pickerGui1,
		Name = "dragbutton",
		BackgroundColor3 = Color3.fromRGB(102, 101, 103),
		AnchorPoint = Vector2.new(0, 1),
		Size = UDim2.new(1, 0, 0, 30),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = "color picker",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 20,
		FontFace = Font.new(fonts.FiraSans),
		AutoButtonColor = false,
		ClipsDescendants = true,
	})
	local pickerGui77 = createInstance("TextButton", {
		Parent = pickerGui76,
		Name = "fullclose",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -5, 0, 5),
		Size = UDim2.fromOffset(20, 20),
		Text = "",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui78 = createInstance("UIStroke", {
		Parent = pickerGui77,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.new(1, 1, 1),
		LineJoinMode = Enum.LineJoinMode.Miter
	})
	local pickerGui79 = createInstance("ImageLabel", {
		Parent = pickerGui77,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = "rbxassetid://74120900238837",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui80 = createInstance("TextButton", {
		Parent = pickerGui76,
		Name = "close",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -30, 0, 5),
		Size = UDim2.fromOffset(20, 20),
		Text = "",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui81 = createInstance("UIStroke", {
		Parent = pickerGui80,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.new(1, 1, 1),
		LineJoinMode = Enum.LineJoinMode.Miter
	})
	local pickerGui82 = createInstance("ImageLabel", {
		Parent = pickerGui80,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = "rbxassetid://15396333997",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local pickerGui83 = createInstance("ImageButton", {
		Parent = pickerGui15,
		Name = "close",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(25, 25),
		Position = UDim2.fromScale(0, 0.473),
		Image = "rbxassetid://3192543734",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local notifyGui1 = createInstance("Frame", {
		Parent = gui1,
		Name = "notification",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 1),
		Size = UDim2.new(0, 200, 1, -20),
		Position = UDim2.new(1, -10, 1, -10),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local notifyGui2 = createInstance("UIListLayout", {
		Parent = notifyGui1,
		Padding = UDim.new(0, 5),
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
		VerticalAlignment = Enum.VerticalAlignment.Bottom
	})
	local placeInfoGui1 = createInstance("Frame", {
		Parent = gui1,
		Name = "placeinfo",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(88, 87, 89),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.4, 0.4),
		Visible = false,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0
	})
	local placeInfoGui2 = createInstance("UIAspectRatioConstraint", {
		Parent = placeInfoGui1,
		AspectRatio = 1.215
	})
	local placeInfoGui3 = createInstance("UIStroke", {
		Parent = placeInfoGui1,
		Color = Color3.fromRGB(163, 162, 165),
		LineJoinMode = Enum.LineJoinMode.Miter,
		Thickness = 5
	})
	local placeInfoGui4 = createInstance("ScrollingFrame", {
		Parent = placeInfoGui1,
		Name = "list",
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, 10),
		Size = UDim2.new(1, -20, 1, -20),
		CanvasSize = UDim2.fromScale(0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
	})
	local placeInfoGui5 = createInstance("UIListLayout", {
		Parent = placeInfoGui4,
		Padding = UDim.new(0, 2),
		SortOrder = Enum.SortOrder.LayoutOrder
	})
	local placeInfoGui6 = createInstance("TextButton", {
		Parent = gui1,
		Name = "closeregion",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = "",
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
	local logGui4 = createInstance("TextButton", {
		Parent = logGui1,
		Name = "dragbutton",
		BackgroundColor3 = Color3.fromRGB(102, 101, 103),
		AnchorPoint = Vector2.new(0, 1),
		Size = UDim2.new(1, 0, 0, 30),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = "logs.txt",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 20,
		FontFace = Font.new(fonts.FiraSans),
		AutoButtonColor = false,
		ClipsDescendants = true,
	})
	local logGui5 = createInstance("TextButton", {
		Parent = logGui4,
		Name = "fullclose",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -5, 0, 5),
		Size = UDim2.fromOffset(20, 20),
		Text = "",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local logGui6 = createInstance("UIStroke", {
		Parent = logGui5,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.new(1, 1, 1),
		LineJoinMode = Enum.LineJoinMode.Miter
	})
	local logGui7 = createInstance("ImageLabel", {
		Parent = logGui5,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = "rbxassetid://74120900238837",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local logGui8 = createInstance("TextButton", {
		Parent = logGui4,
		Name = "close",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -30, 0, 5),
		Size = UDim2.fromOffset(20, 20),
		Text = "",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local logGui9 = createInstance("UIStroke", {
		Parent = logGui8,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.new(1, 1, 1),
		LineJoinMode = Enum.LineJoinMode.Miter
	})
	local logGui10 = createInstance("ImageLabel", {
		Parent = logGui8,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = "rbxassetid://15396333997",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local logGui11 = createInstance("TextButton", {
		Parent = logGui1,
		Name = "resizebottom",
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, -2, 0, 7),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = "",
		AutoButtonColor = false
	})
	local logGui12 = createInstance("TextButton", {
		Parent = logGui1,
		Name = "resizeside",
		BackgroundTransparency = 1,
		Position = UDim2.new(1, 0, 0, -30),
		Size = UDim2.new(0, 7, 1, 28),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = "",
		AutoButtonColor = false
	})
	local logGui13 = createInstance("TextButton", {
		Parent = logGui1,
		Name = "resizeboth",
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(1, 1),
		Size = UDim2.fromOffset(7, 7),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = "",
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
		FontFace = Font.new(fonts.SourceSansPro, Enum.FontWeight.Bold),
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
	local commandGui8 = createInstance("UIScale", {Parent = commandGui1})
	commandGui1:SetAttribute("Hovering", false)
	local utilsGui1 = createInstance("TextButton", {
		Parent = gui2,
		Name = "utils",
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(0.747, 0, 2.657, 0),
		Size = UDim2.fromOffset(53, 43),
		Text = "fun utils",
		TextScaled = true,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local utilsGui2 = createInstance("Frame", {
		Parent = utilsGui1,
		Name = "utils",
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.fromOffset(0, 0),
		ClipsDescendants = true,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	utilsGui2:SetAttribute("Size", UDim2.fromOffset(70, 150))
	createInstance("UIListLayout", {
		Parent = utilsGui2,
		Padding = UDim.new(0, 5),
		Wraps = true,
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		VerticalFlex = Enum.UIFlexAlignment.Fill
	})
	createInstance("UIPadding", {
		Parent = utilsGui2,
		PaddingBottom = UDim.new(0, 4),
		PaddingRight = UDim.new(0, 5),
		PaddingTop = UDim.new(0, 5)
	})
	local utilsGui3 = createInstance("TextButton", {
		Parent = utilsGui2,
		Name = "calculator",
		BackgroundColor3 = Color3.new(),
		Size = UDim2.fromOffset(60, 0),
		FontFace = Font.new(fonts.FiraSans),
		Text = "calculator",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 14,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})

	local utilsGui4 = createInstance("TextButton", {
		Parent = utilsGui2,
		Name = "executor",
		BackgroundColor3 = Color3.new(),
		Size = UDim2.fromOffset(60, 0),
		FontFace = Font.new(fonts.FiraSans),
		Text = "executor",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 14,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local executorGui1 = createInstance("Frame", {
		Parent = gui1,
		Name = "executor",
		BackgroundColor3 = Color3.fromRGB(102, 101, 103),
		Position = UDim2.fromOffset(0, 88),
		Size = UDim2.fromOffset(240, 160),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Visible = false
	})
	local executorGui2 = createInstance("ScrollingFrame", {
		Parent = executorGui1,
		BackgroundColor3 = Color3.fromRGB(37, 37, 37),
		Size = UDim2.new(1, 0, 1, -30),
		CanvasSize = UDim2.fromOffset(0, 0),
		BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
		TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
		ScrollBarImageColor3 = Color3.fromRGB(179, 179, 179),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local executorGui3 = createInstance("TextBox", {
		Parent = executorGui2,
		Name = "luau",
		BackgroundTransparency = 1,
		ClearTextOnFocus = false,
		MultiLine = true,
		Size = UDim2.fromOffset(1e6, 1e6),
		Font = executorConfig.font,
		Text = [[print("Hello DeepScope!")]],
		TextTransparency = 1,
		TextColor3 = Color3.fromRGB(204, 204, 204),
		TextSize = 15,
		RichText = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local executorGui3_2 = createInstance("TextLabel", {
		Parent = executorGui3,
		Name = "visual",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 2,
		Font = executorConfig.font,
		Text = [[print("Hello DeepScope!")]],
		TextColor3 = Color3.fromRGB(204, 204, 204),
		TextSize = 15,
		RichText = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local executorGui4 = createInstance("Frame", {
		Parent = executorGui1,
		Name = "lines",
		BackgroundColor3 = Color3.fromRGB(43, 43, 43),
		Size = UDim2.new(0, 0, 1, -30),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		ClipsDescendants = true,
	})
	local executorGui5 = createInstance("TextLabel", {
		Parent = executorGui4,
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(0, 1e6),
		FontFace = Font.new(fonts.BuilderMono),
		Text = "1",
		TextColor3 = Color3.fromRGB(204, 204, 204),
		TextSize = 15,
		RichText = true,
		TextXAlignment = Enum.TextXAlignment.Right,
		TextYAlignment = Enum.TextYAlignment.Top,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	createInstance("UIPadding", {
		Parent = executorGui5,
		PaddingRight = UDim.new(0, 10)
	})
	local executorGui6 = createInstance("ImageButton", {
		Parent = executorGui1,
		Name = "run",
		AnchorPoint = Vector2.new(1, 1),
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -2, 1, -2),
		Size = UDim2.fromOffset(25, 25),
		Image = "rbxassetid://12099513379",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local executorGui7 = createInstance("TextButton", {
		Parent = executorGui1,
		Name = "dragbutton",
		BackgroundColor3 = Color3.fromRGB(102, 101, 103),
		AnchorPoint = Vector2.new(0, 1),
		Size = UDim2.new(1, 0, 0, 30),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = "executor",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 20,
		FontFace = Font.new(fonts.FiraSans),
		AutoButtonColor = false,
		ClipsDescendants = true,
	})
	local executorGui8 = createInstance("TextButton", {
		Parent = executorGui7,
		Name = "fullclose",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -5, 0, 5),
		Size = UDim2.fromOffset(20, 20),
		Text = "",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	createInstance("UIStroke", {
		Parent = executorGui8,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.new(1, 1, 1),
		LineJoinMode = Enum.LineJoinMode.Miter
	})
	local executorGui9 = createInstance("ImageLabel", {
		Parent = executorGui8,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = "rbxassetid://74120900238837",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local executorGui10 = createInstance("TextButton", {
		Parent = executorGui7,
		Name = "close",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -30, 0, 5),
		Size = UDim2.fromOffset(20, 20),
		Text = "",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	createInstance("UIStroke", {
		Parent = executorGui10,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.new(1, 1, 1),
		LineJoinMode = Enum.LineJoinMode.Miter
	})
	local executorGui12 = createInstance("ImageLabel", {
		Parent = executorGui10,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = "rbxassetid://15396333997",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local executorGui13 = createInstance("TextButton", {
		Parent = executorGui1,
		Name = "resizebottom",
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, -2, 0, 7),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = "",
		AutoButtonColor = false
	})
	local executorGui14 = createInstance("TextButton", {
		Parent = executorGui1,
		Name = "resizeside",
		BackgroundTransparency = 1,
		Position = UDim2.new(1, 0, 0, -30),
		Size = UDim2.new(0, 7, 1, 28),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = "",
		AutoButtonColor = false
	})
	local executorGui15 = createInstance("TextButton", {
		Parent = executorGui1,
		Name = "resizeboth",
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(1, 1),
		Size = UDim2.fromOffset(7, 7),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Text = "",
		AutoButtonColor = false
	})
	local executorGui16 = createInstance("TextLabel", {
		Parent = executorGui1,
		Name = "codeLimit",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.fromScale(1, 1),
		Size = UDim2.new(1, -35, 0, 30),
		FontFace = Font.new(fonts.FiraSans),
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Right,
		Text = "0/200K",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	createInstance("UIPadding", {
		Parent = executorGui16,
		PaddingRight = UDim.new(0, 35)
	})
	local executorGui17 = createInstance("Frame", {
		Parent = executorGui3,
		Name = "cursor",
		AnchorPoint = Vector2.new(1, 1),
		Size = UDim2.fromOffset(1, 14.4),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local settingsGui1 = createInstance("Frame", {
		Parent = gui1,
		Name = "settings",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(102, 101, 103),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.35, 0.6),
		BorderSizePixel = 0,
		Visible = false
	})
	createInstance("UIAspectRatioConstraint", {
		Parent = settingsGui1,
		AspectRatio = 0.677
	})
	local settingsGui2 = createInstance("ScrollingFrame", {
		Parent = settingsGui1,
		Name = "list",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.fromScale(0, 0),
		ScrollBarThickness = 0
	})
	createInstance("UIListLayout", {
		Parent = settingsGui2,
		Padding = UDim.new(0, 1),
		SortOrder = Enum.SortOrder.LayoutOrder
	})
	local settingsGui3 = createInstance("TextButton", {
		Parent = settingsGui1,
		Name = "dragbutton",
		AnchorPoint = Vector2.new(0, 1),
		BackgroundColor3 = Color3.fromRGB(102, 101, 103),
		Size = UDim2.fromScale(1, 0.086),
		FontFace = Font.new(fonts.FiraSans),
		Text = "settings",
		TextColor3 = Color3.new(1, 1, 1),
		TextScaled = true,
		BorderSizePixel = 0
	})
	createInstance("UIPadding", {
		Parent = settingsGui3,
		PaddingBottom = UDim.new(0, 3),
		PaddingTop = UDim.new(0, 3)
	})
	local settingsGui4 = createInstance("TextButton", {
		Parent = settingsGui3,
		Name = "fullclose",
		AnchorPoint = Vector2.new(1, 0),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -5, 0.05, 0),
		Size = UDim2.fromScale(0.9, 0.9),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		Text = ""
	})
	createInstance("UIStroke", {
		Parent = settingsGui4,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.new(1, 1, 1),
		LineJoinMode = Enum.LineJoinMode.Miter
	})
	local settingsGui5 = createInstance("ImageLabel", {
		Parent = settingsGui4,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = "rbxassetid://74120900238837",
	})
	executorGui3_2.Text = modules.other.executor.highlightLuau(executorGui3_2.ContentText)
	modules.other.executor.Update(executorGui3.Text, executorGui3, executorGui5)
	infoList = placeInfoGui4
	logList = logGui2

	return gui2
end
local newgui = createGui()
local function makeFakeScripts()
	local folder = createInstance("Folder", {
		Parent = game.ReplicatedStorage,
		Name = "_DeepScopeCore"
	})
	local fakeScript1 = createInstance("ModuleScript", {
		Parent = folder,
		Name = "Core"
	})
	local fakeScript2 = createInstance("ModuleScript", {
		Parent = fakeScript1,
		Name = "Explorer"
	})
	local fakeScript3 = createInstance("ModuleScript", {
		Parent = fakeScript1,
		Name = "Properties"
	})
	local fakeScript4 = createInstance("ModuleScript", {
		Parent = folder,
		Name = "ColorPicker"
	})
	local fakeScript5 = createInstance("ModuleScript", {
		Parent = folder,
		Name = "Notifications"
	})
	local fakeScript6 = createInstance("ModuleScript", {
		Parent = folder,
		Name = "BuildMode"
	})
	local fakeScript7 = createInstance("ModuleScript", {
		Parent = folder,
		Name = "Logs"
	})
	local fakeScript8 = createInstance("ModuleScript", {
		Parent = folder,
		Name = "DeepScopeCommandBar"
	})
	local fakeScript9 = createInstance("ModuleScript", {
		Parent = fakeScript8,
		Name = "Commands"
	})
	local fakeScript10 = createInstance("ModuleScript", {
		Parent = fakeScript1,
		Name = "Executor"
	})
end
local function getMousePos()
	return game.UserInputService:GetMouseLocation()
end
local function notify(icon, text, countdown)
	if not countdown then countdown = 3 end
	local template = createInstance("Frame", {
		Parent = newgui.Parent.notification,
		Name = "template",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(200, 50),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Visible = false
	})
	local notifyGui4 = createInstance("Frame", {
		Parent = template,
		Name = "inner",
		Size = UDim2.fromOffset(200, 50),
		Position = UDim2.fromOffset(210, 0),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local notifyGui5 = createInstance("Frame", {
		Parent = notifyGui4,
		Name = "countdown",
		BackgroundColor3 = Color3.new(1, 1, 1),
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, 0, 0, 3),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local notifyGui6 = createInstance("Frame", {
		Parent = notifyGui4,
		Name = "mainframe",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(1, 0, 0, 30),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local notifyGui7 = createInstance("UIListLayout", {
		Parent = notifyGui6,
		Padding = UDim.new(0, 5),
		FillDirection = Enum.FillDirection.Horizontal
	})
	local notifyGui8 = createInstance("UIPadding", {
		Parent = notifyGui6,
		PaddingLeft = UDim.new(0, 5),
		PaddingRight = UDim.new(0, 5)
	})
	local notifyGui9 = createInstance("ImageLabel", {
		Parent = notifyGui6,
		Name = "icon",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(30, 30),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local notifyGui10 = createInstance("TextLabel", {
		Parent = notifyGui6,
		Name = "title",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(155, 30),
		Text = "hi",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 13,
		RichText = true,
		TextWrapped = true,
		FontFace = Font.new(fonts.FiraSans),
		TextXAlignment = Enum.TextXAlignment.Left,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	notify_amount += 1
	local newTemplate = template:Clone()
	newTemplate.Parent = newgui.Parent.notification
	TweenService:Create(newTemplate.inner, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		Position = UDim2.new(0, 0, 0, 0)
	}):Play()
	newTemplate.inner.mainframe.title.Size = UDim2.fromOffset(icon ~= nil and 155 or 190, 30)
	newTemplate.inner.mainframe.icon.Visible = icon ~= nil
	newTemplate.inner.mainframe.icon.Image = icon ~= nil and icon or ""
	newTemplate.inner.mainframe.title.Text = text
	newTemplate.LayoutOrder = -notify_amount
	newTemplate.Name = "template" .. notify_amount
	newTemplate.Visible = true
	local sound = Instance.new("Sound")
	sound.Parent = newTemplate
	sound.SoundId = notificationSoundId
	sound:Play()
	game.Debris:AddItem(newTemplate, countdown + 1.4)
	delay(0.3, function()
		TweenService:Create(newTemplate.inner.countdown, TweenInfo.new(countdown, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Size = UDim2.fromOffset(0, 3)
		}):Play()
	end)
	delay(countdown + 0.8, function()
		TweenService:Create(newTemplate.inner, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Position = UDim2.new(0, 210, 0, 0)
		}):Play()
	end)
	delay(countdown + 1.15, function()
		TweenService:Create(newTemplate, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Size = UDim2.fromOffset(200, 0)
		}):Play()
	end)
end
do
	local Window = {}
	Window.__index = Window

	local defaultSize = UDim2.new(0, 240, 0, 240)
	local defaultTitle = "New Window"

	function Window.new(name)
		local self = setmetatable({}, Window)
		self.Name = name or defaultTitle
		self.Resizeable = true
		self.Collapseable = true
		self.Dragable = true
		self.GuiElems = {}
		self.closedEvent = Instance.new("BindableEvent")
		self.Closed = self.closedEvent.Event
		self._connections = {}
		self._actions = {}

		self.GuiElems.Main = createInstance("Frame", {
			Parent = newgui.Parent,
			Name = name,
			BackgroundColor3 = Color3.new(0.4, 0.396078, 0.403922),
			BorderSizePixel = 0,
			Size = defaultSize
		})
		createInstance("TextButton", {
			Parent = self.GuiElems.Main,
			Name = "dragbutton",
			AnchorPoint = Vector2.new(0, 1),
			BackgroundColor3 = Color3.new(0.4, 0.396078, 0.403922),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 30),
			FontFace = Font.new(fonts.FiraSans),
			Text = "placeholder",
			TextColor3 = Color3.new(1, 1, 1),
			TextSize = 20
		})
		createInstance("TextButton", {
			Parent = self.GuiElems.Main.dragbutton,
			Name = "close",
			AnchorPoint = Vector2.new(1, 0),
			BackgroundTransparency = 1,
			Position = UDim2.new(1, -30, 0, 5),
			Size = UDim2.new(0, 20, 0, 20),
		})
		createInstance("UIStroke", {
			Parent = self.GuiElems.Main.dragbutton.close,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			LineJoinMode = Enum.LineJoinMode.Miter
		})
		createInstance("ImageLabel", {
			Parent = self.GuiElems.Main.dragbutton.close,
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Image = "rbxassetid://15396333997"
		})
		createInstance("TextButton", {
			Parent = self.GuiElems.Main.dragbutton,
			Name = "fullclose",
			AnchorPoint = Vector2.new(1, 0),
			BackgroundTransparency = 1,
			Position = UDim2.new(1, -30, 0, 5),
			Size = UDim2.new(0, 20, 0, 20),
		})
		createInstance("UIStroke", {
			Parent = self.GuiElems.Main.dragbutton.fullclose,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			LineJoinMode = Enum.LineJoinMode.Miter
		})
		createInstance("ImageLabel", {
			Parent = self.GuiElems.Main.dragbutton.fullclose,
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Image = "rbxassetid://74120900238837"
		})
		createInstance("TextButton", {
			Parent = self.GuiElems.Main,
			Name = "resizeboth",
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			Position = UDim2.new(1, 0, 1, 0),
			Size = UDim2.new(0, 7, 0, 7),
			Text = ""
		})
		createInstance("TextButton", {
			Parent = self.GuiElems.Main,
			Name = "resizebottom",
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, 1, 0),
			Size = UDim2.new(1, 0, 0, 7),
			Text = ""
		})
		createInstance("TextButton", {
			Parent = self.GuiElems.Main,
			Name = "resizeside",
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			Position = UDim2.new(1, 0, 0, -30),
			Size = UDim2.new(0, 7, 1, 30),
			Text = ""
		})
		local aliases = {
			["bottom"] = "Y",
			["side"] = "X",
			["both"] = "XY"
		}
		self.GuiElems.TitleBar = self.GuiElems.Main.dragbutton
		for _, v in self.GuiElems.Main:GetChildren() do
			if v:IsA("TextButton") then
				if v.Name:find("resize") then
					if not self._actions["collapsed"] then
						v.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								self._actions["resizing"] = v
								self._actions["smp"] = UserInputService:GetMouseLocation()
								self._actions["sws"] = self.GuiElems.Main.Size
								self._actions["crs"] = aliases[v.Name:sub(7)]
							end
						end)
						v.MouseEnter:Connect(function()
							v.BackgroundTransparency = 0.5
						end)
						v.MouseLeave:Connect(function()
							v.BackgroundTransparency = 1
						end)
					end
				end
			end
		end
		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				self._actions["resizing"] = nil
				self._actions["smp"] = nil
				self._actions["sws"] = nil
			end
		end)
		self.GuiElems.TitleBar.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				self._actions["dragging"] = true
				self._actions["smp"] = UserInputService:GetMouseLocation()
				self._actions["swp"] = self.GuiElems.Main.Position
			end
		end)
		self._connections = RunService.RenderStepped:Connect(function()
			local mouse = UserInputService:GetMouseLocation()
			if self._actions["resizing"] then
				if self._actions.crs == "Y" then
					local deltaY = mouse.Y - self._actions["smp"].Y
					local newHeight = math.clamp(self._actions["sws"].Y.Offset + deltaY, 100, 600)
					self.GuiElems.Main.Size = UDim2.new(self._actions["sws"].X.Scale, self._actions["sws"].X.Offset, 0, newHeight)
				elseif self._actions.crs == "X" then
					local deltaX = mouse.X - self._actions["smp"].X
					local newWidth = math.clamp(self._actions["sws"].X.Offset + deltaX, 100, 600)
					self.GuiElems.Main.Size = UDim2.new(0, newWidth, self._actions["sws"].Y.Scale, self._actions["sws"].Y.Offset)
				elseif self._actions.crs == "XY" then
					local deltaX = mouse.X - self._actions["smp"].X
					local deltaY = mouse.Y - self._actions["smp"].Y
					local newWidth = math.clamp(self._actions["sws"].X.Offset + deltaX, 100, 600)
					local newHeight = math.clamp(self._actions["sws"].Y.Offset + deltaY, 100, 600)
					self.GuiElems.Main.Size = UDim2.new(0, newWidth, 0, newHeight)
				end
			end
			if self._actions["dragging"] and self.Dragable then
				local deltaX = mouse.X - self._actions["smp"].X
				local deltaY = mouse.Y - self._actions["smp"].Y
				self.GuiElems.Main.Position = UDim2.new(self._actions["swp"].X.Scale, self._actions["swp"].X.Offset + deltaX, self._actions["swp"].Y.Scale, self._actions["swp"].Y.Offset + deltaY)
			end
		end)
		self.GuiElems.TitleBar.close.MouseButton1Click:Connect(function()
			self._actions["collapsed"] = not self._actions["collapsed"]
			if not self._actions["collapsed"] then
				self._actions["oldsize"] = self.GuiElems.Main.Size
				self.GuiElems.Main:TweenSize(UDim2.new(self.GuiElems.Main.Size.X.Scale, self.GuiElems.Main.Size.X.Offset, 0, 0), "InOut", "Size", 0.2, true)
			else
				self.GuiElems.Main:TweenSize(self._actions["oldsize"], "InOut", "Size", 0.2, true)
			end
		end)
		self.GuiElems.TitleBar.fullclose.MouseButton1Click:Connect(function()
			self.GuiElems.Main:Destroy()
			self.closedEvent:Fire()
			return
		end)
		return self
	end

	function Window:SetTitle(text)
		self.Name = text
		if self.GuiElems and self.GuiElems.TitleBar then
			self.GuiElems.TitleBar.Text = text
		end
	end

	function Window:Resize(x, y)
		if self.GuiElems.Main then
			self.GuiElems.Main.Size = UDim2.new(0, x, 0, y)
		end
	end

	function Window:SetPosition(tbl, isScale)
		if self.GuiElems.Main then
			if isScale then
				self.GuiElems.Main.Position = UDim2.new(tbl[1], 0, tbl[2], 0)
			else
				self.GuiElems.Main.Position = UDim2.new(0, tbl[1], 0, tbl[2])
			end
		end
	end

	function Window:SetAnchorPoint(x, y)
		if self.GuiElems.Main then
			if not x then x = 0 end if not y then y = 0	end
			self.GuiElems.Main.AnchorPoint = Vector2.new(x, y)
		end
	end

	coreModules.Lib.Window = {
		new = Window.new
	}
end
makeFakeScripts()
LocalPlayer.CharacterAdded:Connect(function(char)
	delay(1, function()
		modules.other.fly.Respawn(char)
	end)
end)

local explorerData = {}
local nodesBuilt = {}
local templates = {}

local function buildExplorerData(instance)
	if not instance or not instance.Parent and instance ~= game then
		return nil
	end
	if explorerData[instance] then
		return explorerData[instance]
	end
	local node = {
		Data = {
			Name = instance.Name or "Unnamed",
			ClassName = instance.ClassName or "Unknown",
			FullPath = (pcall(function() return instance:GetFullName() end) and instance:GetFullName()) or "Unknown",
			Parent = instance.Parent,
			ChildrenCount = #instance:GetChildren()
		},
		Instance = instance,
		Children = {},
	}

	explorerData[instance] = node

	if instance.Name then
		instance:GetPropertyChangedSignal("Name"):Connect(function()
			if node.Data then
				node.Data.Name = instance.Name
				node.Data.FullPath = (pcall(function() return instance:GetFullName() end) and instance:GetFullName()) or "Unknown"
			end
		end)
	end
	if instance.ClassName then
		instance:GetPropertyChangedSignal("ClassName"):Connect(function()
			if node.Data then
				node.Data.ClassName = instance.ClassName
			end
		end)
	end
	if instance:IsA("ValueBase") then
		local success, error = pcall(function()
			node.Data.Value = instance.Value
			instance:GetPropertyChangedSignal("Value"):Connect(function()
				if node.Data then
					node.Data.Value = instance.Value
				end
			end)
		end)
		if not success and error then
			AddLog("game.ReplicatedStorage._DeepScopeCore.Core.Explorer:7423: "..error, "DeepScope", "error")
		end
	end
	for _, child in ipairs(instance:GetChildren()) do
		if not table.find(explorerBlacklistInstances, child.Name) then
			local childNode = buildExplorerData(child)
			if childNode then
				table.insert(node.Children, childNode)
			end
		end
	end

	return node
end

local function recalcAndPropagateSize(entryFrame)
	if not entryFrame or not entryFrame:IsA("Frame") then return end

	local function computeFrameHeight(frame)
		local base = 24
		local dropdown = frame:FindFirstChild("dropdown")
		if dropdown and dropdown.Visible then
			local h = dropdown:FindFirstChild("UIListLayout") and dropdown.UIListLayout.AbsoluteContentSize.Y or 0
			for _, child in ipairs(dropdown:GetChildren()) do
				if child:IsA("Frame") then
					child.Size = UDim2.new(1, 0, 0, computeFrameHeight(child))
				end
			end
			return base + (h or 0)
		end
		return base
	end

	entryFrame.Size = UDim2.new(1, 0, 0, computeFrameHeight(entryFrame))

	local parent = entryFrame.Parent
	while parent and parent:IsA("Frame") do
		if parent.Name == "dropdown" then
			local parentEntry = parent.Parent
			if parentEntry and parentEntry:IsA("Frame") then
				parentEntry.Size = UDim2.new(1, 0, 0, computeFrameHeight(parentEntry))
				parent = parentEntry.Parent
			else
				break
			end
		else
			parent.Size = UDim2.new(1, 0, 0, computeFrameHeight(parent))
			parent = parent.Parent
		end
	end
end
local guiToNode = {}
local nodeToGui = {}
local nodeToProps = {}
local hoveringNode = nil

local function makeProperties(instance)
	return {
		Archivable = instance.Archivable,
		ClassName = instance.ClassName,
		Name = instance.Name,
		Parent = instance.Parent and instance.Parent.Name or "nil",
		UniqueId = (function()
			local success, id = pcall(function()
				return instance.UniqueId
			end)
			return success and id or 0
		end)(),
		Tags = (function()
			local success, tags = pcall(function()
				return instance:GetTags()
			end)
			return success and tags or {}
		end)(),
		Attributes = instance:GetAttributes()
	}
end

local function attachPropertyListeners(instance, node)
	instance:GetPropertyChangedSignal("Name"):Connect(function()
		if nodeToProps[node] then
			nodeToProps[node].Name = instance.Name
			if nodeToGui[node] then
				nodeToGui[node].mainframe.name.Text = instance.Name
			end
		end
	end)
	instance:GetPropertyChangedSignal("Parent"):Connect(function()
		if nodeToProps[node] then
			nodeToProps[node].Parent = instance.Parent and instance.Parent.Name or "nil"
		end
	end)
end

local function applySelection(instance)
	local selectionBox = Instance.new("SelectionBox")
	selectionBox.Adornee = instance
	selectionBox.Color3 = Color3.fromRGB(85, 255, 255)
	selectionBox.LineThickness = 0.025
	selectionBox.Parent = workspace
	selectionBox.Name = generateRandomString()
end
local RMD = coreModules.Lib:FetchRMD()
local function createEntryForInstance(node, parentGui)
	local template = createInstance("Frame", {
		Parent = nil,
		Name = "template",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(228, 24),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
	})
	local explorerGui5 = createInstance("Frame", {
		Parent = template,
		Name = "mainframe",
		BackgroundColor3 = Color3.fromRGB(88, 87, 89),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 24)
	})
	explorerGui5:SetAttribute("NormalColor", explorerGui5.BackgroundColor3)
	explorerGui5:SetAttribute("HoverColor", Color3.fromRGB(57, 58, 59))
	explorerGui5:SetAttribute("SelectedColor", Color3.fromRGB(0, 170, 255))
	explorerGui5:SetAttribute("Selected", false)
	local explorerGui6 = createInstance("UIListLayout", {
		Parent = explorerGui5,
		Padding = UDim.new(0, 2),
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder
	})
	local explorerGui7 = createInstance("UIPadding", {
		Parent = explorerGui5,
		PaddingLeft = UDim.new(0, 2)
	})
	local explorerGui8 = createInstance("UIGradient", {
		Parent = explorerGui5,
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.95, 0),
			NumberSequenceKeypoint.new(1, 1)
		})
	})
	local explorerGui9 = createInstance("ImageButton", {
		Parent = explorerGui5,
		Name = "dropdownbutton",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(20, 20),
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0
	})
	local explorerGui10 = createInstance("ImageLabel", {
		Parent = explorerGui9,
		Name = "icon",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		BorderColor3 = Color3.new(0, 0, 0),
		Rotation = -90,
		BorderSizePixel = 0,
		Image = "rbxassetid://11552476728",
	})
	local explorerGui11 = createInstance("ImageLabel", {
		Parent = explorerGui5,
		Name = "icon",
		BackgroundTransparency = 1,
		LayoutOrder = 1,
		Size = UDim2.fromOffset(17, 17),
		Image = "\114\98\120\97\115\115\101\116\58\47\47\116\101\120\116\117\114\101\115\47\67\108\97\115\115\73\109\97\103\101\115\46\80\78\71",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		ImageRectSize = Vector2.new(table.unpack(icons.size))
	})
	local explorerGui12 = createInstance("TextLabel", {
		Parent = explorerGui5,
		Name = "name",
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		LayoutOrder = 2,
		Size = UDim2.fromOffset(0, 17),
		FontFace = Font.new(fonts.FiraSans),
		Text = "hi",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 15,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextXAlignment = Enum.TextXAlignment.Left
	})
	local explorerGui17 = createInstance("ImageButton", {
		Parent = explorerGui5,
		Name = "add",
		BackgroundTransparency = 1,
		LayoutOrder = 3,
		Size = UDim2.fromOffset(20, 10),
		Image = "rbxassetid://88065133864491",
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		ScaleType = Enum.ScaleType.Fit,
		Visible = false
	})
	local explorerGui14 = createInstance("Frame", {
		Parent = template,
		Name = "dropdown",
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(24, 24),
		Size = UDim2.fromScale(1, 0),
		Visible = false
	})
	local explorerGui15 = createInstance("UIListLayout", {Parent = explorerGui14})
	local explorerGui16 = createInstance("TextButton", {
		Parent = template,
		Name = "activateregion",
		BackgroundTransparency = 1,
		Text = "",
		Size = UDim2.fromScale(1, 1),
		ZIndex = 0
	})
	local classData = RMD.Classes[node.Data.ClassName]
	local explorerImageIndex = classData and classData.ExplorerImageIndex or 0
	local explorerOrder = classData and classData.ExplorerOrder or 9999
	local newTemplate = template:Clone()
	local index = explorerOrder
	local iconOffset = Vector2.new(explorerImageIndex*16, 0)

	newTemplate.Parent = parentGui
	newTemplate.Name = node.Data.Name
	newTemplate.mainframe.name.Text = node.Data.Name
	newTemplate.mainframe.icon.ImageRectOffset = iconOffset
	newTemplate.LayoutOrder = index
	guiToNode[newTemplate] = node
	nodeToGui[node] = newTemplate

	local dropdown = newTemplate.dropdown
	dropdown.Visible = false
	newTemplate:SetAttribute("ChildrenBuilt", false)

	if node.Data.ChildrenCount > 0 then
		newTemplate.mainframe.dropdownbutton.Visible = true

		newTemplate.mainframe.dropdownbutton.MouseButton1Click:Connect(function()
			if not newTemplate:GetAttribute("ChildrenBuilt") then
				for _, childNode in ipairs(node.Children) do
					createEntryForInstance(childNode, dropdown)
				end
				newTemplate:SetAttribute("ChildrenBuilt", true)
			end

			dropdown.Visible = not dropdown.Visible
			newTemplate.mainframe.dropdownbutton.icon.Rotation = dropdown.Visible and 0 or -90
			recalcAndPropagateSize(newTemplate)
		end)
	else
		newTemplate.mainframe.dropdownbutton.icon:Destroy()
		dropdown:Destroy()
	end
	templates[newTemplate] = newTemplate
	local function selectTemplate(template)
		for _, v in templates do
			v:SetAttribute("Selected", false)
			v.mainframe.BackgroundColor3 = v.mainframe:GetAttribute("NormalColor")
		end
		template:SetAttribute("Selected", true)
		template.mainframe.BackgroundColor3 = template.mainframe:GetAttribute("SelectedColor")
		selectedObject = template.Instance
		applySelection(selectedObject)
	end

	UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			local mousePos = UserInputService:GetMouseLocation()
			local objects = LocalPlayer.PlayerGui:GetGuiObjectsAtPosition(mousePos.X, mousePos.Y)
			for _, obj in objects do
				for _, template in templates do
					if obj == template.activateregion or obj:IsDescendantOf(template.activateregion) then
						selectTemplate(template)
						return
					end
				end
			end
		end
	end)

	--[[RunService.RenderStepped:Connect(function()
		local mousePos = getMousePos()
		local objects = LocalPlayer.PlayerGui:GetGuiObjectsAtPosition(mousePos.X, mousePos.Y)
		local hoveredTemplate = nil

		for _, obj in objects do
			for _, template in templates do
				if obj == template.activateregion or obj:IsDescendantOf(template.activateregion) then
					hoveredTemplate = template
					break
				end
			end
		end

		for _, template in templates do
			local isSelected = template:GetAttribute("Selected")
			local colorAttr = isSelected and "SelectedColor"
				or (template == hoveredTemplate and "HoverColor" or "NormalColor")
			template.mainframe.BackgroundColor3 = template.mainframe:GetAttribute(colorAttr)
			template.mainframe.add.Visible = (template == hoveredTemplate)
		end
	end)]]
	newTemplate.Size = UDim2.new(1, 0, 0, 24)
	return newTemplate
end

local function buildChildrenNodes(instance, parentNode, parentGui)
	local node = {
		Instance = instance,
		Data = {
			Name = instance.Name,
			ClassName = instance.ClassName,
			ChildrenCount = #instance:GetChildren(),
		},
		Children = {}
	}

	nodeToProps[node] = makeProperties(instance)

	local entry = createEntryForInstance(node, parentGui)
	guiToNode[entry] = node
	nodeToGui[node] = entry

	attachPropertyListeners(instance, node)

	instance.ChildAdded:Connect(function(child)
		local childNode = buildChildrenNodes(child, node, entry.dropdown)
		table.insert(node.Children, childNode)
		recalcAndPropagateSize(entry)
	end)

	instance.ChildRemoved:Connect(function(child)
		for i, childNode in ipairs(node.Children) do
			if childNode.Instance == child then
				local gui = nodeToGui[childNode]
				if gui then
					gui:Destroy()
					guiToNode[gui] = nil
				end
				nodeToGui[childNode] = nil

				nodeToProps[childNode] = nil

				table.remove(node.Children, i)
				recalcAndPropagateSize(entry)
				break
			end
		end
	end)

	for _, child in ipairs(instance:GetChildren()) do
		local childNode = buildChildrenNodes(child, node, entry.dropdown)
		table.insert(node.Children, childNode)
	end

	return node
end

local function setExplorer()
	explorerUsing = true
	explorerData = {}
	local explorer = newgui.Parent.explorer
	local list = explorer.ScrollingFrame
	explorer.Visible = true

	for _, child in ipairs(list:GetChildren()) do
		if child:IsA("Frame") then child:Destroy() end
	end

	for _, child in ipairs(game:GetChildren()) do
		if not table.find(explorerBlacklistInstances, child.Name) then
			local node = buildExplorerData(child)
			createEntryForInstance(node, list)
		end
	end

	RunService.RenderStepped:Connect(function()
		if explorerUsing and explorer.Visible then
			local absPos = list.AbsolutePosition.Y
			local absSize = list.AbsoluteWindowSize.Y

			for _, frame in ipairs(templates) do
				if frame:IsA("Frame") and frame:FindFirstChild("mainframe") then
					local y = frame.AbsolutePosition.Y
					local h = frame.AbsoluteSize.Y

					local onScreen = (y + h > absPos) and (y < absPos + absSize)
					frame.mainframe.Visible = onScreen
				end
			end
		end
	end)
	local MIN_WIDTH, MIN_HEIGHT = 240, 32
	local MAX_WIDTH, MAX_HEIGHT = CurrentCamera.ViewportSize.X-100, CurrentCamera.ViewportSize.Y-100
	CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		MAX_WIDTH, MAX_HEIGHT = CurrentCamera.ViewportSize.X-100, CurrentCamera.ViewportSize.Y-100
	end)
	explorer.resizebottom.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if explorerOpened then
				if not countdowns["explorer"] then
					resizingExplorer = "Y"
					startMousePos = getMousePos()
					startExplorerSize = explorer.Size
				end
			end
		end
	end)

	explorer.resizeside.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if not countdowns["explorer"] then
				resizingExplorer = "X"
				startMousePos = getMousePos()
				startExplorerSize = explorer.Size
			end
		end
	end)

	explorer.resizeboth.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if not countdowns["explorer"] then
				resizingExplorer = "XY"
				startMousePos = getMousePos()
				startExplorerSize = explorer.Size
			end
		end
	end)

	game:GetService("UserInputService").InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			resizingExplorer = false
		end
	end)

	game:GetService("RunService").RenderStepped:Connect(function()
		if resizingExplorer then
			local mouse = getMousePos()

			if resizingExplorer == "Y" then
				local deltaY = mouse.Y - startMousePos.Y
				local newHeight = math.clamp(startExplorerSize.Y.Offset + deltaY, MIN_HEIGHT, MAX_HEIGHT)
				explorer.Size = UDim2.new(startExplorerSize.X.Scale, startExplorerSize.X.Offset, 0, newHeight)
			elseif resizingExplorer == "X" then
				local deltaX = mouse.X - startMousePos.X
				local newWidth = math.clamp(startExplorerSize.X.Offset + deltaX, MIN_WIDTH, MAX_HEIGHT)
				explorer.Size = UDim2.new(0, newWidth, startExplorerSize.Y.Scale, startExplorerSize.Y.Offset)
			elseif resizingExplorer == "XY" then
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
		TweenService:Create(explorer.resizebottom, TweenInfo.new(0.2), {
			BackgroundTransparency = 0.5
		}):Play()
	end)
	explorer.resizebottom.MouseLeave:Connect(function()
		TweenService:Create(explorer.resizebottom, TweenInfo.new(0.2), {
			BackgroundTransparency = 1
		}):Play()
	end)
	explorer.resizeside.MouseEnter:Connect(function()
		TweenService:Create(explorer.resizeside, TweenInfo.new(0.2), {
			BackgroundTransparency = 0.5
		}):Play()
	end)
	explorer.resizeside.MouseLeave:Connect(function()
		TweenService:Create(explorer.resizeside, TweenInfo.new(0.2), {
			BackgroundTransparency = 1
		}):Play()
	end)
	explorer.resizeboth.MouseEnter:Connect(function()
		TweenService:Create(explorer.resizeboth, TweenInfo.new(0.2), {
			BackgroundTransparency = 0.5
		}):Play()
	end)
	explorer.resizeboth.MouseLeave:Connect(function()
		TweenService:Create(explorer.resizeboth, TweenInfo.new(0.2), {
			BackgroundTransparency = 1
		}):Play()
	end)
	explorer.dragbutton.close.MouseButton1Click:Connect(function()
		explorerOpened = not explorerOpened
		if not explorerOpened then
			countdowns.explorer = true
			explorer.dragbutton.close.ImageLabel.Image = explorer.dragbutton.close:GetAttribute("ClosedImage")
			explorer:SetAttribute("oldysize", explorer.Size.Y.Offset)
			explorer:TweenSize(UDim2.fromOffset(explorer.Size.X.Offset, 0), "InOut", "Sine", 0.2, true)
			delay(0.2, function()
				countdowns.explorer = nil
			end)
		else
			countdowns.explorer = true
			explorer.dragbutton.close.ImageLabel.Image = explorer.dragbutton.close:GetAttribute("OpenedImage")
			explorer:TweenSize(UDim2.fromOffset(explorer.Size.X.Offset, explorer:GetAttribute("oldysize")), "InOut", "Sine", 0.2, true)
			explorer:SetAttribute("oldysize", nil)
			delay(0.2, function()
				countdowns.explorer = nil
			end)
		end
	end)
	explorer.dragbutton.fullclose.MouseButton1Click:Connect(function()
		explorerUsing = false
		explorerData = {}
		for _, child in list:GetChildren() do
			if child:IsA("Frame") then
				child:Destroy()
			end
		end
		explorer.Visible = false
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
	if mode == "square" then
		picker.picker.square.Visible = true
		picker.picker.circle.Visible = false
		picker.picker.triangle.Visible = false
	elseif mode == "circle" then
		picker.picker.square.Visible = false
		picker.picker.circle.Visible = true
		picker.picker.triangle.Visible = false
	elseif mode == "triangle" then
		picker.picker.square.Visible = false
		picker.picker.circle.Visible = false
		picker.picker.triangle.Visible = true
	end
	picker.picker.pointer.Position = module.GetPointerPositionFromColor(colors.h, colors.s, colors.v)
	setVisualMode()
	pickerMode = mode
end
local function formatTime(num)
	local formatstr = "%02i:%02i:%02i:%02i"
	local days = (num / 86400) % 86400
	local hours = (num / 3600) % 24
	local minutes = (num / 60) % 60
	local seconds = num % 60
	return formatstr:format(days, hours, minutes, seconds)
end
local function format(number, useCommas, useShort, demicals)
	demicals = demicals or 1
	if type(number) ~= "number" then
		error("Expected number, got " .. typeof(number))
	end

	local absNumber = math.round(tonumber(tostring(number):format("%.0f", number)))

	if useShort then
		if absNumber < 1000 then
			return tostring(number)
		end

		local tier = math.round(math.log10(absNumber) / 3)
		if tier >= #suffixes then
			return string.format("%.0f", number)
		end

		local suffix = ""
		local scaled = 0
		local succ, err = pcall(function()
			suffix = suffixes[tier + 1]:upper()
			scaled = number / (10 ^ (tier * 3))
		end)

		if scaled % 1 == 0 then
			return string.format("%d%s", scaled, suffix)
		else
			return string.format(`%.{demicals}f%s`, scaled, suffix)
		end
	end

	if useCommas then
		local formatted = string.format("%.0f", math.round(number))
		local k
		while true do
			formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
			if k == 0 then break end
		end
		return formatted
	end

	return math.round(number)
end
local function setColorPicker(color, gui)
	local pickerTemplate = newgui.Parent.colorpicker
	local picker = pickerTemplate:Clone()
	picker.Parent = newgui.Parent
	picker.Visible = true

	local state = {
		gui = gui,
		h = 0, s = 0, v = 1,
		r = 255, g = 255, b = 255,
		c = 0, m = 0, y = 0, k = 0,
		h2 = 0, s2 = 0, l = 1,
		active = true,
		dragging = false,
		picking = false,
		sliderInfo = {active = nil, conn = nil},
	}

	if color then
		state.h, state.s, state.v = color:ToHSV()
		state.r, state.g, state.b = math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255)
		state.c, state.m, state.y, state.k = modules.other.colorTranslations.rgbToCMYK(state.r, state.g, state.b)
		state.h2, state.s2, state.l = modules.other.colorTranslations.rgbToHSL(state.r, state.g, state.b)
	end

	local function updateVisuals()
		local color3 = Color3.fromHSV(state.h, state.s, state.v)
		picker.middlebar.result.color.BackgroundColor3 = color3
		picker.middlebar.hex.TextBox.Text = string.format("#%02x%02x%02x", state.r, state.g, state.b)

		picker.picker.pointer.Position = modules[pickerMode].GetPointerPositionFromColor(state.h, state.s, state.v)
		picker.picker.triangle.ImageColor3 = Color3.fromHSV(state.h, 1, 1)
		picker.picker.square.BackgroundColor3 = Color3.fromHSV(state.h, 1, 1)

		local function updateSlider(slider, val, seq)
			slider.pointer.Position = modules.slider.GetPointerPositionFromColor(val, seq, slider)
		end

		updateSlider(picker.sliders.hue, state.h)
		updateSlider(picker.sliders.saturation, state.s, ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(state.h, 1, 1))
		}))
		updateSlider(picker.sliders.value, state.v, ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new()),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(state.h, state.s, 1))
		}))
		updateSlider(picker.sliders.R, state.r/255, ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new(0,state.g/255,state.b/255)),
			ColorSequenceKeypoint.new(1, Color3.new(1,state.g/255,state.b/255))
		}))
		updateSlider(picker.sliders.G, state.g/255, ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new(state.r/255,0,state.b/255)),
			ColorSequenceKeypoint.new(1, Color3.new(state.r/255,1,state.b/255))
		}))
		updateSlider(picker.sliders.B, state.b/255, ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new(state.r/255,state.g/255,0)),
			ColorSequenceKeypoint.new(1, Color3.new(state.r/255,state.g/255,1))
		}))

		state.gui.BackgroundColor3 = color3
		state.gui.Parent.Text = string.format("[%d, %d, %d]", state.r, state.g, state.b)
	end

	local connections = {}

	for _, slider in picker.sliders:GetChildren() do
		if slider:IsA("Frame") then
			table.insert(connections, slider.activateregion.MouseButton1Down:Connect(function()
				state.sliderInfo.active = slider

				if state.sliderInfo.conn then
					state.sliderInfo.conn:Disconnect()
				end

				state.sliderInfo.conn = game:GetService("RunService").RenderStepped:Connect(function()
					local mouseX = getMousePos().X
					local relative = (mouseX - slider.AbsolutePosition.X) / slider.AbsoluteSize.X
					local val = math.clamp(relative, 0, 1)

					local name = slider.Name:sub(1, 1):lower()
					if name == "r" or name == "g" or name == "b" then
						state[name] = math.round(val * 255)
					elseif 
						(name == "h" or name == "s" or name == "v") or 
						(name == "c" or name == "m" or name == "y" or name == "k") or 
						(name == "h2" or name == "s2" or name == "l") 
					then
						state[name] = val
					end
				end)
			end))
		end
	end
	for _, v in picker.options.modes:GetChildren() do
		local button = v.button
		button.MouseButton1Click:Connect(function()
			setMode(v.Name)
		end)
	end
	table.insert(connections, picker.dragbutton.MouseButton1Down:Connect(function()
		state.dragging = true
		startExplorerPos = picker.Position
		startMousePos = getMousePos()
	end))
	table.insert(connections, picker.picker.activateregion.MouseButton1Down:Connect(function()
		state.picking = true
	end))
	table.insert(connections, UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			state.dragging = false
			state.picking = false
			state.sliderInfo = {active = nil, conn = nil}
		end
	end))
	table.insert(connections, RunService.RenderStepped:Connect(function()
		if not state.active then return end

		if state.dragging then
			local newX = getMousePos().X - startMousePos.X
			local newY = getMousePos().Y - startMousePos.Y
			newX = math.clamp(startExplorerPos.X.Offset + newX, 0, newgui.Parent.AbsoluteSize.X - picker.AbsoluteSize.X)
			newY = math.clamp(startExplorerPos.Y.Offset + newY, game.GuiService.TopbarInset.Height + picker.dragbutton.AbsoluteSize.Y, newgui.Parent.AbsoluteSize.Y - picker.AbsoluteSize.Y)
			picker.Position = UDim2.new(0, newX, 0, newY)
		end

		if state.picking then
			local mousePos = (getMousePos() - picker.picker.AbsolutePosition - Vector2.new(0, GuiService.TopbarInset.Height)) / picker.picker.AbsoluteSize
			local h, s, v = table.unpack(modules[pickerMode].GetColor(mousePos))
			local c, m, y, k = modules.other.colorTranslations.rgbToCMYK(state.r, state.g, state.b)
			local c = Color3.fromHSV(h, s, v)
			state.h, state.s, state.v = h, s, v
			state.r, state.g, state.b = math.round(c.R * 255), math.round(c.G * 255), math.round(c.B * 255)
			state.c, state.m, state.y, state.k = c, m, y, k

			updateVisuals()
		end
	end))

	table.insert(connections, picker.options.close.MouseButton1Click:Connect(function()
		state.active = false
		local finalColor = Color3.fromHSV(state.h, state.s, state.v)
		state.gui.Parent.Parent:SetAttribute("Value", finalColor)
		picker:Destroy()
		for _, c in ipairs(connections) do
			pcall(function() c:Disconnect() end)
		end
	end))

	updateVisuals()
end
local function setLogMenu()
	logsOpened = true
	local logMenu = newgui.Parent.logs
	logMenu.Visible = true
	local MIN_WIDTH, MIN_HEIGHT = 170, 20
	local MAX_WIDTH, MAX_HEIGHT = CurrentCamera.ViewportSize.X-100, CurrentCamera.ViewportSize.Y-100
	CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		MAX_WIDTH, MAX_HEIGHT = CurrentCamera.ViewportSize.X-100, CurrentCamera.ViewportSize.Y-100
	end)
	logMenu.resizebottom.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if explorerOpened then
				if not countdowns["logMenu"] then
					resizingLogMenu = "Y"
					startMousePos = getMousePos()
					startLogSize = logMenu.Size
				end
			end
		end
	end)

	logMenu.resizeside.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if not countdowns["logMenu"] then
				resizingLogMenu = "X"
				startMousePos = getMousePos()
				startLogSize = logMenu.Size
			end
		end
	end)

	logMenu.resizeboth.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if not countdowns["logMenu"] then
				resizingLogMenu = "XY"
				startMousePos = getMousePos()
				startLogSize = logMenu.Size
			end
		end
	end)

	game:GetService("UserInputService").InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			resizingLogMenu = false
		end
	end)

	game:GetService("RunService").RenderStepped:Connect(function()
		if resizingLogMenu then
			local mouse = getMousePos()

			if resizingLogMenu == "Y" then
				local deltaY = mouse.Y - startMousePos.Y
				local newHeight = math.clamp(startLogSize.Y.Offset + deltaY, MIN_HEIGHT, MAX_HEIGHT)
				logMenu.Size = UDim2.new(startLogSize.X.Scale, startLogSize.X.Offset, 0, newHeight)
			elseif resizingLogMenu == "X" then
				local deltaX = mouse.X - startMousePos.X
				local newWidth = math.clamp(startLogSize.X.Offset + deltaX, MIN_WIDTH, MAX_WIDTH)
				logMenu.Size = UDim2.new(0, newWidth, startLogSize.Y.Scale, startLogSize.Y.Offset)
			elseif resizingLogMenu == "XY" then
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
		TweenService:Create(logMenu.resizebottom, TweenInfo.new(0.2), {
			BackgroundTransparency = 0.5
		}):Play()
	end)
	logMenu.resizebottom.MouseLeave:Connect(function()
		TweenService:Create(logMenu.resizebottom, TweenInfo.new(0.2), {
			BackgroundTransparency = 1
		}):Play()
	end)
	logMenu.resizeside.MouseEnter:Connect(function()
		TweenService:Create(logMenu.resizeside, TweenInfo.new(0.2), {
			BackgroundTransparency = 0.5
		}):Play()
	end)
	logMenu.resizeside.MouseLeave:Connect(function()
		TweenService:Create(logMenu.resizeside, TweenInfo.new(0.2), {
			BackgroundTransparency = 1
		}):Play()
	end)
	logMenu.resizeboth.MouseEnter:Connect(function()
		TweenService:Create(logMenu.resizeboth, TweenInfo.new(0.2), {
			BackgroundTransparency = 0.5
		}):Play()
	end)
	logMenu.resizeboth.MouseLeave:Connect(function()
		TweenService:Create(logMenu.resizeboth, TweenInfo.new(0.2), {
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
function setExecutor()
	local executor = newgui.Parent.executor

	executor.resizebottom.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if explorerOpened then
				if not countdowns["logMenu"] then
					resizingExecutor = "Y"
					startMousePos = getMousePos()
					startExecutorSize = executor.Size
				end
			end
		end
	end)

	executor.resizeside.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if not countdowns["logMenu"] then
				resizingExecutor = "X"
				startMousePos = getMousePos()
				startExecutorSize = executor.Size
			end
		end
	end)

	executor.resizeboth.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if not countdowns["logMenu"] then
				resizingExecutor = "XY"
				startMousePos = getMousePos()
				startExecutorSize = executor.Size
			end
		end
	end)
	game:GetService("RunService").RenderStepped:Connect(function()
		if resizingExecutor then
			local mouse = getMousePos()

			if resizingExecutor == "Y" then
				local deltaY = mouse.Y - startMousePos.Y
				local newHeight = math.clamp(startExecutorSize.Y.Offset + deltaY, 180, 2000)
				executor.Size = UDim2.new(startExecutorSize.X.Scale, startExecutorSize.X.Offset, 0, newHeight)
			elseif resizingExecutor == "X" then
				local deltaX = mouse.X - startMousePos.X
				local newWidth = math.clamp(startExecutorSize.X.Offset + deltaX, 0, 2000)
				executor.Size = UDim2.new(0, newWidth, startExecutorSize.Y.Scale, startExecutorSize.Y.Offset)
			elseif resizingExecutor == "XY" then
				local deltaX = mouse.X - startMousePos.X
				local deltaY = mouse.Y - startMousePos.Y
				local newWidth = math.clamp(startExecutorSize.X.Offset + deltaX, 180, 2000)
				local newHeight = math.clamp(startExecutorSize.Y.Offset + deltaY, 0, 2000)
				executor.Size = UDim2.new(0, newWidth, 0, newHeight)
			end
		end
		if draggingExecutor then
			local newX = getMousePos().X - startMousePos.X
			local newY = getMousePos().Y - startMousePos.Y
			local minX = 0
			local maxX = newgui.Parent.AbsoluteSize.X - executor.AbsoluteSize.X
			local minY = game.GuiService.TopbarInset.Height + executor.dragbutton.AbsoluteSize.Y
			local maxY = newgui.Parent.AbsoluteSize.Y - executor.AbsoluteSize.Y
			newX = math.clamp(startExecutorPos.X.Offset + newX, minX, maxX)
			newY = math.clamp(startExecutorPos.Y.Offset + newY, minY, maxY) 

			executor.Position = UDim2.new(0, newX, 0, newY)
		end
	end)
	executor.resizebottom.MouseEnter:Connect(function()
		TweenService:Create(executor.resizebottom, TweenInfo.new(0.2), {
			BackgroundTransparency = 0.5
		}):Play()
	end)
	executor.resizebottom.MouseLeave:Connect(function()
		TweenService:Create(executor.resizebottom, TweenInfo.new(0.2), {
			BackgroundTransparency = 1
		}):Play()
	end)
	executor.resizeside.MouseEnter:Connect(function()
		TweenService:Create(executor.resizeside, TweenInfo.new(0.2), {
			BackgroundTransparency = 0.5
		}):Play()
	end)
	executor.resizeside.MouseLeave:Connect(function()
		TweenService:Create(executor.resizeside, TweenInfo.new(0.2), {
			BackgroundTransparency = 1
		}):Play()
	end)
	executor.resizeboth.MouseEnter:Connect(function()
		TweenService:Create(executor.resizeboth, TweenInfo.new(0.2), {
			BackgroundTransparency = 0.5
		}):Play()
	end)
	executor.resizeboth.MouseLeave:Connect(function()
		TweenService:Create(executor.resizeboth, TweenInfo.new(0.2), {
			BackgroundTransparency = 1
		}):Play()
	end)
end
local CoreSettings = coreModules.Lib.Settings
CoreSettings.LoopConn = nil

function CoreSettings:CreateSetting(name, value, type)
	local templates = {}
	local template = createInstance("Frame", {
		Name = name,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 0.075),
	})
	createInstance("Frame", {
		Parent = template,
		Name = "divider",
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, 0, 0, 1),
		BorderSizePixel = 0,
	})
	createInstance("Frame", {
		Parent = template,
		Name = "separator",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.new(1, 1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(0, 1, 1, 0),
		BorderSizePixel = 0,
	})
	createInstance("TextLabel", {
		Parent = template,
		Name = "name",
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 5, 0.5, 0),
		Size = UDim2.new(0.5, -5, 0.8, 0),
		FontFace = Font.new(fonts.BuilderSans),
		Text = name,
		TextColor3 = Color3.new(1, 1, 1),
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left
	})
	local newTemplate = template:Clone()
	newTemplate.Name = name
	newTemplate.Parent = newgui.Parent.settings.list
	if type == "TextPole" then
		local pole = createInstance("TextBox", {
			Parent = newTemplate,
			Name = "value",
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 1,
			ClearTextOnFocus = false,
			Position = UDim2.new(1, -5, 0.5, 0),
			Size = UDim2.new(0.5, -5, 0.8, 0),
			FontFace = Font.new(fonts.BuilderSans),
			Text = value,
			TextColor3 = Color3.new(1, 1, 1),
			TextScaled = true,
		})
		createInstance("Frame", {
			Parent = pole,
			Name = "outline",
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(0, 0),
			BorderSizePixel = 0,
		})
		createInstance("UIStroke", {
			Parent = pole.outline,
			Color = Color3.new(1, 1, 1),
			LineJoinMode = Enum.LineJoinMode.Miter
		})
		pole.outline.Size = UDim2.fromOffset(pole.TextBounds.X + 5, pole.TextBounds.Y)
		newTemplate:SetAttribute("Value", pole.Text)
		pole:GetPropertyChangedSignal("Text"):Connect(function()
			newTemplate:SetAttribute("Value", pole.Text)
			pole.outline:TweenSize(UDim2.fromOffset(pole.TextBounds.X + 5, pole.TextBounds.Y), "InOut", "Size", 0.2, true)
		end)
	elseif type == "Slider" then
		local max, min, default = value[1].Max, value[1].Min, value[2]
		local slider = createInstance("Frame", {
			Parent = newTemplate,
			Name = "slider",
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundTransparency = 1,
			Position = UDim2.new(0.5, 4, 0.5, 0),
			Size = UDim2.new(0.5, -8, 0.5, 0),
		})
		createInstance("Frame", {
			Parent = slider,
			Name = "slider",
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.new(1, 1, 1),
			Position = UDim2.fromScale(0.4, 0.5),
			Size = UDim2.fromScale(0.7, 0.1),
			BorderSizePixel = 0
		})
		createInstance("Frame", {
			Parent = slider.slider,
			Name = "pointer",
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.new(),
			Position = UDim2.fromScale(0, 0.5),
			Size = UDim2.fromScale(0.1, 0.1),
			SizeConstraint = Enum.SizeConstraint.RelativeXX
		})
		createInstance("TextButton", {
			Parent = slider,
			Name = "activateregion",
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.8, 1),
			Text = ""
		})
		createInstance("TextBox", {
			Parent = slider,
			Name = "value",
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(1, 0.5),
			Size = UDim2.fromScale(0.2, 1),
			FontFace = Font.fromName("Oswald"),
			Text = default,
			TextColor3 = Color3.new(1, 1, 1),
			TextScaled = true,
		})
		createInstance("UIStroke", {
			Parent = slider.value,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Color3.new(1, 1, 1)
		})
		local output = math.clamp((default / max), 0, 1)
		slider.slider.pointer.Position = UDim2.fromScale(output, 0.5)
		slider.value.Text = output * max
		newTemplate:SetAttribute("Holding", false)
		newTemplate:SetAttribute("Value", slider.value.Text)
		slider.activateregion.MouseButton1Down:Connect(function()
			newTemplate:SetAttribute("Holding", true)
			CoreSettings.LoopConn = game:GetService("RunService").RenderStepped:Connect(function()
				if newTemplate:GetAttribute("Holding") then
					local value = math.clamp(((getMousePos().X - slider.slider.AbsolutePosition.X) / slider.slider.AbsoluteSize.X), 0, 1)
					slider.value.Text = math.floor(value * max)
					slider.slider.pointer.Position = UDim2.fromScale(value, 0.5)
					newTemplate:SetAttribute("Value", math.floor(value * max))
				end	
			end)
		end)
		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				newTemplate:SetAttribute("Holding", false)
				if CoreSettings.LoopConn then
					CoreSettings.LoopConn:Disconnect()
					CoreSettings.LoopConn = nil
				end
			end
		end)
		slider.value.FocusLost:Connect(function()
			local value = math.clamp(tonumber(slider.value.Text), min, max)
			local delta = (value / max)
			slider.slider.pointer.Position = UDim2.fromScale(delta, 0.5)
			slider.value.Text = math.floor(delta * max)
		end)
	elseif type == "Switch" then
		local switch = createInstance("TextButton", {
			Parent = newTemplate,
			Name = "switch",
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.new(1, 1, 1),
			Position = UDim2.fromScale(0.65, 0.5),
			Size = UDim2.fromScale(0.2, 0.8),
			Text = "",
			BorderSizePixel = 0
		})
		createInstance("Frame", {
			Parent = switch,
			Name = "pointer",
			BackgroundColor3 = Color3.new(),
			Size = UDim2.fromScale(1, 1),
			SizeConstraint = Enum.SizeConstraint.RelativeYY,
			BorderSizePixel = 0
		})
		newTemplate:SetAttribute("Value", value)
		switch.pointer.Position = UDim2.fromScale(value and 0.6 or 0, 0)
		switch.MouseButton1Click:Connect(function()
			if newTemplate:GetAttribute("Value") == true then
				newTemplate:SetAttribute("Value", false)
				switch.pointer:TweenPosition(UDim2.fromScale(0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.25)
			else
				newTemplate:SetAttribute("Value", true)
				switch.pointer:TweenPosition(UDim2.fromScale(0.6, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.25)
			end
		end)
	elseif type == "Color" then
		local formatStr = "[%d, %d, %d]"
		local currentColor = Color3.new(value.R, value.G, value.B)
		local rgb = {
			math.floor(currentColor.R * 255),
			math.floor(currentColor.G * 255),
			math.floor(currentColor.B * 255),
		}

		local color = createInstance("TextBox", {
			Parent = newTemplate,
			Name = "colorlabel",
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundTransparency = 1,
			ClearTextOnFocus = false,
			Position = UDim2.new(0.5, 4, 0.5, 0),
			Size = UDim2.new(0.405, -8, 0.8, 0),
			FontFace = Font.fromName("Oswald"),
			PlaceholderText = "[R, G, B]",
			Text = formatStr:format(table.unpack(rgb)),
			TextColor3 = Color3.new(1, 1, 1),
			TextScaled = true,
			TextXAlignment = Enum.TextXAlignment.Left
		})

		local pick = createInstance("TextButton", {
			Parent = color,
			Name = "pick",
			BackgroundColor3 = Color3.fromRGB(table.unpack(rgb)),
			Position = UDim2.fromScale(1, 0),
			Size = UDim2.fromScale(1, 1),
			SizeConstraint = Enum.SizeConstraint.RelativeYY,
			Text = "",
			BorderSizePixel = 0
		})

		newTemplate:SetAttribute("Value", currentColor)

		pick.MouseButton1Click:Connect(function()
			if not pickerOpened then
				setColorPicker(currentColor, pick)
			end
		end)

		color.FocusLost:Connect(function()
			local r, g, b = color.Text:match("%[?(%d+),?%s*(%d+),?%s*(%d+)%]?")
			if r and g and b then
				r, g, b = tonumber(r), tonumber(g), tonumber(b)
				r, g, b = math.clamp(r, 0, 255), math.clamp(g, 0, 255), math.clamp(b, 0, 255)

				currentColor = Color3.fromRGB(r, g, b)
				pick.BackgroundColor3 = currentColor
				color.Text = formatStr:format(r, g, b)
				newTemplate:SetAttribute("Value", currentColor)
			else
				color.Text = formatStr:format(table.unpack(rgb))
			end
		end)
	elseif type == "Dropdown" then
		local options = value[2]
		local firstVariant = value[1] or options[1]
		local dropdownButton = createInstance("TextButton", {
			Parent = newTemplate,
			Name = "dropdown",
			AnchorPoint = Vector2.new(0, 1),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			Position = UDim2.new(0.5, 4, 0.9, 0),
			Size = UDim2.new(0.5, -8, 0.8, 0),
			FontFace = Font.new(fonts.BuilderSans, Enum.FontWeight.Bold),
			Text = firstVariant,
			TextColor3 = Color3.new(1, 1, 1),
			TextScaled = true,
			BorderColor3 = Color3.new(0, 0, 0),
			BorderSizePixel = 0,
		})
		newTemplate:SetAttribute("Value", firstVariant)
		dropdownButton:SetAttribute("Opened", false)
		createInstance("UIStroke", {
			Parent = dropdownButton,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Color3.new(1, 1, 1),
			LineJoinMode = Enum.LineJoinMode.Miter
		})
		createInstance("UIGradient", {
			Parent = dropdownButton.UIStroke,
			Enabled = false,
			Rotation = 90,
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(0.9699999, 0),
				NumberSequenceKeypoint.new(0.97, 1),
				NumberSequenceKeypoint.new(1, 1)
			})
		})
		dropdownButton.MouseButton1Click:Connect(function()
			if not dropdownButton:GetAttribute("Opened") then
				dropdownButton.UIStroke.UIGradient.Enabled = true
				newgui.Parent.settings.list.ScrollingEnabled = false
				dropdownButton:SetAttribute("Opened", true)
				local dropdownPos = dropdownButton.AbsolutePosition + Vector2.new(0, GuiService.TopbarInset.Height)
				local frame = createInstance("Frame", {
					Parent = newgui.Parent,
					Name = "Dropdown_"..generateRandomString(),
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(102, 101, 103),
					Position = UDim2.fromOffset(dropdownPos.X, dropdownPos.Y),
					Size = UDim2.fromOffset(dropdownButton.AbsoluteSize.X, 0),
					BorderColor3 = Color3.new(0, 0, 0),
					BorderSizePixel = 0
				})
				createInstance("UIStroke", {Parent = frame, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, LineJoinMode = Enum.LineJoinMode.Miter})
				createInstance("UIGradient", {Parent = frame.UIStroke, Rotation = -90, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0),NumberSequenceKeypoint.new(0.969, 0),NumberSequenceKeypoint.new(0.97, 1),NumberSequenceKeypoint.new(1, 1)})})
				local dropdown = createInstance("ScrollingFrame", {
					Parent = frame,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 0),
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					CanvasSize = UDim2.fromScale(0, 0),
					ScrollBarThickness = 0
				})
				createInstance("UIListLayout", {Parent = dropdown})
				createInstance("UISizeConstraint", {Parent = dropdown, MaxSize = Vector2.new(1e308, 300)})
				for _, v in options do
					local option = createInstance("TextButton", {
						Parent = dropdown,
						Name = generateRandomString().."_"..v,
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						FontFace = Font.new(fonts.BuilderSans, Enum.FontWeight.Bold),
						Text = v,
						TextColor3 = Color3.new(1, 1, 1),
						TextScaled = true,
					})
					option.MouseEnter:Connect(function()
						for _, v in dropdown:GetChildren() do
							if v:IsA("TextButton") then
								v.BackgroundTransparency = 1
							end
						end
						option.BackgroundTransparency = 0.9
					end)
					option.MouseLeave:Connect(function()
						option.BackgroundTransparency = 1
					end)
					option.MouseButton1Click:Connect(function()
						dropdownButton.Text = v
						dropdownButton:SetAttribute("Opened", false)
						dropdownButton.UIStroke.UIGradient.Enabled = false
						newgui.Parent.settings.list.ScrollingEnabled = true
						dropdown:Destroy()
						newTemplate:SetAttribute("Value", firstVariant)
					end)
				end
			end
		end)
	end
end
function CoreSettings:CreateSeparator(name)
	local separator = createInstance("Frame", {
		Name = name,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 0.125),
	})
	createInstance("TextLabel", {
		Parent = separator,
		Name = "txt",
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, 0),
		Size = UDim2.fromScale(1, 1),
		FontFace = Font.fromName("Oswald"),
		Text = name,
		TextColor3 = Color3.new(1, 1, 1),
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left
	})
	createInstance("Frame", {
		Parent = separator.txt,
		BackgroundColor3 = Color3.new(1, 1, 1),
		Position = UDim2.new(0, -10, 1, 0),
		Size = UDim2.new(1, 0, 0, 1),
		BorderSizePixel = 0
	})
	local newSeparator = separator:Clone()
	newSeparator.Name = name
	newSeparator.Parent = newgui.Parent.settings.list
end
local luauPole: TextBox = newgui.Parent.executor.ScrollingFrame.luau
luauPole:GetPropertyChangedSignal("Text"):Connect(function()
	newgui.Parent.executor.ScrollingFrame.CanvasSize = UDim2.fromOffset(luauPole.TextBounds.X, luauPole.TextBounds.Y)
	modules.other.executor.Update(luauPole.Text, luauPole, luauPole.Parent.Parent.lines.TextLabel)
	newgui.Parent.executor.codeLimit.Text = #luauPole.ContentText.."/200K"
	luauPole.visual.Text = modules.other.executor.highlightLuau(luauPole.Text)
end)
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
	local success,color = pcall(function() return Color3.fromHex(newgui.Parent.colorpicker.middlebar.hex.TextBox.Text:gsub("#", "")) end)

	if success and color then
		local r, g, b = math.round(color.R * 255), math.round(color.G * 255), math.round(color.B * 255)
		local h, s, v = Color3.fromRGB(r, g, b):ToHSV()
		colors.r, colors.g, colors.b = r, g, b
		colors.h, colors.s, colors.v = h, s, v
		local module = modules[pickerMode]
		local pointer = newgui.Parent.colorpicker.picker.pointer
		pointer.Position = module.GetPointerPositionFromColor(h, s, v)
		newgui.Parent.colorpicker.middlebar.result.color.BackgroundColor3 = Color3.fromHSV(h, s, v)
		newgui.Parent.colorpicker.middlebar.hex.TextBox.Text = string.format("#%02x%02x%02x", colors.r, colors.g, colors.b)
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
		newgui.Parent.colorpicker.middlebar.hex.TextBox.Text = string.format("#%02x%02x%02x", colors.r, colors.g, colors.b)
	end
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
newgui.Parent.executor.dragbutton.MouseButton1Down:Connect(function()
	startMousePos = game.UserInputService:GetMouseLocation()
	startExecutorPos = newgui.Parent.executor.Position
	draggingExecutor = true
end)
newgui.Parent.colorpicker.picker.activateregion.MouseButton1Down:Connect(function()
	pickingColor = true
end)
game.UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		newgui.Parent.closeregion.Interactable = false
	end
end)
game.UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingExplorer = false
		draggingColorPicker = false
		pickingColor = false
		draggingLogs = false
		resizingColorPicker = false
		resizingExecutor = false
		draggingExecutor = false
		usingSlider = {
			enabled = false,
			slider = nil
		}
	end
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		newgui.Parent.closeregion.Interactable = true
	end
end)
local updateConn
newgui.placeinfo.MouseButton1Click:Connect(function()
	newgui.Parent.placeinfo.Visible = true
	newgui.Parent.closeregion.Visible = true

	local module = modules.other.placeinfo
	local placeId = game.PlaceId
	local gameInfo = game.MarketplaceService:GetProductInfo(placeId)

	module.CreateSeparator("GAME INFO")
	module.CreateText("Name", gameInfo.Name)
	module.CreateText("ID", gameInfo.AssetId)
	module.CreateText("Updated", gameInfo.Updated:sub(1, 10):gsub("-", "/"))
	module.CreateText("Created", gameInfo.Created:sub(1, 10):gsub("-", "/"))
	module.CreateText("CCU", 0)
	module.CreateText("Visits", 0)

	module.CreateSeparator("CREATOR INFO")

	local creatorName = gameInfo.Creator.Name or "Unknown"
	local creatorId = gameInfo.Creator.Id or 0
	local creatorType = gameInfo.Creator.CreatorType

	if creatorType == "Group" then
		module.CreateText("Group", creatorName .. (gameInfo.Creator.HasVerifiedBadge and utf8.char(0xE000) or ""))
	else
		pcall(function()
			local userName = game.Players:GetNameFromUserIdAsync(creatorId)
			module.CreateText("Creator", userName .. (gameInfo.Creator.HasVerifiedBadge and utf8.char(0xE000) or ""))
		end)
	end

	module.CreateText("UserId", creatorId)

	local safeLimit = 4000
	local warnLimit = 11000

	module.CreateSeparator("CLIENT")
	module.CreateText("Ping", math.round(LocalPlayer:GetNetworkPing() * 1000) .. "ms")
	module.CreateText("FPS", 0)
	module.CreateText("Client Memory Usage", 0)

	updateConn = RunService.RenderStepped:Connect(function()
		local fps = math.round((1 / RunService.RenderStepped:Wait()))
		local ratio = math.clamp(fps / 60, 0, 1)
		local r = 255 - ratio * 255
		local g = ratio * 255

		modules.other.placeinfo.UpdateText("FPS", ('<font color="rgb(%d, %d, 0)">%sfps</font>'):format(r, g, fps))
		modules.other.placeinfo.UpdateText("Ping", math.round(LocalPlayer:GetNetworkPing() * 1000) .. "ms")
	end)

	task.spawn(function()
		while updateConn do
			local ok, response = pcall(function()
				local url = "https://games.roblox.com/v1/games?universeIds=" .. game.GameId
				return HttpService:JSONDecode(game:HttpGet(url))
			end)

			if ok and response and response.data and response.data[1] then
				local data = response.data[1]
				module.UpdateText("CCU", format(data.playing, false, true, 3))
				module.UpdateText("Visits", format(data.visits, false, true, 3))
			end

			local CMU = math.floor(stst:GetTotalMemoryUsageMb())
			local ratio = math.clamp((CMU - safeLimit) / (warnLimit - safeLimit), 0, 1)
			local r = 255 * ratio
			local g = 255 * (1 - ratio)
			local b = 0

			module.UpdateText(
				"Client Memory Usage",
				string.format('<font color="rgb(%d,%d,%d)">%s MB</font>', r, g, b, CMU)
			)

			task.wait(1)
		end
	end)
end)

newgui.Parent.closeregion.MouseButton1Click:Connect(function()
	newgui.Parent.placeinfo.Visible = false
	newgui.Parent.closeregion.Visible = false
	if updateConn then
		updateConn:Disconnect()
		updateConn = nil
	end
	for _, v in newgui.Parent.placeinfo.list:GetChildren() do
		if v:IsA("Frame") then
			v:Destroy()
		end
	end
end)
local function fixMagnitudeLimit(x, y, z)
	return math.sqrt(x^2 + y^2 + z^2)
end

local guiobj_1 = newgui.list
CoreSettings:CreateSetting("UI Color", currentUIColor, "Color")
CoreSettings:CreateSeparator("Executor")
CoreSettings:CreateSetting("Text Color", executorConfig.textColor, "Color")
CoreSettings:CreateSetting("Background Color", executorConfig.backgroundColor, "Color")
CoreSettings:CreateSetting("String Color", executorConfig.stringColor, "Color")
CoreSettings:CreateSetting("Number Color", executorConfig.numberColor, "Color")
CoreSettings:CreateSetting("Library Color", executorConfig.libColor, "Color")
CoreSettings:CreateSetting("Operator Color", executorConfig.operatorColor, "Color")
CoreSettings:CreateSetting("Function Color", executorConfig.funcColor, "Color")
CoreSettings:CreateSetting("Comment Color", executorConfig.commentColor, "Color")
CoreSettings:CreateSetting("Keyword Color", executorConfig.keywordColor, "Color")
CoreSettings:CreateSetting("Bools Color", executorConfig.boolsColor, "Color")
CoreSettings:CreateSetting("Text Size", {NumberRange.new(5, 25), executorConfig.TextSize}, "Slider")
CoreSettings:CreateSeparator("Misc")
CoreSettings:CreateSetting("Constraints Visible", false, "Switch")
CoreSettings:CreateSetting("Custom Cursor", false, "Switch")
CoreSettings:CreateSeparator("DS")
CoreSettings:CreateSetting("Cheat Enabled", false, "Switch")
CoreSettings:CreateSetting("Mode", {"follow", {"spectate","follow"}}, "Dropdown")
CoreSettings:CreateSetting("Format Mode", {
	"Thousand",
	{
		"Thousand",
		"Million",
		"Billion",
		"Trillion",
		"Quadrillion",
		"Quintillion",
		"Sextillion",
		"Septillion",
		"Octillion",
		"Nonillion",
		"Decillion",
		"Undecillion"
	}
}, "Dropdown")
local commands = {}
local function registerCommand(name, callback)
	local template = createInstance("TextButton", {
		Parent = newgui.Parent.commandbar.commandlist,
		Name = name,
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(195, 15),
		FontFace = Font.new(fonts.SourceSansPro, Enum.FontWeight.Bold),
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
	template.MouseButton1Click:Connect(function()

	end)
	commands[name] = callback
end
local function runCommand(input)
	if input == "" then
		return
	end
	if input:sub(1, 1) == commandPrefix then
		input = input:sub(2)
	end

	local parts = input:split(" ")
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
local specialBlocks = {
	["Piston"] = {
		AditionalProperties = {
			"ExtendLength",
			"LastDirection",
			"Speed"
		}
	},
	["Delay"] = {
		AditionalProperties = {
			"WaitDuration"
		}
	}
}
if game.PlaceId == 537413528 then
	local folder = "DeepScopeCore/Addons/"..game.MarketplaceService:GetProductInfo(game.PlaceId).Name.."/Builds"
	makefolder(folder)
	local points = {
		CFrame.new(-164.266, 356.9, 288.862),
		CFrame.new(-164.266, 77.9, 1371.862),
		CFrame.new(-164.266, 77.9, 8611.861),
		CFrame.new(-49.883, 300.1, 8956.861),
		CFrame.new(-55.883, -361.1, 9490.861),
	}

	local waitTimes = {
		[1] = 0,
		[2] = 0,
		[3] = 0,
		[4] = 0,
		[5] = 17,
	}

	local moveSpeed = 300
	local enabled = false
	local connection = nil
	local currentPoint = 1
	local startCFrame, endCFrame, duration, startTime
	local bodyP = nil
	local attachment, beam = nil, nil
	local isWaiting = false
	local function tryGetHRP()
		local char = LocalPlayer.Character
		if char then
			return char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
		end
		return nil
	end

	local function cleanupVisuals()
		if attachment then
			attachment:Destroy()
			attachment = nil
		end
		if beam then
			beam:Destroy()
			beam = nil
		end
	end

	local function cleanupBodyP()
		if bodyP then
			bodyP:Destroy()
			bodyP = nil
		end
	end
	local function recalcSegment()
		startCFrame = points[currentPoint]
		endCFrame = points[currentPoint + 1] or points[1]
		duration = (endCFrame.Position - startCFrame.Position).Magnitude / moveSpeed
		startTime = tick()
	end
	local function ensureMovementSetup()
		local hrp = tryGetHRP()
		if hrp and not bodyP then
			bodyP = Instance.new("BodyPosition")
			bodyP.MaxForce = Vector3.new(1e6, 1e6, 1e6)
			bodyP.P = 5e4
			bodyP.D = 1250
			bodyP.Position = startCFrame.Position
			bodyP.Parent = hrp
		end

		local char = LocalPlayer.Character
		if char and not attachment and not beam and endCFrame then
			attachment = Instance.new("Attachment")
			attachment.Parent = workspace
			attachment.WorldCFrame = endCFrame

			beam = Instance.new("Beam")
			beam.Parent = workspace
			beam.LightEmission = 0
			beam.Texture = "rbxassetid://138007024966757"
			beam.TextureSpeed = -1
			beam.TextureMode = 2
			beam.FaceCamera = true
			beam.Attachment0 = attachment
			pcall(function()
				if char.PrimaryPart and char.PrimaryPart:FindFirstChild("RootAttachment") then
					beam.Attachment1 = char.PrimaryPart.RootAttachment
				elseif char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart:FindFirstChild("RootAttachment") then
					beam.Attachment1 = char.HumanoidRootPart.RootAttachment
				end
			end)
		end
	end
	local function onHeartbeat()
		if not enabled or isWaiting then return end
		local hrp = tryGetHRP()
		if not hrp then LocalPlayer.Character.Humanoid.Health = 0 return end

		if not startCFrame or not endCFrame then
			recalcSegment()
		end

		local now = tick()
		local alpha = duration > 0 and math.clamp((now - startTime) / duration, 0, 1) or 1
		local newPos = startCFrame.Position:Lerp(endCFrame.Position, alpha)

		if not bodyP then
			ensureMovementSetup()
		end
		if bodyP then
			bodyP.Position = newPos
		end

		if attachment and endCFrame then
			attachment.WorldCFrame = endCFrame
		end
		if alpha >= 1 then
			currentPoint += 1

			if currentPoint > #points then
				currentPoint = 1
				local char = LocalPlayer.Character
				if bodyP then
					bodyP.Position = points[currentPoint].Position
				end

				recalcSegment()
				return
			end
			local waitTime = waitTimes[currentPoint] or 0
			if waitTime > 0 then
				isWaiting = true
				task.spawn(function()
					task.wait(waitTime)
					if enabled then
						isWaiting = false
						recalcSegment()
					end
				end)
			else
				recalcSegment()
			end
		end
	end
	local function startMove()
		if enabled then return end
		enabled = true
		currentPoint = 1
		recalcSegment()
		ensureMovementSetup()

		if not connection then
			connection = RunService.Heartbeat:Connect(onHeartbeat)
		end
		LocalPlayer.CharacterAdded:Connect(function(char)
			task.wait(0.1)
			cleanupBodyP()
			cleanupVisuals()
			if enabled then
				recalcSegment()
				ensureMovementSetup()
			end
		end)
		if LocalPlayer.Character then
			local humanoid = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
			if humanoid then
				humanoid.Died:Connect(function()
					cleanupBodyP()
					cleanupVisuals()
				end)
			end
		end
	end

	local function disable()
		enabled = false
		isWaiting = false
		if connection then
			connection:Disconnect()
			connection = nil
		end
		cleanupBodyP()
		cleanupVisuals()
	end
	CoreSettings:CreateSeparator("Addons")
	CoreSettings:CreateSetting("Auto farm", false, "Switch")
	CoreSettings:CreateSetting("Auto Trick Or Treat", false, "Switch")
	local uiSwitch2 = newgui.Parent.settings.list["Auto Trick Or Treat"]
	local uiSwitch = newgui.Parent.settings.list["Auto farm"]
	LocalPlayer.CharacterAdded:Connect(function()
		if uiSwitch:GetAttribute("Value") == true and uiSwitch2:GetAttribute("Value") == false then
			wait(2)
			disable()
			startMove()
		end
	end)

	uiSwitch:GetAttributeChangedSignal("Value"):Connect(function()
		if uiSwitch:GetAttribute("Value") == true and uiSwitch2:GetAttribute("Value") == false then
			startMove()
		else
			disable()
		end
	end)

	if uiSwitch:GetAttribute("Value") == true and uiSwitch2:GetAttribute("Value") == false then
		startMove()
	end

	local houses = {}
	local connection2
	local bodyP2, bodyG2
	local currentCFrame = CFrame.new(0, -400, 0)
	local enabled = false
	local updateThread = nil

	local function createBodyMovers()
		local char = LocalPlayer.Character
		if not char then return end
		local root = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
		if not root then return end
		runCommand("noclip")
		runCommand("spin")
		if not bodyP2 then
			bodyP2 = Instance.new("BodyPosition")
			bodyP2.MaxForce = Vector3.new(1e6, 1e6, 1e6)
			bodyP2.P = 5e4
			bodyP2.D = 1250
			bodyP2.Position = currentCFrame.Position
			bodyP2.Parent = root
		end
		if not bodyG2 then
			bodyG2 = Instance.new("BodyGyro")
			bodyG2.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
			bodyG2.CFrame = currentCFrame
			bodyG2.Parent = root
		end
	end

	local function destroyBodyMovers()
		if bodyP2 then
			bodyP2:Destroy()
			bodyP2 = nil
		end
		if bodyG2 then
			bodyG2:Destroy()
			bodyG2 = nil
		end
	end

	task.spawn(function()
		while task.wait(5) do
			pcall(function()
				local housesFolder = workspace:FindFirstChild("Houses")
				if housesFolder then
					houses = housesFolder:GetChildren()
				end
			end)
		end
	end)

	local function startMoving()
		if updateThread then return end
		updateThread = task.spawn(function()
			while enabled do
				task.wait(0.5)
				if uiSwitch2:GetAttribute("Value") == true and uiSwitch:GetAttribute("Value") == false then
					createBodyMovers()

					local selectedHouse = houses[#houses]
					if selectedHouse and selectedHouse.PrimaryPart then
						local offset = CFrame.new(0, 3, -1.5)
						currentCFrame = selectedHouse.PrimaryPart.CFrame * offset
					else
						currentCFrame = CFrame.new(0, -400, 0)
					end
				else
					destroyBodyMovers()
				end

				if bodyP2 and bodyG2 then
					bodyP2.Position = currentCFrame.Position
					bodyG2.CFrame = currentCFrame
				end
			end
		end)
	end

	local function hookCharacter(char)
		local humanoid = char:WaitForChild("Humanoid", 5)
		if humanoid then
			humanoid.Died:Connect(function()
				destroyBodyMovers()
			end)
		end
	end


	local function enableMode()
		if enabled then return end
		enabled = true
		createBodyMovers()
		startMoving()
		LocalPlayer.Character.Humanoid.PlatformStand = true
	end

	local function disableMode()
		enabled = false
		destroyBodyMovers()
		LocalPlayer.Character.Humanoid.PlatformStand = false
		if updateThread then
			task.cancel(updateThread)
			updateThread = nil
		end
	end
	LocalPlayer.CharacterAdded:Connect(function(char)
		task.wait(1)
		if enabled and uiSwitch2:GetAttribute("Value") == true then
			disableMode()
			enableMode()
		end
	end)
	uiSwitch2:GetAttributeChangedSignal("Value"):Connect(function()
		if uiSwitch2:GetAttribute("Value") == true then
			enableMode()
		else
			disableMode()
		end
	end)
	if uiSwitch2:GetAttribute("Value") == true then
		enableMode()
	end

	local button = createInstance("TextButton", {
		Parent = newgui,
		Name = "autobuild",
		Position = UDim2.fromScale(0.15, 1.658),
		Size = UDim2.fromScale(0.138, 0.343),
		Text = "auto build",
		TextScaled = true
	})
	local opened = false
	local function calculatePosition(pos, player)
		local plrTeam = tostring(player.TeamColor)
		local buildZone = workspace[plrTeam.."Zone"]
		local diff = buildZone.Position - pos
		return tostring(diff.X..","..diff.Y..","..diff.Z)
	end
	local function calculateSize(obj)
		local hasBind = nil
		pcall(function()
			hasBind = obj:FindFirstChildOfClass("Value").Name:find("Bind") ~= nil
		end)
		if hasBind then
			return nil
		else
			return tostring(obj.PPart.Size.X..","..obj.PPart.Size.Y..","..obj.PPart.Size.Z)
		end
	end
	local function calculateRotation(obj)
		return tostring(obj.PPart.Rotation.X..","..obj.PPart.Rotation.Y..","..obj.PPart.Rotation.Z)
	end
	button.MouseButton1Click:Connect(function()
		if not opened then
			local main = createInstance("Frame", {
				Parent = newgui.Parent,
				Name = "autobuild",
				BackgroundColor3 = Color3.new(0.4, 0.396078, 0.403922),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.fromOffset(240, 200)
			})
			createInstance("TextButton", {
				Parent = main,
				Name = "dragbutton",
				AnchorPoint = Vector2.new(0, 1),
				BackgroundColor3 = Color3.new(0.4, 0.396078, 0.403922),
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 30),
				FontFace = Font.new(fonts.FiraSans),
				Text = "auto build",
				TextColor3 = Color3.new(1, 1, 1),
				TextSize = 20
			})
			createInstance("TextButton", {
				Parent = main.dragbutton,
				Name = "fullclose",
				AnchorPoint = Vector2.new(1, 0),
				BackgroundTransparency = 1,
				Text = "",
				Position = UDim2.new(1, -30, 0, 5),
				Size = UDim2.new(0, 20, 0, 20),
			})
			createInstance("UIStroke", {
				Parent = main.dragbutton.fullclose,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				LineJoinMode = Enum.LineJoinMode.Miter
			})
			createInstance("ImageLabel", {
				Parent = main.dragbutton.fullclose,
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Image = "rbxassetid://74120900238837"
			})
			createInstance("TextButton", {
				Parent = main,
				Name = "resizeboth",
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, 0, 1, 0),
				Size = UDim2.new(0, 7, 0, 7),
				Text = ""
			})
			createInstance("TextButton", {
				Parent = main,
				Name = "resizebottom",
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 1, 0),
				Size = UDim2.new(1, 0, 0, 7),
				Text = ""
			})
			createInstance("TextButton", {
				Parent = main,
				Name = "resizeside",
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, 0, 0, -30),
				Size = UDim2.new(0, 7, 1, 30),
				Text = ""
			})
			local filename = createInstance("TextBox", {	
				Parent = main,
				Name = "filename",
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.new(0.5, 0, 0, 10),
				Size = UDim2.new(1, -20, 0, 20),
				PlaceholderColor3 = Color3.new(1, 1, 1),
				PlaceholderText = "file name",
				Text = "",
				TextColor3 = Color3.new(1, 1, 1),
				TextScaled = true,
			})
			local loadbutton = createInstance("TextButton", {	
				Parent = main,
				Name = "loadbutton",
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.new(0.5, 0, 0.4, 35),
				Size = UDim2.new(0.5, 0, 0, 20),
				Text = "load file",
				TextColor3 = Color3.new(1, 1, 1),
				TextScaled = true
			})
			local loadfilebox = createInstance("TextBox", {	
				Parent = main,
				Name = "loadfilebox",
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.new(0.5, 0, 0.4, 10),
				Size = UDim2.new(1, -20, 0, 20),
				PlaceholderColor3 = Color3.new(1, 1, 1),
				PlaceholderText = "file name to load",
				Text = "",
				TextColor3 = Color3.new(1, 1, 1),
				TextScaled = true,
			})
			local playername = createInstance("TextBox", {
				Parent = main,
				Name = "playername",
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.new(0.5, 0, 0.27, 10),
				Size = UDim2.new(1, -20, 0, 20),
				PlaceholderColor3 = Color3.new(1, 1, 1),
				PlaceholderText = "player name",
				Text = "",
				TextColor3 = Color3.new(1, 1, 1),
				TextScaled = true,
			})
			local savebutton = createInstance("TextButton", {	
				Parent = main,
				Name = "savebutton",
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.new(0.5, 0, 0, 35),
				Size = UDim2.new(0.5, 0, 0, 20),
				Text = "save file",
				TextColor3 = Color3.new(1, 1, 1),
				TextScaled = true
			})
			savebutton.MouseButton1Click:Connect(function()
				local player = game.Players:FindFirstChild(playername.Text)
				local fileName = player.Name..".build"
				if player then
					local saved = {}
					local playerBlocks = workspace.Blocks[player.Name]
					for _, v in playerBlocks:GetChildren() do
						saved[v.Name] = {
							Name = v.Name,
							Position = calculatePosition(v.PrimaryPart.Position, player),
							Size = calculateSize(v),
							Color = v.Name ~= "Portal" and v.PPart.Color:ToHex() or v.PortalPart.Color:ToHex(),
							Anchored = v.PPart.Anchored,
							Rotation = calculateRotation(v)
						}
						if v.Name == "Delay" then
							saved[v.Name].WaitDuration = v.WaitDuration.Value
						end	
						if v.Name == "Piston" then
							saved[v.Name].ExtendLength = v.ExtendLength.Value
							saved[v.Name].Speed = v.Speed.Value
						end
					end
					local json = HttpService:JSONEncode(saved)
					writefile(folder.."/"..fileName..".build", json)
				end
			end)
			loadbutton.MouseButton1Click:Connect(function()
				local currentPlot = workspace[tostring(LocalPlayer.TeamColor).."Zone"]
				local fileName = ""
				if currentPlot then
					if loadfilebox.Text == "" then
						notify(nil, "Please, enter File Name")
						return
					end
					local data = HttpService:JSONDecode(readfile(folder.."/"..loadfilebox.Text..".build"))
					for _, v in data do
						local name = v.Name
						local newBlock = game.ReplicatedStorage.BuildingParts[name]:Clone()
						newBlock.Parent = workspace.Blocks[LocalPlayer.Name]
						for i, v_2 in v do
							if i == "Position" then
								newBlock:SetPrimaryPartCFrame(CFrame.new(currentPlot.Position - Vector3.new(table.unpack(v_2:split(",")))))
							end
							if i == "Size" then
								newBlock.PPart.Size = Vector3.new(table.unpack(v_2:split(",")))
							end
							if i == "Rotation" then
								newBlock:PivotTo(newBlock.PPart.CFrame * CFrame.Angles(table.unpack(v_2:split(","))))
							end
							if i == "Color" then
								if name == "Portal" then
									newBlock.PortalPart.Color = Color3.fromHex(v_2)
								else
									for _, v_3 in newBlock:GetDescendants() do
										if v_3:IsA("BasePart") then
											v_3.Color = Color3.fromHex(v_2)
										end
									end
								end
							end
							if i == "Anchored" then
								newBlock.PPart.Anchored = v_2
							end
							wait()
						end
					end
				end
			end)
			main.dragbutton.fullclose.MouseButton1Click:Connect(function()
				opened = false
				main:Destroy()
			end)
		end		
	end)
end
local conn = nil
local currentCursor = nil
newgui.Parent.settings.list["Custom Cursor"]:GetAttributeChangedSignal("Value"):Connect(function()
	if newgui.Parent.settings.list["Custom Cursor"]:GetAttribute("Value") == true then
		UserInputService.MouseIconEnabled = false
		currentCursor = createInstance("ImageLabel", {
			Parent = newgui.Parent,
			Name = to_base64(generateRandomString()),
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.fromOffset(75, 75),
			Image = "rbxassetid://7767269282",
			ZIndex = 2147483647
		})
		conn = game:GetService("RunService").RenderStepped:Connect(function()
			currentCursor.Position = UDim2.fromOffset(getMousePos().X, getMousePos().Y)
		end)
	else
		if conn then
			conn:Disconnect()
			conn = nil
		end
		UserInputService.MouseIconEnabled = true
		currentCursor:Destroy()
	end
end)
newgui.settings.MouseButton1Click:Connect(function()
	newgui.Parent.settings.Visible = true
end)
newgui.Parent.settings.dragbutton.fullclose.MouseButton1Click:Connect(function()
	newgui.Parent.settings.Visible = false
end)
local function search()
	local text = newgui.searchPlayer.Text:lower()
	local list = guiobj_1:GetChildren()

	for _, v in list do
		if v:IsA("TextButton") then
			if text == "" then
				v.Visible = true
			else
				local name = v.Text:split(" | ")[1]:lower()
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
	local gui_template = createInstance("TextButton", {
		Parent = nil,
		Name = "template",
		Size = UDim2.new(1, 0, 0.2, 0),
		Text = "",
		BackgroundColor3 = currentUIColor,
		BorderColor3 = Color3.new(0, 0, 0),
		BorderSizePixel = 0,
		Visible = false,
		TextScaled = true
	})
	for _, v in guiobj_1:GetChildren() do
		if v:IsA("TextButton") then
			v:Destroy()
		end
	end
	for _, v in game.Players:GetPlayers() do
		if v.Name ~= LocalPlayer.Name then
			local new = gui_template:Clone()
			new.Name = v.Name
			new.Text = v.Name.." | "..v.DisplayName
			new.Parent = guiobj_1
			new.MouseButton1Click:Connect(function()
				newgui.currentplr.Text = "selectedPlayer: "..v.Name
				selectedplr = v.Name
				AddLog("Player Attached.", "DeepScope", "info")
			end)
			new.MouseButton2Click:Connect(function()
				newgui.currentplr.Text = "selectedPlayer: nobody"
				selectedplr = "nobody"
				AddLog("Player Deattached.", "DeepScope", "info")
			end)
		end
	end
	search()
	newgui.label.Text = "select player | total players: "..#game.Players:GetPlayers()
end
updatePlayerList()
game.Players.ChildAdded:Connect(function(plr)
	updatePlayerList()
	notify(nil, "Player "..plr.Name.." Joined.", 4)
	AddLog("Player "..plr.Name.." Joined.", "Server", "info")
end)
game.Players.ChildRemoved:Connect(function(plr)
	updatePlayerList()
	notify(nil, "Player "..plr.Name.." Left.", 4)
	AddLog("Player "..plr.Name.." Left.", "Server", "info")
	if plr.Name == selectedplr then
		notify(nil, "Player "..plr.Name.." Left, target deattached")
		selectedplr = "nobody"
		newgui.currentplr.Text = "selectedPlayer: "..selectedplr
	end
end)
local db = false
for _, v in newgui:GetChildren() do
	v:SetAttribute("OriginalPosition", v.Position)
	v:SetAttribute("OriginalSize", v.Size)
end
newgui.hidebutton.MouseButton1Click:Connect(function()
	if not db then
		guiHiden = not guiHiden
		db = true
		for _, v in newgui:GetChildren() do
			if v.Name ~= "hidebutton" then
				if guiHiden then
					v:TweenPosition(UDim2.fromScale(0, 5), "InOut", "Quad", 0.5, true)
					v:TweenSize(UDim2.fromOffset(0, 0), "InOut", "Quad", 0.5, true)
				else
					v:TweenPosition(v:GetAttribute("OriginalPosition"), "InOut", "Quad", 0.5, true)
					v:TweenSize(v:GetAttribute("OriginalSize"), "InOut", "Quad", 0.5, true)
				end
			end
		end
		delay(1, function()
			db = false
		end)
		newgui.hidebutton.Text = guiHiden and "show" or "hide"
	end
end)

newgui.unitformat.MouseButton1Click:Connect(function()
	if currentUnit == "K" then
		currentUnit = "M"
	elseif currentUnit == "M" then
		currentUnit = "B"
	elseif currentUnit == "B" then
		currentUnit = "T"
	elseif currentUnit == "T" then
		currentUnit = "QA"
	elseif currentUnit == "QA" then
		currentUnit = "QI"
	elseif currentUnit == "QI" then
		currentUnit = "SX"
	elseif currentUnit == "SX" then
		currentUnit = "SP"
	elseif currentUnit == "SP" then
		currentUnit = "OC"
	elseif currentUnit == "OC" then
		currentUnit = "NO"
	elseif currentUnit == "NO" then
		currentUnit = "DC"
	elseif currentUnit == "DC" then
		currentUnit = "UND"
	elseif currentUnit == "UND" then
		currentUnit = "K"
	end
	AddLog("Number format changed to: "..currentUnit, "DeepScope", "info")
	newgui.unitformat.Text = "format: "..currentUnit
end)

newgui.startbutton.MouseButton1Down:Connect(function()
	cheatEnabled = not cheatEnabled
	newgui.startbutton.Text = cheatEnabled and "stop" or "start"
	if cheatEnabled == true then
		lastcf = LocalPlayer.Character:GetPrimaryPartCFrame()
	else
		LocalPlayer.Character:SetPrimaryPartCFrame(lastcf)
		lastcf = CFrame.new(0, 0, 0)
	end
end)
newgui.Parent.commandbar:GetAttributeChangedSignal("Hovering"):Connect(function()
	if newgui.Parent.commandbar:GetAttribute("Hovering") then
		newgui.Parent.commandbar:TweenSize(UDim2.fromOffset(195, 138), "InOut", "Quad", 0.3, true)
	else
		newgui.Parent.commandbar:TweenSize(UDim2.fromOffset(195, 18), "InOut", "Quad", 0.3, true)
	end
end)
newgui.utils.MouseButton1Click:Connect(function()
	if not utilsOpened then
		utilsOpened = true
		newgui.utils.utils:TweenSize(newgui.utils.utils:GetAttribute("Size"), "InOut", "Sine", 0.3, true)
	else
		utilsOpened = false
		newgui.utils.utils:TweenSize(UDim2.fromOffset(0, 0), "InOut", "Sine", 0.3, true)
	end
end)
newgui.utils.utils.executor.MouseButton1Click:Connect(function()
	if not newgui.Parent.executor.Visible then
		newgui.Parent.executor.Visible = true
		setExecutor()
	end
end)
local textBox: TextBox = newgui.Parent.commandbar.input
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == commandKey then
		RunService.RenderStepped:Wait()
		textBox:CaptureFocus()
		textBox.Parent:SetAttribute("Hovering", true)
	end
end)
newgui.Parent.commandbar.hoverregion.MouseEnter:Connect(function()
	textBox.Parent:SetAttribute("Hovering", true)
end)
newgui.Parent.commandbar.hoverregion.MouseLeave:Connect(function()
	if not textBox:IsFocused() then
		textBox.Parent:SetAttribute("Hovering", false)
	end
end)
newgui.searchPlayer.Changed:Connect(function()
	search()
end)
notify("rbxthumb://type=AvatarHeadShot&id="..LocalPlayer.UserId.."&w=420&h=420", initMessages[math.random(1, #initMessages)]:gsub("{player}", LocalPlayer.DisplayName), 10)
warn("\97\87\89\103\101\87\57\49\73\72\78\108\90\83\66\48\97\71\108\122\76\67\66\107\98\50\53\48\73\71\86\52\99\71\120\118\97\88\81\103\89\87\53\53\98\87\57\121\90\83\69\61")
newgui.mode.MouseButton1Down:Connect(function()
	if mode == "follow" then
		mode = "spectate"
	elseif mode == "spectate" then
		mode = "follow"
	end
	newgui.mode.Text = "mode: "..mode
end)
LocalPlayer.Character.Humanoid.Seated:Connect(function(active, seat)
	if Enabled and seat and seat:IsA("VehicleSeat") then
		humanoid.Sit = false
		humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 15, 0)

		notify("rbxassetid://6525485104", "You cant seat on VehicleSeat while Flying!", 6)
	end
end)
local function checkIfR15(char)
	return char:FindFirstChild("UpperTorso") ~= nil
end
textBox.FocusLost:Connect(function()
	textBox.Parent:SetAttribute("Hovering", false)
	runCommand(textBox.Text)
end)
textBox.Changed:Connect(function()
	local text = textBox.Text:lower()
	local list = newgui.Parent.commandbar.commandlist:GetChildren()

	for _, v in list do
		if v:IsA("TextButton") then
			if text == "" then
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
	newgui.startbutton.Text = cheatEnabled and "stop" or "start"
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
	notify("rbxassetid://1352543873", `Welcome! "DeepScope command bar" is inspired by <font color="rgb(85,0,255)">IY</font>. all design and functionality credit goes to EdgeIY"s <font color="rgb(85,0,255)">Infinity Yield</font>.`, 10)
end)
local Noclipping = nil
registerCommand("noclip", function()
	wait(0.1)
	if Noclipping then
		Noclipping:Disconnect()
		Noclipping = nil
	end
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
end)
registerCommand("unnoclip", function()
	if Noclipping then
		Noclipping:Disconnect()
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
registerCommand("serverhop", function(args, speaker)
	local servers = {}
	local req = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true")
	local body = HttpService:JSONDecode(req)

	if body and body.data then
		for i, v in next, body.data do
			if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
				table.insert(servers, 1, v.id)
			end
		end
	end

	if #servers > 0 then
		game["Teleport Service"]:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
	else
		notify(nil, "Could't find a server.")
		return
	end
end)
registerCommand("exit", function()
	game:Shutdown()
end)
registerCommand("align", function(args)
	local unit = tostring(args[1]) or "left"
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
registerCommand("speed", function(args)
	local speed = tonumber(args[1]) or 16
	local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = speed
	end
end)
registerCommand("jumppower", function(args)
	local jump = tonumber(args[1]) or 50
	local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.JumpPower = jump
	end
end)
registerCommand("spin", function(args)
	local speed = tonumber(args[1]) or 20
	local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if root then
		for i,v in pairs(root:GetChildren()) do
			if v.Name == "spin" then
				v:Destroy()
			end
		end
		local BAV = Instance.new("BodyAngularVelocity", root)
		BAV.Name = "spin"
		BAV.MaxTorque = Vector3.new(0, math.huge, 0)
		BAV.AngularVelocity = Vector3.new(0, speed, 0)
	end
end)
registerCommand("unspin", function()
	local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if root then
		for i,v in pairs(root:GetChildren()) do
			if v.Name == "spin" then
				v:Destroy()
			end
		end
	end
end)
registerCommand("notifyping", function()
	notify(nil, "Ping: "..math.round(LocalPlayer:GetNetworkPing() * 1000).."ms", 4)
end)
registerCommand("notifyfps", function()
	notify(nil, "FPS: "..math.round(1 / game:GetService("RunService").RenderStepped:Wait()).."fps", 4)
end)
registerCommand("guiscale", function(args)
	local min = 0.5
	local max = 3
	local value = tonumber(args[1]) or 1
	local uiscale = newgui.Parent.commandbar.UIScale

	if uiscale then
		uiscale.Scale = math.clamp(value, min, max)
	end
end)
savePlayedGames()
while true do
	task.wait()
	if selectedplr ~= "nobody" then
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
						newgui.distance.Text = "distance from character: " ..  format(math.round(distance), false, true, 3) .. " | " .. format(distance, true, false) .. ` ({precent_toT}% to one {fullUnits[currentUnit:lower()]})`
						newgui.spawndistance.TextColor3 = Color3.new(math.clamp(distance / units[currentUnit:lower()], 0, 1), 0, 0)	
					end)
				else
					newgui.distance.Text = "distance from character: unknown | unknown"
				end
				if cheatEnabled == true then
					if LocalPlayer.Character.PrimaryPart then
						if mode == "follow" then
							LocalPlayer.Character:SetPrimaryPartCFrame(player.PrimaryPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, math.pi, 0))
						end
						pcall(function()
							CurrentCamera.CameraSubject = player.Humanoid
						end)
					end
				else
					pcall(function()
						CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
					end)
					cheatEnabled = false
				end
			end
			pcall(function()
				if player.Humanoid.WalkSpeed > 0 then
					newgui.currentspeed.Text = "current speed: " .. format(math.round(
						math.round(
							fixMagnitudeLimit(
								player.PrimaryPart.AssemblyLinearVelocity.X,
								player.PrimaryPart.AssemblyLinearVelocity.Y,
								player.PrimaryPart.AssemblyLinearVelocity.Z
							)
						)
						), false, true, 3) .. " | " .. format(player.Humanoid.WalkSpeed, false, true, 3).." | "..string.format("%.6f",
						fixMagnitudeLimit(
							player.PrimaryPart.AssemblyLinearVelocity.X,
							player.PrimaryPart.AssemblyLinearVelocity.Y,
							player.PrimaryPart.AssemblyLinearVelocity.Z
						)
							/player.Humanoid.WalkSpeed)..":1"
				else
					newgui.currentspeed.Text = "current speed: 0 | 0 | 0:0"
				end
			end)
		else
			CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
			cheatEnabled = false
		end
	else
		pcall(function()
			newgui.currentspeed.Text = "current speed: " .. format(math.round(
				math.round(
					fixMagnitudeLimit(
						LocalPlayer.Character.PrimaryPart.AssemblyLinearVelocity.X,
						LocalPlayer.Character.PrimaryPart.AssemblyLinearVelocity.Y,
						LocalPlayer.Character.PrimaryPart.AssemblyLinearVelocity.Z
					)
				)
				), false, true, 3) .. " | " .. format(LocalPlayer.Character.Humanoid.WalkSpeed, false, true, 3).." | "..string.format("%.6f",
				fixMagnitudeLimit(
					LocalPlayer.Character.PrimaryPart.AssemblyLinearVelocity.X,
					LocalPlayer.Character.PrimaryPart.AssemblyLinearVelocity.Y,
					LocalPlayer.Character.PrimaryPart.AssemblyLinearVelocity.Z
				)
					/LocalPlayer.Character.Humanoid.WalkSpeed)..":1"
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
		newgui.spawndistance.Text = "distance from spawn: " ..  format(math.round(distance), false, true, 3) .. " | " .. format(distance, true, false) .. ` ({precent_toT}% to one {fullUnits[currentUnit:lower()]})`
		newgui.spawndistance.TextColor3 = Color3.new(math.clamp(distance / units[currentUnit:lower()], 0, 1), 0, 0)
	else
		newgui.spawndistance.Text = "distance from spawn: unknown | unknown"
	end
end





