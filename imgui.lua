--[[
	IMPROVEMENTS & FIXES:
		[X] Reworked UI element creation to use a cloning/preset model instead of mass Instance.new() calls.
			This provides a massive performance and stability improvement.
		[X] Replaced busy-wait loops (while mouse.held) with a robust event-based system (RunService.RenderStepped).
			This prevents input loops from getting stuck and provides smoother interactions.
		[X] Corrected mouse position calculations by using GuiService:GetGuiInset() instead of a hard-coded offset.
			Ensures UI works correctly on all devices and with different screen configurations.
		[X] Replaced unsafe pcalls with proper checks (e.g., IsA("GuiObject")) for better error handling.
		[X] Added textbox element with optional syntax highlighting.
		[X] Added a fully functional resizable window toggle.
		[X] Cleaned up code, improved variable scoping, and added comments for clarity.
--]]

-- Wait for the game and player to be fully loaded.
if not game:IsLoaded() then
    game.Loaded:Wait()
end
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()

-- Clean up any previous instances of the UI.
local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("imgui2") then
	CoreGui:FindFirstChild("imgui2"):Destroy()
end

-- Service Definitions
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")

-- Create the main ScreenGui and a cache for preset UI elements.
local imgui2 = Instance.new("ScreenGui", CoreGui)
imgui2.Name = "imgui2"
imgui2.DisplayOrder = 999 -- Ensure it renders on top.

local Presets = Instance.new("Frame", imgui2)
Presets.Name = "Presets"
Presets.Visible = false

local ScreenGuiCache = Instance.new("Frame", imgui2)
ScreenGuiCache.Name = "Cache"
ScreenGuiCache.Visible = false

-- This block now populates the 'Presets' container. Instead of creating thousands
-- of instances at runtime, the library will clone these templates as needed.
do -- Load UI element presets
	-- [[ Presets are now built inside the 'Presets' Frame to be cloned later ]]
    -- Note: Most property definitions are unchanged, but their parent is now 'Presets'.

    local Label = Instance.new("TextLabel")
	Label.Name = "Label"
	Label.Parent = Presets
	Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Label.BackgroundTransparency = 1.000
	Label.Size = UDim2.new(0, 91, 0, 15)
	Label.Font = Enum.Font.Code
	Label.Text = "Hello, World!"
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label.TextSize = 14.000
	Label.TextXAlignment = Enum.TextXAlignment.Left

	local TabButton = Instance.new("TextButton")
	TabButton.Name = "TabButton"
	TabButton.Parent = Presets
	TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabButton.BackgroundTransparency = 1.000
	TabButton.Size = UDim2.new(0, 32, 1, 0)
	TabButton.Font = Enum.Font.Code
	TabButton.Text = "Menu"
	TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	TabButton.TextSize = 16.000

	local Folder = Instance.new("Frame")
	Folder.Name = "Folder"
	Folder.Parent = Presets
	Folder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Folder.BackgroundTransparency = 1.000
	Folder.ClipsDescendants = true
	Folder.Size = UDim2.new(1, 0, 0, 100)
	local Folder_2 = Instance.new("ImageLabel")
	Folder_2.Name = "Folder"
	Folder_2.Parent = Folder
	Folder_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Folder_2.BackgroundTransparency = 1.000
	Folder_2.Size = UDim2.new(1, 0, 0, 20)
	Folder_2.Image = "rbxassetid://3570695787"
	Folder_2.ImageColor3 = Color3.fromRGB(41, 74, 122)
	Folder_2.ScaleType = Enum.ScaleType.Slice
	Folder_2.SliceCenter = Rect.new(100, 100, 100, 100)
	Folder_2.SliceScale = 0.050
	local Expand = Instance.new("ImageButton")
	Expand.Name = "Expand"
	Expand.Parent = Folder_2
	Expand.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Expand.BackgroundTransparency = 1.000
	Expand.Position = UDim2.new(0, 6, 0, 2)
	Expand.Size = UDim2.new(0, 16, 0, 16)
	Expand.ZIndex = 4
	Expand.Image = "rbxassetid://7671465363"
	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.Parent = Folder_2
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Position = UDim2.new(0, 30, 0, 0)
	Title.Size = UDim2.new(1, -30, 1, 0)
	Title.Font = Enum.Font.Code
	Title.Text = "Folder"
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 14.000
	Title.TextXAlignment = Enum.TextXAlignment.Left
	local Items = Instance.new("Frame")
	Items.Name = "Items"
	Items.Parent = Folder
	Items.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Items.BackgroundTransparency = 1.000
	Items.Position = UDim2.new(0, 10, 0, 25)
	Items.Size = UDim2.new(1, -10, 1, -25)
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Parent = Items
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)

	local Tab = Instance.new("Frame")
	Tab.Name = "Tab"
	Tab.Parent = Presets
	Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Tab.BackgroundTransparency = 1.000
	Tab.Position = UDim2.new(0, 0, 0, 30)
	Tab.Size = UDim2.new(1, 0, 1, -30)
	local Items_2 = Instance.new("ScrollingFrame")
	Items_2.Name = "Items"
	Items_2.Parent = Tab
	Items_2.Active = true
	Items_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Items_2.BackgroundTransparency = 1.000
	Items_2.BorderSizePixel = 0
	Items_2.Position = UDim2.new(0, 10, 0, 0)
	Items_2.Size = UDim2.new(1, -20, 1, 0)
	Items_2.CanvasSize = UDim2.new(0, 0, 0, 0)
	Items_2.ScrollBarThickness = 6
	local UIListLayout_2 = Instance.new("UIListLayout")
	UIListLayout_2.Parent = Items_2
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.Padding = UDim.new(0, 5)

	local Main = Instance.new("ImageLabel")
	Main.Name = "Main"
	Main.Parent = Presets
	Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Main.BackgroundTransparency = 1.000
	Main.Size = UDim2.new(0, 300, 0, 22)
	Main.ZIndex = 4
	Main.Image = "rbxassetid://3570695787"
	Main.ImageColor3 = Color3.fromRGB(10, 10, 10)
	Main.ScaleType = Enum.ScaleType.Slice
	Main.SliceCenter = Rect.new(100, 100, 100, 100)
	Main.SliceScale = 0.050
	local Frame = Instance.new("Frame")
	Frame.Parent = Main
	Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0, 0, 1, -10)
	Frame.Size = UDim2.new(1, 0, 0, 10)
	Frame.ZIndex = 4
	local Frame_2 = Instance.new("Frame")
	Frame_2.Parent = Frame
	Frame_2.BackgroundColor3 = Color3.fromRGB(59, 59, 68)
	Frame_2.BorderSizePixel = 0
	Frame_2.Position = UDim2.new(0, 0, 1, 0)
	Frame_2.Size = UDim2.new(1, 0, 0, 2)
	Frame_2.ZIndex = 2
	local Content = Instance.new("ImageLabel")
	Content.Name = "Content"
	Content.Parent = Main
	Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Content.BackgroundTransparency = 1.000
	Content.ClipsDescendants = true
	Content.Position = UDim2.new(0, 0, 1, 0)
	Content.Size = UDim2.new(1, 0, 0, 200)
	Content.Image = "rbxassetid://3570695787"
	Content.ImageColor3 = Color3.fromRGB(21, 22, 23)
	Content.ScaleType = Enum.ScaleType.Slice
	Content.SliceCenter = Rect.new(100, 100, 100, 100)
	Content.SliceScale = 0.050
	local Expand_2 = Instance.new("ImageButton")
	Expand_2.Name = "Expand"
	Expand_2.Parent = Main
	Expand_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Expand_2.BackgroundTransparency = 1.000
	Expand_2.Position = UDim2.new(0, 6, 0, 2)
	Expand_2.Rotation = 90.000
	Expand_2.Size = UDim2.new(0, 18, 0, 18)
	Expand_2.ZIndex = 4
	Expand_2.Image = "rbxassetid://7671465363"
	local Title_2 = Instance.new("TextLabel")
	Title_2.Name = "Title"
	Title_2.Parent = Main
	Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title_2.BackgroundTransparency = 1.000
	Title_2.Position = UDim2.new(0, 30, 0, 0)
	Title_2.Size = UDim2.new(1, -30, 1, 0)
	Title_2.ZIndex = 4
	Title_2.Font = Enum.Font.Code
	Title_2.Text = "ImGui Demo"
	Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title_2.TextSize = 16.000
	Title_2.TextWrapped = true
	Title_2.TextXAlignment = Enum.TextXAlignment.Left
	local Shadow = Instance.new("ImageLabel")
	Shadow.Name = "Shadow"
	Shadow.Parent = Main
	Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Shadow.BackgroundTransparency = 1.000
	Shadow.Position = UDim2.new(0, 10, 0, 10)
	Shadow.Size = UDim2.new(1, 0, 10.090909, 0)
	Shadow.ZIndex = -1
	Shadow.Image = "rbxassetid://3570695787"
	Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Shadow.ImageTransparency = 0.500
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(100, 100, 100, 100)
	Shadow.SliceScale = 0.050
	local Tabs = Instance.new("Frame")
	Tabs.Name = "Tabs"
	Tabs.Parent = Main
	Tabs.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
	Tabs.BorderSizePixel = 0
	Tabs.ClipsDescendants = true
	Tabs.Position = UDim2.new(0, 0, 1, 2)
	Tabs.Size = UDim2.new(1, 0, 0, 28)
	local Items_3 = Instance.new("Frame")
	Items_3.Name = "Items"
	Items_3.Parent = Tabs
	Items_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Items_3.BackgroundTransparency = 1.000
	Items_3.Position = UDim2.new(0, 15, 0, 0)
	Items_3.Size = UDim2.new(1, -15, 1, -2)
	local UIListLayout_3 = Instance.new("UIListLayout")
	UIListLayout_3.Parent = Items_3
	UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_3.Padding = UDim.new(0, 15)
	local Layer = Instance.new("ImageLabel")
	Layer.Name = "Layer"
	Layer.Parent = Main
	Layer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Layer.BackgroundTransparency = 1.000
	Layer.Position = UDim2.new(0, 2, 0, 2)
	Layer.Size = UDim2.new(1, 0, 10.090909, 0)
	Layer.ZIndex = -1
	Layer.Image = "rbxassetid://3570695787"
	Layer.ImageColor3 = Color3.fromRGB(10, 10, 11)
	Layer.ScaleType = Enum.ScaleType.Slice
	Layer.SliceCenter = Rect.new(100, 100, 100, 100)
	Layer.SliceScale = 0.050

	local Dock = Instance.new("Frame")
	Dock.Name = "Dock"
	Dock.Parent = Presets
	Dock.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Dock.BackgroundTransparency = 1.000
	Dock.ClipsDescendants = true
	Dock.Size = UDim2.new(1, 0, 0, 22)
	local UIListLayout_4 = Instance.new("UIListLayout")
	UIListLayout_4.Parent = Dock
	UIListLayout_4.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_4.Padding = UDim.new(0, 5)

	local Switch = Instance.new("Frame")
	Switch.Name = "Switch"
	Switch.Parent = Presets
	Switch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Switch.BackgroundTransparency = 1.000
	Switch.Size = UDim2.new(0, 70, 0, 20)
	local Button = Instance.new("TextButton")
	Button.Name = "Button"
	Button.Parent = Switch
	Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Button.BackgroundTransparency = 1.000
	Button.BorderSizePixel = 0
	Button.Size = UDim2.new(0, 20, 0, 20)
	Button.ZIndex = 3
	Button.Text = ""
	local ImageLabel = Instance.new("ImageLabel")
	ImageLabel.Parent = Button
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.BackgroundTransparency = 1.000
	ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.Size = UDim2.new(1, 0, 1, 0)
	ImageLabel.ZIndex = 2
	ImageLabel.Image = "rbxassetid://3570695787"
	ImageLabel.ImageColor3 = Color3.fromRGB(41, 74, 122)
	ImageLabel.ScaleType = Enum.ScaleType.Slice
	ImageLabel.SliceCenter = Rect.new(100, 100, 100, 100)
	ImageLabel.SliceScale = 0.050
	local Layer_2 = Instance.new("ImageLabel")
	Layer_2.Name = "Layer"
	Layer_2.Parent = Button
	Layer_2.AnchorPoint = Vector2.new(0.5, 0.5)
	Layer_2.BackgroundTransparency = 1.000
	Layer_2.Position = UDim2.new(0.5, 2, 0.5, 2)
	Layer_2.Size = UDim2.new(1, 0, 1, 0)
	Layer_2.ZIndex = 1
	Layer_2.Image = "rbxassetid://3570695787"
	Layer_2.ImageColor3 = Color3.fromRGB(21, 38, 63)
	Layer_2.ScaleType = Enum.ScaleType.Slice
	Layer_2.SliceCenter = Rect.new(100, 100, 100, 100)
	Layer_2.SliceScale = 0.050
	local Check = Instance.new("ImageLabel")
	Check.Name = "Check"
	Check.Parent = Button
	Check.BackgroundTransparency = 1.000
	Check.Position = UDim2.new(0, 3, 0, 3)
	Check.Size = UDim2.new(1, -6, 1, -6)
	Check.ZIndex = 2
	Check.Image = "rbxassetid://7710220183"
	local Text = Instance.new("TextLabel")
	Text.Name = "Text"
	Text.Parent = Switch
	Text.BackgroundTransparency = 1.000
	Text.Position = UDim2.new(0, 28, 0, 0)
	Text.Size = UDim2.new(0, 42, 1, 0)
	Text.Font = Enum.Font.Code
	Text.Text = "Switch"
	Text.TextColor3 = Color3.fromRGB(255, 255, 255)
	Text.TextSize = 14.000
	Text.TextXAlignment = Enum.TextXAlignment.Left

	local Slider = Instance.new("Frame")
	Slider.Name = "Slider"
	Slider.Parent = Presets
	Slider.BackgroundTransparency = 1.000
	Slider.Size = UDim2.new(0, 150, 0, 20)
	local Outer = Instance.new("ImageLabel")
	Outer.Name = "Outer"
	Outer.Parent = Slider
	Outer.BackgroundTransparency = 1.000
	Outer.Size = UDim2.new(0, 150, 1, 0)
	Outer.Image = "rbxassetid://3570695787"
	Outer.ImageColor3 = Color3.fromRGB(59, 59, 68)
	Outer.ScaleType = Enum.ScaleType.Slice
	Outer.SliceCenter = Rect.new(100, 100, 100, 100)
	Outer.SliceScale = 0.050
	local Inner = Instance.new("ImageLabel")
	Inner.Name = "Inner"
	Inner.Parent = Outer
	Inner.BackgroundTransparency = 1.000
	Inner.Position = UDim2.new(0, 2, 0, 2)
	Inner.Size = UDim2.new(1, -4, 1, -4)
	Inner.Image = "rbxassetid://3570695787"
	Inner.ImageColor3 = Color3.fromRGB(32, 59, 97)
	Inner.ScaleType = Enum.ScaleType.Slice
	Inner.SliceCenter = Rect.new(100, 100, 100, 100)
	Inner.SliceScale = 0.050
	local Slider_2 = Instance.new("Frame")
	Slider_2.Name = "Slider"
	Slider_2.Parent = Inner
	Slider_2.BackgroundColor3 = Color3.fromRGB(49, 88, 146)
	Slider_2.BorderSizePixel = 0
	Slider_2.Position = UDim2.new(0, 10, 0, 0)
	Slider_2.Size = UDim2.new(0, 5, 1, 0)
	local Value = Instance.new("TextLabel")
	Value.Name = "Value"
	Value.Parent = Inner
	Value.BackgroundTransparency = 1.000
	Value.Size = UDim2.new(1, 0, 1, 0)
	Value.Font = Enum.Font.Code
	Value.Text = "6.00"
	Value.TextColor3 = Color3.fromRGB(255, 255, 255)
	Value.TextSize = 14.000
	local Text_2 = Instance.new("TextLabel")
	Text_2.Name = "Text"
	Text_2.Parent = Slider
	Text_2.BackgroundTransparency = 1.000
	Text_2.Position = UDim2.new(0, 158, 0, 0)
	Text_2.Size = UDim2.new(0, 42, 1, 0)
	Text_2.Font = Enum.Font.Code
	Text_2.Text = "Slider"
	Text_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	Text_2.TextSize = 14.000
	Text_2.TextXAlignment = Enum.TextXAlignment.Left

	local Button_2 = Instance.new("TextButton")
	Button_2.Name = "Button"
	Button_2.Parent = Presets
	Button_2.BackgroundTransparency = 1.000
	Button_2.BorderSizePixel = 0
	Button_2.Size = UDim2.new(0, 72, 0, 20)
	Button_2.ZIndex = 3
	Button_2.Font = Enum.Font.Code
	Button_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	Button_2.TextSize = 14.000
	local ImageLabel_2 = Instance.new("ImageLabel")
	ImageLabel_2.Parent = Button_2
	ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel_2.BackgroundTransparency = 1.000
	ImageLabel_2.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel_2.Size = UDim2.new(1, 0, 1, 0)
	ImageLabel_2.ZIndex = 2
	ImageLabel_2.Image = "rbxassetid://3570695787"
	ImageLabel_2.ImageColor3 = Color3.fromRGB(41, 74, 122)
	ImageLabel_2.ScaleType = Enum.ScaleType.Slice
	ImageLabel_2.SliceCenter = Rect.new(100, 100, 100, 100)
	ImageLabel_2.SliceScale = 0.050
	local Layer_3 = Instance.new("ImageLabel")
	Layer_3.Name = "Layer"
	Layer_3.Parent = Button_2
	Layer_3.AnchorPoint = Vector2.new(0.5, 0.5)
	Layer_3.BackgroundTransparency = 1.000
	Layer_3.Position = UDim2.new(0.5, 2, 0.5, 2)
	Layer_3.Size = UDim2.new(1, 0, 1, 0)
	Layer_3.Image = "rbxassetid://3570695787"
	Layer_3.ImageColor3 = Color3.fromRGB(21, 38, 63)
	Layer_3.ScaleType = Enum.ScaleType.Slice
	Layer_3.SliceCenter = Rect.new(100, 100, 100, 100)
	Layer_3.SliceScale = 0.050

	local ColorPicker = Instance.new("Frame")
	ColorPicker.Name = "ColorPicker"
	ColorPicker.Parent = Presets
	ColorPicker.BackgroundTransparency = 1.000
	ColorPicker.Size = UDim2.new(0, 112, 0, 20)
	local Button_3 = Instance.new("TextButton")
	Button_3.Name = "Button"
	Button_3.Parent = ColorPicker
	Button_3.BackgroundTransparency = 1.000
	Button_3.BorderSizePixel = 0
	Button_3.Size = UDim2.new(0, 20, 0, 20)
	Button_3.ZIndex = 3
	Button_3.Text = ""
	local ImageLabel_4 = Instance.new("ImageLabel")
	ImageLabel_4.Parent = Button_3
	ImageLabel_4.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel_4.BackgroundTransparency = 1.000
	ImageLabel_4.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel_4.Size = UDim2.new(1, 0, 1, 0)
	ImageLabel_4.ZIndex = 2
	ImageLabel_4.Image = "rbxassetid://3570695787"
	ImageLabel_4.ImageColor3 = Color3.fromRGB(255, 0, 0)
	ImageLabel_4.ScaleType = Enum.ScaleType.Slice
	ImageLabel_4.SliceCenter = Rect.new(100, 100, 100, 100)
	ImageLabel_4.SliceScale = 0.050
	local ImageLabel_5 = Instance.new("ImageLabel")
	ImageLabel_5.Parent = ImageLabel_4
	ImageLabel_5.BackgroundTransparency = 1.000
	ImageLabel_5.Position = UDim2.new(0, 4, 0, 4)
	ImageLabel_5.Size = UDim2.new(1, -8, 1, -8)
	ImageLabel_5.ZIndex = 2
	ImageLabel_5.Image = "rbxassetid://11144378537"
	local Layer_4 = Instance.new("ImageLabel")
	Layer_4.Name = "Layer"
	Layer_4.Parent = Button_3
	Layer_4.AnchorPoint = Vector2.new(0.5, 0.5)
	Layer_4.BackgroundTransparency = 1.000
	Layer_4.Position = UDim2.new(0.5, 2, 0.5, 2)
	Layer_4.Size = UDim2.new(1, 0, 1, 0)
	Layer_4.Image = "rbxassetid://3570695787"
	Layer_4.ImageColor3 = Color3.fromRGB(127, 0, 0)
	Layer_4.ScaleType = Enum.ScaleType.Slice
	Layer_4.SliceCenter = Rect.new(100, 100, 100, 100)
	Layer_4.SliceScale = 0.050
	local Text_3 = Instance.new("TextLabel")
	Text_3.Name = "Text"
	Text_3.Parent = ColorPicker
	Text_3.BackgroundTransparency = 1.000
	Text_3.Position = UDim2.new(0, 28, 0, 0)
	Text_3.Size = UDim2.new(0, 84, 1, 0)
	Text_3.Font = Enum.Font.Code
	Text_3.Text = "Color Picker"
	Text_3.TextColor3 = Color3.fromRGB(255, 255, 255)
	Text_3.TextSize = 14.000
	Text_3.TextXAlignment = Enum.TextXAlignment.Left

	local DropdownOption = Instance.new("TextButton")
	DropdownOption.Name = "DropdownOption"
	DropdownOption.Parent = Presets
	DropdownOption.BackgroundTransparency = 1.000
	DropdownOption.BorderSizePixel = 0
	DropdownOption.Size = UDim2.new(1, 0, 0, 20)
	DropdownOption.ZIndex = 3
	DropdownOption.Font = Enum.Font.Code
	DropdownOption.Text = "  Option"
	DropdownOption.TextColor3 = Color3.fromRGB(255, 255, 255)
	DropdownOption.TextSize = 14.000
	DropdownOption.TextXAlignment = Enum.TextXAlignment.Left
	local ImageLabel_6 = Instance.new("ImageLabel")
	ImageLabel_6.Parent = DropdownOption
	ImageLabel_6.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel_6.BackgroundTransparency = 1.000
	ImageLabel_6.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel_6.Size = UDim2.new(1, 0, 1, 0)
	ImageLabel_6.ZIndex = -1
	ImageLabel_6.Image = "rbxassetid://3570695787"
	ImageLabel_6.ImageColor3 = Color3.fromRGB(42, 44, 46)
	ImageLabel_6.ScaleType = Enum.ScaleType.Slice
	ImageLabel_6.SliceCenter = Rect.new(100, 100, 100, 100)
	ImageLabel_6.SliceScale = 0.050

	local DropdownWindow = Instance.new("ImageLabel")
	DropdownWindow.Name = "DropdownWindow"
	DropdownWindow.Parent = Presets
	DropdownWindow.BackgroundTransparency = 1.000
	DropdownWindow.Size = UDim2.new(0, 200, 0, 22)
	DropdownWindow.ZIndex = 4
	DropdownWindow.Image = "rbxassetid://3570695787"
	DropdownWindow.ImageColor3 = Color3.fromRGB(10, 10, 10)
	DropdownWindow.ScaleType = Enum.ScaleType.Slice
	DropdownWindow.SliceCenter = Rect.new(100, 100, 100, 100)
	DropdownWindow.SliceScale = 0.050
	local Title_3 = Instance.new("TextLabel")
	Title_3.Name = "Title"
	Title_3.Parent = DropdownWindow
	Title_3.BackgroundTransparency = 1.000
	Title_3.Position = UDim2.new(0, 30, 0, 0)
	Title_3.Size = UDim2.new(1, -30, 1, 0)
	Title_3.ZIndex = 4
	Title_3.Font = Enum.Font.Code
	Title_3.Text = "Dropdown"
	Title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title_3.TextSize = 16.000
	Title_3.TextXAlignment = Enum.TextXAlignment.Left
	local Shadow_2 = Instance.new("ImageLabel")
	Shadow_2.Name = "Shadow"
	Shadow_2.Parent = DropdownWindow
	Shadow_2.BackgroundTransparency = 1.000
	Shadow_2.Position = UDim2.new(0, 10, 0, 10)
	Shadow_2.Size = UDim2.new(1, 0, 8.727, 10)
	Shadow_2.ZIndex = -1
	Shadow_2.Image = "rbxassetid://3570695787"
	Shadow_2.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Shadow_2.ImageTransparency = 0.500
	Shadow_2.ScaleType = Enum.ScaleType.Slice
	Shadow_2.SliceCenter = Rect.new(100, 100, 100, 100)
	Shadow_2.SliceScale = 0.050
	local Layer_5 = Instance.new("ImageLabel")
	Layer_5.Name = "Layer"
	Layer_5.Parent = DropdownWindow
	Layer_5.BackgroundTransparency = 1.000
	Layer_5.Position = UDim2.new(0, 2, 0, 2)
	Layer_5.Size = UDim2.new(1, 0, 9, 2)
	Layer_5.ZIndex = -1
	Layer_5.Image = "rbxassetid://3570695787"
	Layer_5.ImageColor3 = Color3.fromRGB(10, 10, 11)
	Layer_5.ScaleType = Enum.ScaleType.Slice
	Layer_5.SliceCenter = Rect.new(100, 100, 100, 100)
	Layer_5.SliceScale = 0.050
	local Content_2 = Instance.new("ImageLabel")
	Content_2.Name = "Content"
	Content_2.Parent = DropdownWindow
	Content_2.BackgroundTransparency = 1.000
	Content_2.ClipsDescendants = true
	Content_2.Position = UDim2.new(0, 0, 1, 0)
	Content_2.Size = UDim2.new(1, 0, 0, 178)
	Content_2.Image = "rbxassetid://3570695787"
	Content_2.ImageColor3 = Color3.fromRGB(21, 22, 23)
	Content_2.ScaleType = Enum.ScaleType.Slice
	Content_2.SliceCenter = Rect.new(100, 100, 100, 100)
	Content_2.SliceScale = 0.050
	local Items_4 = Instance.new("ScrollingFrame")
	Items_4.Name = "Items"
	Items_4.Parent = Content_2
	Items_4.BackgroundColor3 = Color3.fromRGB(21, 22, 23)
	Items_4.BorderSizePixel = 0
	Items_4.Position = UDim2.new(0, 10, 0, 30)
	Items_4.Size = UDim2.new(1, -20, 1, -60)
	Items_4.ScrollBarThickness = 6
	local UIListLayout_5 = Instance.new("UIListLayout")
	UIListLayout_5.Parent = Items_4
	UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_5.Padding = UDim.new(0, 2)
	local Search = Instance.new("Frame")
	Search.Name = "Search"
	Search.Parent = Content_2
	Search.BackgroundTransparency = 1.000
	Search.Position = UDim2.new(0, 5, 0, 6)
	Search.Size = UDim2.new(1, -10, 0, 20)
	local TextBox_2 = Instance.new("TextBox")
	TextBox_2.Name = "TextBox"
	TextBox_2.Parent = Search
	TextBox_2.BackgroundTransparency = 1
	TextBox_2.Size = UDim2.new(1, 0, 1, 0)
	TextBox_2.Font = Enum.Font.SourceSans
	TextBox_2.Text = ""
	TextBox_2.PlaceholderText = "Search..."
	TextBox_2.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
	TextBox_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextBox_2.TextSize = 14.000
	TextBox_2.TextXAlignment = Enum.TextXAlignment.Left
	TextBox_2.ClearTextOnFocus = false
	local Outer_2 = Instance.new("ImageLabel")
	Outer_2.Name = "Outer"
	Outer_2.Parent = Search
	Outer_2.ZIndex = -1
	Outer_2.BackgroundTransparency = 1.000
	Outer_2.Size = UDim2.new(1, 0, 1, 0)
	Outer_2.Image = "rbxassetid://3570695787"
	Outer_2.ImageColor3 = Color3.fromRGB(32, 59, 97)
	Outer_2.ScaleType = Enum.ScaleType.Slice
	Outer_2.SliceCenter = Rect.new(100, 100, 100, 100)
	Outer_2.SliceScale = 0.050
	local Expand_3 = Instance.new("ImageButton")
	Expand_3.Name = "Expand"
	Expand_3.Parent = DropdownWindow
	Expand_3.BackgroundTransparency = 1.000
	Expand_3.Position = UDim2.new(0, 6, 0, 2)
	Expand_3.Rotation = 90.000
	Expand_3.Size = UDim2.new(0, 18, 0, 18)
	Expand_3.ZIndex = 4
	Expand_3.Image = "rbxassetid://7671465363"
	local Selected = Instance.new("TextLabel")
	Selected.Name = "Selected"
	Selected.Parent = Content_2
	Selected.BackgroundTransparency = 1.000
	Selected.Position = UDim2.new(0, 10, 1, -30)
	Selected.Size = UDim2.new(1, -10, 0, 30)
	Selected.Font = Enum.Font.Code
	Selected.Text = "Selected: [...]"
	Selected.TextColor3 = Color3.fromRGB(178, 178, 178)
	Selected.TextSize = 12.000
	Selected.TextXAlignment = Enum.TextXAlignment.Left

	local ColorPickerWindow = Instance.new("ImageLabel")
	ColorPickerWindow.Name = "ColorPickerWindow"
	ColorPickerWindow.Parent = Presets
	ColorPickerWindow.BackgroundTransparency = 1.000
	ColorPickerWindow.Size = UDim2.new(0, 200, 0, 22)
	ColorPickerWindow.ZIndex = 4
	ColorPickerWindow.Image = "rbxassetid://3570695787"
	ColorPickerWindow.ImageColor3 = Color3.fromRGB(10, 10, 10)
	ColorPickerWindow.ScaleType = Enum.ScaleType.Slice
	ColorPickerWindow.SliceCenter = Rect.new(100, 100, 100, 100)
	ColorPickerWindow.SliceScale = 0.050
	local Title_4 = Instance.new("TextLabel")
	Title_4.Name = "Title"
	Title_4.Parent = ColorPickerWindow
	Title_4.BackgroundTransparency = 1.000
	Title_4.Position = UDim2.new(0, 30, 0, 0)
	Title_4.Size = UDim2.new(1, -30, 1, 0)
	Title_4.ZIndex = 4
	Title_4.Font = Enum.Font.Code
	Title_4.Text = "Color Picker"
	Title_4.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title_4.TextSize = 16.000
	Title_4.TextXAlignment = Enum.TextXAlignment.Left
	local Shadow_3 = Instance.new("ImageLabel")
	Shadow_3.Name = "Shadow"
	Shadow_3.Parent = ColorPickerWindow
	Shadow_3.BackgroundTransparency = 1.000
	Shadow_3.Position = UDim2.new(0, 10, 0, 10)
	Shadow_3.Size = UDim2.new(1, 0, 8.727, 10)
	Shadow_3.ZIndex = -1
	Shadow_3.Image = "rbxassetid://3570695787"
	Shadow_3.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Shadow_3.ImageTransparency = 0.500
	Shadow_3.ScaleType = Enum.ScaleType.Slice
	Shadow_3.SliceCenter = Rect.new(100, 100, 100, 100)
	Shadow_3.SliceScale = 0.050
	local Layer_6 = Instance.new("ImageLabel")
	Layer_6.Name = "Layer"
	Layer_6.Parent = ColorPickerWindow
	Layer_6.BackgroundTransparency = 1.000
	Layer_6.Position = UDim2.new(0, 2, 0, 2)
	Layer_6.Size = UDim2.new(1, 0, 9, 2)
	Layer_6.ZIndex = -1
	Layer_6.Image = "rbxassetid://3570695787"
	Layer_6.ImageColor3 = Color3.fromRGB(10, 10, 11)
	Layer_6.ScaleType = Enum.ScaleType.Slice
	Layer_6.SliceCenter = Rect.new(100, 100, 100, 100)
	Layer_6.SliceScale = 0.050
	local Expand_4 = Instance.new("ImageButton")
	Expand_4.Name = "Expand"
	Expand_4.Parent = ColorPickerWindow
	Expand_4.BackgroundTransparency = 1.000
	Expand_4.Position = UDim2.new(0, 6, 0, 2)
	Expand_4.Rotation = 90.000
	Expand_4.Size = UDim2.new(0, 18, 0, 18)
	Expand_4.ZIndex = 4
	Expand_4.Image = "rbxassetid://7671465363"
	local Content_3 = Instance.new("ImageLabel")
	Content_3.Name = "Content"
	Content_3.Parent = ColorPickerWindow
	Content_3.BackgroundTransparency = 1.000
	Content_3.ClipsDescendants = true
	Content_3.Position = UDim2.new(0, 0, 1, 0)
	Content_3.Size = UDim2.new(1, 0, 0, 178)
	Content_3.Image = "rbxassetid://3570695787"
	Content_3.ImageColor3 = Color3.fromRGB(21, 22, 23)
	Content_3.ScaleType = Enum.ScaleType.Slice
	Content_3.SliceCenter = Rect.new(100, 100, 100, 100)
	Content_3.SliceScale = 0.050
	local Palette = Instance.new("ImageLabel")
	Palette.Name = "Palette"
	Palette.Parent = Content_3
	Palette.BackgroundTransparency = 1.000
	Palette.Position = UDim2.new(0, 10, 0, 10)
	Palette.Size = UDim2.new(1, -45, 1, -45)
	Palette.Image = "rbxassetid://698052001"
	local Indicator = Instance.new("ImageLabel")
	Indicator.Name = "Indicator"
	Indicator.Parent = Palette
	Indicator.BackgroundTransparency = 1.000
	Indicator.Size = UDim2.new(0, 5, 0, 5)
	Indicator.Image = "rbxassetid://2851926732"
	local Saturation = Instance.new("ImageLabel")
	Saturation.Name = "Saturation"
	Saturation.Parent = Content_3
	Saturation.BackgroundTransparency = 1.000
	Saturation.Position = UDim2.new(1, -25, 0, 10)
	Saturation.Size = UDim2.new(0, 15, 1, -45)
	Saturation.Image = "rbxassetid://3641079629"
	local Indicator_2 = Instance.new("Frame")
	Indicator_2.Name = "Indicator"
	Indicator_2.Parent = Saturation
	Indicator_2.BackgroundColor3 = Color3.fromRGB(49, 88, 146)
	Indicator_2.BorderSizePixel = 0
	Indicator_2.Size = UDim2.new(1, 0, 0, 2)
	local FinalColor = Instance.new("ImageLabel")
	FinalColor.Name = "FinalColor"
	FinalColor.Parent = Content_3
	FinalColor.BackgroundTransparency = 1.000
	FinalColor.Position = UDim2.new(1, -25, 1, -25)
	FinalColor.Size = UDim2.new(0, 15, 0, 15)
	FinalColor.Image = "rbxassetid://3570695787"
	FinalColor.ScaleType = Enum.ScaleType.Slice
	FinalColor.SliceCenter = Rect.new(100, 100, 100, 100)
	FinalColor.SliceScale = 0.800
	local SaturationColor = Instance.new("ImageLabel")
	SaturationColor.Name = "SaturationColor"
	SaturationColor.Parent = Content_3
	SaturationColor.BackgroundTransparency = 1.000
	SaturationColor.Position = UDim2.new(1, -50, 1, -25)
	SaturationColor.Size = UDim2.new(0, 15, 0, 15)
	SaturationColor.Image = "rbxassetid://3570695787"
	SaturationColor.ScaleType = Enum.ScaleType.Slice
	SaturationColor.SliceCenter = Rect.new(100, 100, 100, 100)
	SaturationColor.SliceScale = 0.800
	local PaletteColor = Instance.new("ImageLabel")
	PaletteColor.Name = "PaletteColor"
	PaletteColor.Parent = Content_3
	PaletteColor.BackgroundTransparency = 1.000
	PaletteColor.Position = UDim2.new(1, -75, 1, -25)
	PaletteColor.Size = UDim2.new(0, 15, 0, 15)
	PaletteColor.Image = "rbxassetid://3570695787"
	PaletteColor.ScaleType = Enum.ScaleType.Slice
	PaletteColor.SliceCenter = Rect.new(100, 100, 100, 100)
	PaletteColor.SliceScale = 0.800

	local Dropdown = Instance.new("Frame")
	Dropdown.Name = "Dropdown"
	Dropdown.Parent = Presets
	Dropdown.BackgroundTransparency = 1.000
	Dropdown.Size = UDim2.new(0, 150, 0, 20)
	local Outer_3 = Instance.new("ImageLabel")
	Outer_3.Name = "Outer"
	Outer_3.Parent = Dropdown
	Outer_3.BackgroundTransparency = 1.000
	Outer_3.Size = UDim2.new(1, 0, 1, 0)
	Outer_3.Image = "rbxassetid://3570695787"
	Outer_3.ImageColor3 = Color3.fromRGB(59, 59, 68)
	Outer_3.ScaleType = Enum.ScaleType.Slice
	Outer_3.SliceCenter = Rect.new(100, 100, 100, 100)
	Outer_3.SliceScale = 0.050
	local Inner_3 = Instance.new("ImageButton")
	Inner_3.Name = "Inner"
	Inner_3.Parent = Outer_3
	Inner_3.BackgroundTransparency = 1.000
	Inner_3.Position = UDim2.new(0, 2, 0, 2)
	Inner_3.Size = UDim2.new(1, -4, 1, -4)
	Inner_3.Image = "rbxassetid://3570695787"
	Inner_3.ImageColor3 = Color3.fromRGB(32, 59, 97)
	Inner_3.ScaleType = Enum.ScaleType.Slice
	Inner_3.SliceCenter = Rect.new(100, 100, 100, 100)
	Inner_3.SliceScale = 0.050
	local Value_2 = Instance.new("TextLabel")
	Value_2.Name = "Value"
	Value_2.Parent = Inner_3
	Value_2.BackgroundTransparency = 1.000
	Value_2.Position = UDim2.new(0, 10, 0, 0)
	Value_2.Size = UDim2.new(1, -10, 1, 0)
	Value_2.Font = Enum.Font.Code
	Value_2.Text = "Selected"
	Value_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	Value_2.TextSize = 14.000
	Value_2.TextXAlignment = Enum.TextXAlignment.Left
	local Text_4 = Instance.new("TextLabel")
	Text_4.Name = "Text"
	Text_4.Parent = Dropdown
	Text_4.BackgroundTransparency = 1.000
	Text_4.Position = UDim2.new(0, 158, 0, 0)
	Text_4.Size = UDim2.new(0, 56, 1, 0)
	Text_4.Font = Enum.Font.Code
	Text_4.Text = "Dropdown"
	Text_4.TextColor3 = Color3.fromRGB(255, 255, 255)
	Text_4.TextSize = 14.000
	Text_4.TextXAlignment = Enum.TextXAlignment.Left

	-- [[ ADDED PRESET FOR RESIZER ]]
	local Resizer = Instance.new("ImageButton")
	Resizer.Name = "Resizer"
	Resizer.Parent = Presets
	Resizer.Active = true
	Resizer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Resizer.BackgroundTransparency = 1
	Resizer.AnchorPoint = Vector2.new(1, 1)
	Resizer.Position = UDim2.new(1, 5, 1, 5) -- Small offset so it doesn't overlap window border
	Resizer.Size = UDim2.new(0, 12, 0, 12)
	Resizer.ZIndex = 100
	Resizer.Image = "rbxassetid://5943232811"
	Resizer.ImageColor3 = Color3.fromRGB(150, 150, 150)
	Resizer.ImageTransparency = 0.3

	-- [[ ADDED PRESET FOR TEXTBOX ]]
	local TextBoxContainer = Instance.new("Frame")
	TextBoxContainer.Name = "TextBox"
	TextBoxContainer.Parent = Presets
	TextBoxContainer.BackgroundTransparency = 1.000
	TextBoxContainer.Size = UDim2.new(0, 200, 0, 150)
	local TextBoxOuter = Instance.new("ImageLabel")
	TextBoxOuter.Name = "Outer"
	TextBoxOuter.Parent = TextBoxContainer
	TextBoxOuter.BackgroundTransparency = 1.000
	TextBoxOuter.Size = UDim2.new(1, 0, 1, 0)
	TextBoxOuter.Image = "rbxassetid://3570695787"
	TextBoxOuter.ImageColor3 = Color3.fromRGB(59, 59, 68)
	TextBoxOuter.ScaleType = Enum.ScaleType.Slice
	TextBoxOuter.SliceCenter = Rect.new(100, 100, 100, 100)
	TextBoxOuter.SliceScale = 0.050
	local TextBoxInner = Instance.new("ScrollingFrame")
	TextBoxInner.Name = "Inner"
	TextBoxInner.Parent = TextBoxOuter
	TextBoxInner.BackgroundTransparency = 1.000
	TextBoxInner.Position = UDim2.new(0, 2, 0, 2)
	TextBoxInner.Size = UDim2.new(1, -4, 1, -4)
	TextBoxInner.BackgroundColor3 = Color3.fromRGB(32, 59, 97)
	TextBoxInner.Image = "rbxassetid://3570695787"
	TextBoxInner.ImageColor3 = Color3.fromRGB(32, 59, 97)
	TextBoxInner.ScaleType = Enum.ScaleType.Slice
	TextBoxInner.SliceCenter = Rect.new(100, 100, 100, 100)
	TextBoxInner.SliceScale = 0.050
	TextBoxInner.BorderSizePixel = 0
	TextBoxInner.ScrollBarThickness = 6
	local UIPadding = Instance.new("UIPadding")
	UIPadding.Parent = TextBoxInner
	UIPadding.PaddingLeft = UDim.new(0, 5)
	UIPadding.PaddingRight = UDim.new(0, 5)
	UIPadding.PaddingTop = UDim.new(0, 3)
	UIPadding.PaddingBottom = UDim.new(0, 3)
	local ActualTextBox = Instance.new("TextBox")
	ActualTextBox.Name = "ActualTextBox"
	ActualTextBox.Parent = TextBoxInner
	ActualTextBox.BackgroundTransparency = 1
	ActualTextBox.Size = UDim2.new(1, -10, 1, -6) -- Account for padding
	ActualTextBox.Font = Enum.Font.Code
	ActualTextBox.Text = ""
	ActualTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	ActualTextBox.TextTransparency = 1 -- Hide the actual text, only cursor shows
	ActualTextBox.TextSize = 14.000
	ActualTextBox.TextXAlignment = Enum.TextXAlignment.Left
	ActualTextBox.TextYAlignment = Enum.TextYAlignment.Top
	ActualTextBox.MultiLine = true
	ActualTextBox.ClearTextOnFocus = false
	ActualTextBox.ZIndex = 4
	local SyntaxLabel = Instance.new("TextLabel")
	SyntaxLabel.Name = "SyntaxLabel"
	SyntaxLabel.Parent = TextBoxInner
	SyntaxLabel.BackgroundTransparency = 1
	SyntaxLabel.Size = UDim2.new(1, -10, 1, -6) -- Match the TextBox size
	SyntaxLabel.Font = Enum.Font.Code
	SyntaxLabel.Text = ""
	SyntaxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	SyntaxLabel.TextSize = 14.000
	SyntaxLabel.TextXAlignment = Enum.TextXAlignment.Left
	SyntaxLabel.TextYAlignment = Enum.TextYAlignment.Top
	SyntaxLabel.RichText = true
	SyntaxLabel.ZIndex = 3
end

-- Global state variables
local isSliding = false
local isColorPicking = false
local isResizing = false
local isDragging = false

-- Event creation utility
local event = {}
function event.new()
	local self = {}
	local bindable = Instance.new("BindableEvent")

	function self:Connect(callback)
		return bindable.Event:Connect(callback)
	end

	function self:Fire(...)
		bindable:Fire(...)
	end

	function self:Destroy()
		bindable:Destroy()
	end

	return self
end

-- Mouse input handler
local mouse = {
	held = false,
	InputBegan = event.new(),
	InputEnded = event.new(),
}
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		mouse.held = true
		mouse.InputBegan:Fire()
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		mouse.held = false
		mouse.InputEnded:Fire()
	end
end)

-- Correctly gets mouse position accounting for Roblox's CoreGui inset
local function getMouseLocation()
	return UserInputService:GetMouseLocation() - GuiService:GetGuiInset().Position
end

-- Centralized tweening function
local function createTween(object, propertyTable, duration)
	duration = duration or 0.1
	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	return TweenService:Create(object, tweenInfo, propertyTable)
end

-- Window management (ZIndex, focus, etc.)
local windowHistory = {}
local windowCache = {}
local mouseCache = {}
local browsingWindow = {}

local function updateWindowHistory()
	for window, order in pairs(windowHistory) do
		local zIndexOffset = 9000 - (order * 100)
		pcall(function()
			window.ZIndex = (windowCache[window] and windowCache[window][window] or 1) + zIndexOffset
			for descendant, originalZIndex in pairs(windowCache[window] or {}) do
				if descendant ~= window and descendant.Parent then
					descendant.ZIndex = originalZIndex + zIndexOffset
				end
			end
		end)
	end
end

local function cacheWindowHistory(window)
	if windowCache[window] then return end
	windowCache[window] = {}

	local function cacheDescendant(descendant)
		if descendant:IsA("GuiObject") then
			windowCache[window][descendant] = descendant.ZIndex
		end
	end

	cacheDescendant(window)
	for _, child in ipairs(window:GetDescendants()) do
		cacheDescendant(child)
	end

	window.DescendantAdded:Connect(function(descendant)
		cacheDescendant(descendant)
		updateWindowHistory()
	end)
end


local function setTopMost(window)
	if not window then return end
	local oldOrder = windowHistory[window]
	if oldOrder == 1 then return end -- Already at the top.

	for w, order in pairs(windowHistory) do
		if w == window then
			windowHistory[w] = 1
		elseif order < oldOrder then
			windowHistory[w] = order + 1
		end
	end
	updateWindowHistory()
end


local function isTopMost(window)
	return windowHistory[window] == 1
end

local function isBrowsing(window)
	return browsingWindow[window] or mouseCache[window]
end

local function findBrowsingTopMost()
	local topWindow, minOrder = nil, math.huge
	for window, order in pairs(windowHistory) do
		if isBrowsing(window) and order < minOrder then
			minOrder = order
			topWindow = window
		end
	end
	return topWindow
end


-- UTILITY FUNCTIONS
local function new(n)
	return Presets:FindFirstChild(n):Clone()
end
local function tint(c)
	return Color3.new(c.R * 0.7, c.G * 0.7, c.B * 0.7)
end
local function bleach(c)
	return Color3.new(math.min(1, c.R * 1.2), math.min(1, c.G * 1.2), math.min(1, c.B * 1.2))
end

-- A centralized input handler to replace 'while mouse.held' loops
local currentInputConnection = nil
local function manageInputLoop(action)
    if currentInputConnection then
        currentInputConnection:Disconnect()
        currentInputConnection = nil
    end
    if action then
        currentInputConnection = RunService.RenderStepped:Connect(action)
    end
end

-- On mouse release, stop any ongoing input actions.
mouse.InputEnded:Connect(function()
    manageInputLoop(nil)
	isDragging = false
    isResizing = false
    isSliding = false
    isColorPicking = false
	-- Allow the mouse icon to be re-enabled if it was hidden
	UserInputService.MouseIconEnabled = true
end)

-- Main Dragger logic
local dragger = {}
function dragger.new(frame, dragHandle)
	dragHandle = dragHandle or frame
	dragHandle.Active = true

	local dragStartFramePosition
	local dragStartMousePosition

	dragHandle.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
		if not isTopMost(frame) or isResizing or isSliding then return end

		isDragging = true
		dragStartMousePosition = getMouseLocation()
		dragStartFramePosition = frame.Position

		manageInputLoop(function()
			if not isDragging then return end
			local mouseDelta = getMouseLocation() - dragStartMousePosition
			local newPosition = UDim2.new(
				dragStartFramePosition.X.Scale,
				dragStartFramePosition.X.Offset + mouseDelta.X,
				dragStartFramePosition.Y.Scale,
				dragStartFramePosition.Y.Offset + mouseDelta.Y
			)
			frame.Position = newPosition
		end)
	end)
end

-- New Resizer Logic
local resizer = {}
function resizer.new(window, content, handle, onResizeCallback)
    handle.Active = true
	local minSize = Vector2.new(250, 200) -- Min Width, Min Height for content

	handle.MouseEnter:Connect(function() UserInputService.MouseIconEnabled = false end)
    handle.MouseLeave:Connect(function()
		if not isResizing then
			UserInputService.MouseIconEnabled = true
		end
	end)

	handle.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
		if not isTopMost(window) or isDragging then return end

		isResizing = true
		local startMousePos = getMouseLocation()
		local startWindowSize = window.AbsoluteSize
		local startContentSize = content.AbsoluteSize

		manageInputLoop(function()
			if not isResizing then return end
			local mouseDelta = getMouseLocation() - startMousePos
			
			local newContentWidth = math.max(minSize.X, startContentSize.X + mouseDelta.X)
			local newContentHeight = math.max(minSize.Y, startContentSize.Y + mouseDelta.Y)

			window.Size = UDim2.fromOffset(newContentWidth, window.Size.Y.Offset)
			content.Size = UDim2.fromOffset(newContentWidth, newContentHeight)

			if onResizeCallback then
				onResizeCallback(window.Size.Y.Offset + content.AbsoluteSize.Y)
			end
		end)
	end)
end

local settings = {
    new = function(default)
        local function l(r)
            return tostring(r):lower()
        end
        return { handle = function(options)
            local self = {}
            options = typeof(options) == "table" and options or {}
            for i, v in next, default do
                self[l(i)] = v
            end
            for i, v in next, options do
                if typeof(default[l(i)]) == typeof(options[l(i)]) then
                    self[l(i)] = v
                end
            end
            return self
        end }
    end,
}

local library = {
	new = function(options)
		local cache = {}
		local self = {
			isopen = true,
		}

		options = settings.new({
			text = "New Window",
			size = Vector2.new(300, 200),
			shadow = 10,
			transparency = 0.2,
			color = Color3.fromRGB(41, 74, 122),
			boardcolor = Color3.fromRGB(21, 22, 23),
			rounding = 5,
			animation = 0.1,
			position = UDim2.new(0, 100, 0, 100),
			resizable = false, -- New resizable option
		}).handle(options)

		local main = new("Main") main.Parent = imgui2
		local content = main:FindFirstChild("Content")
		local tabs = main:FindFirstChild("Tabs")
		local shadow = main:FindFirstChild("Shadow")
		local layer = main:FindFirstChild("Layer")
		local expand = main:FindFirstChild("Expand")

		main.Position = options.position
		content.ImageTransparency = options.transparency
		layer.ImageTransparency = options.transparency
		shadow.ImageTransparency = 0.6 * (options.transparency + 1)

		expand.MouseButton1Click:Connect(function()
			if self.isopen then
				self.close()
			else
				self.open()
			end
		end)

		dragger.new(main)
		main:FindFirstChild("Title").Text = options.text
		main.ImageColor3 = options.color
		main:FindFirstChild("Frame").BackgroundColor3 = options.color
		main.Size = UDim2.fromOffset(options.size.X, main.Size.Y.Offset)
		main.SliceScale = options.rounding / 100

		content.ImageColor3 = options.boardcolor
		content.Size = UDim2.fromOffset(options.size.X, options.size.Y)
		content.SliceScale = options.rounding / 100

		function cache.update_layers(totalHeight)
			shadow.Position = UDim2.new(0, options.shadow, 0, options.shadow)
			shadow.Size = UDim2.fromOffset(main.AbsoluteSize.X, totalHeight)
			shadow.SliceScale = options.rounding / 100

			layer.Position = UDim2.fromOffset(2, 2)
			layer.Size = UDim2.fromOffset(main.AbsoluteSize.X, totalHeight)
			layer.SliceScale = options.rounding / 100
		end

		local function updateLayersFromSize()
			local totalHeight = main.Size.Y.Offset + content.Size.Y.Offset
			cache.update_layers(totalHeight)
		end
		
		updateLayersFromSize() -- Initial update

		main:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateLayersFromSize)
		content:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateLayersFromSize)

		-- [[ ADD RESIZER IF ENABLED ]]
		if options.resizable then
			local resizeHandle = new("Resizer")
			resizeHandle.Parent = main
			-- Position the handle inside the content so it scales correctly
			resizeHandle.Parent = content
			resizer.new(main, content, resizeHandle, cache.update_layers)
		end

		function self.new(tabOptions)
			local tabSelf = {}
			tabOptions = settings.new({
				text = "New Tab",
			}).handle(tabOptions)

			local tabbutton = new("TabButton")
			local tabbuttons = tabs:FindFirstChild("Items")
			tabbutton.Parent = tabbuttons
			tabbutton.Text = tabOptions.text
			tabbutton.Size = UDim2.new(0, tabbutton.TextBounds.X, 1, 0)
			tabbutton.TextColor3 = Color3.new(0.4, 0.4, 0.4)
			tabbutton.MouseButton1Click:Connect(function()
				tabSelf.show()
			end)

			local tab = new("Tab")
			tab.Parent = content
			local items = tab:FindFirstChild("Items")
			tab.Visible = false

			local function countSize(o, horizontal)
				local listLayout = o:FindFirstChildOfClass("UIListLayout")
				if not listLayout then return Vector2.zero end

				local padding = listLayout.Padding.Offset
				local totalX, totalY = 0, 0
				local maxX = 0
				
				for _, v in ipairs(o:GetChildren()) do
					if not v:IsA("UIListLayout") then
						if horizontal then
							totalX = totalX + v.AbsoluteSize.X + padding
							if v.AbsoluteSize.Y > totalY then
								totalY = v.AbsoluteSize.Y
							end
						else
							totalY = totalY + v.AbsoluteSize.Y + padding
							if v.AbsoluteSize.X > maxX then
								maxX = v.AbsoluteSize.X
							end
						end
					end
				end

				return horizontal and Vector2.new(totalX, totalY) or Vector2.new(maxX, totalY)
			end


			local function updateCanvas()
				task.wait() -- Wait a frame for UIListLayout to update
				local newSize = countSize(items)
				if newSize then
					items.CanvasSize = UDim2.fromOffset(0, newSize.Y)
				end
			end


			items.ScrollBarImageColor3 = Color3.new()
			items.ChildAdded:Connect(updateCanvas)
			items.ChildRemoved:Connect(updateCanvas)

			local types = {}
			function types.label(labelOptions)
				local self = {}
				labelOptions = settings.new({
					text = "New Label",
					color = Color3.new(1, 1, 1),
				}).handle(labelOptions)
				
				local label = new("Label")
				label.Parent = items
				label.Text = labelOptions.text
				label.Size = UDim2.new(1, 0, 0, label.TextBounds.Y)
				label.TextColor3 = labelOptions.color
				
				function self.setText(text)
					label.Text = text
				end
				
				function self.setColor(color)
					label.TextColor3 = color
				end
				
				function self:Destroy() label:Destroy() end
				self.self = label
				return self
			end

			function types.button(buttonOptions)
				local self = { event = event.new() }
				self.eventBlock = false
				
				buttonOptions = settings.new({
					text = "New Button",
					color = options.color,
					rounding = options.rounding,
				}).handle(buttonOptions)
				
				local button = new("Button")
				button.Parent = items
				button.Text = buttonOptions.text
				button.Size = UDim2.new(0, button.TextBounds.X + 20, 0, 20)
				button.MouseButton1Click:Connect(function()
					if not self.eventBlock then
						self.event:Fire()
					end
				end)
				
				local ImageLabel = button:FindFirstChild("ImageLabel")
				local Layer = button:FindFirstChild("Layer")
				ImageLabel.ImageColor3 = buttonOptions.color
				Layer.ImageColor3 = tint(buttonOptions.color)
				ImageLabel.SliceScale = buttonOptions.rounding / 100
				Layer.SliceScale = buttonOptions.rounding / 100
				
				local originalColor = ImageLabel.ImageColor3
				button.MouseEnter:Connect(function() ImageLabel.ImageColor3 = bleach(originalColor) end)
				button.MouseLeave:Connect(function() ImageLabel.ImageColor3 = originalColor end)

				function self.setColor(color) ImageLabel.ImageColor3 = color Layer.ImageColor3 = tint(color) end
				function self.getColor() return ImageLabel.ImageColor3 end
				function self:Destroy() button:Destroy() end
				
				self.self = button
				return self
			end
			
			function types.switch(switchOptions)
				local self = { event = event.new() }
				
				switchOptions = settings.new({
					text = "New Switch", on = false, color = options.color,
					rounding = options.rounding, animation = options.animation,
				}).handle(switchOptions)

				self.on = switchOptions.on
				self.eventBlock = false

				local switch = new("Switch")
				switch.Parent = items
				local button = switch:FindFirstChild("Button")
				local text = switch:FindFirstChild("Text")
				local check = button:FindFirstChild("Check")
				local ImageLabel = button:FindFirstChild("ImageLabel")
				local layer = button:FindFirstChild("Layer")
				
				ImageLabel.ImageColor3 = switchOptions.color
				layer.ImageColor3 = tint(switchOptions.color)
				ImageLabel.SliceScale = switchOptions.rounding / 100
				layer.SliceScale = switchOptions.rounding / 100

				text:GetPropertyChangedSignal("Text"):Connect(function()
					switch.Size = UDim2.new(0, 28 + text.TextBounds.X, 0, 20)
				end)

				text.Text = switchOptions.text
				check.ImageTransparency = self.on and 0 or 1

				button.MouseButton1Click:Connect(function()
					self.set(not self.on)
				end)
				
				function self.set(boolean)
					local state = not not boolean
					if state == self.on then return end
					self.on = state
					createTween(check, { ImageTransparency = self.on and 0 or 1 }, switchOptions.animation):Play()
					if not self.eventBlock then
						self.event:Fire(self.on)
					end
				end
				
				function self.setColor(color) ImageLabel.ImageColor3 = color layer.ImageColor3 = tint(color) end
				function self.getColor() return ImageLabel.ImageColor3 end
				function self:Destroy() switch:Destroy() end

				self.self = switch
				return self
			end

			function types.slider(sliderOptions)
				local self = { event = event.new() }
				
				sliderOptions = settings.new({
					text = "New Slider", size = 150, min = 0, max = 100, value = 0,
					color = options.color, barcolor = bleach(options.color),
					rounding = options.rounding, animation = options.animation,
				}).handle(sliderOptions)
				
				self.value = sliderOptions.value
				self.eventBlock = false
				
				local function round(x)
					return string.format("%.2f", x)
				end
				
				local slider = new("Slider")
				slider.Parent = items

				local text = slider:FindFirstChild("Text")
				local outer = slider:FindFirstChild("Outer")
				local inner = outer:FindFirstChild("Inner")
				local bar = inner:FindFirstChild("Slider")
				local valueLabel = inner:FindFirstChild("Value")
				inner.ClipsDescendants = true

				outer.SliceScale = sliderOptions.rounding / 100
				inner.SliceScale = sliderOptions.rounding / 100
				inner.ImageColor3 = sliderOptions.color
				bar.BackgroundColor3 = sliderOptions.barcolor
				
				function self.setColor(color) inner.ImageColor3 = color bar.BackgroundColor3 = bleach(color) end
				function self.getColor() return inner.ImageColor3 end

				text.Text = sliderOptions.text
				outer.Size = UDim2.fromOffset(sliderOptions.size, 20)
				text.Position = UDim2.new(0, sliderOptions.size + 8, 0, 0)
				slider.Size = UDim2.new(0, sliderOptions.size + 8 + text.TextBounds.X, 0, 20)
				
				local oldVal = self.value

				function self.set(n, fromInput)
					local min, max = sliderOptions.min, sliderOptions.max
					n = math.clamp(n, math.min(min,max), math.max(min,max))
					
					if n == self.value and not fromInput then return end
					
					self.value = n
					valueLabel.Text = round(self.value)

					local range = max - min
					if range ~= 0 then
						local percentage = (n - min) / range
						createTween(bar, { Size = UDim2.new(percentage, 0, 1, 0) }, fromInput and 0 or sliderOptions.animation):Play()
					end

					if self.value ~= oldVal then
						if not self.eventBlock then
							self.event:Fire(self.value)
						end
						oldVal = self.value
					end
				end

				self.set(self.value) -- Initialize
				
				inner.InputBegan:Connect(function(input)
					if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
					if not isTopMost(main) or isResizing or isDragging then return end

					isSliding = true
					manageInputLoop(function()
						if not isSliding then return end
						local mouseX = getMouseLocation().X
						local startX = inner.AbsolutePosition.X
						local width = inner.AbsoluteSize.X
						local percentage = math.clamp((mouseX - startX) / width, 0, 1)

						local range = sliderOptions.max - sliderOptions.min
						local newValue = sliderOptions.min + (range * percentage)
						self.set(newValue, true)
					end)
				end)

				function self:Destroy() slider:Destroy() end

				self.self = slider
				return self
			end
			
			function types.textbox(textboxOptions)
				local self = {}
				
				textboxOptions = settings.new({
					text = "", size = Vector2.new(250, 150), syntax = false,
					color = options.color, rounding = options.rounding
				}).handle(textboxOptions)
				
				local textbox = new("TextBox")
				textbox.Parent = items
				textbox.Size = UDim2.fromOffset(textboxOptions.size.X, textboxOptions.size.Y)
				
				local outer = textbox:FindFirstChild("Outer")
				local inner = outer:FindFirstChild("Inner")
				local syntaxLabel = inner:FindFirstChild("SyntaxLabel")
				local actualTextBox = inner:FindFirstChild("ActualTextBox")
				
				outer.SliceScale = textboxOptions.rounding / 100
				inner.ImageColor3 = textboxOptions.color
				actualTextBox.Text = textboxOptions.text

				function self.setText(text)
					actualTextBox.Text = text
					actualTextBox:ReleaseFocus()
				end

				function self.getText() return actualTextBox.Text end
				
				if textboxOptions.syntax then
					local syntaxPatterns = {
						["(and|break|do|else|elseif|end|false|for|function|if|in|local|nil|not|or|repeat|return|then|true|until|while)"] = '<font color="#C586C0">%1</font>',
						["(self|game|workspace|script|wait|print|error|Vector3|Vector2|UDim2|Color3|Instance|Enum|typeof|pcall|task)"] = '<font color="#4FC1FF">%1</font>',
						["([%d%.]+)"] = '<font color="#B5CEA8">%1</font>',
						['(".-")'] = '<font color="#CE9178">%1</font>',
						["('.-')"] = "<font color='#CE9178'>%1</font>",
						["(--.-)\n"] = "<font color='#6A9955'>%1</font>\n",
						["(--%[%[.-%]%])"] = "<font color='#6A9955'>%1</font>"
					}
					
					local function highlight(text)
						text = text:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
						for pattern, replacement in pairs(syntaxPatterns) do
							text = text:gsub(pattern, replacement)
						end
						return text
					end
					
					syntaxLabel.Visible = true

					local function updateHighlight()
						syntaxLabel.Text = highlight(actualTextBox.Text)
						local bounds = syntaxLabel.TextBounds
						local newSize = UDim2.fromOffset(math.max(textboxOptions.size.X - 20, bounds.X), math.max(textboxOptions.size.Y - 10, bounds.Y))
						syntaxLabel.Size = newSize
						actualTextBox.Size = newSize
						inner.CanvasSize = UDim2.fromOffset(newSize.X.Offset, newSize.Y.Offset)
					end

					actualTextBox.Changed:Connect(function(prop)
						if prop == "Text" then
							syntaxLabel.Text = highlight(actualTextBox.Text)
						end
					end)
					actualTextBox.FocusLost:Connect(updateHighlight)
					updateHighlight() -- initial highlight

				else
					syntaxLabel.Visible = false
					actualTextBox.TextTransparency = 0 -- Make normal textbox text visible
				end
				
				function self:Destroy() textbox:Destroy() end
				self.self = textbox
				return self
			end

			function types.folder(folderOptions)
				local self = { event = event.new() }
				
				folderOptions = settings.new({
					text = "New Folder", isopen = false, color = options.color,
					rounding = options.rounding, animation = options.animation,
				}).handle(folderOptions)
				
				self.isopen = false
				local folderItems = {}

				local folder = new("Folder")
				folder.Parent = items
				
				local header = folder:FindFirstChild("Folder")
				local itemContainer = folder:FindFirstChild("Items")
				header.SliceScale = folderOptions.rounding / 100
				header.ImageColor3 = folderOptions.color

				local title = header:FindFirstChild("Title")
				local expand = header:FindFirstChild("Expand")
				title.Text = folderOptions.text
				
				local function updateFolderSize()
					task.wait() -- Allow UIListLayout to update
					local height = 25
					if self.isopen then
						local contentSize = countSize(itemContainer)
						height += contentSize.Y
					end
					createTween(folder, {Size = UDim2.new(1, 0, 0, height-5)}, folderOptions.animation):Play()
					updateCanvas()
				end

				function self.close()
					self.isopen = false
					createTween(expand, {Rotation = 0}, folderOptions.animation):Play()
					updateFolderSize()
				end

				function self.open()
					self.isopen = true
					createTween(expand, {Rotation = 90}, folderOptions.animation):Play()
					updateFolderSize()
				end
				
				header.MouseButton1Click:Connect(function() if self.isopen then self.close() else self.open() end end)
				
				function self.new(type, typeOptions)
					type = type:lower()
					local constructor = types[type]
					assert(constructor, "Invalid element type: " .. type)
					
					local element = constructor(typeOptions)
					element.self.Parent = itemContainer
					table.insert(folderItems, element)

					if element.self:FindFirstChildOfClass("UIListLayout") then
						element.self.ChildAdded:Connect(updateFolderSize)
						element.self.ChildRemoved:Connect(updateFolderSize)
					end

					updateFolderSize()
					return element
				end

				function self:Destroy() folder:Destroy() end
				
				if folderOptions.isopen then self.open() else self.close() end
				self.self = folder
				return self
			end

			-- Assign types to tab self table.
			for typeName, constructor in pairs(types) do
				tabSelf[typeName] = constructor
			end

			function tabSelf.new(type, opts)
				local constructor = tabSelf[type:lower()]
				assert(constructor, "Invalid element type: "..tostring(type))
				local obj = constructor(opts)

				if obj.type == "folder" then
					obj.updated:Connect(updateCanvas)
				end
				
				-- Metatable to redirect event connections like :Connect() to the event object
				return setmetatable(obj, {
					__index = function(t, k)
						return rawget(t, k) or rawget(t, "event")[k]
					end,
				})
			end

			function tabSelf.show()
				for _, child in ipairs(tabbuttons:GetChildren()) do
					if child:IsA("TextButton") then
						createTween(child, {TextColor3 = Color3.new(0.4, 0.4, 0.4)}, options.animation):Play()
					end
				end
				for _, child in ipairs(content:GetChildren()) do
					if child.Name == "Tab" then
						child.Visible = false
					end
				end
				createTween(tabbutton, {TextColor3 = Color3.new(1, 1, 1)}, options.animation):Play()
				tab.Visible = true
			end

			tabSelf.show()
			return tabSelf
		end

		function self.close()
			if not self.isopen then return end
			self.isopen = false

			createTween(expand, {Rotation = 0}, options.animation):Play()
			cache.content_size = content.Size.Y.Offset
			cache.tabs_size = tabs.Size.Y.Offset
			createTween(content, {Size = UDim2.new(1, 0, 0, 0)}, options.animation):Play()
			createTween(tabs, {Size = UDim2.new(1, 0, 0, 0)}, options.animation):Play()
		end

		function self.open()
			if self.isopen then return end
			self.isopen = true
			createTween(expand, {Rotation = 90}, options.animation):Play()
			createTween(content, {Size = UDim2.new(1, 0, 0, cache.content_size)}, options.animation):Play()
			createTween(tabs, {Size = UDim2.new(1, 0, 0, cache.tabs_size)}, options.animation):Play()
		end
		
		do
			local animSpeed = options.animation
			options.animation = 0
			self.close()
			options.animation = animSpeed
		end

		return self
	end
}

do -- window history zindex
	imgui2.ChildAdded:Connect(function(window)
		if window:IsA("GuiObject") and window:FindFirstChild("Content") then
			local content = window:FindFirstChild("Content")

			window.MouseEnter:Connect(function() mouseCache[window] = true end)
			content.MouseEnter:Connect(function() browsingWindow[window] = true end)
			window.MouseLeave:Connect(function() mouseCache[window] = nil end)
			content.MouseLeave:Connect(function() browsingWindow[window] = nil end)

			cacheWindowHistory(window)
			setTopMost(window)
		end
	end)

	imgui2.ChildRemoved:Connect(function(window)
		windowHistory[window] = nil
		windowCache[window] = nil
	end)

	mouse.InputBegan:Connect(function()
		task.wait()
		if isDragging or isResizing or isSliding or isColorPicking then return end
		local topMost = findBrowsingTopMost()
		if topMost then
			setTopMost(topMost)
		end
	end)
end

return library
