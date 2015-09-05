module(..., package.seeall);

function new(type)
	local dialog_container = display.newImage("images/dialog_container.png");
	dialog_container.x = xCenter;
	dialog_container.y = yCenter;
	
	local grp_dialog = display.newGroup();
	grp_dialog.isVisible = false;
	
	if (type == "paused") then
		local btn_resume = _button.new({type = "resume", image = "images/btn_resume.png", x = xCenter - 50, y = yCenter});
		grp_dialog.btn_left = btn_resume;
	elseif (type == "game_finished") then
		local btn_next = _button.new({type = "next", image = "images/btn_next.png", x = xCenter - 50, y = yCenter});
		grp_dialog.btn_left = btn_next;
	end
	
	local btn_reload = _button.new({type = "reload", image = "images/btn_reload.png", x = xCenter + 50, y = yCenter});
	grp_dialog.btn_right = btn_reload;
	
	grp_dialog:insert(dialog_container);
	grp_dialog:insert(grp_dialog.btn_left);
	grp_dialog:insert(grp_dialog.btn_right);

	function grp_dialog.show()
		grp_dialog.isVisible = true;
		pop(grp_dialog);
	end

	function grp_dialog.hide()
		grp_dialog.isVisible = false;
	end
	
	return grp_dialog;
end
