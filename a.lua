local players = game:GetService("Players")
local player = players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 600, 0, 450)
frame.Position = UDim2.new(0.5, -300, 0.5, -225)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
title.BorderSizePixel = 0
title.Text = "luau executor"
title.TextColor3 = Color3.fromRGB(200, 200, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = frame

local box = Instance.new("TextBox")
box.Size = UDim2.new(1, -20, 1, -120)
box.Position = UDim2.new(0, 10, 0, 60)
box.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
box.TextColor3 = Color3.fromRGB(220, 220, 255)
box.ClearTextOnFocus = false
box.MultiLine = true
box.TextWrapped = true
box.Font = Enum.Font.Code
box.TextSize = 16
box.RichText = true
box.PlaceholderText = "-- write your code here"
box.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -20, 0, 50)
button.Position = UDim2.new(0, 10, 1, -60)
button.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
button.BorderSizePixel = 0
button.Text = "execute"
button.TextColor3 = Color3.fromRGB(200, 200, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 18
button.Parent = frame

local settingsButton = Instance.new("TextButton")
settingsButton.Size = UDim2.new(0, 120, 0, 35)
settingsButton.Position = UDim2.new(1, -130, 0, 10)
settingsButton.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
settingsButton.BorderSizePixel = 0
settingsButton.Text = "settings"
settingsButton.TextColor3 = Color3.fromRGB(200, 200, 255)
settingsButton.Font = Enum.Font.SourceSans
settingsButton.TextSize = 16
settingsButton.Parent = frame

local colors = {
    globals = Color3.fromRGB(255, 100, 150),
    keywords = Color3.fromRGB(150, 200, 255),
    strings = Color3.fromRGB(255, 200, 150),
    numbers = Color3.fromRGB(180, 255, 180),
    booleans = Color3.fromRGB(255, 180, 180),
    comments = Color3.fromRGB(120, 120, 120),
    nils = Color3.fromRGB(255, 150, 150)
}

local globals = {"game","workspace","players","script","tick","math","table","string"}
local keywords = {"and","break","do","else","elseif","end","for","function","if","in","local","not","or","repeat","return","then","until","while"}
local booleans = {"true","false"}
local nils = {"nil"}

local function highlight(text)
    text = text:gsub("(%-%-.-)\n", function(c) return "<font color=\"rgb("..colors.comments.R*255..","..colors.comments.G*255..","..colors.comments.B*255..")\">" .. c .. "</font>\n" end)
    text = text:gsub("(['\"][^'\"]*['\"])", function(c) return "<font color=\"rgb("..colors.strings.R*255..","..colors.strings.G*255..","..colors.strings.B*255..")\">" .. c .. "</font>" end)
    for _, g in pairs(globals) do
        text = text:gsub("(%f[%w_]"..g.."%f[%W])", "<font color=\"rgb("..colors.globals.R*255..","..colors.globals.G*255..","..colors.globals.B*255..")\">%1</font>")
    end
    for _, k in pairs(keywords) do
        text = text:gsub("(%f[%w_]"..k.."%f[%W])", "<font color=\"rgb("..colors.keywords.R*255..","..colors.keywords.G*255..","..colors.keywords.B*255..")\">%1</font>")
    end
    for _, b in pairs(booleans) do
        text = text:gsub("(%f[%w_]"..b.."%f[%W])", "<font color=\"rgb("..colors.booleans.R*255..","..colors.booleans.G*255..","..colors.booleans.B*255..")\">%1</font>")
    end
    for _, n in pairs(nils) do
        text = text:gsub("(%f[%w_]"..n.."%f[%W])", "<font color=\"rgb("..colors.nils.R*255..","..colors.nils.G*255..","..colors.nils.B*255..")\">%1</font>")
    end
    text = text:gsub("(%d+%.?%d*)", function(c) return "<font color=\"rgb("..colors.numbers.R*255..","..colors.numbers.G*255..","..colors.numbers.B*255..")\">"..c.."</font>" end)
    return text
end

box:GetPropertyChangedSignal("Text"):Connect(function()
    local pos = box.CursorPosition
    local text = highlight(box.Text)
    box.Text = text
    box.CursorPosition = pos
end)

settingsButton.MouseButton1Click:Connect(function()
    if colors.globals == Color3.fromRGB(255,100,150) then
        colors.globals = Color3.fromRGB(255,255,100)
    elseif colors.globals == Color3.fromRGB(255,255,100) then
        colors.globals = Color3.fromRGB(255,180,180)
    else
        colors.globals = Color3.fromRGB(255,100,150)
    end
end)

button.MouseButton1Click:Connect(function()
    loadstring(box.Text)()
end)
