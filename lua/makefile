LUA=mylib.lua utils.lua
all: $(LUA)

$(LUA): %.lua: %.fnl fennel
	    ./fennel --compile $< > $@

clean:
	rm -f mylib.lua utils.lua
