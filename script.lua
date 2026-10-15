local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

pcall(function()
    if CoreGui:FindFirstChild("DhanUltimateRadar") then
        CoreGui.DhanUltimateRadar:Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DhanUltimateRadar"
ScreenGui.Parent = CoreGui

-- Main Menu Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 240, 0, 220)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Title Bar with Name krm3mk
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 35)
TitleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleLabel.Text = "🐊 krm3mk - Radar Menu"
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleLabel

-- Toggle Visibility Button (RightControl)
local toggleKey = Enum.KeyCode.RightControl
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == toggleKey then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- Speed Hack Section
local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(0, 200, 0, 35)
SpeedBox.Position = UDim2.new(0.1, 0, 0.25, 0)
SpeedBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.PlaceholderText = "اكتب السرعة هنا (مثال: 50)"
SpeedBox.Text = ""
SpeedBox.TextScaled = true
SpeedBox.Font = Enum.Font.SourceSans
SpeedBox.Parent = MainFrame

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 6)
SpeedCorner.Parent = SpeedBox

SpeedBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local val = tonumber(SpeedBox.Text)
        if val and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = val
        end
    end
end)

-- Distance Box Section
local DistBox = Instance.new("TextBox")
DistBox.Size = UDim2.new(0, 200, 0, 35)
DistBox.Position = UDim2.new(0.1, 0, 0.45, 0)
DistBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
DistBox.TextColor3 = Color3.fromRGB(255, 255, 255)
DistBox.PlaceholderText = "مدى الرادار بالمتر (مثال: 1500)"
DistBox.Text = "1500"
DistBox.TextScaled = true
DistBox.Font = Enum.Font.SourceSans
DistBox.Parent = MainFrame

local DistCorner = Instance.new("UICorner")
DistCorner.CornerRadius = UDim.new(0, 6)
DistCorner.Parent = DistBox

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 40)
StatusLabel.Position = UDim2.new(0, 0, 0.7, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "زر الإخفاء/الإظهار: RightControl"
StatusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
StatusLabel.TextScaled = true
StatusLabel.Font = Enum.Font.SourceSansItalic
StatusLabel.Parent = MainFrame

-- Scanner Logic
local function scanFolder(parentObj)
    for _, obj in ipairs(parentObj:GetChildren()) do
        pcall(function()
            local name = string.lower(obj.Name)
            local maxDist = tonumber(DistBox.Text) or 1500
            
            -- فحص الكائنات ومطابقة الأسماء المخصوصة والندرات
            if name:find("ضب") or name:find("ألماس") or name:find("الشعري") or name:find("الطود") or name:find("التنين") or name:find("سلطان") or name:find("lizard") or name:find("dhan") or name:find("خرافي") or name:find("أسطوري") or name:find("فاخر") or obj:IsA("Model") then
                if obj ~= LocalPlayer.Character and not Players:GetPlayerFromCharacter(obj) then
                    local character = LocalPlayer.Character
                    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                    
                    if rootPart then
                        local target = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                        if target then
                            local distance = (rootPart.Position - target.Position).Magnitude
                            if distance <= maxDist then
                                local rarityText = "خرافي"
                                local rarityColor = Color3.fromRGB(235, 60, 60) -- أحمر خفيف للـ خرافي والأنواع الخاصة

                                -- تمييز الأسماء المخصوصة
                                if name:find("الشعري") then
                                    rarityText = "🔥 ضب الشعري (خرافي)"
                                elseif name:find("طود") or name:find("الطود") then
                                    rarityText = "⚡ الطَّود (خرافي)"
                                elseif name:find("تنين") or name:find("التنين") then
                                    rarityText = "🐉 ضب التنين (خرافي)"
                                elseif name:find("سلطان") then
                                    rarityText = "👑 سلطان الأقاصي (خرافي)"
                                elseif name:find("ألماس") or name:find("الماس") then
                                    rarityText = "💎 ضب الألماس (خرافي)"
                                elseif name:find("أسطوري") or name:find("astoori") then
                                    rarityText = "أسطوري"
                                    rarityColor = Color3.fromRGB(255, 140, 0) -- برتقالي
                                elseif name:find("فاخر") or name:find("fakher") then
                                    rarityText = "فاخر"
                                    rarityColor = Color3.fromRGB(160, 32, 240) -- بنفسجي
                                end

                                -- فحص إذا كان هناك Humanoid لقراءة الدم
                                local healthText = ""
                                local hum = obj:FindFirstChildWhichIsA("Humanoid") or target.Parent:FindFirstChildWhichIsA("Humanoid")
                                if hum then
                                    healthText = "\n❤️ الدم: " .. math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth)
                                end

                                if not target:FindFirstChild("DhanESP") then
                                    local esp = Instance.new("BillboardGui")
                                    esp.Name = "DhanESP"
                                    esp.Size = UDim2.new(0, 140, 0, 55)
                                    esp.StudsOffset = Vector3.new(0, 3.5, 0)
                                    esp.AlwaysOnTop = true

                                    local txt = Instance.new("TextLabel")
                                    txt.Name = "ESPText"
                                    txt.Size = UDim2.new(1, 0, 1, 0)
                                    txt.BackgroundTransparency = 1
                                    txt.Text = rarityText .. " 🎯\n[" .. math.floor(distance) .. "م]" .. healthText
                                    txt.TextColor3 = rarityColor
                                    txt.TextScaled = true
                                    txt.Font = Enum.Font.SourceSansBold
                                    txt.TextStrokeTransparency = 0.3
                                    txt.Parent = esp

                                    esp.Parent = target
                                else
                                    local esp = target:FindFirstChild("DhanESP")
                                    if esp and esp:FindFirstChild("ESPText") then
                                        esp.ESPText.Text = rarityText .. " 🎯\n[" .. math.floor(distance) .. "م]" .. healthText
                                        esp.ESPText.TextColor3 = rarityColor
                                    end
                                end
                            end
                        end
                    end
                end
            end
            
            if #obj:GetChildren() > 0 then
                scanFolder(obj)
            end
        end)
    end
end

task.spawn(function()
    while true do
        task.wait(0.4)
        pcall(function()
            scanFolder(Workspace)
        end)
    end
end)
