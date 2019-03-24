-- Test

-- If it was called with assert(loadfile("xxx_test.lua"))(callback)
-- then take the callback parameter and use it at the end of the test.
local T = require("testutil")
T.callback = ...


-- Testing the built-in tmr
node.task.post(function()
	local t = {}
	for i = 1, 60 do
		t[i] = tmr.create()
		if t[i] then
			t[i]:alarm(1000*i, tmr.ALARM_SEMI, function()
				print("Tick", i)
				t[i]:unregister()
				if i==60 then
					T.endtest(true, "Success")
				end
			end)
		else
			print("Failed to create timer", i)
		end
	end
end)

