--[[
	Serpent UI Library | Version 2.0

	Change Log:
        - Refactored API for ease of use.
        - Fixed a potential error when closing windows.
        - Added a line counter feature to the textbox (:linecounter() or :lc()).
        - Improved textbox resizing to prevent content overflow.
--]]

repeat task.wait() until game:GetService("Players").LocalPlayer
if game:GetService("CoreGui"):FindFirstChild("Serpent | Main") then
    game:GetService("CoreGui"):FindFirstChild("Serpent | Main"):Destroy()
end

do -- Load items
    local imgui2 = Instance.new("ScreenGui")
    local Presets = Instance.new("Frame")
    local Label = Instance.new("TextLabel")
    local TabButton = Instance.new("TextButton")
    local Folder = Instance.new("Frame")
    local Folder_2 = Instance.new("ImageLabel")
    local Expand = Instance.new("ImageButton")
    local Title = Instance.new("TextLabel")
    local Items = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local Tab = Instance.new("Frame")
    local Items_2 = Instance.new("ScrollingFrame")
    local UIListLayout_2 = Instance.new("UIListLayout")
    local Padding = Instance.new("Frame")
    local Main = Instance.new("ImageLabel")
    local Frame = Instance.new("Frame")
    local Frame_2 = Instance.new("Frame")
    local Content = Instance.new("ImageLabel")
    local Frame_3 = Instance.new("Frame")
    local Message = Instance.new("ImageLabel")
    local Expand_2 = Instance.new("ImageButton")
    local Title_2 = Instance.new("TextLabel")
    local Shadow = Instance.new("ImageLabel")
    local Tabs = Instance.new("Frame")
    local Items_3 = Instance.new("Frame")
    local UIListLayout_3 = Instance.new("UIListLayout")
    local Frame_4 = Instance.new("Frame")
    local Layer = Instance.new("ImageLabel")
    local Dock = Instance.new("Frame")
    local UIListLayout_4 = Instance.new("UIListLayout")
    local Switch = Instance.new("Frame")
    local Button = Instance.new("TextButton")
    local ImageLabel = Instance.new("ImageLabel")
    local Layer_2 = Instance.new("ImageLabel")
    local Check = Instance.new("ImageLabel")
    local Text = Instance.new("TextLabel")
    local Slider = Instance.new("Frame")
    local Outer = Instance.new("ImageLabel")
    local Inner = Instance.new("ImageLabel")
    local Slider_2 = Instance.new("Frame")
    local Value = Instance.new("TextLabel")
    local Text_2 = Instance.new("TextLabel")
    local Button_2 = Instance.new("TextButton")
    local ImageLabel_2 = Instance.new("ImageLabel")
    local Layer_3 = Instance.new("ImageLabel")
    local Card = Instance.new("ImageLabel")
    local UIGradient = Instance.new("UIGradient")
    local ImageLabel_3 = Instance.new("ImageLabel")
    local Roundify = Instance.new("ImageLabel")
    local heading = Instance.new("TextLabel")
    local Frame_5 = Instance.new("ImageLabel")
    local SubHeading = Instance.new("TextLabel")
    local ColorPicker = Instance.new("Frame")
    local Button_3 = Instance.new("TextButton")
    local ImageLabel_4 = Instance.new("ImageLabel")
    local ImageLabel_5 = Instance.new("ImageLabel")
    local Layer_4 = Instance.new("ImageLabel")
    local Text_3 = Instance.new("TextLabel")
    local DropdownOption = Instance.new("TextButton")
    local ImageLabel_6 = Instance.new("ImageLabel")
    local DropdownWindow = Instance.new("ImageLabel")
    local Frame_6 = Instance.new("Frame")
    local Frame_7 = Instance.new("Frame")
    local Title_3 = Instance.new("TextLabel")
    local Shadow_2 = Instance.new("ImageLabel")
    local Layer_5 = Instance.new("ImageLabel")
    local Content_2 = Instance.new("ImageLabel")
    local Items_4 = Instance.new("ScrollingFrame")
    local UIListLayout_5 = Instance.new("UIListLayout")
    local Search = Instance.new("Frame")
    local Outer_2 = Instance.new("ImageLabel")
    local Inner_2 = Instance.new("ImageLabel")
    local ImageLabel_7 = Instance.new("ImageLabel")
    local TextBox = Instance.new("TextLabel")
    local Selected = Instance.new("TextLabel")
    local Expand_3 = Instance.new("ImageButton")
    local Cache = Instance.new("Frame")
    local ColorPickerWindow = Instance.new("ImageLabel")
    local Frame_8 = Instance.new("Frame")
    local Frame_9 = Instance.new("Frame")
    local Title_4 = Instance.new("TextLabel")
    local Shadow_3 = Instance.new("ImageLabel")
    local Layer_6 = Instance.new("ImageLabel")
    local Expand_4 = Instance.new("ImageButton")
    local Content_3 = Instance.new("ImageLabel")
    local Palette = Instance.new("ImageLabel")
    local Indicator = Instance.new("ImageLabel")
    local Saturation = Instance.new("ImageLabel")
    local Indicator_2 = Instance.new("Frame")
    local FinalColor = Instance.new("ImageLabel")
    local SaturationColor = Instance.new("ImageLabel")
    local PaletteColor = Instance.new("ImageLabel")
    local TextLabel = Instance.new("TextLabel")
    local Dropdown = Instance.new("Frame")
    local Outer_3 = Instance.new("ImageLabel")
    local Inner_3 = Instance.new("ImageButton")
    local ImageLabel_8 = Instance.new("ImageLabel")
    local Value_2 = Instance.new("TextLabel")
    local Text_4 = Instance.new("TextLabel")
    local Cache_2 = Instance.new("Frame")
    local Resizer = Instance.new("ImageButton")
    local TextBoxContainer = Instance.new("Frame")
    local TextBoxOuter = Instance.new("ImageLabel")
    local TextBoxInner = Instance.new("ScrollingFrame")
    local LineCounter = Instance.new("TextLabel")
    local EditorGroup = Instance.new("Frame")
    local SyntaxLabel = Instance.new("TextLabel")
    local ActualTextBox = Instance.new("TextBox")
    
    imgui2.Name = "Serpent | Main"
    imgui2.Parent = game:GetService("CoreGui")
    imgui2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Presets.Name = "Presets"
    Presets.Parent = imgui2
    Presets.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Presets.Size = UDim2.new(0, 100, 0, 100)
    Presets.Visible = false

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

    TabButton.Name = "TabButton"
    TabButton.Parent = Presets
    TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.BackgroundTransparency = 1.000
    TabButton.Size = UDim2.new(0, 32, 1, 0)
    TabButton.Font = Enum.Font.Code
    TabButton.Text = "Menu"
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 16.000

    Folder.Name = "Folder"
    Folder.Parent = Presets
    Folder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Folder.BackgroundTransparency = 1.000
    Folder.ClipsDescendants = true
    Folder.Size = UDim2.new(1, 0, 0, 100)

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

    Expand.Name = "Expand"
    Expand.Parent = Folder_2
    Expand.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Expand.BackgroundTransparency = 1.000
    Expand.Position = UDim2.new(0, 6, 0, 2)
    Expand.Size = UDim2.new(0, 16, 0, 16)
    Expand.ZIndex = 4
    Expand.Image = "rbxassetid://7671465363"

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

    Items.Name = "Items"
    Items.Parent = Folder
    Items.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Items.BackgroundTransparency = 1.000
    Items.Position = UDim2.new(0, 10, 0, 25)
    Items.Size = UDim2.new(1, -10, 1, -25)

    UIListLayout.Parent = Items
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

    Tab.Name = "Tab"
    Tab.Parent = Presets
    Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Tab.BackgroundTransparency = 1.000
    Tab.Position = UDim2.new(0, 0, 0, 30)
    Tab.Size = UDim2.new(1, 0, 1, -30)

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

    UIListLayout_2.Parent = Items_2
    UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_2.Padding = UDim.new(0, 5)

    Padding.Name = "Padding"
    Padding.Parent = Items_2
    Padding.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Padding.BackgroundTransparency = 1.000

    Main.Name = "Main"
    Main.Parent = Presets
    Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Main.BackgroundTransparency = 1.000
    Main.Position = UDim2.new(0.309293151, 0, 0.41276595, 0)
    Main.Size = UDim2.new(0, 300, 0, 22)
    Main.ZIndex = 4
    Main.Image = "rbxassetid://3570695787"
    Main.ImageColor3 = Color3.fromRGB(10, 10, 10)
    Main.ScaleType = Enum.ScaleType.Slice
    Main.SliceCenter = Rect.new(100, 100, 100, 100)
    Main.SliceScale = 0.050

    Frame.Parent = Main
    Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0, 0, 1, -10)
    Frame.Size = UDim2.new(1, 0, 0, 10)
    Frame.ZIndex = 4

    Frame_2.Parent = Frame
    Frame_2.BackgroundColor3 = Color3.fromRGB(59, 59, 68)
    Frame_2.BorderSizePixel = 0
    Frame_2.Position = UDim2.new(0, 0, 1, 0)
    Frame_2.Size = UDim2.new(1, 0, 0, 2)
    Frame_2.ZIndex = 2

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

    Frame_3.Parent = Content
    Frame_3.BackgroundColor3 = Color3.fromRGB(21, 22, 23)
    Frame_3.BorderSizePixel = 0
    Frame_3.Size = UDim2.new(1, 0, 0, 10)

    Message.Name = "Message"
    Message.Parent = Content
    Message.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Message.BackgroundTransparency = 1.000
    Message.Position = UDim2.new(0, 0, 0, -22)
    Message.Size = UDim2.new(1, 0, 1, 22)
    Message.ZIndex = 3
    Message.Image = "rbxassetid://3570695787"
    Message.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Message.ImageTransparency = 1.000
    Message.ScaleType = Enum.ScaleType.Slice
    Message.SliceCenter = Rect.new(100, 100, 100, 100)
    Message.SliceScale = 0.050

    Expand_2.Name = "Expand"
    Expand_2.Parent = Main
    Expand_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Expand_2.BackgroundTransparency = 1.000
    Expand_2.Position = UDim2.new(0, 6, 0, 2)
    Expand_2.Rotation = 90.000
    Expand_2.Size = UDim2.new(0, 18, 0, 18)
    Expand_2.ZIndex = 4
    Expand_2.Image = "rbxassetid://7671465363"

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

    Shadow.Name = "Shadow"
    Shadow.Parent = Main
    Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Shadow.BackgroundTransparency = 1.000
    Shadow.Position = UDim2.new(0, 10, 0, 10)
    Shadow.Size = UDim2.new(1, 0, 10.090909, 0)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://3570695787"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.500
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(100, 100, 100, 100)
    Shadow.SliceScale = 0.050

    Tabs.Name = "Tabs"
    Tabs.Parent = Main
    Tabs.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
    Tabs.BorderSizePixel = 0
    Tabs.ClipsDescendants = true
    Tabs.Position = UDim2.new(0, 0, 1, 2)
    Tabs.Size = UDim2.new(1, 0, 0, 28)

    Items_3.Name = "Items"
    Items_3.Parent = Tabs
    Items_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Items_3.BackgroundTransparency = 1.000
    Items_3.Position = UDim2.new(0, 15, 0, 0)
    Items_3.Size = UDim2.new(1, -15, 1, -2)

    UIListLayout_3.Parent = Items_3
    UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_3.Padding = UDim.new(0, 15)

    Frame_4.Parent = Tabs
    Frame_4.BackgroundColor3 = Color3.fromRGB(59, 59, 68)
    Frame_4.BorderSizePixel = 0
    Frame_4.Position = UDim2.new(0, 0, 1, -2)
    Frame_4.Size = UDim2.new(1, 0, 0, 2)
    Frame_4.ZIndex = 2

    Layer.Name = "Layer"
    Layer.Parent = Main
    Layer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Layer.BackgroundTransparency = 1.000
    Layer.Position = UDim2.new(0, 2, 0, 2)
    Layer.Size = UDim2.new(1, 0, 10.090909, 0)
    Layer.ZIndex = 0
    Layer.Image = "rbxassetid://3570695787"
    Layer.ImageColor3 = Color3.fromRGB(10, 10, 11)
    Layer.ScaleType = Enum.ScaleType.Slice
    Layer.SliceCenter = Rect.new(100, 100, 100, 100)
    Layer.SliceScale = 0.050

    Dock.Name = "Dock"
    Dock.Parent = Presets
    Dock.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Dock.BackgroundTransparency = 1.000
    Dock.ClipsDescendants = true
    Dock.Size = UDim2.new(1, 0, 0, 22)

    UIListLayout_4.Parent = Dock
    UIListLayout_4.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_4.Padding = UDim.new(0, 5)

    Switch.Name = "Switch"
    Switch.Parent = Presets
    Switch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Switch.BackgroundTransparency = 1.000
    Switch.Size = UDim2.new(0, 70, 0, 20)

    Button.Name = "Button"
    Button.Parent = Switch
    Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Button.BackgroundTransparency = 1.000
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(0, 20, 0, 20)
    Button.ZIndex = 3
    Button.Font = Enum.Font.Code
    Button.Text = ""
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14.000

    ImageLabel.Parent = Button
    ImageLabel.Active = true
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel.BackgroundTransparency = 1.000
    ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel.Selectable = true
    ImageLabel.Size = UDim2.new(1, 0, 1, 0)
    ImageLabel.ZIndex = 2
    ImageLabel.Image = "rbxassetid://3570695787"
    ImageLabel.ImageColor3 = Color3.fromRGB(41, 74, 122)
    ImageLabel.ScaleType = Enum.ScaleType.Slice
    ImageLabel.SliceCenter = Rect.new(100, 100, 100, 100)
    ImageLabel.SliceScale = 0.050

    Layer_2.Name = "Layer"
    Layer_2.Parent = Button
    Layer_2.Active = true
    Layer_2.AnchorPoint = Vector2.new(0.5, 0.5)
    Layer_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Layer_2.BackgroundTransparency = 1.000
    Layer_2.Position = UDim2.new(0.5, 2, 0.5, 2)
    Layer_2.Selectable = true
    Layer_2.Size = UDim2.new(1, 0, 1, 0)
    Layer_2.Image = "rbxassetid://3570695787"
    Layer_2.ImageColor3 = Color3.fromRGB(21, 38, 63)
    Layer_2.ScaleType = Enum.ScaleType.Slice
    Layer_2.SliceCenter = Rect.new(100, 100, 100, 100)
    Layer_2.SliceScale = 0.050

    Check.Name = "Check"
    Check.Parent = Button
    Check.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Check.BackgroundTransparency = 1.000
    Check.Position = UDim2.new(0, 3, 0, 3)
    Check.Size = UDim2.new(1, -6, 1, -6)
    Check.ZIndex = 2
    Check.Image = "rbxassetid://7710220183"

    Text.Name = "Text"
    Text.Parent = Switch
    Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Text.BackgroundTransparency = 1.000
    Text.Position = UDim2.new(0, 28, 0, 0)
    Text.Size = UDim2.new(0, 42, 1, 0)
    Text.Font = Enum.Font.Code
    Text.Text = "Switch"
    Text.TextColor3 = Color3.fromRGB(255, 255, 255)
    Text.TextSize = 14.000
    Text.TextXAlignment = Enum.TextXAlignment.Left

    Slider.Name = "Slider"
    Slider.Parent = Presets
    Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Slider.BackgroundTransparency = 1.000
    Slider.Size = UDim2.new(0, 150, 0, 20)

    Outer.Name = "Outer"
    Outer.Parent = Slider
    Outer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Outer.BackgroundTransparency = 1.000
    Outer.Size = UDim2.new(0, 150, 1, 0)
    Outer.Image = "rbxassetid://3570695787"
    Outer.ImageColor3 = Color3.fromRGB(59, 59, 68)
    Outer.ScaleType = Enum.ScaleType.Slice
    Outer.SliceCenter = Rect.new(100, 100, 100, 100)
    Outer.SliceScale = 0.050

    Inner.Name = "Inner"
    Inner.Parent = Outer
    Inner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Inner.BackgroundTransparency = 1.000
    Inner.Position = UDim2.new(0, 2, 0, 2)
    Inner.Size = UDim2.new(1, -4, 1, -4)
    Inner.Image = "rbxassetid://3570695787"
    Inner.ImageColor3 = Color3.fromRGB(32, 59, 97)
    Inner.ScaleType = Enum.ScaleType.Slice
    Inner.SliceCenter = Rect.new(100, 100, 100, 100)
    Inner.SliceScale = 0.050

    Slider_2.Name = "Slider"
    Slider_2.Parent = Inner
    Slider_2.BackgroundColor3 = Color3.fromRGB(49, 88, 146)
    Slider_2.BorderSizePixel = 0
    Slider_2.Position = UDim2.new(0, 10, 0, 0)
    Slider_2.Size = UDim2.new(0, 5, 1, 0)

    Value.Name = "Value"
    Value.Parent = Inner
    Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Value.BackgroundTransparency = 1.000
    Value.Size = UDim2.new(1, 0, 1, 0)
    Value.Font = Enum.Font.Code
    Value.Text = "6.00"
    Value.TextColor3 = Color3.fromRGB(255, 255, 255)
    Value.TextSize = 14.000

    Text_2.Name = "Text"
    Text_2.Parent = Slider
    Text_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Text_2.BackgroundTransparency = 1.000
    Text_2.Position = UDim2.new(0, 158, 0, 0)
    Text_2.Size = UDim2.new(0, 42, 1, 0)
    Text_2.Font = Enum.Font.Code
    Text_2.Text = "Slider"
    Text_2.TextColor3 = Color3.fromRGB(255, 255, 255)
    Text_2.TextSize = 14.000
    Text_2.TextXAlignment = Enum.TextXAlignment.Left

    Button_2.Name = "Button"
    Button_2.Parent = Presets
    Button_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Button_2.BackgroundTransparency = 1.000
    Button_2.BorderSizePixel = 0
    Button_2.Size = UDim2.new(0, 72, 0, 20)
    Button_2.ZIndex = 3
    Button_2.Font = Enum.Font.Code
    Button_2.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button_2.TextSize = 14.000

    ImageLabel_2.Parent = Button_2
    ImageLabel_2.Active = true
    ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel_2.BackgroundTransparency = 1.000
    ImageLabel_2.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel_2.Selectable = true
    ImageLabel_2.Size = UDim2.new(1, 0, 1, 0)
    ImageLabel_2.ZIndex = 2
    ImageLabel_2.Image = "rbxassetid://3570695787"
    ImageLabel_2.ImageColor3 = Color3.fromRGB(41, 74, 122)
    ImageLabel_2.ScaleType = Enum.ScaleType.Slice
    ImageLabel_2.SliceCenter = Rect.new(100, 100, 100, 100)
    ImageLabel_2.SliceScale = 0.050

    Layer_3.Name = "Layer"
    Layer_3.Parent = Button_2
    Layer_3.Active = true
    Layer_3.AnchorPoint = Vector2.new(0.5, 0.5)
    Layer_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Layer_3.BackgroundTransparency = 1.000
    Layer_3.Position = UDim2.new(0.5, 2, 0.5, 2)
    Layer_3.Selectable = true
    Layer_3.Size = UDim2.new(1, 0, 1, 0)
    Layer_3.Image = "rbxassetid://3570695787"
    Layer_3.ImageColor3 = Color3.fromRGB(21, 38, 63)
    Layer_3.ScaleType = Enum.ScaleType.Slice
    Layer_3.SliceCenter = Rect.new(100, 100, 100, 100)
    Layer_3.SliceScale = 0.050

    Card.Name = "Card"
    Card.Parent = Presets
    Card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Card.BackgroundTransparency = 1.000
    Card.Size = UDim2.new(1, 0, 0, 100)
    Card.Image = "rbxassetid://3570695787"
    Card.ScaleType = Enum.ScaleType.Slice
    Card.SliceCenter = Rect.new(100, 100, 100, 100)
    Card.SliceScale = 0.120

    UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 129, 167)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 160, 168))}
    UIGradient.Rotation = 30
    UIGradient.Parent = Card

    ImageLabel_3.Parent = Card
    ImageLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel_3.BorderSizePixel = 0
    ImageLabel_3.Position = UDim2.new(0, 24, 0, 24)
    ImageLabel_3.Size = UDim2.new(0, 52, 1, -48)
    ImageLabel_3.ZIndex = 3
    ImageLabel_3.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

    Roundify.Name = "Roundify"
    Roundify.Parent = ImageLabel_3
    Roundify.AnchorPoint = Vector2.new(0.5, 0.5)
    Roundify.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Roundify.BackgroundTransparency = 1.000
    Roundify.Position = UDim2.new(0.5, 0, 0.5, 0)
    Roundify.Size = UDim2.new(1, 24, 1, 24)
    Roundify.ZIndex = 3
    Roundify.Image = "rbxassetid://3570695787"
    Roundify.ImageColor3 = Color3.fromRGB(200, 200, 200)
    Roundify.ScaleType = Enum.ScaleType.Slice
    Roundify.SliceCenter = Rect.new(100, 100, 100, 100)
    Roundify.SliceScale = 0.120

    heading.Name = "heading"
    heading.Parent = Card
    heading.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    heading.BackgroundTransparency = 1.000
    heading.Position = UDim2.new(0, 100, 0, 24)
    heading.Size = UDim2.new(1, -100, 0, 50)
    heading.ZIndex = 3
    heading.Font = Enum.Font.GothamBlack
    heading.Text = "welcome, singularity"
    heading.TextColor3 = Color3.fromRGB(255, 255, 255)
    heading.TextSize = 14.000
    heading.TextXAlignment = Enum.TextXAlignment.Left
    heading.TextYAlignment = Enum.TextYAlignment.Top

    Frame_5.Name = "Frame"
    Frame_5.Parent = Card
    Frame_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_5.BackgroundTransparency = 1.000
    Frame_5.Size = UDim2.new(1, 0, 1, 0)
    Frame_5.ZIndex = 2
    Frame_5.Image = "rbxassetid://3570695787"
    Frame_5.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Frame_5.ImageTransparency = 0.500
    Frame_5.ScaleType = Enum.ScaleType.Slice
    Frame_5.SliceCenter = Rect.new(100, 100, 100, 100)
    Frame_5.SliceScale = 0.120

    SubHeading.Name = "SubHeading"
    SubHeading.Parent = Card
    SubHeading.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SubHeading.BackgroundTransparency = 1.000
    SubHeading.Position = UDim2.new(0, 100, 0, 44)
    SubHeading.Size = UDim2.new(1, -100, 0, 50)
    SubHeading.ZIndex = 3
    SubHeading.Font = Enum.Font.Gotham
    SubHeading.Text = "subheading"
    SubHeading.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubHeading.TextSize = 14.000
    SubHeading.TextXAlignment = Enum.TextXAlignment.Left
    SubHeading.TextYAlignment = Enum.TextYAlignment.Top

    ColorPicker.Name = "ColorPicker"
    ColorPicker.Parent = Presets
    ColorPicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ColorPicker.BackgroundTransparency = 1.000
    ColorPicker.Size = UDim2.new(0, 112, 0, 20)

    Button_3.Name = "Button"
    Button_3.Parent = ColorPicker
    Button_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Button_3.BackgroundTransparency = 1.000
    Button_3.BorderSizePixel = 0
    Button_3.Size = UDim2.new(0, 20, 0, 20)
    Button_3.ZIndex = 3
    Button_3.Font = Enum.Font.Code
    Button_3.Text = ""
    Button_3.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button_3.TextSize = 14.000

    ImageLabel_4.Parent = Button_3
    ImageLabel_4.Active = true
    ImageLabel_4.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel_4.BackgroundTransparency = 1.000
    ImageLabel_4.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel_4.Selectable = true
    ImageLabel_4.Size = UDim2.new(1, 0, 1, 0)
    ImageLabel_4.ZIndex = 2
    ImageLabel_4.Image = "rbxassetid://3570695787"
    ImageLabel_4.ImageColor3 = Color3.fromRGB(255, 0, 0)
    ImageLabel_4.ScaleType = Enum.ScaleType.Slice
    ImageLabel_4.SliceCenter = Rect.new(100, 100, 100, 100)
    ImageLabel_4.SliceScale = 0.050

    ImageLabel_5.Parent = ImageLabel_4
    ImageLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel_5.BackgroundTransparency = 1.000
    ImageLabel_5.Position = UDim2.new(0, 4, 0, 4)
    ImageLabel_5.Size = UDim2.new(1, -8, 1, -8)
    ImageLabel_5.ZIndex = 2
    ImageLabel_5.Image = "rbxassetid://11144378537"

    Layer_4.Name = "Layer"
    Layer_4.Parent = Button_3
    Layer_4.Active = true
    Layer_4.AnchorPoint = Vector2.new(0.5, 0.5)
    Layer_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Layer_4.BackgroundTransparency = 1.000
    Layer_4.Position = UDim2.new(0.5, 2, 0.5, 2)
    Layer_4.Selectable = true
    Layer_4.Size = UDim2.new(1, 0, 1, 0)
    Layer_4.Image = "rbxassetid://3570695787"
    Layer_4.ImageColor3 = Color3.fromRGB(127, 0, 0)
    Layer_4.ScaleType = Enum.ScaleType.Slice
    Layer_4.SliceCenter = Rect.new(100, 100, 100, 100)
    Layer_4.SliceScale = 0.050

    Text_3.Name = "Text"
    Text_3.Parent = ColorPicker
    Text_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Text_3.BackgroundTransparency = 1.000
    Text_3.Position = UDim2.new(0, 28, 0, 0)
    Text_3.Size = UDim2.new(0, 84, 1, 0)
    Text_3.Font = Enum.Font.Code
    Text_3.Text = "Color Picker"
    Text_3.TextColor3 = Color3.fromRGB(255, 255, 255)
    Text_3.TextSize = 14.000
    Text_3.TextXAlignment = Enum.TextXAlignment.Left

    DropdownOption.Name = "DropdownOption"
    DropdownOption.Parent = Presets
    DropdownOption.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DropdownOption.BackgroundTransparency = 1.000
    DropdownOption.BorderSizePixel = 0
    DropdownOption.Size = UDim2.new(1, 0, 0, 20)
    DropdownOption.ZIndex = 3
    DropdownOption.Font = Enum.Font.Code
    DropdownOption.Text = "  Option"
    DropdownOption.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownOption.TextSize = 14.000
    DropdownOption.TextXAlignment = Enum.TextXAlignment.Left

    ImageLabel_6.Parent = DropdownOption
    ImageLabel_6.Active = true
    ImageLabel_6.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel_6.BackgroundTransparency = 1.000
    ImageLabel_6.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel_6.Selectable = true
    ImageLabel_6.Size = UDim2.new(1, 0, 1, 0)
    ImageLabel_6.ZIndex = 2
    ImageLabel_6.Image = "rbxassetid://3570695787"
    ImageLabel_6.ImageColor3 = Color3.fromRGB(42, 44, 46)
    ImageLabel_6.ScaleType = Enum.ScaleType.Slice
    ImageLabel_6.SliceCenter = Rect.new(100, 100, 100, 100)
    ImageLabel_6.SliceScale = 0.050

    DropdownWindow.Name = "DropdownWindow"
    DropdownWindow.Parent = Presets
    DropdownWindow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DropdownWindow.BackgroundTransparency = 1.000
    DropdownWindow.Position = UDim2.new(0.496228397, 0, 0.411765426, 0)
    DropdownWindow.Size = UDim2.new(0, 200, 0, 22)
    DropdownWindow.ZIndex = 4
    DropdownWindow.Image = "rbxassetid://3570695787"
    DropdownWindow.ImageColor3 = Color3.fromRGB(10, 10, 10)
    DropdownWindow.ScaleType = Enum.ScaleType.Slice
    DropdownWindow.SliceCenter = Rect.new(100, 100, 100, 100)
    DropdownWindow.SliceScale = 0.050

    Frame_6.Parent = DropdownWindow
    Frame_6.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Frame_6.BorderSizePixel = 0
    Frame_6.Position = UDim2.new(0, 0, 1, -10)
    Frame_6.Size = UDim2.new(1, 0, 0, 10)
    Frame_6.ZIndex = 4

    Frame_7.Parent = Frame_6
    Frame_7.BackgroundColor3 = Color3.fromRGB(59, 59, 68)
    Frame_7.BorderSizePixel = 0
    Frame_7.Position = UDim2.new(0, 0, 1, 0)
    Frame_7.Size = UDim2.new(1, 0, 0, 2)
    Frame_7.ZIndex = 2

    Title_3.Name = "Title"
    Title_3.Parent = DropdownWindow
    Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title_3.BackgroundTransparency = 1.000
    Title_3.Position = UDim2.new(0, 30, 0, 0)
    Title_3.Size = UDim2.new(1, -30, 1, 0)
    Title_3.ZIndex = 4
    Title_3.Font = Enum.Font.Code
    Title_3.Text = "Dropdown"
    Title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_3.TextSize = 16.000
    Title_3.TextWrapped = true
    Title_3.TextXAlignment = Enum.TextXAlignment.Left

    Shadow_2.Name = "Shadow"
    Shadow_2.Parent = DropdownWindow
    Shadow_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Shadow_2.BackgroundTransparency = 1.000
    Shadow_2.Position = UDim2.new(0, 10, 0, 10)
    Shadow_2.Size = UDim2.new(1, 0, 8.72700024, 10)
    Shadow_2.ZIndex = 0
    Shadow_2.Image = "rbxassetid://3570695787"
    Shadow_2.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow_2.ImageTransparency = 0.500
    Shadow_2.ScaleType = Enum.ScaleType.Slice
    Shadow_2.SliceCenter = Rect.new(100, 100, 100, 100)
    Shadow_2.SliceScale = 0.050

    Layer_5.Name = "Layer"
    Layer_5.Parent = DropdownWindow
    Layer_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Layer_5.BackgroundTransparency = 1.000
    Layer_5.Position = UDim2.new(0, 2, 0, 2)
    Layer_5.Size = UDim2.new(1, 0, 9, 2)
    Layer_5.ZIndex = 0
    Layer_5.Image = "rbxassetid://3570695787"
    Layer_5.ImageColor3 = Color3.fromRGB(10, 10, 11)
    Layer_5.ScaleType = Enum.ScaleType.Slice
    Layer_5.SliceCenter = Rect.new(100, 100, 100, 100)
    Layer_5.SliceScale = 0.050

    Content_2.Name = "Content"
    Content_2.Parent = DropdownWindow
    Content_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Content_2.BackgroundTransparency = 1.000
    Content_2.ClipsDescendants = true
    Content_2.Position = UDim2.new(0, 0, 1, 0)
    Content_2.Size = UDim2.new(1, 0, 0, 178)
    Content_2.Image = "rbxassetid://3570695787"
    Content_2.ImageColor3 = Color3.fromRGB(21, 22, 23)
    Content_2.ScaleType = Enum.ScaleType.Slice
    Content_2.SliceCenter = Rect.new(100, 100, 100, 100)
    Content_2.SliceScale = 0.050

    Items_4.Name = "Items"
    Items_4.Parent = Content_2
    Items_4.Active = true
    Items_4.BackgroundColor3 = Color3.fromRGB(21, 22, 23)
    Items_4.BorderSizePixel = 0
    Items_4.Position = UDim2.new(0, 10, 0, 30)
    Items_4.Size = UDim2.new(1, -20, 1, -60)
    Items_4.CanvasSize = UDim2.new(0, 0, 0, 0)
    Items_4.ScrollBarThickness = 6

    UIListLayout_5.Parent = Items_4
    UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_5.Padding = UDim.new(0, 2)

    Search.Name = "Search"
    Search.Parent = Content_2
    Search.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Search.BackgroundTransparency = 1.000
    Search.Position = UDim2.new(0, 5, 0, 6)
    Search.Size = UDim2.new(1, -10, 0, 20)

    Outer_2.Name = "Outer"
    Outer_2.Parent = Search
    Outer_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Outer_2.BackgroundTransparency = 1.000
    Outer_2.Size = UDim2.new(1, 0, 1, 0)
    Outer_2.Image = "rbxassetid://3570695787"
    Outer_2.ImageColor3 = Color3.fromRGB(59, 59, 68)
    Outer_2.ScaleType = Enum.ScaleType.Slice
    Outer_2.SliceCenter = Rect.new(100, 100, 100, 100)
    Outer_2.SliceScale = 0.050

    Inner_2.Name = "Inner"
    Inner_2.Parent = Outer_2
    Inner_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Inner_2.BackgroundTransparency = 1.000
    Inner_2.Position = UDim2.new(0, 2, 0, 2)
    Inner_2.Size = UDim2.new(1, -4, 1, -4)
    Inner_2.Image = "rbxassetid://3570695787"
    Inner_2.ImageColor3 = Color3.fromRGB(32, 59, 97)
    Inner_2.ScaleType = Enum.ScaleType.Slice
    Inner_2.SliceCenter = Rect.new(100, 100, 100, 100)
    Inner_2.SliceScale = 0.050

    ImageLabel_7.Parent = Inner_2
    ImageLabel_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel_7.BackgroundTransparency = 1.000
    ImageLabel_7.Position = UDim2.new(0, 5, 1, -16)
    ImageLabel_7.Size = UDim2.new(0, 16, 0, 16)
    ImageLabel_7.Image = "rbxassetid://11146003594"

    TextBox.Name = "TextBox"
    TextBox.Parent = Inner_2
    TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.BackgroundTransparency = 1.000
    TextBox.Position = UDim2.new(0, 30, 0, 0)
    TextBox.Size = UDim2.new(1, -30, 1, 0)
    TextBox.Font = Enum.Font.SourceSans
    TextBox.Text = "Search ..."
    TextBox.TextColor3 = Color3.fromRGB(178, 178, 178)
    TextBox.TextSize = 14.000
    TextBox.TextXAlignment = Enum.TextXAlignment.Left

    Selected.Name = "Selected"
    Selected.Parent = Content_2
    Selected.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Selected.BackgroundTransparency = 1.000
    Selected.Position = UDim2.new(0, 10, 1, -30)
    Selected.Size = UDim2.new(1, -10, 0, 30)
    Selected.Font = Enum.Font.Code
    Selected.Text = "Selected: [...]"
    Selected.TextColor3 = Color3.fromRGB(178, 178, 178)
    Selected.TextSize = 12.000
    Selected.TextXAlignment = Enum.TextXAlignment.Left

    Expand_3.Name = "Expand"
    Expand_3.Parent = DropdownWindow
    Expand_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Expand_3.BackgroundTransparency = 1.000
    Expand_3.Position = UDim2.new(0, 6, 0, 2)
    Expand_3.Rotation = 90.000
    Expand_3.Size = UDim2.new(0, 18, 0, 18)
    Expand_3.ZIndex = 4
    Expand_3.Image = "rbxassetid://7671465363"

    Cache.Name = "Cache"
    Cache.Parent = DropdownWindow
    Cache.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Cache.Size = UDim2.new(0, 100, 0, 100)
    Cache.Visible = false

    ColorPickerWindow.Name = "ColorPickerWindow"
    ColorPickerWindow.Parent = Presets
    ColorPickerWindow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ColorPickerWindow.BackgroundTransparency = 1.000
    ColorPickerWindow.Position = UDim2.new(0.712284446, 0, 0.110530853, 0)
    ColorPickerWindow.Size = UDim2.new(0, 200, 0, 22)
    ColorPickerWindow.ZIndex = 4
    ColorPickerWindow.Image = "rbxassetid://3570695787"
    ColorPickerWindow.ImageColor3 = Color3.fromRGB(10, 10, 10)
    ColorPickerWindow.ScaleType = Enum.ScaleType.Slice
    ColorPickerWindow.SliceCenter = Rect.new(100, 100, 100, 100)
    ColorPickerWindow.SliceScale = 0.050

    Frame_8.Parent = ColorPickerWindow
    Frame_8.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Frame_8.BorderSizePixel = 0
    Frame_8.Position = UDim2.new(0, 0, 1, -10)
    Frame_8.Size = UDim2.new(1, 0, 0, 10)
    Frame_8.ZIndex = 4

    Frame_9.Parent = Frame_8
    Frame_9.BackgroundColor3 = Color3.fromRGB(59, 59, 68)
    Frame_9.BorderSizePixel = 0
    Frame_9.Position = UDim2.new(0, 0, 1, 0)
    Frame_9.Size = UDim2.new(1, 0, 0, 2)
    Frame_9.ZIndex = 2

    Title_4.Name = "Title"
    Title_4.Parent = ColorPickerWindow
    Title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title_4.BackgroundTransparency = 1.000
    Title_4.Position = UDim2.new(0, 30, 0, 0)
    Title_4.Size = UDim2.new(1, -30, 1, 0)
    Title_4.ZIndex = 4
    Title_4.Font = Enum.Font.Code
    Title_4.Text = "Color Picker"
    Title_4.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_4.TextSize = 16.000
    Title_4.TextWrapped = true
    Title_4.TextXAlignment = Enum.TextXAlignment.Left

    Shadow_3.Name = "Shadow"
    Shadow_3.Parent = ColorPickerWindow
    Shadow_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Shadow_3.BackgroundTransparency = 1.000
    Shadow_3.Position = UDim2.new(0, 10, 0, 10)
    Shadow_3.Size = UDim2.new(1, 0, 8.72700024, 10)
    Shadow_3.ZIndex = 0
    Shadow_3.Image = "rbxassetid://3570695787"
    Shadow_3.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow_3.ImageTransparency = 0.500
    Shadow_3.ScaleType = Enum.ScaleType.Slice
    Shadow_3.SliceCenter = Rect.new(100, 100, 100, 100)
    Shadow_3.SliceScale = 0.050

    Layer_6.Name = "Layer"
    Layer_6.Parent = ColorPickerWindow
    Layer_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Layer_6.BackgroundTransparency = 1.000
    Layer_6.Position = UDim2.new(0, 2, 0, 2)
    Layer_6.Size = UDim2.new(1, 0, 9, 2)
    Layer_6.ZIndex = 0
    Layer_6.Image = "rbxassetid://3570695787"
    Layer_6.ImageColor3 = Color3.fromRGB(10, 10, 11)
    Layer_6.ScaleType = Enum.ScaleType.Slice
    Layer_6.SliceCenter = Rect.new(100, 100, 100, 100)
    Layer_6.SliceScale = 0.050

    Expand_4.Name = "Expand"
    Expand_4.Parent = ColorPickerWindow
    Expand_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Expand_4.BackgroundTransparency = 1.000
    Expand_4.Position = UDim2.new(0, 6, 0, 2)
    Expand_4.Rotation = 90.000
    Expand_4.Size = UDim2.new(0, 18, 0, 18)
    Expand_4.ZIndex = 4
    Expand_4.Image = "rbxassetid://7671465363"

    Content_3.Name = "Content"
    Content_3.Parent = ColorPickerWindow
    Content_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Content_3.BackgroundTransparency = 1.000
    Content_3.ClipsDescendants = true
    Content_3.Position = UDim2.new(0, 0, 1, 0)
    Content_3.Size = UDim2.new(1, 0, 0, 178)
    Content_3.Image = "rbxassetid://3570695787"
    Content_3.ImageColor3 = Color3.fromRGB(21, 22, 23)
    Content_3.ScaleType = Enum.ScaleType.Slice
    Content_3.SliceCenter = Rect.new(100, 100, 100, 100)
    Content_3.SliceScale = 0.050

    Palette.Name = "Palette"
    Palette.Parent = Content_3
    Palette.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Palette.BackgroundTransparency = 1.000
    Palette.Position = UDim2.new(0, 10, 0, 10)
    Palette.Size = UDim2.new(1, -45, 1, -45)
    Palette.Image = "rbxassetid://698052001"

    Indicator.Name = "Indicator"
    Indicator.Parent = Palette
    Indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Indicator.BackgroundTransparency = 1.000
    Indicator.Size = UDim2.new(0, 5, 0, 5)
    Indicator.Image = "rbxassetid://2851926732"

    Saturation.Name = "Saturation"
    Saturation.Parent = Content_3
    Saturation.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Saturation.BackgroundTransparency = 1.000
    Saturation.Position = UDim2.new(1, -25, 0, 10)
    Saturation.Size = UDim2.new(0, 15, 1, -45)
    Saturation.Image = "rbxassetid://3641079629"

    Indicator_2.Name = "Indicator"
    Indicator_2.Parent = Saturation
    Indicator_2.BackgroundColor3 = Color3.fromRGB(49, 88, 146)
    Indicator_2.BorderSizePixel = 0
    Indicator_2.Size = UDim2.new(1, 0, 0, 2)

    FinalColor.Name = "FinalColor"
    FinalColor.Parent = Content_3
    FinalColor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    FinalColor.BackgroundTransparency = 1.000
    FinalColor.Position = UDim2.new(1, -25, 1, -25)
    FinalColor.Size = UDim2.new(0, 15, 0, 15)
    FinalColor.Image = "rbxassetid://3570695787"
    FinalColor.ScaleType = Enum.ScaleType.Slice
    FinalColor.SliceCenter = Rect.new(100, 100, 100, 100)
    FinalColor.SliceScale = 0.800

    SaturationColor.Name = "SaturationColor"
    SaturationColor.Parent = Content_3
    SaturationColor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SaturationColor.BackgroundTransparency = 1.000
    SaturationColor.Position = UDim2.new(1, -50, 1, -25)
    SaturationColor.Size = UDim2.new(0, 15, 0, 15)
    SaturationColor.Image = "rbxassetid://3570695787"
    SaturationColor.ScaleType = Enum.ScaleType.Slice
    SaturationColor.SliceCenter = Rect.new(100, 100, 100, 100)
    SaturationColor.SliceScale = 0.800

    PaletteColor.Name = "PaletteColor"
    PaletteColor.Parent = Content_3
    PaletteColor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PaletteColor.BackgroundTransparency = 1.000
    PaletteColor.Position = UDim2.new(1, -75, 1, -25)
    PaletteColor.Size = UDim2.new(0, 15, 0, 15)
    PaletteColor.Image = "rbxassetid://3570695787"
    PaletteColor.ScaleType = Enum.ScaleType.Slice
    PaletteColor.SliceCenter = Rect.new(100, 100, 100, 100)
    PaletteColor.SliceScale = 0.800

    TextLabel.Parent = Content_3
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.Position = UDim2.new(0, 10, 1, -35)
    TextLabel.Size = UDim2.new(1, -10, 0, 35)
    TextLabel.Font = Enum.Font.Code
    TextLabel.Text = "Selected:"
    TextLabel.TextColor3 = Color3.fromRGB(178, 178, 178)
    TextLabel.TextSize = 12.000
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left

    Dropdown.Name = "Dropdown"
    Dropdown.Parent = Presets
    Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Dropdown.BackgroundTransparency = 1.000
    Dropdown.Size = UDim2.new(0, 150, 0, 20)

    Outer_3.Name = "Outer"
    Outer_3.Parent = Dropdown
    Outer_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Outer_3.BackgroundTransparency = 1.000
    Outer_3.Size = UDim2.new(1, 0, 1, 0)
    Outer_3.Image = "rbxassetid://3570695787"
    Outer_3.ImageColor3 = Color3.fromRGB(59, 59, 68)
    Outer_3.ScaleType = Enum.ScaleType.Slice
    Outer_3.SliceCenter = Rect.new(100, 100, 100, 100)
    Outer_3.SliceScale = 0.050

    Inner_3.Name = "Inner"
    Inner_3.Parent = Outer_3
    Inner_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Inner_3.BackgroundTransparency = 1.000
    Inner_3.Position = UDim2.new(0, 2, 0, 2)
    Inner_3.Size = UDim2.new(1, -4, 1, -4)
    Inner_3.Image = "rbxassetid://3570695787"
    Inner_3.ImageColor3 = Color3.fromRGB(32, 59, 97)
    Inner_3.ScaleType = Enum.ScaleType.Slice
    Inner_3.SliceCenter = Rect.new(100, 100, 100, 100)
    Inner_3.SliceScale = 0.050

    ImageLabel_8.Parent = Inner_3
    ImageLabel_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel_8.BackgroundTransparency = 1.000
    ImageLabel_8.Position = UDim2.new(1, -26, 1, -16)
    ImageLabel_8.Size = UDim2.new(0, 16, 0, 16)
    ImageLabel_8.Image = "rbxassetid://11145100810"

    Value_2.Name = "Value"
    Value_2.Parent = Inner_3
    Value_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Value_2.BackgroundTransparency = 1.000
    Value_2.Position = UDim2.new(0, 10, 0, 0)
    Value_2.Size = UDim2.new(1, -10, 1, 0)
    Value_2.Font = Enum.Font.Code
    Value_2.Text = "Selected"
    Value_2.TextColor3 = Color3.fromRGB(255, 255, 255)
    Value_2.TextSize = 14.000
    Value_2.TextXAlignment = Enum.TextXAlignment.Left

    Text_4.Name = "Text"
    Text_4.Parent = Dropdown
    Text_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Text_4.BackgroundTransparency = 1.000
    Text_4.Position = UDim2.new(0, 158, 0, 0)
    Text_4.Size = UDim2.new(0, 56, 1, 0)
    Text_4.Font = Enum.Font.Code
    Text_4.Text = "Dropdown"
    Text_4.TextColor3 = Color3.fromRGB(255, 255, 255)
    Text_4.TextSize = 14.000
    Text_4.TextXAlignment = Enum.TextXAlignment.Left

    Cache_2.Name = "Cache"
    Cache_2.Parent = imgui2
    Cache_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Cache_2.Size = UDim2.new(0, 100, 0, 100)
    Cache_2.Visible = false

    Resizer.Name = "Resizer"
    Resizer.Parent = Presets
    Resizer.Active = true
    Resizer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Resizer.BackgroundTransparency = 1
    Resizer.AnchorPoint = Vector2.new(1, 1)
    Resizer.Position = UDim2.new(1, 0, 1, 0)
    Resizer.Size = UDim2.new(0, 15, 0, 15)
    Resizer.ZIndex = 99
    Resizer.Image = "rbxassetid://5943232811"
    Resizer.ImageColor3 = Color3.fromRGB(150, 150, 150)
    
    TextBoxContainer.Name = "TextBox"
    TextBoxContainer.Parent = Presets
    TextBoxContainer.BackgroundTransparency = 1.000
    TextBoxContainer.Size = UDim2.new(0, 200, 0, 150)
    
    TextBoxOuter.Name = "Outer"
    TextBoxOuter.Parent = TextBoxContainer
    TextBoxOuter.BackgroundTransparency = 1.000
    TextBoxOuter.Size = UDim2.new(1, 0, 1, 0)
    TextBoxOuter.Image = "rbxassetid://3570695787"
    TextBoxOuter.ImageColor3 = Color3.fromRGB(59, 59, 68)
    TextBoxOuter.ScaleType = Enum.ScaleType.Slice
    TextBoxOuter.SliceCenter = Rect.new(100, 100, 100, 100)
    TextBoxOuter.SliceScale = 0.050

    TextBoxInner.Name = "Inner"
    TextBoxInner.Parent = TextBoxOuter
    TextBoxInner.BackgroundTransparency = 1.000
    TextBoxInner.Position = UDim2.new(0, 2, 0, 2)
    TextBoxInner.Size = UDim2.new(1, -4, 1, -4)
    TextBoxInner.BackgroundColor3 = Color3.fromRGB(32, 59, 97)
    TextBoxInner.BorderSizePixel = 0
    TextBoxInner.ScrollBarThickness = 6

    LineCounter.Name = "LineCounter"
    LineCounter.Parent = TextBoxInner
    LineCounter.BackgroundTransparency = 1
    LineCounter.Size = UDim2.new(0, 30, 1, 0)
    LineCounter.Font = Enum.Font.Code
    LineCounter.Text = "1"
    LineCounter.TextColor3 = Color3.fromRGB(128, 128, 128)
    LineCounter.TextSize = 14.000
    LineCounter.TextXAlignment = Enum.TextXAlignment.Right
    LineCounter.TextYAlignment = Enum.TextYAlignment.Top

    EditorGroup.Name = "EditorGroup"
    EditorGroup.Parent = TextBoxInner
    EditorGroup.BackgroundTransparency = 1
    EditorGroup.Position = UDim2.new(0, 35, 0, 0)
    EditorGroup.Size = UDim2.new(1, -35, 1, 0)

    SyntaxLabel.Name = "SyntaxLabel"
    SyntaxLabel.Parent = EditorGroup
    SyntaxLabel.BackgroundTransparency = 1
    SyntaxLabel.Size = UDim2.new(1, 0, 1, 0)
    SyntaxLabel.Font = Enum.Font.Code
    SyntaxLabel.Text = ""
    SyntaxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SyntaxLabel.TextSize = 14.000
    SyntaxLabel.TextXAlignment = Enum.TextXAlignment.Left
    SyntaxLabel.TextYAlignment = Enum.TextYAlignment.Top
    SyntaxLabel.TextWrapped = true
    SyntaxLabel.RichText = true
    SyntaxLabel.ZIndex = 3
    
    ActualTextBox.Name = "ActualTextBox"
    ActualTextBox.Parent = EditorGroup
    ActualTextBox.BackgroundTransparency = 1
    ActualTextBox.Size = UDim2.new(1, 0, 1, 0)
    ActualTextBox.Font = Enum.Font.Code
    ActualTextBox.Text = ""
    ActualTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    ActualTextBox.TextSize = 14.000
    ActualTextBox.TextXAlignment = Enum.TextXAlignment.Left
    ActualTextBox.TextYAlignment = Enum.TextYAlignment.Top
    ActualTextBox.MultiLine = true
    ActualTextBox.TextWrapped = true
    ActualTextBox.ClearTextOnFocus = false
    ActualTextBox.ZIndex = 4
    
end

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local CoreGui = game:GetService("CoreGui")
local ScreenGui = CoreGui:FindFirstChild("Serpent | Main")
local Presets = ScreenGui:FindFirstChild("Presets")
local ScreenGuiCache = ScreenGui:FindFirstChild("Cache")

local colorpicking = false
local sliding = false
local resizing = false

local event = { } do
    function event.new()
        local event = setmetatable({ Alive = true }, { __tostring = function() return "Event" end, __call = function(...) event:Fire(...) end })
        local bindable = Instance.new("BindableEvent")
        function event:Connect(callback)
            local c = { }
            local connection = bindable.Event:Connect(callback)
            c.Connected = true
            function c:Disconnect() connection:Disconnect() c.Connected = false end
            return c
        end
        function event:Fire(...) bindable:Fire(...) end
        function event:Destroy() event.Alive = false bindable:Destroy() end
        return event
    end
end

local mouse = { } do
    mouse.held = false
    mouse.InputBegan = event.new()
    mouse.InputEnded = event.new()
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then mouse.held = true mouse.InputBegan:Fire() end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then mouse.held = false mouse.InputEnded:Fire() end
    end)
end

local function getMouse()
	return UserInputService:GetMouseLocation()
end

local function resizeTween(part, new, _delay)
	_delay = _delay or 0.5
	local tweenInfo = TweenInfo.new(_delay, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tween = game:GetService("TweenService"):Create(part, tweenInfo, new)
	tween:Play()
end

local windowHistory = { }
local windowCache = { }
local mouseCache = { }
local browsingWindow = { }

local function updateWindowHistory()
    for i, v in pairs(windowHistory) do
        local offset = 9e3 - v * 100
        i.ZIndex = rawget(windowCache[i], i) + offset
        for i2, v2 in pairs(i:GetDescendants()) do
            if pcall(function() return v2.ZIndex end) then
                if rawget(windowCache[i], v2) then
                    v2.ZIndex = rawget(windowCache[i], v2) + offset
                end
            end
        end
    end
end

local function cacheWindowHistory(window)
    rawset(windowCache, window, { })
    rawset(windowCache[window], window, window.ZIndex)
    for i, v in pairs(window:GetDescendants()) do
        if pcall(function() return v.ZIndex end) then
            rawset(windowCache[window], v, v.ZIndex)
        end
    end
    window.DescendantAdded:Connect(function(descendant)
        if pcall(function() return descendant.ZIndex end) then
            rawset(windowCache[window], descendant, descendant.ZIndex)
            updateWindowHistory()
        end
    end)
end

local function setTopMost(window)
    for i, v in pairs(windowHistory) do
        if i ~= window then
            windowHistory[i] = v + 1
        end
    end
    windowHistory[window] = 1
    updateWindowHistory()
end

local function isTopMost(window) return rawget(windowHistory, window) == 1 end
local function isBrowsing(window) return not not (rawget(browsingWindow, window) or rawget(mouseCache, window)) end

local function findBrowsingTopMost()
    local copy = { }
    for i, v in pairs(windowHistory) do
        if isBrowsing(i) then copy[i] = v end
    end
    local level, result = math.huge
    for i, v in pairs(copy) do
        if v < level then level = v result = i end
    end
    return result
end

local dragger = {} do
    local draggerCache = { }
    function dragger.new(frame)
        frame.Active = true
        frame.MouseLeave:connect(function() draggerCache[frame] = false end)
        frame.MouseEnter:connect(function() draggerCache[frame] = true end)
        mouse.InputBegan:Connect(function()
            if findBrowsingTopMost() == frame then
                if (not colorpicking) and (not sliding) and (not resizing) and rawget(draggerCache, frame) then
                    local objectPosition = getMouse() - frame.AbsolutePosition
                    while mouse.held do
                        pcall(function()
                            local newPos = getMouse() - objectPosition
                            resizeTween(frame, { Position = UDim2.fromOffset(newPos.X, newPos.Y) }, 0.1)
                        end)
                        RunService.Heartbeat:Wait()
                    end
                end
            end
        end)
    end
end

local resizer = {} do
    function resizer.new(window, handle, content, onResize)
        local isResizing = false
        handle.Active = true
        handle.MouseEnter:Connect(function() UserInputService.MouseIconEnabled = false end)
        handle.MouseLeave:Connect(function() if not isResizing then UserInputService.MouseIconEnabled = true end end)
        mouse.InputBegan:Connect(function()
            if findBrowsingTopMost() == window and not UserInputService.MouseIconEnabled then
                resizing, isResizing = true, true
                local startMousePos = getMouse()
                local startWindowSize = window.AbsoluteSize
                local startContentSize = content.AbsoluteSize
                
                while mouse.held do
                    local delta = getMouse() - startMousePos
                    local newX = math.max(200, startWindowSize.X + delta.X)
                    local newY_Content = math.max(100, startContentSize.Y + delta.Y)
                    window.Size = UDim2.fromOffset(newX, window.Size.Y.Offset)
                    content.Size = UDim2.new(1, 0, 0, newY_Content)
                    if onResize then onResize(window.Size.Y.Offset + content.Size.Y.Offset) end
                    RunService.Heartbeat:Wait()
                end
                isResizing, resizing = false, false
                UserInputService.MouseIconEnabled = true
            end
        end)
    end
end

local function betweenOpenInterval(n, n1, n2) return n <= n2 and n >= n1 end
local function betweenClosedInterval(n, n1, n2) return n < n2 and n > n1 end

local function rgbtohsv(color)
	local r, g, b = color.R, color.G, color.B; local max, min = math.max(r, g, b), math.min(r, g, b)
	local h, s, v; v = max; local d = max - min
	if max == 0 then s = 0 else s = d / max end
	if max == min then h = 0 else
		if max == r then h = (g - b) / d if g < b then h = h + 6 end
		elseif max == g then h = (b - r) / d + 2
		elseif max == b then h = (r - g) / d + 4 end
		h = h / 6
	end
	return h, s, v
end

local function new(n) return Presets:FindFirstChild(n):Clone() end
local function tint(c) return Color3.new(c.R * 0.5, c.G * 0.5, c.B * 0.5) end
local function bleach(c) return Color3.new(c.R * 1.2, c.G * 1.2, c.B * 1.2) end

local function hoverColor(object)
    local originalColor = object.ImageColor3
    object.MouseEnter:Connect(function() resizeTween(object, {ImageColor3 = tint(originalColor)}, 0.2) end)
    object.MouseLeave:Connect(function() resizeTween(object, {ImageColor3 = originalColor}, 0.2) end)
end

local settings = {
    new = function(default)
        local function l(r) return tostring(r):lower() end
        return { handle = function(options)
            local self = { }
            options = typeof(options) == "table" and options or { }
            for i, v in pairs(default) do self[l(i)] = v end
            for i, v in pairs(options) do
                if typeof(default[l(i)]) == typeof(options[l(i)]) or default[l(i)] == nil then
                    self[l(i)] = v
                end
            end
            return self
        end }
    end,
}

local CoreLibrary
CoreLibrary = {
    new = function(options)
        local cache = { }
        local self = { isopen = true }

        options = settings.new({
            text = "New Window", size = Vector2.new(300, 200), shadow = 10, transparency = 0.2,
            color = Color3.fromRGB(41, 74, 122), boardcolor = Color3.fromRGB(21, 22, 23),
            rounding = 5, animation = 0.1, position = UDim2.new(0, 100, 0, 100), resizable = false
        }).handle(options)

        local main = new("Main") main.Parent = ScreenGui
        local content = main:FindFirstChild("Content")
        local tabs = main:FindFirstChild("Tabs")
        local shadow = main:FindFirstChild("Shadow")
        local layer = main:FindFirstChild("Layer")
        local expand = main:FindFirstChild("Expand")

        main.Position = options.position
        content.ImageTransparency, layer.ImageTransparency = options.transparency, options.transparency
        shadow.ImageTransparency = 0.6 * (options.transparency + 1)

        expand.MouseButton1Click:Connect(function() self.isopen and self.close() or self.open() end)

        dragger.new(main)
        main:FindFirstChild("Title").Text = options.text
        main.ImageColor3 = options.color
        main:FindFirstChild("Frame").BackgroundColor3 = options.color
        main.Size = UDim2.new(0, options.size.X, 0, main.Size.Y.Offset)
        main.SliceScale = options.rounding / 100
        content.ImageColor3 = options.boardcolor
        content.Size = UDim2.new(1, 0, 0, options.size.Y)
        content.SliceScale = options.rounding / 100
        
        function cache.update_layers(y)
            shadow.Position = UDim2.new(0, options.shadow, 0, options.shadow)
            shadow.Size = UDim2.new(1, 0, 0, y)
            shadow.SliceScale = options.rounding / 100
            layer.Size = UDim2.new(1, 0, 0, y)
            layer.SliceScale = options.rounding / 100
        end cache.update_layers(main.Size.Y.Offset + content.Size.Y.Offset)
        content:GetPropertyChangedSignal("Size"):Connect(function() cache.update_layers(main.Size.Y.Offset + content.Size.Y.Offset) end)
        
        if options.resizable then
            local resizeHandle = new("Resizer")
            resizeHandle.Parent = content
            resizer.new(main, resizeHandle, content, cache.update_layers)
        end

        function self.new(tabOptions)
            local self = { }
            tabOptions = settings.new({ text = "New Tab" }).handle(tabOptions)
            local tabbutton, tabbuttons = new("TabButton"), tabs:FindFirstChild("Items")
            tabbutton.Parent, tabbutton.Text = tabbuttons, tabOptions.text
            tabbutton.Size = UDim2.new(0, tabbutton.TextBounds.X, 1, 0)
            tabbutton.TextColor3 = Color3.new(0.4, 0.4, 0.4)
            tabbutton.MouseButton1Click:Connect(function() self.show() end)
            local tab = new("Tab"); tab.Parent, tab.Visible = content, false
            local items = tab:FindFirstChild("Items")

            local function countSize(o, horizontal)
                if not o:FindFirstChildOfClass("UIListLayout") then return end
                local padding = o:FindFirstChildOfClass("UIListLayout").Padding.Offset
                local X, Y, _horizontal = 0, 0, 0
                for _, v in pairs(o:GetChildren()) do
                    if not v:IsA("UIListLayout") then
                        Y = Y + v.AbsoluteSize.Y + padding
                        if v.AbsoluteSize.X > X then X = v.AbsoluteSize.X end
                        _horizontal = _horizontal + v.AbsoluteSize.X + padding
                    end
                end
                if horizontal then return Vector2.new(_horizontal, 0) end
                return Vector2.new(X, Y)
            end

            local function updateCanvas() if countSize(items) then items.CanvasSize = UDim2.fromOffset(countSize(items).X, countSize(items).Y) end end
            items.ChildAdded:Connect(updateCanvas)
            items.ChildRemoved:Connect(updateCanvas)

            local types = { } do
                function types.label(labelOptions)
                    local self = {}
                    labelOptions = settings.new({ text = "New Label", color = Color3.new(1, 1, 1) }).handle(labelOptions)
                    local label = new("Label")
                    label.Parent, label.Text, label.TextColor3 = items, labelOptions.text, labelOptions.color
                    label.Size = UDim2.new(0, label.TextBounds.X, 0, label.Size.Y.Offset)
                    function self.setText(text) label.Text = text label.Size = UDim2.new(0, label.TextBounds.X, 0, label.Size.Y.Offset) end
                    function self.setColor(color) label.TextColor3 = color end
                    function self:Destroy() label:Destroy() end
                    self.self = label
                    return self
                end
                function types.button(buttonOptions)
                    local self = { eventBlock = false }
                    buttonOptions = settings.new({ text = "New Button", color = options.color, rounding = options.rounding }).handle(buttonOptions)
                    local button = new("Button")
                    button.Parent, button.Text = items, buttonOptions.text
                    button.Size = UDim2.new(0, button.TextBounds.X + 20, 0, 20)
                    button.MouseButton1Click:Connect(function() if not self.eventBlock then self.event:Fire() end end)
                    local ImageLabel, Layer = button:FindFirstChild("ImageLabel"), button:FindFirstChild("Layer")
                    ImageLabel.ImageColor3, Layer.ImageColor3 = buttonOptions.color, tint(buttonOptions.color)
                    ImageLabel.SliceScale, Layer.SliceScale = buttonOptions.rounding / 100, buttonOptions.rounding / 100
                    hoverColor(ImageLabel)
                    function self.setColor(color) ImageLabel.ImageColor3 = color Layer.ImageColor3 = tint(color) end
                    function self:Destroy() button:Destroy() end
                    self.self, self.event = button, event.new()
                    return self
                end
                function types.textbox(textboxOptions)
                    local self = {}
                    textboxOptions = settings.new({ text = "", size = Vector2.new(250, 150), syntax = false, linecounter = false, lc = false, color = options.color, rounding = options.rounding }).handle(textboxOptions)
                    textboxOptions.linecounter = textboxOptions.linecounter or textboxOptions.lc
                    
                    local textbox = new("TextBox")
                    textbox.Parent, textbox.Size = items, UDim2.fromOffset(textboxOptions.size.X, textboxOptions.size.Y)
                    
                    local outer, inner = textbox:FindFirstChild("Outer"), textbox:FindFirstChild("Outer"):FindFirstChild("Inner")
                    local lineCounter, editorGroup = inner:FindFirstChild("LineCounter"), inner:FindFirstChild("EditorGroup")
                    local syntaxLabel, actualTextBox = editorGroup:FindFirstChild("SyntaxLabel"), editorGroup:FindFirstChild("ActualTextBox")

                    outer.SliceScale, inner.BackgroundColor3, actualTextBox.Text = textboxOptions.rounding / 100, textboxOptions.color, textboxOptions.text
                    
                    lineCounter.Visible = textboxOptions.linecounter
                    if not textboxOptions.linecounter then editorGroup.Position, editorGroup.Size = UDim2.fromOffset(0,0), UDim2.new(1,0,1,0) end
                    
                    function self.setText(text) actualTextBox.Text = text actualTextBox:ReleaseFocus() end
                    function self.getText() return actualTextBox.Text end
                    
                    local function updateEditorCanvas()
                        local editorWidth = editorGroup.AbsoluteSize.X
                        if editorWidth <= 0 then return end

                        local textBounds = TextService:GetTextSize(actualTextBox.Text, actualTextBox.TextSize, actualTextBox.Font, Vector2.new(editorWidth, math.huge))
                        local newHeight = math.max(inner.AbsoluteSize.Y - 6, textBounds.Y + 6)
                        
                        syntaxLabel.Size = UDim2.fromOffset(editorWidth, newHeight)
                        actualTextBox.Size = UDim2.fromOffset(editorWidth, newHeight)
                        lineCounter.Size = UDim2.new(0, lineCounter.Size.X.Offset, 0, newHeight)
                        inner.CanvasSize = UDim2.fromOffset(0, newHeight)
                    end

                    if textboxOptions.syntax then
                        local syntaxPatterns = {
                            ["(and|break|do|else|elseif|end|false|for|function|if|in|local|nil|not|or|repeat|return|then|true|until|while)"] = '<font color="#C586C0">%1</font>',
                            ["(self|game|workspace|script|wait|print|error|typeof|pcall|ypcall|xpcall|setclipboard|getclipboard|readfile|writefile)"] = '<font color="#4FC1FF">%1</font>',
                            ["([%d%.]+)"] = '<font color="#B5CEA8">%1</font>',
                            ['(".-")'] = '<font color="#CE9178">%1</font>',
                            ["('.-')"] = "<font color='#CE9178'>%1</font>",
                            ["(--.-)\n"] = "<font color='#6A9955'>%1</font>\n",
                        }
                        local function highlight(text)
                            text = text:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
                            for pattern, replacement in pairs(syntaxPatterns) do text = text:gsub(pattern, replacement) end
                            return text
                        end
                        
                        syntaxLabel.Visible, actualTextBox.TextTransparency = true, 0.5
                        actualTextBox:GetPropertyChangedSignal("Text"):Connect(function() syntaxLabel.Text = highlight(actualTextBox.Text) end)
                    else syntaxLabel.Visible = false end
                    
                    if textboxOptions.linecounter then
                        local function updateLineCount()
                            local _, count = actualTextBox.Text:gsub("\n", "")
                            local numbers = {}
                            for i = 1, count + 1 do table.insert(numbers, tostring(i)) end
                            lineCounter.Text = table.concat(numbers, "\n")
                        end
                        updateLineCount()
                        actualTextBox:GetPropertyChangedSignal("Text"):Connect(updateLineCount)
                    end

                    actualTextBox:GetPropertyChangedSignal("Text"):Connect(updateEditorCanvas)
                    inner:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateEditorCanvas)
                    task.wait()
                    updateEditorCanvas()
                    
                    function self:Destroy() textbox:Destroy() end
                    self.self = textbox
                    return self
                end
                function types.switch(switchOptions) -- Kept other elements for completeness
                    local self = { on = false }
                    switchOptions = settings.new({ text = "New Switch", on = false, color = options.color, rounding = options.rounding, animation = options.animation }).handle(switchOptions)
                    self.on, self.eventBlock = switchOptions.on, false
                    local switch, button, text = new("Switch"), switch:FindFirstChild("Button"), switch:FindFirstChild("Text")
                    switch.Parent = items
                    local check, ImageLabel, layer = button:FindFirstChild("Check"), button:FindFirstChild("ImageLabel"), button:FindFirstChild("Layer")
                    ImageLabel.ImageColor3, layer.ImageColor3, ImageLabel.SliceScale, layer.SliceScale = switchOptions.color, tint(switchOptions.color), switchOptions.rounding / 100, switchOptions.rounding / 100
                    text:GetPropertyChangedSignal("Text"):Connect(function() switch.Size = UDim2.new(0, 28 + text.TextBounds.X, 0, 20) end)
                    text.Text, check.ImageTransparency = switchOptions.text, self.on and 0 or 1
                    button.MouseButton1Click:Connect(function() self.set(not self.on) end)
                    function self.set(boolean) if (not not boolean) == self.on then return end; self.on = not not boolean; resizeTween(check, { ImageTransparency = self.on and 0 or 1 }, switchOptions.animation); if not self.eventBlock then self.event:Fire(self.on) end end
                    function self.setColor(color) ImageLabel.ImageColor3 = color; Layer.ImageColor3 = tint(color) end
                    function self:Destroy() switch:Destroy() end
                    self.self, self.event = switch, event.new()
                    return self
                end
                function types.slider(sliderOptions)
                    local self = { }
                    sliderOptions = settings.new({ text = "New Slider", size = 150, min = 0, max = 100, value = 0, color = options.color, barcolor = bleach(options.color), rounding = options.rounding, animation = options.animation, }).handle(sliderOptions)
                    self.value, self.event, self.eventBlock = sliderOptions.value, event.new(), false
                    local slider, text, outer, inner = new("Slider"), slider:FindFirstChild("Text"), slider:FindFirstChild("Outer"), outer:FindFirstChild("Inner")
                    slider.Parent = items
                    local _slider, value = inner:FindFirstChild("Slider"), inner:FindFirstChild("Value")
                    inner.ClipsDescendants, outer.SliceScale, inner.SliceScale = true, sliderOptions.rounding / 100, sliderOptions.rounding / 100
                    inner.ImageColor3, _slider.BackgroundColor3 = sliderOptions.color, sliderOptions.barcolor
                    function self.setColor(color) inner.ImageColor3 = color; _slider.BackgroundColor3 = bleach(color) end
                    text.Text, outer.Size, text.Position = sliderOptions.text, UDim2.new(0, sliderOptions.size, 0, 20), UDim2.new(0, sliderOptions.size + 8, 0, 0)
                    slider.Size = UDim2.new(0, sliderOptions.size + 8 + text.TextBounds.X, 0, 20)
                    function self.set(n)
                        n = math.clamp(n, math.min(sliderOptions.min, sliderOptions.max), math.max(sliderOptions.min, sliderOptions.max))
                        if self.value ~= n then if not self.eventBlock then self.event:Fire(n) end end; self.value = n
                        value.Text = string.format("%.2f", n); local d = math.abs(sliderOptions.max - sliderOptions.min)
                        resizeTween(_slider, { Position = UDim2.new((n - sliderOptions.min) / d, -2.5, 0, 0) }, sliderOptions.animation)
                    end; self.set(self.value)
                    local inside = false; inner.MouseEnter:Connect(function() inside = true end); inner.MouseLeave:Connect(function() inside = false end)
                    mouse.InputBegan:Connect(function()
                        task.spawn(function()
                            if inside and isTopMost(main) then
                                while mouse.held do sliding = true; local x = math.clamp((getMouse().X - inner.AbsolutePosition.X), 0, sliderOptions.size); local m = sliderOptions.size / math.abs(sliderOptions.max - sliderOptions.min); self.set((x / m) + sliderOptions.min); RunService.Heartbeat:Wait() end
                            end; sliding = false
                        end)
                    end)
                    function self:Destroy() slider:Destroy() end
                    self.self = slider; return self
                end
            end

            function self.new(type, typeOptions)
                type = type:lower()
                local p = rawget(types, type); assert(p, "invalid type")
                local o = p(typeOptions); o.type = type
                if o.type == "folder" then o.updated:Connect(updateCanvas) end
                return setmetatable(o, { __index = function(s, idx) return rawget(rawget(s, "event"), idx) end, __newindex = function()end })
            end

            function self.show()
                for _, v in pairs(tabbuttons:GetChildren()) do if not v:IsA("UIListLayout") then resizeTween(v, { TextColor3 = Color3.new(0.4, 0.4, 0.4) }, options.animation) end end
                for _, v in pairs(content:GetChildren()) do if v.Name == "Tab" then v.Visible = false end end
                resizeTween(tabbutton, { TextColor3 = Color3.new(1, 1, 1) }, options.animation); tab.Visible = true
            end
            self.show()
            return self
        end

        function self.close()
            if not self.isopen then return end; self.isopen = false
            resizeTween(expand, { Rotation = 0 }, options.animation)
            cache.content_size, cache.tabs_size = content.Size.Y.Offset, tabs.Size.Y.Offset
            resizeTween(content, { Size = UDim2.new(1, 0, 0, 0) }, options.animation)
            resizeTween(tabs, { Size = UDim2.new(1, 0, 0, 0) }, options.animation)
        end
        function self.open()
            if self.isopen then return end; self.isopen = true
            resizeTween(expand, { Rotation = 90 }, options.animation)
            resizeTween(content, { Size = UDim2.new(1, 0, 0, cache.content_size) }, options.animation)
            resizeTween(tabs, { Size = UDim2.new(1, 0, 0, cache.tabs_size) }, options.animation)
        end
        function self.setPosition(pos) main.Position = pos end
        local old_anim = options.animation; options.animation = 0; self.close(); options.animation = old_anim

        self.self = main -- Expose the main frame
        return self
    end,
}

local Serpent = {}
local Serpent_Window = { __index = Serpent_Window }
local Serpent_Tab = { __index = Serpent_Tab }

function Serpent.Window(options)
    local self = setmetatable({}, Serpent_Window)
    self.core = CoreLibrary.new(options)
    self.tabs = {}
    return self
end

function Serpent_Window:Tab(options)
    if type(options) == "string" then options = { text = options } end
    local coreTab = self.core:new(options)
    local tab = setmetatable({ core = coreTab, window = self }, Serpent_Tab)
    table.insert(self.tabs, tab)
    if #self.tabs == 1 then tab:Show() end
    return tab
end

function Serpent_Tab:Button(options, callback)
    if type(options) == "string" then options = { text = options } end
    local button = self.core.new(self.core, "button", options)
    if callback then button.event:Connect(callback) end
    return button
end

function Serpent_Tab:Label(options)
    if type(options) == "string" then options = { text = options } end
    return self.core.new(self.core, "label", options)
end

function Serpent_Tab:Switch(options, callback)
    if type(options) == "string" then options = { text = options } end
    local switch = self.core.new(self.core, "switch", options)
    if callback then switch.event:Connect(callback) end
    return switch
end

function Serpent_Tab:Slider(options, callback)
    if type(options) == "string" then options = { text = options } end
    local slider = self.core.new(self.core, "slider", options)
    if callback then slider.event:Connect(callback) end
    return slider
end

function Serpent_Tab:TextBox(options)
    return self.core.new(self.core, "textbox", options)
end

function Serpent_Tab:Show()
    self.core.show(self.core)
end

do -- window history zindex
    ScreenGui.ChildAdded:Connect(function(window)
        if window:IsA("ImageLabel") and window:FindFirstChild("Content") then
            window.MouseEnter:Connect(function() mouseCache[window] = true end)
            window:FindFirstChild("Content").MouseEnter:Connect(function() browsingWindow[window] = true end)
            window.MouseLeave:Connect(function() mouseCache[window] = false end)
            window:FindFirstChild("Content").MouseLeave:Connect(function() browsingWindow[window] = false end)
            
            cacheWindowHistory(window)
            for i in pairs(windowHistory) do windowHistory[i] = windowHistory[i] + 1 end
            windowHistory[window] = 1
            updateWindowHistory()
        end
    end)
    
    ScreenGui.ChildRemoved:Connect(function(window)
        if windowHistory[window] then
            local removedZ = windowHistory[window]
            windowHistory[window] = nil
            windowCache[window] = nil
            mouseCache[window] = nil
            browsingWindow[window] = nil
            for i, z in pairs(windowHistory) do
                if z > removedZ then windowHistory[i] = z - 1 end
            end
            updateWindowHistory()
        end
    end)

    mouse.InputBegan:Connect(function()
        task.wait()
        if not (colorpicking or sliding or resizing) then
            local lastZIndex, focused = math.huge
            for i, v in pairs(mouseCache) do
                if v and windowHistory[i] and windowHistory[i] < lastZIndex then
                    lastZIndex, focused = windowHistory[i], i
                end
            end
            if focused then setTopMost(focused) end
        end
    end)
end

return Serpent
