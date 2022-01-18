local player = game.Players.LocalPlayer

local vehicleSeat = workspace:WaitForChild(player.Name.."'s BlackCar"):WaitForChild("Base"):WaitForChild("VehicleSeat")

local motorFR = workspace:WaitForChild(player.Name.."'s BlackCar").WheelFR:FindFirstChildWhichIsA("CylindricalConstraint", true)
local motorFL = workspace:WaitForChild(player.Name.."'s BlackCar").WheelFL:FindFirstChildWhichIsA("CylindricalConstraint", true)
local motorBR = workspace:WaitForChild(player.Name.."'s BlackCar").WheelBR:FindFirstChildWhichIsA("CylindricalConstraint", true)
local motorBL = workspace:WaitForChild(player.Name.."'s BlackCar").WheelBL:FindFirstChildWhichIsA("CylindricalConstraint", true)

local springFR = workspace:WaitForChild(player.Name.."'s BlackCar").WheelFR:FindFirstChildWhichIsA("SpringConstraint", true)
local springFL = workspace:WaitForChild(player.Name.."'s BlackCar").WheelFL:FindFirstChildWhichIsA("SpringConstraint", true)
local springBR = workspace:WaitForChild(player.Name.."'s BlackCar").WheelBR:FindFirstChildWhichIsA("SpringConstraint", true)
local springBL = workspace:WaitForChild(player.Name.."'s BlackCar").WheelBL:FindFirstChildWhichIsA("SpringConstraint", true)

local wheelHingeR = workspace:WaitForChild(player.Name.."'s BlackCar").WheelFR:FindFirstChildWhichIsA("HingeConstraint", true)
local wheelHingeL = workspace:WaitForChild(player.Name.."'s BlackCar").WheelFL:FindFirstChildWhichIsA("HingeConstraint", true)


-- TUNING VALUES
----------------------------------------
-- Factor of torque applied to get the wheels spinning
-- Larger number generally means faster acceleration
local TORQUE = 100000

-- Factor of torque applied to change the wheel direction
-- Larger number generally means faster braking
local BRAKING_TORQUE = 8000

-- Max angle the wheels will reach when turning
-- Higher number means sharper turning, but too high means the wheels might hit the car base
local MAX_TURN_ANGLE = 30

-- Car max speed
local MAX_SPEED = 50
----------------------------------------


-- HELPER FUNCTIONS
----------------------------------------
-- Set the "MotorMaxTorque" property on all of the CylindricalConstraint motors
local function setMotorTorque(torque)
	motorFR.MotorMaxTorque = torque
	motorFL.MotorMaxTorque = torque
	motorBR.MotorMaxTorque = torque
	motorBL.MotorMaxTorque = torque
end

-- Set the "AngularVelocity" property on all of the CylindricalConstraint motors
local function setMotorVelocity(vel)
	motorFL.AngularVelocity = vel
	motorBL.AngularVelocity = vel
	-- Motors on the right side are facing the opposite direction, so negative velocity must be used
	motorFR.AngularVelocity = -vel
	motorBR.AngularVelocity = -vel
end

-- Calculate the average linear velocity of the car based on the rate at which all wheels are spinning
local function getAverageVelocity()
	local vFR = -motorFR.Attachment1.WorldAxis:Dot(motorFR.Attachment1.Parent.RotVelocity)
	local vRR = -motorBR.Attachment1.WorldAxis:Dot(motorBR.Attachment1.Parent.RotVelocity)
	local vFL = motorFL.Attachment1.WorldAxis:Dot(motorFL.Attachment1.Parent.RotVelocity)
	local vRL = motorBL.Attachment1.WorldAxis:Dot(motorBL.Attachment1.Parent.RotVelocity)
	return 0.25 * ( vFR + vFL + vRR + vRL )
end


-- DRIVE LOOP
----------------------------------------

local function driveCar()
	-- Input values taken from the VehicleSeat
	local steerFloat = vehicleSeat.SteerFloat  -- Forward and backward direction, between -1 and 1
	local throttle = vehicleSeat.ThrottleFloat  -- Left and right direction, between -1 and 1

	-- Convert "steerFloat" to an angle for the HingeConstraint servos
	local turnAngle = steerFloat * MAX_TURN_ANGLE
	wheelHingeR.TargetAngle = turnAngle
	wheelHingeL.TargetAngle = turnAngle

	-- Apply torque to the CylindricalConstraint motors depending on our throttle input and the current speed of the car
	local currentVel = getAverageVelocity()
	local targetVel = 0
	local motorTorque = 0

	-- Idling
	if math.abs(throttle) < 0.1 then
		motorTorque = 10000

		-- Accelerating
	elseif math.abs(throttle * currentVel) > 0 then
		-- Reduce torque with speed (if torque was constant, there would be a jerk reaching the target velocity)
		-- This also produces a reduction in speed when turning
		local r = math.abs(currentVel) / MAX_SPEED
		-- Torque should be more sensitive to input at low throttle than high, so square the "throttle" value
		motorTorque = math.exp( - 3 * r * r ) * TORQUE * throttle * throttle
		targetVel = math.sign(throttle) * 1000000  -- Arbitrary large number

		-- Braking
	else
		motorTorque = BRAKING_TORQUE * throttle * throttle
	end

	-- Use helper functions to apply torque and target velocity to all motors
	setMotorTorque(motorTorque)
	setMotorVelocity(targetVel)
	wait()
	driveCar()
end

vehicleSeat:GetPropertyChangedSignal("Occupant"):Connect(function()
	local humanoid = vehicleSeat.Occupant
	if humanoid then
		driveCar()
	end
end)






