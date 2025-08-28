local list = { ["size_xml"] = "Size", ["transparency_xml"] = "Transparency", ["anchored_xml"] = "Anchored", ["cancollide_xml"] = "CanCollide", ["material_xml"] = "Material", ["reflectance_xml"] = "Reflectance", ["color_xml"] = "Color", ["brickcolor_xml"] = "BrickColor", ["shape_xml"] = "Shape", ["velocity_xml"] = "Velocity", ["rotvelocity_xml"] = "RotVelocity", ["position_xml"] = "Position", ["orientation_xml"] = "Orientation", ["parent_xml"] = "Parent", ["name_xml"] = "Name", ["archivable_xml"] = "Archivable", ["massless_xml"] = "Massless", ["collisiongroupid_xml"] = "CollisionGroupId", ["customphysicalproperties_xml"] = "CustomPhysicalProperties", ["elasticity_xml"] = "Elasticity", ["friction_xml"] = "Friction", ["assemblylinearvelocity_xml"] = "AssemblyLinearVelocity", ["assemblyangularvelocity_xml"] = "AssemblyAngularVelocity" }

local registry = debug.getregistry()
local info = debug.info
local isa = game.IsA

getgenv().gethui=function()
return cloneref(game.CoreGui.RobloxGui) -- secure
end

getgenv().dumpstring = function(fn)
    assert(type(fn) == "function", "expected function")
    return string.dump(fn)
end

getgenv().toclipboard = function(x)
    setclipboard(x)
end

getgenv().fireproximityprompt = function(p)
 local Hold, Distance, Enabled, Thing, CFrame1= p.HoldDuration, p.MaxActivationDistance, p.Enabled, p.RequiresLineOfSight, nil
 p.MaxActivationDistance = math.huge
 p.HoldDuration = 0
 p.Enabled = true
 p.RequiresLineOfSight = false
 local function get()
  local classes = {'BasePart', 'Part', 'MeshPart'}
  for _, v in pairs(classes) do
   if p:FindFirstAncestorOfClass(v) then
    return p:FindFirstAncestorOfClass(v)
   end
  end
 end
 local a = get()
 if not a then
  local parent = p.Parent
  p.Parent = Instance.new("Part", workspace)
  a = p.Parent
 end
 CFrame1 = a.CFrame
 a.CFrame = game:GetService("Players").LocalPlayer.Character.Head.CFrame + game:GetService("Players").LocalPlayer.Character.Head.CFrame.LookVector * 2
 task.wait()
 p:InputHoldBegin()
 task.wait()
 p:InputHoldEnd()
 p.HoldDuration = Hold
 p.MaxActivationDistance = Distance
 p.Enabled = Enabled
 p.RequiresLineOfSight = Thing
 a.CFrame = CFrame1
 p.Parent = parent or p.Parent
end

getgenv().firetouchinterest = function(toTouch, TouchWith, on)
 if on == 0 then return end
 if toTouch.ClassName == 'TouchTransmitter' then
   local function get()
    local classes = {'BasePart', 'Part', 'MeshPart'}
    for _, v in pairs(classes) do
    if toTouch:FindFirstAncestorOfClass(v) then
     return toTouch:FindFirstAncestorOfClass(v)
    end
   end
  end
  toTouch = get()
 end
 local cf = toTouch.CFrame
 local anc = toTouch.CanCollide
 toTouch.CanCollide = false
 toTouch.CFrame = TouchWith.CFrame
 task.wait()
 toTouch.CFrame = cf
 toTouch.CanCollide = anc
end



local UserInputService = game:GetService("UserInputService")

local isWindowFocused = true

UserInputService.WindowFocused:Connect(function()
    isWindowFocused = true
end)

UserInputService.WindowFocusReleased:Connect(function()
    isWindowFocused = false
end)

getgenv().isrbxactive = function()
    return isWindowFocused
end

getgenv().isgameactive = getgenv().isrbxactive

getgenv().loadfile = function(path)
    local ok, content = pcall(readfile, path)
    if not ok then
        return nil, content -- readfile failed
    end
    return loadstring(content, "@" .. path)
end

getgenv().isreadonly = table.isfrozen or function(tbl)
    local s, e = pcall(function()
        local key = newproxy and newproxy() or tostring({})
        rawset(tbl, key, nil)
    end)
    return not s
end

local HiddenProperties = {}
pcall(function()
    local HttpService = game:GetService('HttpService')
    local API_Dump_Url = "https://raw.githubusercontent.com/MaximumADHD/Roblox-Client-Tracker/roblox/Mini-API-Dump.json"
    local API_Dump = game:HttpGet(API_Dump_Url)
    for _, class in pairs(HttpService:JSONDecode(API_Dump).Classes) do
        for _, member in pairs(class.Members) do
            if member.Tags and table.find(member.Tags, "NotScriptable") then
                HiddenProperties[class.Name .. "." .. member.Name] = true
            end
        end
    end
end)

getgenv().getloadedmodules = function()
    local modules = {}
    local seen_sources = {}
    for _, script in ipairs(getgenv().getrunningscripts()) do
        pcall(function()
            for _, descendant in ipairs(script:GetDescendants()) do
                if descendant:IsA("ModuleScript") then
                    if not seen_sources[descendant] then
                        table.insert(modules, descendant)
                        seen_sources[descendant] = true
                    end
                end
            end
        end)
    end
    return modules
end

getgenv().getrunningscripts = function()
    local scripts = {}
    for _, script in ipairs(game:GetDescendants()) do
        if script:IsA("LocalScript") and script.Enabled then
            table.insert(scripts, script)
        end
    end
    return scripts
end

getgenv().getscripts = function()
    local scripts = {}
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
            table.insert(scripts, obj)
        end
    end
    return scripts
end

getgenv().setfpscap = function(fps)
    if typeof(fps) ~= 'number' then
        error("Argument 1 missing or nil", 2)
        return
    end
    pcall(function()
        local settings = UserSettings()
        local userGameSettings = settings:GetService("UserGameSettings")
        userGameSettings.MaxFrameRate = fps
    end)
end

getgenv().getrenv = function()
    local env = {}
    local funcs = {
        "wait", "spawn", "delay", "tick", "time", "elapsedTime", "typeof", "warn",
        "print", "error", "pcall", "xpcall", "shared", "plugin"
    }
    for _, name in ipairs(funcs) do
        local s, v = pcall(function() return getfenv(0)[name] end)
        if s and v then
            env[name] = v
        end
    end
    return env
end

getgenv().getsenv=function(x)
    for _, v in registry do
        if type(v) == "thread" then
            local env = getfenv(info(v, 1, "f"))
            if env.script == x then
                return env
            end
        end
    end
end
local getmenv = getsenv

getgenv().getscriptclosure=function(x)
    for _, v in registry do
        if type(v) == "thread" then
            local func = info(v, 1, "f")
            if getfenv(func).script == x then
                return func
            end
        end
    end
end

getgenv().hookmetamethod=function(x, y, z)
    local heh = getrawmetatable(x)
    local hehe = isreadonly(heh)
    setreadonly(heh, false)
    local old = heh[y]
    heh[y] = z
    setreadonly(heh, hehe)
    return old
end

getgenv().isscriptable = function(instance, property)
    if property == nil then return false end
    if typeof and typeof(instance) == "Instance" then
        -- instance + property
    else
        if type(instance) ~= "table" and type(instance) ~= "userdata" then
            return false
        end
    end
    if HiddenProperties and HiddenProperties[tostring(instance.ClassName) .. "." .. tostring(property)] then
        return false
    end
    local ok = pcall(function() local _ = instance[property] end)
    return ok, true
end
--[[
getgenv().setscriptable = function(tbl, writable)
    if type(tbl) ~= "table" and type(tbl) ~= "userdata" then
        return
    end
    setreadonly(tbl, not writable)
end
]]

getgenv().sethiddenproperty = function(instance, key, value)
    key = key:lower()
    local prop = list[key]
    if prop and instance[prop] ~= nil then
        instance[prop] = value
        return true
    else
        warn("unknown property:", key)
    end
end

getgenv().gethiddenproperty = function(instance, key)
    key = key:lower()
    local prop = list[key]
    if prop and instance[prop] ~= nil then
        return instance[prop], true
    else
        warn("unknown property:", key)
        return nil
    end
end

getgenv().getinstances = function()
    local x = {game}
    local d = game:GetDescendants()
    for y = 1, #d do
        local z = d[y]
        x[#x + 1] = z
    end
    return x
end

getgenv().getnilinstances = function()
    local x = getinstances()
    local y = {}
    for z = 1, #x do
        if not x[z].Parent then
            y[#y + 1] = x[z]
        end
    end
    return y
end

getgenv().setthreadidentity=setidentity
getgenv().getthreadidentity=getidentity
getgenv().setthreadcontext=setidentity
getgenv().getthreadcontext=getidentity

local drawingUI = nil
task.spawn(function()
	repeat task.wait()
	until getgenv().Instance and getgenv().game

	drawingUI = getgenv().Instance.new("ScreenGui", getgenv().game:GetService("CoreGui"))
	drawingUI.Name = "Drawing | Serpent"
	drawingUI.IgnoreGuiInset = true
	drawingUI.DisplayOrder = 0x7fffffff
end)

local drawingIndex = 0

local baseDrawingObj = setmetatable({
	Visible = true,
	ZIndex = 0,
	Transparency = 1,
	Color = Color3.new(),
	Remove = function(self)
		setmetatable(self, nil)
	end,
	Destroy = function(self)
		setmetatable(self, nil)
	end
}, {
	__add = function(t1, t2)
		local result = table.clone(t1)

		for index, value in t2 do
			result[index] = value
		end
		return result
	end
})

local drawingFontsEnum = {
	[0] = Font.fromEnum(Enum.Font.Roboto),
	[1] = Font.fromEnum(Enum.Font.Legacy),
	[2] = Font.fromEnum(Enum.Font.SourceSans),
	[3] = Font.fromEnum(Enum.Font.RobotoMono),
}

local function convertTransparency(transparency: number): number
	return math.clamp(1 - transparency, 0, 1)
end

local DrawingLib = {}
DrawingLib.Fonts = {
	["UI"] = 0,
	["System"] = 1,
	["Plex"] = 2,
	["Monospace"] = 3
}

function DrawingLib.new(drawingType)
	drawingIndex += 1
	if drawingType == "Line" then
		local lineObj = ({
			From = Vector2.zero,
			To = Vector2.zero,
			Thickness = 1
		} + baseDrawingObj)

		local lineFrame = getgenv().Instance.new("Frame")
		lineFrame.Name = drawingIndex
		lineFrame.AnchorPoint = (Vector2.one * .5)
		lineFrame.BorderSizePixel = 0

		lineFrame.BackgroundColor3 = lineObj.Color
		lineFrame.Visible = lineObj.Visible
		lineFrame.ZIndex = lineObj.ZIndex
		lineFrame.BackgroundTransparency = convertTransparency(lineObj.Transparency)

		lineFrame.Size = UDim2.new()

		lineFrame.Parent = drawingUI
		return setmetatable({__type = "Drawing Object"}, {
			__newindex = function(_, index, value)
				if typeof(lineObj[index]) == "nil" then return end

				if index == "From" then
					local direction = (lineObj.To - value)
					local center = (lineObj.To + value) / 2
					local distance = direction.Magnitude
					local theta = math.deg(math.atan2(direction.Y, direction.X))

					lineFrame.Position = UDim2.fromOffset(center.X, center.Y)
					lineFrame.Rotation = theta
					lineFrame.Size = UDim2.fromOffset(distance, lineObj.Thickness)
				elseif index == "To" then
					local direction = (value - lineObj.From)
					local center = (value + lineObj.From) / 2
					local distance = direction.Magnitude
					local theta = math.deg(math.atan2(direction.Y, direction.X))

					lineFrame.Position = UDim2.fromOffset(center.X, center.Y)
					lineFrame.Rotation = theta
					lineFrame.Size = UDim2.fromOffset(distance, lineObj.Thickness)
				elseif index == "Thickness" then
					local distance = (lineObj.To - lineObj.From).Magnitude
					lineFrame.Size = UDim2.fromOffset(distance, value)
				elseif index == "Visible" then
					lineFrame.Visible = value
				elseif index == "ZIndex" then
					lineFrame.ZIndex = value
				elseif index == "Transparency" then
					lineFrame.BackgroundTransparency = convertTransparency(value)
				elseif index == "Color" then
					lineFrame.BackgroundColor3 = value
				end
				lineObj[index] = value
			end,

			__index = function(self, index)
				if index == "Remove" or index == "Destroy" then
					return function()
						lineFrame:Destroy()
						lineObj.Remove(self)
						return lineObj:Remove()
					end
				end
				return lineObj[index]
			end,

			__tostring = function() return "Drawing" end
		})
	elseif drawingType == "Text" then
		local textObj = ({
			Text = "",
			Font = DrawingLib.Fonts.UI,
			Size = 0,
			Position = Vector2.zero,
			Center = false,
			Outline = false,
			OutlineColor = Color3.new()
		} + baseDrawingObj)

		local textLabel, uiStroke = getgenv().Instance.new("TextLabel"), getgenv().Instance.new("UIStroke")
		textLabel.Name = drawingIndex
		textLabel.AnchorPoint = (Vector2.one * .5)
		textLabel.BorderSizePixel = 0
		textLabel.BackgroundTransparency = 1

		textLabel.Visible = textObj.Visible
		textLabel.TextColor3 = textObj.Color
		textLabel.TextTransparency = convertTransparency(textObj.Transparency)
		textLabel.ZIndex = textObj.ZIndex

		textLabel.FontFace = drawingFontsEnum[textObj.Font]
		textLabel.TextSize = textObj.Size

		textLabel:GetPropertyChangedSignal("TextBounds"):Connect(function()
			local textBounds = textLabel.TextBounds
			local offset = textBounds / 2

			textLabel.Size = UDim2.fromOffset(textBounds.X, textBounds.Y)
			textLabel.Position = UDim2.fromOffset(textObj.Position.X + (if not textObj.Center then offset.X else 0), textObj.Position.Y + offset.Y)
		end)

		uiStroke.Thickness = 1
		uiStroke.Enabled = textObj.Outline
		uiStroke.Color = textObj.Color

		textLabel.Parent, uiStroke.Parent = drawingUI, textLabel
		return setmetatable({__type = "Drawing Object"}, {
			__newindex = function(_, index, value)
				if typeof(textObj[index]) == "nil" then return end

				if index == "Text" then
					textLabel.Text = value
				elseif index == "Font" then
					value = math.clamp(value, 0, 3)
					textLabel.FontFace = drawingFontsEnum[value]
				elseif index == "Size" then
					textLabel.TextSize = value
				elseif index == "Position" then
					local offset = textLabel.TextBounds / 2

					textLabel.Position = UDim2.fromOffset(value.X + (if not textObj.Center then offset.X else 0), value.Y + offset.Y)
				elseif index == "Center" then
					local position = (
						if value then
							workspace.CurrentCamera.ViewportSize / 2
							else
							textObj.Position
					)
					textLabel.Position = UDim2.fromOffset(position.X, position.Y)
				elseif index == "Outline" then
					uiStroke.Enabled = value
				elseif index == "OutlineColor" then
					uiStroke.Color = value
				elseif index == "Visible" then
					textLabel.Visible = value
				elseif index == "ZIndex" then
					textLabel.ZIndex = value
				elseif index == "Transparency" then
					local transparency = convertTransparency(value)

					textLabel.TextTransparency = transparency
					uiStroke.Transparency = transparency
				elseif index == "Color" then
					textLabel.TextColor3 = value
				end
				textObj[index] = value
			end,

			__index = function(self, index)
				if index == "Remove" or index == "Destroy" then
					return function()
						textLabel:Destroy()
						textObj.Remove(self)
						return textObj:Remove()
					end
				elseif index == "TextBounds" then
					return textLabel.TextBounds
				end
				return textObj[index]
			end,

			__tostring = function() return "Drawing" end
		})
	elseif drawingType == "Circle" then
		local circleObj = ({
			Radius = 150,
			Position = Vector2.zero,
			Thickness = .7,
			Filled = false
		} + baseDrawingObj)

		local circleFrame, uiCorner, uiStroke = getgenv().Instance.new("Frame"), getgenv().Instance.new("UICorner"), getgenv().Instance.new("UIStroke")
		circleFrame.Name = drawingIndex
		circleFrame.AnchorPoint = (Vector2.one * .5)
		circleFrame.BorderSizePixel = 0

		circleFrame.BackgroundTransparency = (if circleObj.Filled then convertTransparency(circleObj.Transparency) else 1)
		circleFrame.BackgroundColor3 = circleObj.Color
		circleFrame.Visible = circleObj.Visible
		circleFrame.ZIndex = circleObj.ZIndex

		uiCorner.CornerRadius = UDim.new(1, 0)
		circleFrame.Size = UDim2.fromOffset(circleObj.Radius, circleObj.Radius)

		uiStroke.Thickness = circleObj.Thickness
		uiStroke.Enabled = not circleObj.Filled
		uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

		circleFrame.Parent, uiCorner.Parent, uiStroke.Parent = drawingUI, circleFrame, circleFrame
		return setmetatable({__type = "Drawing Object"}, {
			__newindex = function(_, index, value)
				if typeof(circleObj[index]) == "nil" then return end

				if index == "Radius" then
					local radius = value * 2
					circleFrame.Size = UDim2.fromOffset(radius, radius)
				elseif index == "Position" then
					circleFrame.Position = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Thickness" then
					value = math.clamp(value, .6, 0x7fffffff)
					uiStroke.Thickness = value
				elseif index == "Filled" then
					circleFrame.BackgroundTransparency = (if value then convertTransparency(circleObj.Transparency) else 1)
					uiStroke.Enabled = not value
				elseif index == "Visible" then
					circleFrame.Visible = value
				elseif index == "ZIndex" then
					circleFrame.ZIndex = value
				elseif index == "Transparency" then
					local transparency = convertTransparency(value)

					circleFrame.BackgroundTransparency = (if circleObj.Filled then transparency else 1)
					uiStroke.Transparency = transparency
				elseif index == "Color" then
					circleFrame.BackgroundColor3 = value
					uiStroke.Color = value
				end
				circleObj[index] = value
			end,

			__index = function(self, index)
				if index == "Remove" or index == "Destroy" then
					return function()
						circleFrame:Destroy()
						circleObj.Remove(self)
						return circleObj:Remove()
					end
				end
				return circleObj[index]
			end,

			__tostring = function() return "Drawing" end
		})
	elseif drawingType == "Square" then
		local squareObj = ({
			Size = Vector2.zero,
			Position = Vector2.zero,
			Thickness = .7,
			Filled = false
		} + baseDrawingObj)

		local squareFrame, uiStroke = getgenv().Instance.new("Frame"), getgenv().Instance.new("UIStroke")
		squareFrame.Name = drawingIndex
		squareFrame.BorderSizePixel = 0

		squareFrame.BackgroundTransparency = (if squareObj.Filled then convertTransparency(squareObj.Transparency) else 1)
		squareFrame.ZIndex = squareObj.ZIndex
		squareFrame.BackgroundColor3 = squareObj.Color
		squareFrame.Visible = squareObj.Visible

		uiStroke.Thickness = squareObj.Thickness
		uiStroke.Enabled = not squareObj.Filled
		uiStroke.LineJoinMode = Enum.LineJoinMode.Miter

		squareFrame.Parent, uiStroke.Parent = drawingUI, squareFrame
		return setmetatable({__type = "Drawing Object"}, {
			__newindex = function(_, index, value)
				if typeof(squareObj[index]) == "nil" then return end

				if index == "Size" then
					squareFrame.Size = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Position" then
					squareFrame.Position = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Thickness" then
					value = math.clamp(value, 0.6, 0x7fffffff)
					uiStroke.Thickness = value
				elseif index == "Filled" then
					squareFrame.BackgroundTransparency = (if value then convertTransparency(squareObj.Transparency) else 1)
					uiStroke.Enabled = not value
				elseif index == "Visible" then
					squareFrame.Visible = value
				elseif index == "ZIndex" then
					squareFrame.ZIndex = value
				elseif index == "Transparency" then
					local transparency = convertTransparency(value)
					squareFrame.BackgroundTransparency = (if squareObj.Filled then transparency else 1)
					uiStroke.Transparency = transparency
				elseif index == "Color" then
					uiStroke.Color = value
					squareFrame.BackgroundColor3 = value
				end
				squareObj[index] = value
			end,

			__index = function(self, index)
				if index == "Remove" or index == "Destroy" then
					return function()
						squareFrame:Destroy()
						squareObj.Remove(self)
						return squareObj:Remove()
					end
				end
				return squareObj[index]
			end,

			__tostring = function() return "Drawing" end
		})
	elseif drawingType == "Image" then
		local imageObj = ({
			Data = "",
			Size = Vector2.zero,
			Position = Vector2.zero
		} + baseDrawingObj)

		local imageFrame = getgenv().Instance.new("ImageLabel")
		imageFrame.Name = drawingIndex
		imageFrame.BorderSizePixel = 0
		imageFrame.ScaleType = Enum.ScaleType.Stretch
		imageFrame.BackgroundTransparency = 1

		imageFrame.Visible = imageObj.Visible
		imageFrame.ZIndex = imageObj.ZIndex
		imageFrame.ImageTransparency = convertTransparency(imageObj.Transparency)
		imageFrame.ImageColor3 = imageObj.Color

		imageFrame.Parent = drawingUI
		return setmetatable({__type = "Drawing Object"}, {
			__newindex = function(_, index, value)
				if typeof(imageObj[index]) == "nil" then return end

				if index == "Data" then
					imageFrame.Image = value
				elseif index == "Size" then
					imageFrame.Size = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Position" then
					imageFrame.Position = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Visible" then
					imageFrame.Visible = value
				elseif index == "ZIndex" then
					imageFrame.ZIndex = value
				elseif index == "Transparency" then
					imageFrame.ImageTransparency = convertTransparency(value)
				elseif index == "Color" then
					imageFrame.ImageColor3 = value
				end
				imageObj[index] = value
			end,

			__index = function(self, index)
				if index == "Remove" or index == "Destroy" then
					return function()
						imageFrame:Destroy()
						imageObj.Remove(self)
						return imageObj:Remove()
					end
				end
				return imageObj[index]
			end,

			__tostring = function() return "Drawing" end
		})
	elseif drawingType == "Quad" then
		local QuadProperties = ({
			Thickness = 1,
			PointA = Vector2.new();
			PointB = Vector2.new();
			PointC = Vector2.new();
			PointD = Vector2.new();
			Filled = false;
		}  + baseDrawingObj);

		local PointA = DrawingLib.new("Line")
		local PointB = DrawingLib.new("Line")
		local PointC = DrawingLib.new("Line")
		local PointD = DrawingLib.new("Line")

		return setmetatable({__type = "Drawing Object"}, {
			__newindex = function(self, Property, Value)
				if Property == "Thickness" then
					PointA.Thickness = Value
					PointB.Thickness = Value
					PointC.Thickness = Value
					PointD.Thickness = Value
				end
				if Property == "PointA" then
					PointA.From = Value
					PointB.To = Value
				end
				if Property == "PointB" then
					PointB.From = Value
					PointC.To = Value
				end
				if Property == "PointC" then
					PointC.From = Value
					PointD.To = Value
				end
				if Property == "PointD" then
					PointD.From = Value
					PointA.To = Value
				end
				if Property == "Visible" then 
					PointA.Visible = true
					PointB.Visible = true
					PointC.Visible = true
					PointD.Visible = true    
				end
				if Property == "Filled" then
					PointA.BackgroundTransparency = 1
					PointB.BackgroundTransparency = 1
					PointC.BackgroundTransparency = 1
					PointD.BackgroundTransparency = 1   
				end
				if Property == "Color" then
					PointA.Color = Value
					PointB.Color = Value
					PointC.Color = Value
					PointD.Color = Value
				end
				if (Property == "ZIndex") then
					PointA.ZIndex = Value
					PointB.ZIndex = Value
					PointC.ZIndex = Value
					PointD.ZIndex = Value
				end
			end,

			__index = function(self, Property)
				if (string.lower(tostring(Property)) == "remove") then
					return (function()
						PointA:Remove();
						PointB:Remove();
						PointC:Remove();
						PointD:Remove();
					end)
				end

				return QuadProperties[Property]
			end
		});
	elseif drawingType == "Triangle" then
		local triangleObj = ({
			PointA = Vector2.zero,
			PointB = Vector2.zero,
			PointC = Vector2.zero,
			Thickness = 1,
			Filled = false
		} + baseDrawingObj)

		local _linePoints = {}
		_linePoints.A = DrawingLib.new("Line")
		_linePoints.B = DrawingLib.new("Line")
		_linePoints.C = DrawingLib.new("Line")
		return setmetatable({__type = "Drawing Object"}, {
			__tostring = function() return "Drawing" end,

			__newindex = function(_, index, value)
				if typeof(triangleObj[index]) == "nil" then return end

				if index == "PointA" then
					_linePoints.A.From = value
					_linePoints.B.To = value
				elseif index == "PointB" then
					_linePoints.B.From = value
					_linePoints.C.To = value
				elseif index == "PointC" then
					_linePoints.C.From = value
					_linePoints.A.To = value
				elseif (index == "Thickness" or index == "Visible" or index == "Color" or index == "ZIndex") then
					for _, linePoint in _linePoints do
						linePoint[index] = value
					end
				elseif index == "Filled" then
					_linePoints.BackgroundTransparency = 1
				end
				triangleObj[index] = value
			end,

			__index = function(self, index)
				if index == "Remove" or index == "Destroy" then
					return function()
						for _, linePoint in _linePoints do
							linePoint:Remove()
						end

						triangleObj.Remove(self)
						return triangleObj:Remove()
					end
				end
				return triangleObj[index]
			end
		})
	end
end

getgenv().Drawing = DrawingLib

getgenv().isrenderobj = function(obj)
	local s, r = pcall(function()
		return obj.__type == "Drawing Object"
	end)
	return s and r
end
getgenv().cleardrawcache = function()
	drawingUI:ClearAllChildren()
end
getgenv().getrenderproperty = function(obj, prop)
	assert(getgenv().isrenderobj(obj), "Object must be a Drawing", 3)
	return obj[prop]
end
getgenv().setrenderproperty = function(obj, prop, val)
	assert(getgenv().isrenderobj(obj), "Object must be a Drawing", 3)
	obj[prop] = val
end


local function addtoallrunningenvironments(x, y)
    for _, v in registry do
        if type(v) == "thread" then
            getfenv(info(v, 1, "f"))[x] = y
        end
    end
end
local renv = {}

setmetatable(
    renv,
    {
        __newindex = function(_, x, y)
            addtoallrunningenvironments(x, y)
        end
    }
)

getgenv().getrenv=function()
    return renv
end

getgenv().crypt.encrypt = function(data, key, iv, mode)
    assert(key, "Key required")
    iv = iv or getgenv().crypt.generatekey(#key)
    local encrypted = {}
    for i = 1, #data do
        local keyChar = string.byte(key, ((i-1) % #key) + 1)
        local ivChar = string.byte(iv, ((i-1) % #iv) + 1)
        local dataChar = string.byte(data, i)
        encrypted[i] = string.char(bit32.bxor(dataChar, keyChar, ivChar))
    end
    return table.concat(encrypted), iv
end

getgenv().getscriptfunction = getscripthash
getgenv().crypt = getgenv().crypt or {}
getgenv().base64 = getgenv().crypt.base64 or {}
getgenv().crypt.base64_encode = getgenv().crypt.base64encode
getgenv().crypt.base64_decode = getgenv().crypt.base64decode
getgenv().base64.encode = getgenv().crypt.base64encode 
getgenv().base64.decode = getgenv().crypt.base64decode

getgenv().crypt.decrypt = function(data, key, iv, mode)
    assert(key and iv, "Key and IV required")
    local decrypted = {}
    for i = 1, #data do
        local keyChar = string.byte(key, ((i-1) % #key) + 1)
        local ivChar = string.byte(iv, ((i-1) % #iv) + 1)
        local dataChar = string.byte(data, i)
        decrypted[i] = string.char(bit32.bxor(dataChar, keyChar, ivChar))
    end
    return table.concat(decrypted)
end
									
getgenv().getscripthash = function(x)
    assert(
        table.find({ "ModuleScript", "LocalScript" }, x.ClassName),
        "Invalid argument #1 to 'getscripthash' (LuaSourceContainer expected, got " .. x.ClassName .. ")"
    )

    return x:GetHash()
end

getgenv().decompile=function(x) --> requires getscriptbytecode
    assert(table.find({"ModuleScript", "LocalScript"}, x.ClassName), "Invalid argument #1 to 'decompile', LuaSourceContainer expected, got " .. x.ClassName)

    return request({
        Url = "http://api.plusgiant5.com/konstant/decompile",
        Method = "POST",
        Headers = {
            ["Content-Type"] = "text/plain"
        },
        Body = getscriptbytecode(LuaScriptContainer)
    }).Body
end

getgenv().lz4compress = function(input) 
    local output = {}
    local i = 1
    while i <= #input do
        local rl = 1
        local c = input:sub(i,i)
        while i+rl <= #input and input:sub(i+rl,i+rl) == c and rl < 255 do
            rl = rl + 1
        end
        table.insert(output, string.char(rl))
        table.insert(output, c)
        i = i + rl
    end
    return table.concat(output)
end
									
getgenv().lz4decompress = function(input) 
    local output = {}
    local i = 1
    while i <= #input do
        local len = string.byte(input:sub(i,i))
        local char = input:sub(i+1,i+1)
        for j = 1, len do
            table.insert(output, char)
        end
        i = i + 2
    end
    return table.concat(output)
end

getgenv().getsenv = function(script)
    assert(script, "No script provided")
    local env = {}
    env.script = script
    setmetatable(env, {
        __index = _G, -- fallback to globals
        __newindex = function(t, k, v)
            rawset(t, k, v)
        end,
    })
    return env
end

getgenv().getscriptclosure = function(x)
    for _, v in registry do
        if type(v) == "thread" then
            local func = info(v, 1, "f")
            if getfenv(func).script == x then
                return func
            end
        end
    end
    if x:IsA("ModuleScript") then
        local src = getscriptbytecode(x) 
        local func = loadstring(src)
        if func then
            local env = getfenv(func)
            env.script = x
            setfenv(func, env)
            return func
        end
    end
end
									
getgenv().isourclosure=getgenv().isexecutorclosure

print("loaded")
