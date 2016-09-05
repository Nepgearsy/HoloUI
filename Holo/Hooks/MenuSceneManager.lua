if not _G.MenuBackgrounds and not GameSetup and Holo.Options:GetValue("Menu/ColoredBackground") then 
	Hooks:PostHook(MenuSceneManager, "update", "HoloUpdateFov", function(self)
		if self._camera_object then
			local fixed_fov = math.min(50, self._new_fov)
			if self._new_fov ~= fixed_fov then		
				self._new_fov = fixed_fov
				self._camera_object:set_fov(self._new_fov)
			end
		end	
	end)
	Hooks:PostHook(MenuSceneManager, "update", "HoloUpdate", function(self)
		local cam = managers.viewport:get_current_camera()
		if type(cam) == "boolean" then
			return
		end
		local w,h = 1600, 900
		local a,b,c = cam:position() - Vector3(0, -486.5, 449.5):rotate_with(cam:rotation()) , Vector3(0, w, 0):rotate_with(cam:rotation()) , Vector3(0, 0, h):rotate_with(cam:rotation())
			if alive(self._background_ws) then
				self._background_ws:set_world(w,h,a,b,c)
				self._background_ws:panel():child("bg"):set_color(Holo:GetColor("Colors/MenuBackground"))
				if self._shaker then
					self._shaker:stop_all()
				end
				managers.environment_controller:set_default_color_grading("color_off") --Remove if you wish Holohud to not remove color grading.
				managers.environment_controller:refresh_render_settings()		
			else
				self._background_ws = World:newgui():create_world_workspace(w,h,a,b,c)
				self._background_ws:panel():bitmap({
					name = "bg",
					color = Holo:GetColor("Colors/MenuBackground"),
					layer = 20000,
					w = w, 
					h = h,
				})
				self._background_ws:set_billboard(Workspace.BILLBOARD_BOTH)
				self._bg_unit:set_visible(false)
				self._bg_unit:effect_spawner(Idstring("e_money")):set_enabled(false)
				managers.environment_controller._vp:vp():set_post_processor_effect("World", Idstring("bloom_combine_post_processor"), Idstring("bloom_combine_empty"))
				local smoke = "units/menu/menu_scene/menu_smokecylinder"
				for k, unit in pairs(World:find_units_quick("all")) do 
					if unit:name() == Idstring(smoke .. "1") or unit:name() == Idstring(smoke .. "2") or unit:name() == Idstring(smoke .. "3") then
						World:delete_unit(unit)
					end
				end				
			end
	end)	
end