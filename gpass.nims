mode = ScriptMode.Silent

# compile website main script
exec "nim c ./src/script.nim"

# set gpass.nim compilation flags
--mm:orc
--define:lto