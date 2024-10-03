--note: this runs on windows but I assume replacing "cmd" with "sh" it can run on linux as well
exe, err = io.popen("clock > stdout.txt 2> stderr.txt")
if not exe then
	print("Could not run command. Error: " .. err)
	return
else
	print("Command run successfully... ready!")
end

stdout, err = io.open("stdout.txt", "r")
if not stdout then
	print("Could not open stdout: " .. err)
	return
end
stderr, err = io.open("stderr.txt", "r")
if not stdout then
	print("Could not open stderr: " .. err)
	return
end

function execute(str)
	exe:write(str)
	return stdout:read("*all") or stderr:read("*all") or "nil"
end

repeat
	print("COMMAND: ")
	userinput = io.read("*line")
	print("You entered: '" .. userinput .. "'")
	if userinput == "" then
		print("Empty line! Exiting program...")
		break
	end
	print("Result: " .. execute(userinput))
until true

print("Closing...")
execute("exit")
print("1")
exe:close()
print("2")
stdout:close()
print("3")
stderr:close()
print("Finished!")
