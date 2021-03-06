-- Bucket: Punch liquid source or flowing liquid to collect it

minetest.register_tool("bucket:bucket", {
	description = "Bucket",
	inventory_image = "bucket.png",
	stack_max = 1,
	liquids_pointable = true,
	groups = { disable_repair = 1 },
	on_use = function(itemstack, user, pointed_thing)
		-- Must be pointing to node
		if pointed_thing.type ~= "node" then
			return
		end
		-- Check if pointing to a liquid
		local n = minetest.get_node(pointed_thing.under)
		local def = minetest.registered_nodes[n.name]
		if def ~= nil and (def.liquidtype == "source" or def.liquidtype == "flowing") then
			minetest.add_node(pointed_thing.under, {name="air"})
			local inv = user:get_inventory()
			if inv then
				inv:add_item("main", ItemStack(n.name))
			end
		end
	end,
})

