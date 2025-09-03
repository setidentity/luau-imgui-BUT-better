if not game:IsLoaded() then
    game.Loaded:Wait();
end

--!native
--native
local uis = game:GetService("UserInputService")
local a = cloneref(game.CoreGui.RobloxGui)
local active = true

getgenv().gethui=function()
return a
end

local m = {
    ["size_xml"] = "Size",
    ["transparency_xml"] = "Transparency",
    ["anchored_xml"] = "Anchored",
    ["cancollide_xml"] = "CanCollide",
    ["material_xml"] = "Material",
    ["reflectance_xml"] = "Reflectance",
    ["color_xml"] = "Color",
    ["brickcolor_xml"] = "BrickColor",
    ["shape_xml"] = "Shape",
    ["velocity_xml"] = "Velocity",
    ["rotvelocity_xml"] = "RotVelocity",
    ["position_xml"] = "Position",
    ["orientation_xml"] = "Orientation",
    ["parent_xml"] = "Parent",
    ["name_xml"] = "Name",
    ["archivable_xml"] = "Archivable",
    ["massless_xml"] = "Massless",
    ["collisiongroupid_xml"] = "CollisionGroupId",
    ["customphysicalproperties_xml"] = "CustomPhysicalProperties",
    ["elasticity_xml"] = "Elasticity",
    ["friction_xml"] = "Friction",
    ["assemblylinearvelocity_xml"] = "AssemblyLinearVelocity",
    ["assemblyangularvelocity_xml"] = "AssemblyAngularVelocity"
}

local r = debug.getregistry()
local h = {}

pcall(function()
    local s = game:GetService('HttpService')
    local u = "https://raw.githubusercontent.com/MaximumADHD/Roblox-Client-Tracker/roblox/Mini-API-Dump.json"
    local d = game:HttpGet(u)
    
    for _, c in pairs(s:JSONDecode(d).Classes) do
        for _, m in pairs(c.Members) do
            if m.Tags and table.find(m.Tags, "NotScriptable") then
                h[c.Name .. "." .. m.Name] = true
            end
        end
    end
end)

uis.WindowFocused:Connect(function()
    active = true
end)

uis.WindowFocusReleased:Connect(function()
    active = false
end)

getgenv().dumpstring = string.dump

getgenv().toclipboard = setclipboard

getgenv().fireproximityprompt = function(x)
    local h, d, e, l = x.HoldDuration, x.MaxActivationDistance, x.Enabled, x.RequiresLineOfSight
    
    x.MaxActivationDistance = math.huge
    x.HoldDuration = 0
    x.Enabled = true
    x.RequiresLineOfSight = false
    
    local function f()
        local c = {'BasePart', 'Part', 'MeshPart'}
        for _, n in ipairs(c) do
            local a = x:FindFirstAncestorOfClass(n)
            if a then return a end
        end
    end
    
    local a = f()
    if not a then
        local p = x.Parent
        x.Parent = Instance.new("Part", workspace)
        a = x.Parent
    end
    
    local c = a.CFrame
    a.CFrame = game.Players.LocalPlayer.Character.Head.CFrame + 
                     game.Players.LocalPlayer.Character.Head.CFrame.LookVector * 2
    
    task.wait()
    x:InputHoldBegin()
    task.wait()
    x:InputHoldEnd()
    
    x.HoldDuration = h
    x.MaxActivationDistance = d
    x.Enabled = e
    x.RequiresLineOfSight = l
    a.CFrame = c
    x.Parent = x.Parent or p
end

getgenv().firetouchinterest = function(x, y, z)
    if z == 0 then return end
    
    if x.ClassName == 'TouchTransmitter' then
        local function f()
            local c = {'BasePart', 'Part', 'MeshPart'}
            for _, n in ipairs(c) do
                local p = x:FindFirstAncestorOfClass(n)
                if p then return p end
            end
        end
        x = f()
    end
    
    local c = x.CFrame
    local k = x.CanCollide
    
    x.CanCollide = false
    x.CFrame = y.CFrame
    task.wait()
    x.CFrame = c
    x.CanCollide = k
end

getgenv().isrbxactive = function() return active end
getgenv().isgameactive = getgenv().isrbxactive

getgenv().loadfile = function(x)
    local o, c = pcall(readfile, x)
    if not o then return nil, c end
    return loadstring(c, "@" .. x)
end

getgenv().isreadonly = table.isfrozen or function(x)
    local s = pcall(function()
        local k = newproxy and newproxy() or tostring({})
        rawset(x, k, nil)
    end)
    return not s
end

getgenv().getloadedmodules = function()
    local m = {}
    local s = {}
    
    for _, sc in ipairs(getgenv().getrunningscripts()) do
        pcall(function()
            for _, d in ipairs(sc:GetDescendants()) do
                if d:IsA("ModuleScript") and not s[d] then
                    table.insert(m, d)
                    s[d] = true
                end
            end
        end)
    end
    
    return m
end

getgenv().getrunningscripts = function()
    local s = {}
    for _, sc in ipairs(game:GetDescendants()) do
        if sc:IsA("LocalScript") and sc.Enabled then
            table.insert(s, sc)
        end
    end
    return s
end

getgenv().getscripts = function()
    local s = {}
    for _, o in ipairs(game:GetDescendants()) do
        if o:IsA("LocalScript") or o:IsA("ModuleScript") then
            table.insert(s, o)
        end
    end
    return s
end

getgenv().setfpscap = function(x)
    if typeof(x) ~= 'number' then
        error("Argument 1 must be a number", 2)
    end
    
    pcall(function()
        local s = UserSettings()
        local u = s:GetService("UserGameSettings")
        u.MaxFrameRate = x
    end)
end

getgenv().getsenv = function(x)
    for _, t in r do
        if type(t) == "thread" then
            local e = getfenv(debug.info(t, 1, "f"))
            if e.script == x then
                return e
            end
        end
    end
end

getgenv().getscriptclosure = function(x)
    for _, t in r do
        if type(t) == "thread" then
            local f = debug.info(t, 1, "f")
            if getfenv(f).script == x then
                return f
            end
        end
    end
end

getgenv().hookmetamethod = function(x, y, z)
    local m = getrawmetatable(x)
    local w = isreadonly(m)
    
    setreadonly(m, false)
    local o = m[y]
    m[y] = z
    setreadonly(m, w)
    
    return o
end

getgenv().isscriptable = function(x, y)
    if not y or typeof(x) ~= "Instance" then
        return false
    end
    
    if h[x.ClassName .. "." .. y] then
        return false
    end
    
    local s = pcall(function() 
        local _ = x[y] 
    end)
    
    return s
end

getgenv().sethiddenproperty = function(x, y, z)
    y = y:lower()
    local p = m[y]
    
    if p and x[p] ~= nil then
        x[p] = z
        return true
    else
        warn("Unknown property:", y)
        return false
    end
end

getgenv().gethiddenproperty = function(x, y)
    y = y:lower()
    local p = m[y]
    
    if p and x[p] ~= nil then
        return x[p], true
    else
        warn("Unknown property:", y)
        return nil, false
    end
end

getgenv().getinstances = function()
    local i = {game}
    local d = game:GetDescendants()
    
    for n = 1, #d do
        table.insert(i, d[n])
    end
    
    return i
end

getgenv().getnilinstances = function()
    local n = {}
    
    for _, i in ipairs(getgenv().getinstances()) do
        if not i.Parent then
            table.insert(n, i)
        end
    end
    
    return n
end

getgenv().setthreadidentity = setidentity
getgenv().getthreadidentity = getidentity
getgenv().setthreadcontext = setidentity
getgenv().getthreadcontext = getidentity

getgenv().replaceclosure = function(x, y)
    assert(type(x) == "function", "original must be a function")
    assert(type(y) == "function", "replacement must be a function")
    
    local e = getfenv(x)
    local w = function(...)
        return y(...)
    end
    
    setfenv(w, e)
    return w
end

local sp = {}

getgenv().isscriptable = function(x, y)
    if x and typeof(x) == 'Instance' then
        local s, r = pcall(function()
            return sp[x][y]
        end)
        
        if s and r ~= nil then
            return r
        end
        
        s, r = pcall(function()
            return x[y] ~= nil
        end)
        
        return s and r
    end
    return false
end

getgenv().setscriptable = function(x, y, z)
    if x and typeof(x) == 'Instance' and y then
        local w = isscriptable(x, y)
        
        if not sp[x] then
            sp[x] = {}
        end
        
        sp[x][y] = z
        return w
    end
end

local Player = game:GetService('Players').LocalPlayer;
	   
repeat wait() until game:IsLoaded() -- precaution

--[[ Variables ]]--

local textService = cloneref(game:GetService("TextService"));

local drawing = {
    Fonts = {
        UI = 0,
        System = 1,
        Plex = 2,
        Monospace = 3
    }
};

local renv = getrenv();
local genv = getgenv();

local pi = renv.math.pi;
local huge = renv.math.huge;

local _assert = (renv.assert);
local _color3new = (renv.Color3.new);
local _instancenew = (renv.Instance.new);
local _mathatan2 = (renv.math.atan2);
local _mathclamp = (renv.math.clamp);
local _mathmax = (renv.math.max);
local _setmetatable = (renv.setmetatable);
local _stringformat = (renv.string.format);
local _typeof = (renv.typeof);
local _taskspawn = (renv.task.spawn);
local _udimnew = (renv.UDim.new);
local _udim2fromoffset = (renv.UDim2.fromOffset);
local _udim2new = (renv.UDim2.new);
local _vector2new = (renv.Vector2.new);

local _destroy = (game.Destroy);
local _gettextboundsasync = (textService.GetTextBoundsAsync);

local _httpget = (game.HttpGet);
local _writecustomasset = function(path, data)
	writefile(path,data)
	return getcustomasset(path)
end

--[[ Functions ]]--

local function create(className, properties, children)
	local inst = _instancenew(className);
	for i, v in properties do
		if i ~= "Parent" then
			inst[i] = v;
		end
	end
	if children then
		for i, v in children do
			v.Parent = inst;
		end
	end
	inst.Parent = properties.Parent;
	return inst;
end

--[[ Setup ]]--

do -- This may look completely useless, but it allows TextBounds to update without yielding and therefore breaking the metamethods.
	local fonts = {
		Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
		Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
		Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
		Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	};

	for i, v in fonts do
		game:GetService("TextService"):GetTextBoundsAsync(create("GetTextBoundsParams", {
			Text = "Hi",
			Size = 12,
			Font = v,
			Width = huge
		}));
	end
end

--[[ Drawing ]]--

do
    local drawingDirectory = create("ScreenGui", {
        DisplayOrder = 15,
        IgnoreGuiInset = true,
        Name = "drawingDirectory",
        Parent = game.CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    });
	
	local function updatePosition(frame, from, to, thickness)
		local central = (from + to) / 2;
		local offset = to - from;
		frame.Position = _udim2fromoffset(central.X, central.Y);
		frame.Rotation = _mathatan2(offset.Y, offset.X) * 180 / pi;
		frame.Size = _udim2fromoffset(offset.Magnitude, thickness);
	end

    local itemCounter = 0;
    local cache = {};

    local classes = {};
    do
        local line = {};

        function line.new()
            itemCounter = itemCounter + 1;
            local id = itemCounter;

            local newLine = _setmetatable({
                _id = id,
                __OBJECT_EXISTS = true,
                _properties = {
                    Color = _color3new(),
                    From = _vector2new(),
                    Thickness = 1,
                    To = _vector2new(),
                    Transparency = 1,
                    Visible = false,
                    ZIndex = 0
                },
                _frame = create("Frame", {
                    Name = id,
                    AnchorPoint = _vector2new(0.5, 0.5),
                    BackgroundColor3 = _color3new(),
                    BorderSizePixel = 0,
                    Parent = drawingDirectory,
                    Position = _udim2new(),
                    Size = _udim2new(),
                    Visible = false,
                    ZIndex = 0
                })
            }, line);

            cache[id] = newLine;
            return newLine;
        end

        function line:__index(k)
			local prop = self._properties[k];
			if prop ~= nil then
				return prop;
			end
			return line[k];
        end

        function line:__newindex(k, v)
            if self.__OBJECT_EXISTS == true then
                self._properties[k] = v;
                if k == "Color" then
                    self._frame.BackgroundColor3 = v;
                elseif k == "From" then
                    self:_updatePosition();
                elseif k == "Thickness" then
                    self._frame.Size = _udim2fromoffset(self._frame.AbsoluteSize.X, _mathmax(v, 1));
                elseif k == "To" then
                    self:_updatePosition();
                elseif k == "Transparency" then
                    self._frame.BackgroundTransparency = _mathclamp(1 - v, 0, 1);
                elseif k == "Visible" then
                    self._frame.Visible = v;
                elseif k == "ZIndex" then
                    self._frame.ZIndex = v;
                end
            end
        end
		
		function line:__iter()
            return next, self._properties;
        end
		
		function line:__tostring()
			return "Drawing";
		end

        function line:Destroy()
			cache[self._id] = nil;
            self.__OBJECT_EXISTS = false;
            _destroy(self._frame);
        end

        function line:_updatePosition()
			local props = self._properties;
			updatePosition(self._frame, props.From, props.To, props.Thickness);
        end

        line.Remove = line.Destroy;
        classes.Line = line;
    end
    
    do
        local circle = {};

        function circle.new()
            itemCounter = itemCounter + 1;
            local id = itemCounter;

            local newCircle = _setmetatable({
                _id = id,
                __OBJECT_EXISTS = true,
                _properties = {
                    Color = _color3new(),
                    Filled = false,
					NumSides = 0,
                    Position = _vector2new(),
                    Radius = 0,
                    Thickness = 1,
                    Transparency = 1,
                    Visible = false,
                    ZIndex = 0
                },
                _frame = create("Frame", {
                    Name = id,
                    AnchorPoint = _vector2new(0.5, 0.5),
                    BackgroundColor3 = _color3new(),
					BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Parent = drawingDirectory,
                    Position = _udim2new(),
                    Size = _udim2new(),
                    Visible = false,
                    ZIndex = 0
                }, {
                    create("UICorner", {
                        Name = "_corner",
                        CornerRadius = _udimnew(1, 0)
                    }),
                    create("UIStroke", {
                        Name = "_stroke",
                        Color = _color3new(),
                        Thickness = 1
                    })
                })
            }, circle);

            cache[id] = newCircle;
            return newCircle;
        end

        function circle:__index(k)
			local prop = self._properties[k];
			if prop ~= nil then
				return prop;
			end
			return circle[k];
        end

        function circle:__newindex(k, v)
            if self.__OBJECT_EXISTS == true then
				local props = self._properties;
                props[k] = v;
                if k == "Color" then
                    self._frame.BackgroundColor3 = v;
                    self._frame._stroke.Color = v;
                elseif k == "Filled" then
                    self._frame.BackgroundTransparency = v and 1 - props.Transparency or 1;
                elseif k == "Position" then
                    self._frame.Position = _udim2fromoffset(v.X, v.Y);
                elseif k == "Radius" then
					self:_updateRadius();
                elseif k == "Thickness" then
                    self._frame._stroke.Thickness = _mathmax(v, 1);
					self:_updateRadius();
                elseif k == "Transparency" then
					self._frame._stroke.Transparency = 1 - v;
					if props.Filled then
						self._frame.BackgroundTransparency = 1 - v;
					end
                elseif k == "Visible" then
                    self._frame.Visible = v;
                elseif k == "ZIndex" then
                    self._frame.ZIndex = v;
                end
            end
        end
		
		function circle:__iter()
            return next, self._properties;
        end
		
		function circle:__tostring()
			return "Drawing";
		end

        function circle:Destroy()
			cache[self._id] = nil;
            self.__OBJECT_EXISTS = false;
            _destroy(self._frame);
        end
		
		function circle:_updateRadius()
			local props = self._properties;
			local diameter = (props.Radius * 2) - (props.Thickness * 2);
			self._frame.Size = _udim2fromoffset(diameter, diameter);
		end

        circle.Remove = circle.Destroy;
        classes.Circle = circle;
    end

	do
		local enumToFont = {
			[drawing.Fonts.UI] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			[drawing.Fonts.System] = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			[drawing.Fonts.Plex] = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			[drawing.Fonts.Monospace] = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		};

		local text = {};
		
		function text.new()
			itemCounter = itemCounter + 1;
            local id = itemCounter;

            local newText = _setmetatable({
                _id = id,
                __OBJECT_EXISTS = true,
                _properties = {
					Center = false,
					Color = _color3new(),
					Font = 0,
					Outline = false,
					OutlineColor = _color3new(),
					Position = _vector2new(),
					Size = 12,
					Text = "",
					TextBounds = _vector2new(),
					Transparency = 1,
					Visible = false,
					ZIndex = 0
                },
                _frame = create("TextLabel", {
					Name = id,
					BackgroundTransparency = 1,
					FontFace = enumToFont[0],
                    Parent = drawingDirectory,
                    Position = _udim2new(),
                    Size = _udim2new(),
					Text = "",
					TextColor3 = _color3new(),
					TextSize = 12,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
                    Visible = false,
                    ZIndex = 0
				}, {
					create("UIStroke", {
						Name = "_stroke",
						Color = _color3new(),
						Enabled = false,
						Thickness = 1
					})
				})
            }, text);

            cache[id] = newText;
            return newText;
		end

		function text:__index(k)
			local prop = self._properties[k];
			if prop ~= nil then
				return prop;
			end
			return text[k];
        end

        function text:__newindex(k, v)
            if self.__OBJECT_EXISTS == true then
                if k ~= "TextBounds" then
					self._properties[k] = v;
				end
				if k == "Center" then
					self._frame.TextXAlignment = v and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left;
				elseif k == "Color" then
					self._frame.TextColor3 = v;
				elseif k == "Font" then
					self._frame.FontFace = enumToFont[v];
					self:_updateTextBounds();
				elseif k == "Outline" then
					self._frame._stroke.Enabled = v;
				elseif k == "OutlineColor" then
					self._frame._stroke.Color = v;
				elseif k == "Position" then
					self._frame.Position = _udim2fromoffset(v.X, v.Y);
				elseif k == "Size" then
					self._frame.TextSize = v;
					self:_updateTextBounds();
				elseif k == "Text" then
					self._frame.Text = v;
					self:_updateTextBounds();
				elseif k == "Transparency" then
					self._frame.TextTransparency = 1 - v;
					self._frame._stroke.Transparency = 1 - v;
				elseif k == "Visible" then
					self._frame.Visible = v;
				elseif k == "ZIndex" then
					self._frame.ZIndex = v;
				end
            end
        end
		
		function text:__iter()
            return next, self._properties;
        end
		
		function text:__tostring()
			return "Drawing";
		end

        function text:Destroy()
			cache[self._id] = nil;
            self.__OBJECT_EXISTS = false;
            _destroy(self._frame);
        end

		function text:_updateTextBounds()
			local props = self._properties;
			props.TextBounds = _gettextboundsasync(textService, create("GetTextBoundsParams", {
				Text = props.Text,
				Size = props.Size,
				Font = enumToFont[props.Font],
				Width = huge
			}));
		end

		text.Remove = text.Destroy;
		classes.Text = text;
	end

	do
		local square = {};

		function square.new()
			itemCounter = itemCounter + 1;
			local id = itemCounter;

			local newSquare = _setmetatable({
                _id = id,
                __OBJECT_EXISTS = true,
				_properties = {
					Color = _color3new(),
					Filled = false,
					Position = _vector2new(),
					Size = _vector2new(),
					Thickness = 1,
					Transparency = 1,
					Visible = false,
					ZIndex = 0
				},
				_frame = create("Frame", {
					BackgroundColor3 = _color3new(),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Parent = drawingDirectory,
                    Position = _udim2new(),
                    Size = _udim2new(),
                    Visible = false,
                    ZIndex = 0
				}, {
					create("UIStroke", {
						Name = "_stroke",
						Color = _color3new(),
						Thickness = 1
					})
				})
			}, square);
			
			cache[id] = newSquare;
			return newSquare;
		end

		function square:__index(k)
			local prop = self._properties[k];
			if prop ~= nil then
				return prop;
			end
			return square[k];
        end

        function square:__newindex(k, v)
            if self.__OBJECT_EXISTS == true then
				local props = self._properties;
				props[k] = v;
				if k == "Color" then
					self._frame.BackgroundColor3 = v;
					self._frame._stroke.Color = v;
				elseif k == "Filled" then
					self._frame.BackgroundTransparency = v and 1 - props.Transparency or 1;
				elseif k == "Position" then
					self:_updateScale();
				elseif k == "Size" then
					self:_updateScale();
				elseif k == "Thickness" then
					self._frame._stroke.Thickness = v;
					self:_updateScale();
				elseif k == "Transparency" then
					self._frame._stroke.Transparency = 1 - v;
					if props.Filled then
						self._frame.BackgroundTransparency = 1 - v;
					end
				elseif k == "Visible" then
					self._frame.Visible = v;
				elseif k == "ZIndex" then
					self._frame.ZIndex = v;
				end
            end
        end
		
		function square:__iter()
            return next, self._properties;
        end
		
		function square:__tostring()
			return "Drawing";
		end

        function square:Destroy()
			cache[self._id] = nil;
            self.__OBJECT_EXISTS = false;
            _destroy(self._frame);
        end

		function square:_updateScale()
			local props = self._properties;
			self._frame.Position = _udim2fromoffset(props.Position.X + props.Thickness, props.Position.Y + props.Thickness);
			self._frame.Size = _udim2fromoffset(props.Size.X - props.Thickness * 2, props.Size.Y - props.Thickness * 2);
		end

		square.Remove = square.Destroy;
		classes.Square = square;
	end
	
	  

do
		local image = {};

		function image.new()
			itemCounter = itemCounter + 1;
			local id = itemCounter;

			local newImage = _setmetatable({
				_id = id,
				_imageId = 0,
				__OBJECT_EXISTS = true,
				_properties = {
					Color = _color3new(1, 1, 1),
					Data = "",
					Position = _vector2new(),
					Rounding = 0,
					Size = _vector2new(),
					Transparency = 1,
					Uri = "",
					Visible = false,
					ZIndex = 0
				},
				_frame = create("ImageLabel", {
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Image = "",
					ImageColor3 = _color3new(1, 1, 1),
					Parent = drawingDirectory,
                    Position = _udim2new(),
                    Size = _udim2new(),
                    Visible = false,
                    ZIndex = 0
				}, {
					create("UICorner", {
						Name = "_corner",
						CornerRadius = _udimnew()
					})
				})
			}, image);
			
			cache[id] = newImage;
			return newImage;
		end

		function image:__index(k)
			_assert(k ~= "Data", _stringformat("Attempt to read writeonly property '%s'", k));
			if k == "Loaded" then
				return self._frame.IsLoaded;
			end
			local prop = self._properties[k];
			if prop ~= nil then
				return prop;
			end
			return image[k];
		end

		function image:__newindex(k, v)
			if self.__OBJECT_EXISTS == true then
				self._properties[k] = v;
				if k == "Color" then
					self._frame.ImageColor3 = v;
				elseif k == "Data" then
					self:_newImage(v);
				elseif k == "Position" then
					self._frame.Position = _udim2fromoffset(v.X, v.Y);
				elseif k == "Rounding" then
					self._frame._corner.CornerRadius = _udimnew(0, v);
				elseif k == "Size" then
					self._frame.Size = _udim2fromoffset(v.X, v.Y);
				elseif k == "Transparency" then
					self._frame.ImageTransparency = 1 - v;
				elseif k == "Uri" then
					self:_newImage(v, true);
				elseif k == "Visible" then
					self._frame.Visible = v;
				elseif k == "ZIndex" then
					self._frame.ZIndex = v;
				end
			end
		end
		
		function image:__iter()
            return next, self._properties;
        end
		
		function image:__tostring()
			return "Drawing";
		end

		function image:Destroy()
			cache[self._id] = nil;
			self.__OBJECT_EXISTS = false;
			_destroy(self._frame);
		end

		function image:_newImage(data, isUri)
			_taskspawn(function() -- this is fucked but u can't yield in a metamethod
				self._imageId = self._imageId + 1;
				local path = _stringformat("%s-%s.png", self._id, self._imageId);
				if isUri then
					data = _httpget(game, data, true);
					self._properties.Data = data;
				else
					self._properties.Uri = "";
				end
				self._frame.Image = _writecustomasset(path, data);
			end);
		end

		image.Remove = image.Destroy;
		classes.Image = image;
	end

	do
		local triangle = {};

		function triangle.new()
			itemCounter = itemCounter + 1;
			local id = itemCounter;

			local newTriangle = _setmetatable({
				_id = id,
				__OBJECT_EXISTS = true,
				_properties = {
					Color = _color3new(),
					Filled = false,
					PointA = _vector2new(),
					PointB = _vector2new(),
					PointC = _vector2new(),
					Thickness = 1,
					Transparency = 1,
					Visible = false,
					ZIndex = 0
				},
				_frame = create("Frame", {
					BackgroundTransparency = 1,
					Parent = drawingDirectory,
					Size = _udim2new(1, 0, 1, 0),
					Visible = false,
					ZIndex = 0
				}, {
					create("Frame", {
						Name = "_line1",
						AnchorPoint = _vector2new(0.5, 0.5),
						BackgroundColor3 = _color3new(),
						BorderSizePixel = 0,
						Position = _udim2new(),
						Size = _udim2new(),
						ZIndex = 0
					}),
					create("Frame", {
						Name = "_line2",
						AnchorPoint = _vector2new(0.5, 0.5),
						BackgroundColor3 = _color3new(),
						BorderSizePixel = 0,
						Position = _udim2new(),
						Size = _udim2new(),
						ZIndex = 0
					}),
					create("Frame", {
						Name = "_line3",
						AnchorPoint = _vector2new(0.5, 0.5),
						BackgroundColor3 = _color3new(),
						BorderSizePixel = 0,
						Position = _udim2new(),
						Size = _udim2new(),
						ZIndex = 0
					})
				})
			}, triangle);
			
			cache[id] = newTriangle;
			return newTriangle;
		end

		function triangle:__index(k)
			local prop = self._properties[k];
			if prop ~= nil then
				return prop;
			end
			return triangle[k];
		end

		function triangle:__newindex(k, v)
			if self.__OBJECT_EXISTS == true then
				local props, frame = self._properties, self._frame;
				props[k] = v;
				if k == "Color" then
					frame._line1.BackgroundColor3 = v;
					frame._line2.BackgroundColor3 = v;
					frame._line3.BackgroundColor3 = v;
				elseif k == "Filled" then
					-- TODO
				elseif k == "PointA" then
					self:_updateVertices({
						{ frame._line1, props.PointA, props.PointB },
						{ frame._line3, props.PointC, props.PointA }
					});
					if props.Filled then
						self:_calculateFill();
					end
				elseif k == "PointB" then
					self:_updateVertices({
						{ frame._line1, props.PointA, props.PointB },
						{ frame._line2, props.PointB, props.PointC }
					});
					if props.Filled then
						self:_calculateFill();
					end
				elseif k == "PointC" then
					self:_updateVertices({
						{ frame._line2, props.PointB, props.PointC },
						{ frame._line3, props.PointC, props.PointA }
					});
					if props.Filled then
						self:_calculateFill();
					end
				elseif k == "Thickness" then
					local thickness = _mathmax(v, 1);
                    frame._line1.Size = _udim2fromoffset(frame._line1.AbsoluteSize.X, thickness);
                    frame._line2.Size = _udim2fromoffset(frame._line2.AbsoluteSize.X, thickness);
                    frame._line3.Size = _udim2fromoffset(frame._line3.AbsoluteSize.X, thickness);
				elseif k == "Transparency" then
					frame._line1.BackgroundTransparency = 1 - v;
					frame._line2.BackgroundTransparency = 1 - v;
					frame._line3.BackgroundTransparency = 1 - v;
				elseif k == "Visible" then
					self._frame.Visible = v;
				elseif k == "ZIndex" then
					self._frame.ZIndex = v;
				end
			end
		end
		
		function triangle:__iter()
            return next, self._properties;
        end
		
		function triangle:__tostring()
			return "Drawing";
		end

		function triangle:Destroy()
			cache[self._id] = nil;
            self.__OBJECT_EXISTS = false;
            _destroy(self._frame);
		end

		function triangle:_updateVertices(vertices)
			local thickness = self._properties.Thickness;
			for i, v in vertices do
				updatePosition(v[1], v[2], v[3], thickness);
			end
		end

		function triangle:_calculateFill()
		
		end

		triangle.Remove = triangle.Destroy;
		classes.Triangle = triangle;
	end
	
	do
		local quad = {};
		
		function quad.new()
			itemCounter = itemCounter + 1;
			local id = itemCounter;
			
			local newQuad = _setmetatable({
				_id = id,
				__OBJECT_EXISTS = true,
				_properties = {
					Color = _color3new(),
					Filled = false,
					PointA = _vector2new(),
					PointB = _vector2new(),
					PointC = _vector2new(),
					PointD = _vector2new(),
					Thickness = 1,
					Transparency = 1,
					Visible = false,
					ZIndex = 0
				},
				_frame = create("Frame", {
					BackgroundTransparency = 1,
					Parent = drawingDirectory,
					Size = _udim2new(1, 0, 1, 0),
					Visible = false,
					ZIndex = 0
				}, {
					create("Frame", {
						Name = "_line1",
						AnchorPoint = _vector2new(0.5, 0.5),
						BackgroundColor3 = _color3new(),
						BorderSizePixel = 0,
						Position = _udim2new(),
						Size = _udim2new(),
						ZIndex = 0
					}),
					create("Frame", {
						Name = "_line2",
						AnchorPoint = _vector2new(0.5, 0.5),
						BackgroundColor3 = _color3new(),
						BorderSizePixel = 0,
						Position = _udim2new(),
						Size = _udim2new(),
						ZIndex = 0
					}),
					create("Frame", {
						Name = "_line3",
						AnchorPoint = _vector2new(0.5, 0.5),
						BackgroundColor3 = _color3new(),
						BorderSizePixel = 0,
						Position = _udim2new(),
						Size = _udim2new(),
						ZIndex = 0
					}),
					create("Frame", {
						Name = "_line4",
						AnchorPoint = _vector2new(0.5, 0.5),
						BackgroundColor3 = _color3new(),
						BorderSizePixel = 0,
						Position = _udim2new(),
						Size = _udim2new(),
						ZIndex = 0
					})
				})
			}, quad);
			
			cache[id] = newQuad;
			return newQuad;
		end
		
		function quad:__index(k)
			local prop = self._properties[k];
			if prop ~= nil then
				return prop;
			end
			return quad[k];
		end

		function quad:__newindex(k, v)
			if self.__OBJECT_EXISTS == true then
				local props, frame = self._properties, self._frame;
				props[k] = v;
				if k == "Color" then
					frame._line1.BackgroundColor3 = v;
					frame._line2.BackgroundColor3 = v;
					frame._line3.BackgroundColor3 = v;
					frame._line4.BackgroundColor3 = v;
				elseif k == "Filled" then
					-- TODO
				elseif k == "PointA" then
					self:_updateVertices({
						{ frame._line1, props.PointA, props.PointB },
						{ frame._line4, props.PointD, props.PointA }
					});
					if props.Filled then
						self:_calculateFill();
					end
				elseif k == "PointB" then
					self:_updateVertices({
						{ frame._line1, props.PointA, props.PointB },
						{ frame._line2, props.PointB, props.PointC }
					});
					if props.Filled then
						self:_calculateFill();
					end
				elseif k == "PointC" then
					self:_updateVertices({
						{ frame._line2, props.PointB, props.PointC },
						{ frame._line3, props.PointC, props.PointD }
					});
					if props.Filled then
						self:_calculateFill();
					end
				elseif k == "PointD" then
					self:_updateVertices({
						{ frame._line3, props.PointC, props.PointD },
						{ frame._line4, props.PointD, props.PointA }
					});
					if props.Filled then
						self:_calculateFill();
					end
				elseif k == "Thickness" then
					local thickness = _mathmax(v, 1);
                    frame._line1.Size = _udim2fromoffset(frame._line1.AbsoluteSize.X, thickness);
                    frame._line2.Size = _udim2fromoffset(frame._line2.AbsoluteSize.X, thickness);
                    frame._line3.Size = _udim2fromoffset(frame._line3.AbsoluteSize.X, thickness);
                    frame._line4.Size = _udim2fromoffset(frame._line3.AbsoluteSize.X, thickness);
				elseif k == "Transparency" then
					frame._line1.BackgroundTransparency = 1 - v;
					frame._line2.BackgroundTransparency = 1 - v;
					frame._line3.BackgroundTransparency = 1 - v;
					frame._line4.BackgroundTransparency = 1 - v;
				elseif k == "Visible" then
					self._frame.Visible = v;
				elseif k == "ZIndex" then
					self._frame.ZIndex = v;
				end
			end
		end
	
		function quad:__iter()
            return next, self._properties;
        end
		
		function quad:__tostring()
			return "Drawing";
		end
	
		function quad:Destroy()
			cache[self._id] = nil;
			self.__OBJECT_EXISTS = false;
			_destroy(self._frame);
		end
		
		function quad:_updateVertices(vertices)
			local thickness = self._properties.Thickness;
			for i, v in vertices do
				updatePosition(v[1], v[2], v[3], thickness);
			end
		end

		function quad:_calculateFill()
		
		end
		
		quad.Remove = quad.Destroy;
		classes.Quad = quad;
	end

    drawing.new = function(x)
        return _assert(classes[x], _stringformat("Invalid drawing type '%s'", x)).new();
    end

    drawing.clear = function()
        for i, v in cache do
			if v.__OBJECT_EXISTS then
				v:Destroy();
			end
        end
    end

	drawing.cache = cache;
end

setreadonly(drawing, true);
setreadonly(drawing.Fonts, true);

genv.Drawing = drawing;
genv.cleardrawcache = drawing.clear;

genv.isrenderobj = function(x)
	--warn("erm: "..tostring(x))
	return tostring(x) == "Drawing";
end

genv.getrenderproperty = function(x, y)
	assert(isrenderobj(x), 'invalid drawing object')
    
    return x[y];
end

genv.setrenderproperty = function(x, y, z)
    assert(isrenderobj(x), 'invalid drawing object')
    x[y] = z;
end

local _isrenderobj = (isrenderobj);

genv.DRAWING_LOADED = true;

getgenv().lz4compress = function(data)
    local i = 1
    local out = ""
    while i <= #data do
        local run = 1
        while i + run <= #data and data:sub(i, i) == data:sub(i + run, i + run) and run < 255 do
            run = run + 1
        end
        out = out .. string.char(run) .. data:sub(i, i)
        i = i + run
    end
    return out
end

getgenv().lz4decompress = function(data)
    local i = 1
    local out = ""
    while i <= #data do
        local len = string.byte(data:sub(i, i))
        local c = data:sub(i + 1, i + 1)
        out = out .. c:rep(len)
        i = i + 2
    end
    return out
end

getgenv().getscripthash = function(x)
    assert(
        table.find({ "ModuleScript", "LocalScript" }, x.ClassName),
        "Invalid argument #1 to 'getscripthash' (LuaSourceContainer expected, got " .. x.ClassName .. ")"
    )

    return x:GetHash()
end


local g=getgenv()
g.dumpstring=function(x)
return string.dump(x)
end
g.toclipboard=function(x)
setclipboard(x)
end
g.isourclosure=function(x)
return isexecutorclosure(x)
end
g.checkclosure=function(x)
return isexecutorclosure(x)
end
g.getscriptfunction=function(x)
return getscriptclosure(x)
end
g.queueonteleport="nil"
g.consoleinput="nil"
g.crypt.base64.encode = crypt.base64encode
g.crypt.base64.decode = crypt.base64decode
g.crypt.base64_encode = crypt.base64encode
g.crypt.base64_decode = crypt.base64decode
g.base64.encode = crypt.base64encode
g.base64.decode = crypt.base64decode
g.base64_encode = crypt.base64encode
g.base64_decode = crypt.base64decode
g.consoledestroy="soon"
g.consoleprint="soon"
g.consoleinput="soon"
g.rconsolename="soon"
g.consolesettitle="soon"
g.rconsolecreate="soon"
g.rconsoleclear="soon" -- aliases
local serpent = serpent or {}

getgenv().serpent.makeserpentfolder = function(path: string)
    local full = "serpent\" .. path
    if not isfolder(full) then
        makefolder(full)
    end
    return true
end

getgenv().serpent.writeserpentfile = function(path: string, content: string)
    local full = "serpent\" .. path
    writefile(full, content)
    return true
end

getgenv().serpent.listserpentfiles = function(path: string)
    local full = "serpent\" .. (path or "")
    if isfolder(full) then
        return listfiles(full)
    end
    return {}
end

getgenv().serpent.isserpentfolder = function(path: string)
    return isfolder("serpent\" .. path)
end

getgenv().serpent.readserpentfile = function(path: string)
    local full = "serpent\" .. path
    if isfile(full) then
        return readfile(full)
    end
    return nil
end

getgenv().serpent.isserpentfile = function(path: string)
    return isfile("serpent\" .. path)
end
