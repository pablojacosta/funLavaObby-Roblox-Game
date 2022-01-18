local RotatingPartsModule = {}

local TweenService = game:GetService("TweenService")

function RotatingPartsModule.RotatingParts(part)
	local tweenInfo = TweenInfo.new(
		2, -- Time
		Enum.EasingStyle.Linear, -- EasingStyle
		Enum.EasingDirection.Out, -- EasingDirection
		-1, -- RepeatCount (when less than zero the tween will loop indefinitely)
		true, -- Reverses (tween will reverse once reaching it's goal)
		0 -- DelayTime
	)

	local tween = TweenService:Create(part, tweenInfo, {CFrame = part.CFrame * CFrame.Angles(0,math.rad(120),0)})

	tween:Play()
end


for _, part in pairs(workspace.RotatingParts:GetChildren()) do
	repeat wait() until part
	if part:IsA("BasePart") then
		RotatingPartsModule.RotatingParts(part)
	end
end


return RotatingPartsModule
