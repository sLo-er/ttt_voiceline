-- INITIALIZE AWESOME

local function LoadFiles(fdir)
	
	local files, _ = file.Find(fdir .. "*", "LUA") 
	table.sort(files)
	
	if SERVER then
		for _, filename in ipairs(files) do
		 
		 	local ftype = filename:sub(1,2)
			
			if ftype == "sv" or ftype == "sh" then
				include(fdir..filename)			
			elseif ftype == "cl" or ftype == "sh" then
				AddCSLuaFile(fdir..filename)
			end
			
			print(GetHostName().."[File was loaded]: "..fdir..filename)
			
		end
		
	else
	
		for _, filename in ipairs(files) do
		
		 	local ftype = filename:sub(1,2)
			
			if ftype == "cl" or ftype == "sh" then
				include(fdir..filename)
			end
			
			print(GetHostName().."[File was loaded]: "..fdir..filename)
			
		end
	end
	
end

local function LoadDirs(fdirs)

	local _, directories = file.Find(fdirs .. "*", 'LUA')
	table.sort(directories)

	for _, fdir in ipairs(directories) do
		LoadFiles(fdirs..fdir.."/")
	end

end
 

if SERVER then

 	AddCSLuaFile()
	
	Awesome = Awesome or {} 
 	Awesome.Config = Awesome.Config or {}
	
	
	LoadFiles("aws_configs/")
	LoadDirs("aws_addons/")
		
else

 	Awesome = Awesome or {} 
 	Awesome.Config = Awesome.Config or {} 
	

	LoadFiles("aws_configs/")
	LoadDirs("aws_addons/")
	
end 