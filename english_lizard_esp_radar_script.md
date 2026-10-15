-- Professional Lizard/Dhan ESP Radar Script for Roblox
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Clean up any existing UI instances to avoid duplicates
pcall(function()
    if CoreGui:FindFirstChild("DhanProRadar") then
        CoreGui.DhanProRadar:Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DhanProRadar"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 210, 0, 55)
MainFrame.Position = UDim2.new(0.03, 0, 0.32, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🐊 Lizard Radar [Active]"
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Parent = MainFrame

-- Deep recursive scanning function to search inside map folders
local function scanFolder(parentObj)
    for _, obj in ipairs(parentObj:GetChildren()) do
        pcall(function()
            local name = string.lower(obj.Name)
            
            -- Targeted keywords for matching target models/parts
            if name:find("ضب") or name:find("lizard") or name:find("dhan") or name:find("dab") or name:find("rish") then
                local character = LocalPlayer.Character
                local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                
                if rootPart then
                    local target = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                    if target then
                        local distance = (rootPart.Position - target.Position).Magnitude
                        if distance <= 800 then
                            if not target:FindFirstChild("ProDhanESP") then
                                local esp = Instance.new("BillboardGui")
                                esp.Name = "ProDhanESP"
                                esp.Size = UDim2.new(0, 90, 0, 35)
                                esp.StudsOffset = Vector3.new(0, 3, 0)
                                esp.AlwaysOnTop = true

                                local txt = Instance.new("TextLabel")
                                txt.Size = UDim2.new(1, 0, 1, 0)
                                txt.BackgroundTransparency = 1
                                txt.Text = "Lizard 🎯"
                                txt.TextColor3 = Color3.fromRGB(0, 255, 0)
                                txt.TextScaled = true
                                txt.Font = Enum.Font.SourceSansBold
                                txt.TextStrokeTransparency = 0
                                txt.Parent = esp

                                esp.Parent = target
                            end
                        end
                    end
                end
            end
            
            -- Recurse through sub-folders/models
            if #obj:GetChildren() > 0 and not obj:IsA("Player") then
                scanFolder(obj)
            end
        end)
    end
end

task.spawn(function()
    while true do
        task.wait(0.8)
        pcall(function()
            scanFolder(Workspace)
        end)
    end
end)