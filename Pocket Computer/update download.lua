args = {...}
 
function download(url, file)
  local content = http.get(url).readAll()
  if not content then
        error("Could not connect to website")
  end
  f = fs.open(file, "w")
  f.write(content)
  f.close()
end
 
download("https://pastebin.com/raw/ZwQjzUxD", "update")
download("https://pastebin.com/raw/dBk8JdgE", "startup")
download("https://pastebin.com/raw/FnasVkam", "cmd")
 
if args[1] == nil then
    print("Downloading...")
    shell.run("update", "boop")
else
    print("Complete...")
end