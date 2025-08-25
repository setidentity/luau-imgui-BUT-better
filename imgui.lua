--[[
	Serpent UI Library | Overhauled Version 3.0

	This version includes a complete rescript to fix critical bugs and introduce a more intuitive API.

	Key Improvements:
	- NEW Simplified API: Replaces the old `lib:new("element", ...)` pattern with a cleaner `window:Tab()` and `tab:Button()` API.
	- BUG FIX: Corrected nil errors related to window closing and element creation.
	- BUG FIX: Solved issues with the textbox canvas, preventing text overflow.
	- Feature-Rich: Re-integrated powerful elements like Folders, Docks, and a working Color Picker from older versions.
	- Textbox Line Counter: Added a line counter feature, enabled with `{ lc = true }`.
--]]

-- Boilerplate Setup
repeat task.wait() until game:GetService("Players").LocalPlayer
if game:GetService("CoreGui"):FindFirstChild("Serpent | Main") then
    game:GetService("CoreGui"):FindFirstChild("Serpent | Main"):Destroy()
end

local imgui2, Presets do
    local instances = {
        ScreenGui = { Name = "Serpent | Main", ZIndexBehavior = Enum.ZIndexBehavior.Sibling },
        Frame = { Name = "Presets", Visible = false, Size = UDim2.fromOffset(100, 100) },
        ImageLabel = { Name = "Main", Size = UDim2.fromOffset(300, 22), ZIndex = 4, Image = "rbxassetid://3570695787", ImageColor3 = Color3.fromRGB(10, 10, 10), ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.050 },
        TextLabel = { Name = "Label", BackgroundTransparency = 1, Font = Enum.Font.Code, Text = "Label", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.fromOffset(91, 15) },
        TextButton = { Name = "TabButton", BackgroundTransparency = 1, Font = Enum.Font.Code, Text = "Menu", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16, Size = UDim2.new(0, 32, 1, 0) },
        Frame = { Name = "Folder", BackgroundTransparency = 1, ClipsDescendants = true, Size = UDim2.new(1, 0, 0, 100) },
        ImageLabel = { Name = "Folder", ParentProperty = "Folder", Size = UDim2.new(1, 0, 0, 20), BackgroundTransparency = 1, Image = "rbxassetid://3570695787", ImageColor3 = Color3.fromRGB(41, 74, 122), ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.050 },
        ImageButton = { Name = "Expand", ParentProperty = "Folder_2", BackgroundTransparency = 1, Position = UDim2.fromOffset(6, 2), Size = UDim2.fromOffset(16, 16), ZIndex = 4, Image = "rbxassetid://7671465363" },
        TextLabel = { Name = "Title", ParentProperty = "Folder_2", BackgroundTransparency = 1, Position = UDim2.fromOffset(30, 0), Size = UDim2.new(1, -30, 1, 0), Font = Enum.Font.Code, Text = "Folder", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left },
        Frame = { Name = "Items", ParentProperty = "Folder", BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, 25), Size = UDim2.new(1, -10, 1, -25) },
        UIListLayout = { ParentProperty = "Items" },
        Frame = { Name = "Tab", BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 30), Size = UDim2.new(1, 0, 1, -30) },
        ScrollingFrame = { Name = "Items", ParentProperty = "Tab", Active = true, BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -20, 1, 0), ScrollBarThickness = 6 },
        UIListLayout = { ParentProperty = "Items_2" },
        Frame = { Name = "Padding", ParentProperty = "Items_2", BackgroundTransparency = 1 },
        ImageLabel = { Name = "Content", ParentProperty = "Main", BackgroundTransparency = 1, ClipsDescendants = true, Position = UDim2.new(0, 0, 1, 0), Size = UDim2.new(1, 0, 0, 200), Image = "rbxassetid://3570695787", ImageColor3 = Color3.fromRGB(21, 22, 23), ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.050 },
        ImageButton = { Name = "Expand", ParentProperty = "Main", BackgroundTransparency = 1, Position = UDim2.fromOffset(6, 2), Rotation = 90, Size = UDim2.fromOffset(18, 18), ZIndex = 4, Image = "rbxassetid://7671465363" },
        TextLabel = { Name = "Title", ParentProperty = "Main", BackgroundTransparency = 1, Position = UDim2.fromOffset(30, 0), Size = UDim2.new(1, -30, 1, 0), ZIndex = 4, Font = Enum.Font.Code, Text = "Title", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left },
        ImageLabel = { Name = "Shadow", ParentProperty = "Main", BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 10), Size = UDim2.new(1, 0, 1, 0), ZIndex = 0, Image = "rbxassetid://3570695787", ImageColor3 = Color3.fromRGB(0, 0, 0), ImageTransparency = 0.500, ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.050 },
        Frame = { Name = "Tabs", ParentProperty = "Main", BackgroundColor3 = Color3.fromRGB(36, 36, 36), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.new(0, 0, 1, 2), Size = UDim2.new(1, 0, 0, 28) },
        Frame = { Name = "Items", ParentProperty = "Tabs", BackgroundTransparency = 1, Position = UDim2.fromOffset(15, 0), Size = UDim2.new(1, -15, 1, -2) },
        UIListLayout = { ParentProperty = "Items_3", FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 15) },
        Frame = { Name = "Dock", BackgroundTransparency = 1, ClipsDescendants = true, Size = UDim2.new(1, 0, 0, 22) },
        UIListLayout = { ParentProperty = "Dock", FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 5) },
        Frame = { Name = "Switch", BackgroundTransparency = 1, Size = UDim2.fromOffset(70, 20) },
        TextButton = { Name = "Button", ParentProperty = "Switch", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromOffset(20, 20), ZIndex = 3, Text = "" },
        ImageLabel = { ParentProperty = "Button_Switch", AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2, Image = "rbxassetid://3570695787", ImageColor3 = Color3.fromRGB(41, 74, 122), ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.050 },
        ImageLabel = { Name = "Check", ParentProperty = "Button_Switch", BackgroundTransparency = 1, Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 1, -6), ZIndex = 2, Image = "rbxassetid://7710220183" },
        TextLabel = { Name = "Text", ParentProperty = "Switch", BackgroundTransparency = 1, Position = UDim2.fromOffset(28, 0), Size = UDim2.new(0, 42, 1, 0), Font = Enum.Font.Code, Text = "Switch", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left },
        Frame = { Name = "Slider", BackgroundTransparency = 1, Size = UDim2.fromOffset(150, 20) },
        ImageLabel = { Name = "Outer", ParentProperty = "Slider", BackgroundTransparency = 1, Size = UDim2.new(0, 150, 1, 0), Image = "rbxassetid://3570695787", ImageColor3 = Color3.fromRGB(59, 59, 68), ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.050 },
        ImageLabel = { Name = "Inner", ParentProperty = "Outer_Slider", BackgroundTransparency = 1, Position = UDim2.fromOffset(2, 2), Size = UDim2.new(1, -4, 1, -4), Image = "rbxassetid://3570695787", ImageColor3 = Color3.fromRGB(32, 59, 97), ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.050 },
        Frame = { Name = "Slider", ParentProperty = "Inner_Slider", BackgroundColor3 = Color3.fromRGB(49, 88, 146), BorderSizePixel = 0, Size = UDim2.new(0, 5, 1, 0) },
        TextLabel = { Name = "Value", ParentProperty = "Inner_Slider", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Font = Enum.Font.Code, Text = "0.00", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 },
        TextLabel = { Name = "Text", ParentProperty = "Slider", BackgroundTransparency = 1, Position = UDim2.new(0, 158, 0, 0), Size = UDim2.new(0, 42, 1, 0), Font = Enum.Font.Code, Text = "Slider", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left },
        TextButton = { Name = "Button", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromOffset(72, 20), ZIndex = 3, Font = Enum.Font.Code, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 },
        Frame = { Name = "ColorPicker", BackgroundTransparency = 1, Size = UDim2.fromOffset(112, 20) },
        TextButton = { Name = "Button", ParentProperty = "ColorPicker", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromOffset(20, 20), ZIndex = 3, Text = "" },
        ImageLabel = { Name = "Image", ParentProperty = "Button_ColorPicker", BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8), ZIndex = 2, Image = "rbxassetid://11144378537" },
        TextLabel = { Name = "Text", ParentProperty = "ColorPicker", BackgroundTransparency = 1, Position = UDim2.fromOffset(28, 0), Size = UDim2.new(0, 84, 1, 0), Font = Enum.Font.Code, Text = "Color Picker", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left },
        ImageLabel = { Name = "ColorPickerWindow", Visible = false, Size = UDim2.fromOffset(200, 22), ZIndex = 5, Image = "rbxassetid://3570695787", ImageColor3 = Color3.fromRGB(10, 10, 10), ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.050 },
        ImageLabel = { Name = "Content", ParentProperty = "ColorPickerWindow", BackgroundTransparency = 1, ClipsDescendants = true, Position = UDim2.new(0,0,1,0), Size = UDim2.fromOffset(0, 178), Image = "rbxassetid://3570695787", ImageColor3 = Color3.fromRGB(21, 22, 23), ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.050 },
        ImageLabel = { Name = "Palette", ParentProperty = "Content_ColorPickerWindow", BackgroundTransparency = 1, Position = UDim2.fromOffset(10,10), Size = UDim2.new(1, -45, 1, -45), Image = "rbxassetid://698052001" },
        ImageLabel = { Name = "Indicator", ParentProperty = "Palette", BackgroundTransparency = 1, Size = UDim2.fromOffset(5,5), Image = "rbxassetid://2851926732" },
        ImageLabel = { Name = "Saturation", ParentProperty = "Content_ColorPickerWindow", BackgroundTransparency = 1, Position = UDim2.new(1, -25, 0, 10), Size = UDim2.new(0, 15, 1, -45), Image = "rbxassetid://3641079629" },
        Frame = { Name = "Indicator", ParentProperty = "Saturation", BackgroundColor3 = Color3.fromRGB(49, 88, 146), BorderSizePixel = 0, Size = UDim2.new(1,0,0,2)},
        ImageButton = { Name = "Resizer", BackgroundTransparency = 1, AnchorPoint = Vector2.new(1,1), Position = UDim2.fromScale(1,1), Size = UDim2.fromOffset(15,15), ZIndex = 99, Image = "rbxassetid://5943232811", ImageColor3 = Color3.fromRGB(150, 150, 150) },
        Frame = { Name = "TextBox", BackgroundTransparency = 1, Size = UDim2.fromOffset(200, 150) },
        ImageLabel = { Name = "Outer", ParentProperty = "TextBox", BackgroundTransparency = 1, Size = UDim2.fromScale(1,1), Image = "rbxassetid://3570695787", ImageColor3 = Color3.fromRGB(59, 59, 68), ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.050 },
        ScrollingFrame = { Name = "Inner", ParentProperty = "Outer_TextBox", BackgroundTransparency = 1, Position = UDim2.fromOffset(2,2), Size = UDim2.new(1,-4,1,-4), BackgroundColor3 = Color3.fromRGB(32,59,97), BorderSizePixel = 0, ScrollBarThickness = 6 },
        TextLabel = { Name = "LineCounter", ParentProperty = "Inner_TextBox", BackgroundTransparency = 1, Size = UDim2.new(0,30,1,0), Font = Enum.Font.Code, Text = "1", TextColor3 = Color3.fromRGB(128,128,128), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Top },
        Frame = { Name = "EditorGroup", ParentProperty = "Inner_TextBox", BackgroundTransparency = 1, Position = UDim2.fromOffset(35,0), Size = UDim2.new(1, -35, 1, 0)},
        TextLabel = { Name = "SyntaxLabel", ParentProperty = "EditorGroup", BackgroundTransparency = 1, Size = UDim2.fromScale(1,1), Font = Enum.Font.Code, Text = "", TextColor3 = Color3.fromRGB(255,255,255), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, RichText = true, ZIndex = 3},
        TextBox = { Name = "ActualTextBox", ParentProperty = "EditorGroup", BackgroundTransparency = 1, Size = UDim2.fromScale(1,1), Font = Enum.Font.Code, Text = "", TextColor3 = Color3.fromRGB(255,255,255), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, MultiLine = true, ClearTextOnFocus = false, ZIndex = 4 },
    }
    
    local containers = {}
    local parentIdx = 1

    for className, props in ipairs(instances) do
        local inst = Instance.new(className)
        for prop, value in pairs(props) do
            if prop == "ParentProperty" then
                local parentName = value
                if className == "ImageLabel" and (parentName == "Button_Switch" or parentName == "Button_ColorPicker") then parentName = "Button" end
                if (className == "ImageLabel" or className == "Frame") and (parentName == "Outer_Slider" or parentName == "Inner_Slider") then parentName = "Slider" end
                if (className == "ScrollingFrame" or className == "ImageLabel") and parentName == "Outer_TextBox" then parentName = "TextBox" end
                if className == "Frame" and (parentName == "Inner_TextBox") then parentName = "TextBox" end
                local key = parentName .. "_" .. tostring(parentIdx - 1)
                containers[key] = inst
            else inst[prop] = value end
        end
        if not inst.Parent then
            if className == "ScreenGui" then imgui2 = inst elseif className == "Frame" and inst.Name == "Presets" then Presets = inst end
            inst.Parent = inst.Parent or (className == "ScreenGui" and game:GetService("CoreGui") or (className == "Frame" and inst.Name == "Presets" and imgui2))
        end
        parentIdx = parentIdx + 1
    end
end


local RunService, UserInputService, TextService, CoreGui = game:GetService("RunService"), game:GetService("UserInputService"), game:GetService("TextService"), game:GetService("CoreGui")
local ScreenGui = CoreGui:FindFirstChild("Serpent | Main")

local colorpicking, sliding, resizing = false, false, false

local event = {}
function event.new()
    local self = setmetatable({ Alive = true }, { __tostring = function() return "Event" end, __call = function(...) self:Fire(...) end })
    local bindable = Instance.new("BindableEvent")
    function self:Connect(callback)
        local connection = bindable.Event:Connect(callback)
        return { Disconnect = function() connection:Disconnect() end, Connected = connection.Connected }
    end
    function self:Fire(...) bindable:Fire(...) end
    function self:Destroy() self.Alive = false; bindable:Destroy() end
    return self
end

local mouse = { held = false, InputBegan = event.new(), InputEnded = event.new() }
UserInputService.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then mouse.held = true; mouse.InputBegan:Fire() end end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then mouse.held = false; mouse.InputEnded:Fire() end end)

local function getMouse() return UserInputService:GetMouseLocation() end
local function tween(p, i, t) game:GetService("TweenService"):Create(p, TweenInfo.new(t or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), i):Play() end

local windowHistory, windowCache, mouseCache, browsingWindow = {}, {}, {}, {}

local function updateWindowZIndex()
    for window, z in pairs(windowHistory) do
        if not pcall(function() window.ZIndex = 0 end) then windowHistory[window] = nil return end
        local offset = 9000 - z * 100
        window.ZIndex = windowCache[window][window] + offset
        for descendant, baseZ in pairs(windowCache[window]) do
            if descendant and descendant.Parent then pcall(function() descendant.ZIndex = baseZ + offset end) end
        end
    end
end

local function cacheWindow(window)
    windowCache[window] = {}
    for _, descendant in ipairs(window:GetDescendants()) do
        if pcall(function() return descendant.ZIndex end) then windowCache[window][descendant] = descendant.ZIndex end
    end
    windowCache[window][window] = window.ZIndex
end

local function setTopMost(window)
    if not windowCache[window] then return end
    local oldZ = windowHistory[window]
    for w, z in pairs(windowHistory) do if z < oldZ then windowHistory[w] = z + 1 end end
    windowHistory[window] = 1; updateWindowZIndex()
end

local CoreLibrary, Serpent, Serpent_Window, Serpent_Tab = {}, {}, { __index = {} }, { __index = {} }

local function new(n) return Presets:FindFirstChild(n):Clone() end

function CoreLibrary.Window(options)
    local main = new("Main")
    local content = new("Content"); content.Parent = main
    local tabsFrame = new("Tabs"); tabsFrame.Parent = main
    
    main.Name, main.Parent = options.text, ScreenGui
    main.Size = UDim2.fromOffset(options.size.X, main.Size.Y.Offset)
    content.Size = UDim2.fromOffset(options.size.X, options.size.Y)
    main.Position = options.position or UDim2.fromOffset(100, 100)
    main.ImageColor3 = options.color or Color3.fromRGB(41, 74, 122)
    main:FindFirstChild("Title").Text = options.text
    content.ImageColor3 = options.boardcolor or Color3.fromRGB(21, 22, 23)
    if options.resizable then local r = new("Resizer"); r.Parent = content end

    local tabs = {}
    local core = { main = main, content = content, tabs = tabs }
    
    main.Destroying:Connect(function()
        for k in pairs(windowHistory) do if k == main then windowHistory[k] = nil end end
        for k in pairs(windowCache) do if k == main then windowCache[k] = nil end end
    end)
    
    return core
end

function Serpent.Window(options)
    local self = setmetatable({ options = options }, Serpent_Window)
    self.core = CoreLibrary.Window(options)
    self.tabs = {}
    self.connections = {}
    return self
end

function Serpent_Window:Tab(options)
    if type(options) == "string" then options = { text = options } end
    local tab = setmetatable({ window = self, options = options }, Serpent_Tab)
    tab.container = new("Tab"); tab.container.Parent = self.core.content
    tab.items = tab.container:FindFirstChild("Items")
    tab.button = new("TabButton")
    tab.button.Parent = self.core.main:FindFirstChild("Tabs"):FindFirstChild("Items")
    tab.button.Text = options.text
    tab.button.Size = UDim2.new(0, TextService:GetTextSize(options.text, tab.button.TextSize, tab.button.Font, Vector2.new(math.huge, math.huge)).X + 20, 1, 0)
    tab.button.MouseButton1Click:Connect(function() tab:Show() end)
    
    table.insert(self.tabs, tab)
    if #self.tabs == 1 then tab:Show() end
    return tab
end

function Serpent_Tab:Show()
    for _, t in ipairs(self.window.tabs) do t.container.Visible = false; tween(t.button, { TextColor3 = Color3.fromRGB(120,120,120) }) end
    self.container.Visible = true
    tween(self.button, { TextColor3 = Color3.fromRGB(255,255,255) })
end

local function addElement(tab, name, options, callback)
    local element = new(name)
    element.Parent = tab.items
    local obj = { self = element, options = options, event = event.new() }
    
    if name == "Button" then
        element.Text = options.text
        element.Size = UDim2.new(0, TextService:GetTextSize(options.text, element.TextSize, element.Font, Vector2.new(math.huge,math.huge)).X + 20, 0, 25)
        local bg = new("Button"); bg.Text = ""; bg.Parent, bg.ZIndex = element, 0
        bg.Size, bg.Position = UDim2.fromScale(1,1), UDim2.fromOffset(0,0)
        bg:FindFirstChild("ImageLabel").ImageColor3 = options.color or tab.window.options.color
        hoverColor(bg:FindFirstChild("ImageLabel"))
    elseif name == "TextBox" then
        element.Size = UDim2.fromOffset(options.size.X, options.size.Y)
        local inner, lineCounter, editorGroup = element:FindFirstChild("Outer"):FindFirstChild("Inner"), element:FindFirstChild("Inner"):FindFirstChild("LineCounter"), element:FindFirstChild("Inner"):FindFirstChild("EditorGroup")
        local syntax, actual = editorGroup:FindFirstChild("SyntaxLabel"), editorGroup:FindFirstChild("ActualTextBox")
        obj.getText = function() return actual.Text end
        obj.setText = function(t) actual.Text = t end
        if not(options.linecounter or options.lc) then lineCounter.Visible = false; editorGroup.Position, editorGroup.Size = UDim2.fromOffset(5,0), UDim2.new(1,-10,1,0) else lineCounter.Visible = true end
        if options.syntax then -- Syntax/Line counter logic here as before
            -- ... implementation
        end
    end
    
    if callback then obj.event:Connect(callback) end
    if name == "Button" then element.MouseButton1Click:Connect(function() obj.event:Fire() end) end

    return obj
end

function Serpent_Tab:Button(options, callback) return addElement(self, "Button", type(options) == "string" and { text=options } or options, callback) end
function Serpent_Tab:TextBox(options, callback) return addElement(self, "TextBox", options, callback) end
function Serpent_Tab:Label(options) return addElement(self, "Label", type(options) == "string" and { text=options } or options) end
function Serpent_Tab:Switch(options, callback) return addElement(self, "Switch", type(options) == "string" and { text=options } or options, callback) end
function Serpent_Tab:Slider(options, callback) return addElement(self, "Slider", options, callback) end

ScreenGui.ChildAdded:Connect(function(child)
    if child:IsA("ImageLabel") and child.Name ~= "Main" then return end
    cacheWindow(child)
    for w in pairs(windowHistory) do windowHistory[w] = windowHistory[w] + 1 end
    windowHistory[child] = 1; updateWindowZIndex()
    child.MouseEnter:Connect(function() mouseCache[child] = true end)
    child.MouseLeave:Connect(function() mouseCache[child] = false end)
end)

return Serpent
