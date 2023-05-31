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

download("https://pastebin.com/raw/QNBw5Xgz", "update")
download("https://pastebin.com/raw/KufLWr7q", "B")
download("https://pastebin.com/raw/DpLWYSkg", "mine")
download("https://pastebin.com/raw/VX1p6pHk", "move")
download("https://pastebin.com/raw/tZTDmxei", "startup")

if args[1] == nil then
    print("Downloading...")
	shell.run("update", "boop")
else
    print("Complete...")
end