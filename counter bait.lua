shared.message = '';
local counterids: table = {
	'rbxassetid://13532562418',
	'rbxassetid://15311685628'
}
local players = {}

local verylegit: boolean = false;
local isAlive = function(v)
	return workspace.Live:FindFirstChild(v.Name) and v and v.PrimaryPart and v:FindFirstChildWhichIsA('Humanoid') and v.Humanoid.Health ~= 0;
end

local func: (Player) -> () = function(v: Player): ()
	assert(v, 'First argument is nil.')
	if not isAlive(v) then
		repeat task.wait() until isAlive(v)
		task.wait()
	end

	if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChildWhichIsA('Humanoid') and v.Character.Humanoid.Health ~= 0 then
		v.Character.Humanoid.AnimationPlayed:Connect(function(anim: Animation): ()
			if isAlive(game.Players.LocalPlayer) and table.find(counterids, anim.Animation.AnimationId) and (v.Character.PrimaryPart.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).Magnitude <= 5.5 then
				if verylegit then print('naw') return end
				verylegit = true;
				verylegit = false;
				game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents.SayMessageRequest:FireServer(shared.message or 'real', 'All');
			end;
		end);
	end;
end

for i: number, v: Player in game:GetService('Players'):GetPlayers() do
	func(v)
	v.CharacterAdded:Connect(func)
	table.insert(players, v.Name)
end

game:GetService('Players').PlayerAdded:Connect(function()
	if v ~= game:GetService('Players').LocalPlayer and not table.find(players, v.Name) then
		func(v)
		v.CharacterAdded:Connect(func)
		table.insert(players, v.Name)
	end
end)