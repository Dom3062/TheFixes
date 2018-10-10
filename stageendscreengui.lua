local origfunc = StageEndScreenGui.set_continue_button_text
function StageEndScreenGui:set_continue_button_text(text, not_clickable, ...)
	return origfunc(self, text, false, ...)
end