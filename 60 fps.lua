local ScreenGui = Instance.new("ScreenGui")
local ToggleUIButton = Instance.new("TextButton")
local RemoveGraphicsButton = Instance.new("TextButton")
local BlackScreen = Instance.new("Frame")
local CreatorText = Instance.new("TextLabel")
local LoadingText = Instance.new("TextLabel")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "GraphicsControl"

ToggleUIButton.Size = UDim2.new(0, 100, 0, 50)
ToggleUIButton.Position = UDim2.new(0, 10, 0, 10)
ToggleUIButton.Text = "Toggle UI"
ToggleUIButton.Parent = ScreenGui

RemoveGraphicsButton.Size = UDim2.new(0, 200, 0, 50)
RemoveGraphicsButton.Position = UDim2.new(0.5, -100, 0.5, -25)
RemoveGraphicsButton.Text = "Remove All Graphics"
RemoveGraphicsButton.Visible = false
RemoveGraphicsButton.Parent = ScreenGui

BlackScreen.Size = UDim2.new(1, 0, 1, 0)
BlackScreen.BackgroundColor3 = Color3.new(0, 0, 0)
BlackScreen.Parent = ScreenGui

CreatorText.Size = UDim2.new(1, 0, 1, 0)
CreatorText.Text = "เฟรนด์เป็นผู้สร้าง"
CreatorText.TextSize = 50
CreatorText.TextColor3 = Color3.new(0, 1, 0) -- Green color for hacker effect
CreatorText.BackgroundTransparency = 1
CreatorText.Font = Enum.Font.SourceSansBold
CreatorText.TextStrokeTransparency = 0.5
CreatorText.TextStrokeColor3 = Color3.new(0, 1, 0)
CreatorText.Parent = BlackScreen

LoadingText.Size = UDim2.new(1, 0, 0, 50)
LoadingText.Position = UDim2.new(0, 0, 1, -50)
LoadingText.Text = "กรุณารอ 2 วิ เพื่ออัพโหลดโปรแกรม"
LoadingText.TextSize = 20
LoadingText.TextColor3 = Color3.new(0, 1, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Font = Enum.Font.SourceSans
LoadingText.TextStrokeTransparency = 0.5
LoadingText.TextStrokeColor3 = Color3.new(0, 1, 0)
LoadingText.Parent = BlackScreen

task.spawn(function()
    while BlackScreen.Parent do
        CreatorText.TextTransparency = math.random(0, 15) / 100
        LoadingText.TextTransparency = math.random(0, 15) / 100
        task.wait(0.1)
    end
end)

task.wait(2)
BlackScreen:Destroy()

local function removeGraphics()
    local Lighting = game:GetService("Lighting")
    Lighting.TimeOfDay = "12:00:00"
    Lighting.Brightness = 2
    Lighting.GlobalShadows = false
    local Terrain = workspace:FindFirstChildOfClass("Terrain")
    if Terrain then
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 1
        Terrain.WaterWaveSize = 0
    end
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.CastShadow = false
            obj.Reflectance = 0
            if obj.Parent:FindFirstChild("Humanoid") then
                obj.Parent.Humanoid.WalkSpeed = 16
                obj.Parent.Humanoid.JumpPower = 50
                obj.Parent.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                obj.Parent.Humanoid.Animator:Destroy()
            end
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
            obj.Enabled = false
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            obj.Transparency = 1
        end
    end
end

ToggleUIButton.MouseButton1Click:Connect(function()
    RemoveGraphicsButton.Visible = not RemoveGraphicsButton.Visible
end)

RemoveGraphicsButton.MouseButton1Click:Connect(removeGraphics)
