# Second timer - Create long period timers on ESP12F - in LUA

The [built-in tmr module](https://nodemcu.readthedocs.io/en/master/en/modules/tmr/) of NodeMCU is fine for almost all purposes. You can create all sorts of timers up to 1:54:30.947, with millisecond resolution.

But sometimes we need extra long times, and we do not need the millisecond resolution.

Second timer, *stmr* implements the following functions:

    alarm
    create
    interval
    register
    start
    stop
    unregister

They have exactly the same interface as the object oriented interface of the [built-in tmr module](https://nodemcu.readthedocs.io/en/master/en/modules/tmr/), except that interval is in seconds and not in milliseconds.

The maximum value for interval is the largest integer that can be exactly represented. Assuming double precision IEEE 754 standard for floating-point numbers, it is 2^53 seconds, which is approximately 6.8 billion years, longer than the age of planet Earth.

There are two additional, rarely used, functions:

    setbasetick(tick)
    destroy()

### setbasetick(tick)

*tick* is in ms, and defines the base tick rate, which is by default 1000 ms. It can be changed either before, or after creating the first second timer, and it affects all running second timers immediately.

### destroy()

After creating the very first second timer, the base timer runs continuously, even after all second timers are deleted.  
If you really do not need second timers for a long time, you **can**, but you do not have to, call destroy to stop the base timer and free some resources. The next time you create a new second timer it will restart automatically.

## Example

    local stmr = require("stmr.lua")
    stmr.create():alarm(3600, tmr.ALARM_SINGLE, function()
        print("There is life after one hour!")
    end)
