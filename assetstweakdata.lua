local original = AssetsTweakData._init_gage_assets
function AssetsTweakData:_init_gage_assets(...)
    original(self, ...)
    local n = #self.gage_assignment.exclude_stages
    self.gage_assignment.exclude_stages[n + 1] = "hvh" -- Cursed Kill Room
    self.gage_assignment.exclude_stages[n + 2] = "nmh" -- No Mercy
end