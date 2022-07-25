mode = ScriptMode.Verbose

#compile website main script
exec "nim c src/script.nim"

--forceBuild:on
--opt:speed
--define:danger
--threads:on
--mm:orc
--deepcopy:on
--define:lto
#--define:ssl # If you use smtp clients
#--hints:off
--outdir:"."
setCommand "c", "gpass.nim"
