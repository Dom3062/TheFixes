-- Make TeamAI always use their primary weapons
local origfunc = TweakData.init
function TweakData:init(...)
	origfunc(self, ...)
	
	if self.criminals
		and self.criminals.characters
		and self.character
	then
		for k,v in pairs(self.criminals.characters) do
			if v.name
				and self.character[v.name]
				and self.character[v.name].weapon
				and self.character[v.name].weapon.weapons_of_choice
				and self.character[v.name].weapon.weapons_of_choice.primary
			then
				local pr = self.character[v.name].weapon.weapons_of_choice.primary
				self.character[v.name].weapon.weapons_of_choice.secondary = pr
			end
		end
	end
end