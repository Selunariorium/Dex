local counterids: table = {
    'rbxassetid://13532562418',
    'rbxassetid://15311685628'
}
local verylegit: boolean = false;
local isAlive = function(v)
    local suc, res = pcall(function()
        return v.Character and v.Character.PrimaryPart and v.Character:FindFirstChildWhichIsA('Humanoid') and v.Character.Humanoid.Health ~= 0;
    end)
    return suc and res or suc
end
local func: (Player) -> () = function(v: Player): ()
    assert(v, 'First argument is nil.')
    if not isAlive(v) then
        repeat task.wait() until workspace.Live:FindFirstChild(v.Name) and workspace.Live:FindFirstChild(v.Name):FindFirstChild('HumanoidRootPart') and workspace.Live:FindFirstChild(v.Name):FindFirstChild('Humanoid') and workspace.Live:FindFirstChild(v.Name).Humanoid.Health ~= 0
    end
    if v ~= game.Players.LocalPlayer then
        v.Character.Humanoid.AnimationPlayed:Connect(function(anim: Animation): ()
            if isAlive(game.Players.LocalPlayer) and table.find(counterids, anim.Animation.AnimationId) and (v.Character.PrimaryPart.Position - game:GetService('Players').LocalPlayer.Character.PrimaryPart.Position).Magnitude <= shared.Range then
                if verylegit then return print('naw') end;
                verylegit = true;
                task.delay(0.05, function()
                    verylegit = false;
                    game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents.SayMessageRequest:FireServer(shared.message or 'real', 'All');
                end)
            end;
        end);
    end;
end
for i: number, v: Player in game:GetService('Players'):GetPlayers() do
    func(v)
    v.CharacterAdded:Connect(func)
end;
